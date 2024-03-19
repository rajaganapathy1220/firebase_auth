import 'package:firebase_authen/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class FireDbInput extends StatefulWidget {
  const FireDbInput({super.key});

  @override
  State<FireDbInput> createState() => _FireDbInputState();
}

class _FireDbInputState extends State<FireDbInput> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var locationController = TextEditingController();

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
      body: SafeArea(
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
                        try {
                          String id = randomAlphaNumeric(10);
                          Map<String, dynamic> map = {
                            "Name": nameController.text,
                            "Age": ageController.text,
                            "Id": id,
                            "Location": locationController.text,
                          };
                          await DataBaseMethods()
                              .addEmployDetails(map, id);
                          print('Saved');
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Icon(Icons.add)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
