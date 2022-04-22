import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_flutter/models/ContactsModel.dart';
import 'package:task_flutter/Screens/HomeScreen.dart';

class AboutUser extends StatefulWidget {
   AboutUser( {
    Key? key,

    required this.index, this.snapshotpass,this.userContacts,this.Text="No User"
} ) : super(key: key);

 AsyncSnapshot<List<ContactsModel>>? snapshotpass;
 List<ContactsModel>? userContacts;
  final int index;
  String Text;

  @override
  _AboutUserState createState() => _AboutUserState();
}

class _AboutUserState extends State<AboutUser> {

  @override
  Widget build(BuildContext context) {
    if(widget.userContacts!.elementAt(widget.index)!=null){
      debugPrint("db not empty>>>>>>>>>>>>>>>>");
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Profile", ),
          ),
          body: SingleChildScrollView(

            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,


            children: [

                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: CircleAvatar(

                      backgroundImage: widget.userContacts!.elementAt(widget.index).profileImage.isEmpty
                  ? AssetImage("assets/no_image.jpg")
                  as ImageProvider
                  : NetworkImage(widget.userContacts!.elementAt(widget.index).profileImage),
                    radius: 80.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${widget.userContacts!.elementAt(widget.index).username.isEmpty ? "No User Name Id to display"
                      : widget.userContacts!.elementAt(widget.index).username}",
                  style: const TextStyle(
                      fontSize: 25.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.userContacts!.elementAt(widget.index).name.isEmpty ? "No Name Id to display"
                      : widget.userContacts!.elementAt(widget.index).name,
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
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Icon(Icons.mail, size: 30),
                      SizedBox(height: 18, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          SizedBox(height: 8),
                          Text( widget.userContacts!.elementAt(widget.index).email
                              .isEmpty
                              ? "No Email Id to display"
                              :  widget.userContacts!.elementAt(widget.index).email)
                        ],
                      )
                    ]),
              const SizedBox(
                height: 20,
              ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Icon(Icons.phone, size: 30),
                      SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Mobile',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          SizedBox(height: 8),
                          Text( widget.userContacts!.elementAt(widget.index).phone
                              .isEmpty
                              ? "No contacts to display"
                              :  widget.userContacts!.elementAt(widget.index).phone)
                        ],
                      )
                    ]),
              const SizedBox(
                height: 20,
              ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Icon(Icons.location_on_sharp, size: 30),
                      SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          SizedBox(height: 8),
                          Text( widget.userContacts!.elementAt(widget.index).address
                              .city.isEmpty &&
                              widget.userContacts!.elementAt(widget.index)
                                  .address.street.isEmpty
                              ? "No address to display"
                              :  widget.userContacts!.elementAt(widget.index)
                              .address.city +
                              " , ${ widget.userContacts!.elementAt(widget.index).address.street}"),
                        ],
                      )
                    ]),
              const SizedBox(
                height: 20,
              ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Icon(Icons.business_outlined, size: 30),
                      SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Company',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text( widget.userContacts!.elementAt(widget.index).company!.name
                              .isEmpty
                              ? "No Company to display"
                              : widget.userContacts!.elementAt(widget.index)
                              .company!.name ),
                        ],
                      )
                    ]),
              const SizedBox(
                height: 20,
              ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Icon(Icons.miscellaneous_services_outlined, size: 30),
                      SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Company service',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text( widget.userContacts!.elementAt(widget.index).company!.bs
                              .isEmpty
                              ? "No Company Service to display"
                              :  widget.userContacts!.elementAt(widget.index)
                              .company!.bs ),
                        ],
                      )
                    ]),
              const SizedBox(
                height: 20,
              ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Icon(Icons.details, size: 30),
                      SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text( widget.userContacts!.elementAt(widget.index).company!.catchPhrase
                              .isEmpty
                              ? "No Details to display"
                              :  widget.userContacts!.elementAt(widget.index)
                              .company!.catchPhrase ),
                        ],
                      )
                    ]),
              const SizedBox(
                height: 20,
              ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Icon(Icons.web_outlined, size: 30),
                      SizedBox(height: 8, width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('WebSite',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text( widget.userContacts!.elementAt(widget.index).website
                              .isEmpty
                              ? "No Website to display"
                              :  widget.userContacts!.elementAt(widget.index).website),
                        ],
                      )
                    ]),
            SizedBox(height: 100,width: 30,)
              ],

            ),
          ));
    }
   else if (widget.snapshotpass?.connectionState == ConnectionState.done &&
        widget.snapshotpass?.data!.elementAt(widget.index)!=null) {
     debugPrint("not Db>>>>>>>>>>>");
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile", style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.black12,
        ),
        body: SingleChildScrollView(

          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

              Padding(
                padding: EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  backgroundImage:widget.snapshotpass!.data![widget.index].profileImage.isEmpty
                      ? AssetImage("assets/no_image.jpg")
                  as ImageProvider
                      : NetworkImage(widget.snapshotpass!.data![widget.index].profileImage),
                  radius: 80.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${widget.snapshotpass!.data![widget.index].username.isEmpty ? "No User Name Id to display"
                    : widget.snapshotpass?.data![widget.index].username}",
                style: const TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                widget.snapshotpass!.data![widget.index].name.isEmpty ? "No Name Id to display"
                    : widget.snapshotpass!.data![widget.index].name,
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
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Icon(Icons.mail, size: 30),
                    SizedBox(height: 8, width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Email',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                                color: Colors.grey)),
                        SizedBox(height: 8),
                        Text(widget.snapshotpass!.data![widget.index].email
                                .isEmpty
                            ? "No Email Id to display"
                            : widget.snapshotpass!.data![widget.index].email)
                      ],
                    )
                  ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Icon(Icons.phone, size: 30),
                    SizedBox(height: 8, width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Mobile',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                                color: Colors.grey)),
                        SizedBox(height: 8),
                        Text(widget.snapshotpass!.data![widget.index].phone
                                .isEmpty
                            ? "No contacts to display"
                            : widget.snapshotpass!.data![widget.index].phone)
                      ],
                    )
                  ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Icon(Icons.location_on_sharp, size: 30),
                    SizedBox(height: 8, width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Address',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                                color: Colors.grey)),
                        SizedBox(height: 8),
                        Text(widget.snapshotpass!.data![widget.index].address
                                    .city.isEmpty &&
                                widget.snapshotpass!.data![widget.index]
                                    .address.street.isEmpty
                            ? "No address to display"
                            : widget.snapshotpass!.data![widget.index]
                                    .address.city +
                                " , ${widget.snapshotpass!.data![widget.index].address.street}"),
                      ],
                    )
                  ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Icon(Icons.business_outlined, size: 30),
                    SizedBox(height: 8, width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Company',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                                color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text(widget.snapshotpass!.data![widget.index].company==""
                            ? "No Company to display"
                            : widget.snapshotpass!.data![widget.index]
                            .company!.name),
                      ],
                    )
                  ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Icon(Icons.miscellaneous_services_outlined, size: 30),
                    SizedBox(height: 8, width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Company service',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                                color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text(widget.snapshotpass!.data![widget.index].company!.bs
                                    .isEmpty
                            ? "No Company Service to display"
                            : widget.snapshotpass!.data![widget.index]
                            .company!.bs ),
                      ],
                    )
                  ]),
              const SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Icon(Icons.details, size: 30),
                    SizedBox(height: 8, width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.0,
                                color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text(widget.snapshotpass!.data![widget.index].company!.catchPhrase
                                    .isEmpty
                            ? "No Details to display"
                            : widget.snapshotpass!.data![widget.index]
                            .company!.catchPhrase ),
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
                        Text(widget.snapshotpass!.data![widget.index].website
                            .isEmpty
                            ? "No Website to display"
                            : widget.snapshotpass!.data![widget.index].website),
                      ],
                    )
                  ]),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

    else {
      return const Scaffold(
        body: Center(
          child: Text("No Person To Display"),
        ),
      );
    }
    }
}
