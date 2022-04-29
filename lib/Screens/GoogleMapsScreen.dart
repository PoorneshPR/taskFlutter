import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../Services/Provider/UtilityProvider.dart';

class GoogleMapScreenFlutter extends StatefulWidget {
  const GoogleMapScreenFlutter({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenFlutterState createState() => _GoogleMapScreenFlutterState();
}

class _GoogleMapScreenFlutterState extends State<GoogleMapScreenFlutter> {
  String storedVal = '';
  geocoding.Placemark? userLocSelect;
  String userLocalitySelect = "";
  LatLng? userPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController? mapController;
  final Location _location = Location();
  geocoding.Placemark? place;
  bool currentLocEnabled = false;
  bool isStoredValue = false;

  getStoredLocation() async {
    await UtilityProvider().getMapLocToSP().then((value) {
      storedVal = value;
    });

  }


  @override
  void initState() {
    getStoredLocation();
    getSetAddress();
    super.initState();
  }

  Future<LatLng> currentLocation() async {
    LocationData userLocationData;
    PermissionStatus permissionStatus;
    permissionStatus = await _location.requestPermission();

    permissionStatus = await _location.hasPermission();
    bool serviceEnabled = await _location.serviceEnabled();

    if (permissionStatus == PermissionStatus.granted && serviceEnabled) {
      userLocationData = await _location.getLocation();
      userPosition =
          LatLng(userLocationData.latitude!, userLocationData.longitude!);
    } else {
      userPosition ??= const LatLng(10.5276416, 76.2144349);
    }
    List<geocoding.Placemark> placemarks =
    await geocoding.placemarkFromCoordinates(
        userPosition!.latitude, userPosition!.longitude);
    userLocSelect = placemarks.first;
    userLocalitySelect = userLocSelect!.locality!;

    return userPosition!;
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
      _location.onLocationChanged.listen((l) {
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
          ),
        );
      });
    });
  }

  getSetAddress({LatLng? tapPos}) async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(tapPos!.latitude, tapPos.longitude);
    place = placemarks.elementAt(0);
    setState(() {
      String markerIdVal =
          'Current location ${tapPos.latitude} , ${tapPos.longitude}';
      MarkerId markerId = MarkerId(markerIdVal);

      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(tapPos.latitude, tapPos.longitude),
        visible: true,
        infoWindow: InfoWindow(title: place?.name),
      );
      markers.clear();
      markers[markerId] = marker;
      storedVal = marker.infoWindow.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Map"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(



                  future: currentLocation(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == true) {
                      return GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        padding: const EdgeInsets.all(30),
                        initialCameraPosition:
                        CameraPosition(target: userPosition!, zoom: 20),
                        onMapCreated: onMapCreated,
                        onCameraMove: (CameraPosition position) {
                          if (currentLocEnabled == true) {
                            mapController?.animateCamera(
                                CameraUpdate.newLatLng(userPosition!));
                            currentLocEnabled = false;
                          } else {
                            mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(position));
                          }
                        },
                        onTap: (LatLng pos) {
                          getSetAddress(tapPos: pos);
                        },
                        markers: Set<Marker>.of(markers.values),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            showDialog(value: place)
          ],
        ));
  }

  Widget showDialog({geocoding.Placemark? value}) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                currentLocEnabled = true;
              });
              currentLocation();
            },
            child: const Text("Use Your Current Location"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 45),
              Expanded(
                child: Text(
                    value?.locality != null
                        ? "${value?.locality.toString()} "
                        : isStoredValue == true
                        ? storedVal
                        : "${UtilityProvider().getMapLocToSP()}",
                    style: const TextStyle(
                        color: Colors.black, fontSize: 18, height: 2)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                UtilityProvider().addMapLocToSP(storedVal);
                setState(() {
                  isStoredValue = true;
                });
              },
              child: const Text("Confirm Location"),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
        ],
      ),
    );
  }
}
