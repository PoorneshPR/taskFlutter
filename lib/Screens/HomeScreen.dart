import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_flutter/Screens/GoogleMapsScreen.dart';
import 'package:task_flutter/screens/AboutUser.dart';
import 'package:task_flutter/screens/UserLoginCheck.dart';
import '../Services/Provider/AuthenticationProvider.dart';
import '../Services/Provider/DbProvider.dart';
import '../Services/Provider/LocalProvider.dart';
import '../Services/Provider/LoginProvider.dart';
import '../Services/Provider/UtilityProvider.dart';
import '../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic futureSearchData;

  bool isSearching = false;
  bool fingerPrintTurnOn = false;
  String userName = "";

  Future<String> fetchingUserName() async {
    if (context.read<AuthenticationProvider>().userInfo != null) {
      return userName = await UtilityProvider().getStringToUserName();
    } else if (UtilityProvider().getStringToUserName() != null) {
      return userName = await UtilityProvider().getStringToUserName();
    } else {
      return userName = await UtilityProvider().getStringToUserName();
    }
  }

  getVal() async {
    fingerPrintTurnOn = await UtilityProvider().getBoolToSF();
  }

  @override
  initState() {
    getVal();
    Future.microtask(() => context.read<DbProvider>().loadContacts());
    fetchingUserName();

    super.initState();
  }

  bool _loginStatus = false;
  bool bottomSearchIconTap = false;
  bool isLanguage = false;

  filteredValue(String valueText) {
    setState(() {
      isSearching = true;
    });
  }

  void toggleLanguage(bool value) {
    if (isLanguage == false) {
      setState(() {
        isLanguage = true;
        Future.microtask(() {
          context.read<LocalProvider>().updateSelectedLanguage('ar');
        });

        // textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isLanguage = false;
        Future.microtask(() {
          context.read<LocalProvider>().updateSelectedLanguage('en');
        });
        // textValue = 'Switch Button is OFF';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final translated = S.of(context);
    return WillPopScope(
      onWillPop: () {
        return UtilityProvider().showExitPopup(context);
      },
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Profiles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profiles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_vert),
              label: 'Menu',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          late CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return isSearching != true ? DbListWidget() : DbListWidget();
              });
              break;
            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                bottomSearchIconTap = true;

                return Scaffold(
                    body: Center(child: Text(translated.underDevelopment)));
              });
              break;
            case 2:
              returnValue = CupertinoTabView(builder: (context) {
                return Scaffold(
                    body: Center(child: Text(translated.underDevelopment)));
              });
              break;
            case 3:
              returnValue = CupertinoTabView(builder: (context) {
                return bottomMenuOption();
              });
              break;
          }
          return returnValue;
        },
      ),
    );
  }

//DatabaseListWidget
  Widget DbListWidget() {
    final translated = S.of(context);
    return Scaffold(
        drawer: Drawer(
            semanticLabel: "Drawer",
            child: Column(children: [
              UserAccountsDrawerHeader(
                accountName: Text(userName),
                accountEmail: const Text("SampleSite.Com"),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/circle_male.jpg"),
                  radius: 50.0,
                ),
              ),
              TextButton(onPressed: () {}, child: Text(translated.About)),
              TextButton(onPressed: () {}, child: Text(translated.Settings)),
              TextButton(onPressed: () {}, child: Text(translated.Menu)),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'red');
                  },
                  child: Text(translated.Notification)),
            ])),
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 2,
          title: !isSearching
              ? Text(
                  translated.home,
                )
              : Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle),
                  child: TextField(
                    onChanged: (val) {
                      Future.microtask(
                          () => context.read<DbProvider>()..filterdata(val));

                      //filteredValue(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "Search Contact Here",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
          actions: [
            isSearching
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        bottomSearchIconTap = false;
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                  ),
            IconButton(
              icon: const Icon(Icons.location_on_sharp),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GoogleMapScreenFlutter(),
                    ));
              },
            )
          ],
        ),
        body: Consumer<DbProvider>(builder: (context, value, child) {
          if (value.contactUser == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: value.contactUser!.length,
                      itemBuilder: (context, int index) {
                        var item = value.contactUser!.elementAt(index);
                        return Card(
                            child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ListTile(
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AboutUser(
                                              userContacts: value.contactUser,
                                              index: index,
                                            )));
                              },
                              leading: CircleAvatar(
                                radius: 37,
                                backgroundImage: item.profileImage.isEmpty
                                    ? const AssetImage("assets/no_image.jpg")
                                        as ImageProvider
                                    : NetworkImage(item.profileImage),
                              ),
                              title: Text(item.username),
                              subtitle: item.name != null
                                  ? Text(item.name)
                                  : const Text("No user name"),
                            ),
                          ],
                        ));
                      }),
                ),
              ],
            );
          }
        }));
  }

//  BottomNavigationBarMenuScreenmWidget its called to main context

  Widget bottomMenuOption() {
    final translated = S.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(translated.turnOnFingerPrint),
                      Switch(
                        activeColor: Colors.green,
                        value: fingerPrintTurnOn,
                        onChanged: (value) async {
                          setState(() {
                            fingerPrintTurnOn = value;
                          });
                          await context
                              .read<UtilityProvider>()
                              .addBoolToSF(fingerPrintTurnOn);
                        },
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        AuthenticationProvider().signOutFB(context);
                        AuthenticationProvider().signOutGoogle(context);
                        AuthenticationProvider().dispose();

                        _loginStatus = false;

                        context
                            .read<LoginProvider>()
                            .userSetLoginCheck(_loginStatus);
                        UtilityProvider().pref?.clear();

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UserLoginCheckScreen(),
                            ));
                      },
                      child: Text(
                        translated.logout,
                        style: const TextStyle(color: Colors.black87),
                      )),
                ],
              ),
              ListTile(
                leading: Text(translated.selectLanguage),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('en'),
                    Switch(
                      onChanged: toggleLanguage,
                      value: isLanguage,
                      activeColor: Colors.green,
                      activeTrackColor: Colors.blueGrey,
                    ),
                    const Text('ar')
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/circle_male.jpg"),
                  radius: 50.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                " $userName",
                style: const TextStyle(color: Colors.black87, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                translated.profile,
                style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
