import 'package:flutter/material.dart';
import 'package:task_flutter/Models/ContactsModel.dart';

class AboutUser extends StatefulWidget {
  AboutUser({
    Key? key,
    this.userContacts,
  }) : super(key: key);

  ContactsModel? userContacts;

  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {
  @override
  Widget build(BuildContext context) {
    String city = widget.userContacts?.address?.city != null
        ? widget.userContacts?.address?.city ?? ""
        : "No city name";
    String street = widget.userContacts?.address?.street != null
        ? widget.userContacts?.address?.street ?? ""
        : "No street name";
    if (widget.userContacts != null) {
      debugPrint("db not empty>>>>>>>>>>>>>>>>");
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Profile",
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: CircleAvatar(
                    backgroundImage: widget.userContacts?.profileImage == null
                        ? AssetImage("assets/no_image.jpg") as ImageProvider
                        : NetworkImage(widget.userContacts?.profileImage ?? ""),
                    radius: 80.0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.userContacts?.username == null
                      ? "No User Name Id to display"
                      : widget.userContacts?.username ?? " No proper name",
                  style: const TextStyle(
                      fontSize: 25.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.userContacts?.name == null
                      ? "No Name Id to display"
                      : widget.userContacts?.name ?? "",
                  style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.mail, size: 30),
                      const SizedBox(height: 18, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          SizedBox(height: 8),
                          Text(widget.userContacts?.email == null
                              ? "No Email Id to display"
                              : widget.userContacts?.email ?? "")
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.phone, size: 30),
                      const SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Mobile',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(widget.userContacts?.phone == null
                              ? "No contacts to display"
                              : widget.userContacts?.phone ?? "")
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.location_on_sharp, size: 30),
                      const SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(city + street),
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.business_outlined, size: 30),
                      const SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Company',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(widget.userContacts?.company?.name == null
                              ? "No Company to display"
                              : widget.userContacts?.company?.name ?? "")
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.miscellaneous_services_outlined, size: 30),
                      const SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Company service',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(widget.userContacts?.company?.bs == null
                              ? "No Company to display"
                              : widget.userContacts?.company?.bs ?? ""),
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.details, size: 30),
                      const SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(widget.userContacts?.company?.catchPhrase == null
                              ? "No Company to display"
                              : widget.userContacts
                              ?.company
                              ?.catchPhrase ??
                              ""),
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      const Icon(Icons.web_outlined, size: 30),
                      const SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('WebSite',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(widget.userContacts?.website == null
                              ? "No Company to display"
                              : widget.userContacts?.website ?? ""),
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 100,
                  width: 30,
                )
              ],
            ),
          ));
    } else {
      return Scaffold(
        body: Center(
          child: TextButton(
              child: const Text("No Person To Display"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
      );
    }
  }
}
