import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authen/database_helper.dart';
import 'package:firebase_authen/fire_db_input.dart';
import 'package:flutter/material.dart';

class EmployViewScreen extends StatefulWidget {
  const EmployViewScreen({super.key});

  @override
  State<EmployViewScreen> createState() => _EmployViewScreenState();
}

class _EmployViewScreenState extends State<EmployViewScreen> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var locationController = TextEditingController();
  Stream? employStream;

  getOnLoad() async {
    employStream = await DataBaseMethods().getEmployDetails();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getOnLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Text(
              'FireBase',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow.shade700),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [Expanded(child: allEmployDetails())],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FireDbInput()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget allEmployDetails() {
    return StreamBuilder(
      stream: employStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 25),
                    child: Material(
                      elevation: 22,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: EdgeInsets.all(19),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name :' + ds["Name"]),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      nameController.text = ds["Name"];
                                      ageController.text = ds["Age"];
                                      locationController.text = ds["Location"];
                                      showEditDialog(ds["Id"]);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.yellow.shade700,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      DataBaseMethods()
                                          .deleteEmployDetails(ds["Id"]);
                                      print('Delete button Clicked');
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                            Text('Age :' + ds["Age"]),
                            SizedBox(
                              height: 9,
                            ),
                            Text('Location :' + ds["Location"])
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  showEditDialog(String Id) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      controller: nameController,
                      cursorColor: Colors.yellow.shade700,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: 'Enter Name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Age',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      controller: ageController,
                      cursorColor: Colors.yellow.shade700,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: 'Enter age',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextFormField(
                      controller: locationController,
                      cursorColor: Colors.yellow.shade700,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: 'Enter location',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "Name": nameController.text,
                            "Age": ageController.text,
                            "Id": Id,
                            "Location": locationController.text
                          };
                          await DataBaseMethods()
                              .updateEmployDetails(Id, updateInfo);
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.update)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
