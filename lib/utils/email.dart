// import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:csv/csv.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Email Sender Demo',
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Email Sender Demo'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             sendEmail();
//           },
//           child: Text('Send Email'),
//         ),
//       ),
//     );
//   }

//   void sendEmail() async {
//     final Email email = Email(
//       body: 'Email body',
//       subject: 'Email subject',
//       recipients: ['recipient@example.com'],
//       attachmentPaths: [await _createCSVFile()],
//       isHTML: false,
//     );

//     String platformResponse;

//     try {
//       await FlutterEmailSender.send(email);
//       platformResponse = 'Email sent';
//     } catch (error) {
//       platformResponse = error.toString();
//     }

//     print(platformResponse);
//   }

//   Future<String> _createCSVFile() async {
//     List<List<dynamic>> rows = List<List<dynamic>>();
//     rows.add(["Name", "Age", "Email"]);
//     rows.add(["John Doe", 30, "john.doe@example.com"]);
//     rows.add(["Jane Smith", 25, "jane.smith@example.com"]);

//     String csv = const ListToCsvConverter().convert(rows);

//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/data.csv');

//     await file.writeAsString(csv);

//     return file.path;
//   }
// }

