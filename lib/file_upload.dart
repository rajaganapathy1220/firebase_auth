import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


// class FileUploadScreen extends StatefulWidget {
//   @override
//   _FileUploadScreenState createState() => _FileUploadScreenState();
// }

// class _FileUploadScreenState extends State<FileUploadScreen> {
//   //File _file;
//  // UploadTask _uploadTask;
//
//   Future<void> _pickFile() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//      //   _file = File(pickedFile.path);
//       });
//     }
//   }
//
//   void _startUpload() {
//     if (_file == null) return;
//
//     final Reference storageRef = FirebaseStorage.instance.ref().child('uploads/${DateTime.now()}_${_file.path.split('/').last}');
//     _uploadTask = storageRef.putFile(_file);
//
//     _uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
//       print('Task state: ${snapshot.state}');
//       print('Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
//     }, onError: (Object e) {
//       print(e); // Handle your error here
//     });
//
//     // Listen for state changes, errors, and completion of the upload.
//     _uploadTask.whenComplete(() {
//       print('Upload complete');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('File Upload'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           if (_file != null) ...[
//             Image.file(_file), // Show preview of selected file
//             SizedBox(height: 20),
//             _uploadTask != null
//                 ? StreamBuilder<TaskSnapshot>(
//               stream: _uploadTask.snapshotEvents,
//               builder: (context, snapshot) {
//                 var progress = 0.0;
//                 if (snapshot.hasData) {
//                   final TaskSnapshot? taskSnapshot = snapshot.data;
//                   progress = (taskSnapshot!.bytesTransferred / taskSnapshot.totalBytes) * 100;
//                 }
//                 return Text('Upload Progress: ${progress.toStringAsFixed(2)} %');
//               },
//             )
//                 : SizedBox(),
//           ],
//           ElevatedButton(
//             onPressed: _pickFile,
//             child: Text('Pick File'),
//           ),
//           ElevatedButton(
//             onPressed: _startUpload,
//             child: Text('Start Upload'),
//           ),
//         ],
//       ),
//     );
//   }
// }
