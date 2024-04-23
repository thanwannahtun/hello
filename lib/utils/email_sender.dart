import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

class EmailSender extends StatefulWidget {
  const EmailSender({super.key});

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'my.thanwanna@gmail.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  Future<void> send() async {
    await _attachFileFromAppDocumentsDirectoy();
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  bool _isInitial = true;

  List<List<dynamic>> csvLists = [];

  @override
  void didChangeDependencies() {
    debugPrint('called DidChangeDepencies!');
    if (_isInitial) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        Map<String, dynamic> arguments =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

        if (arguments['csv_list'] != null) {
          csvLists = arguments['csv_list'];
          debugPrint('csvList dependencies : $csvLists   ${csvLists.length}');
        }
      }
    }
    _isInitial = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Sender '),
        actions: <Widget>[
          IconButton(
            onPressed: send,
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
            CheckboxListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
              title: const Text('HTML'),
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    isHTML = value;
                  });
                }
              },
              value: isHTML,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  for (var i = 0; i < attachments.length; i++)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            attachments[i],
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => {_removeAttachment(i)},
                        )
                      ],
                    ),
                  // TextButton(
                  //   child: const Text('Attach file in app documents directory'),
                  //   onPressed: () => _attachFileFromAppDocumentsDirectoy(),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  Future<void> _attachFileFromAppDocumentsDirectoy() async {
    String csvData = const ListToCsvConverter().convert(csvLists);

    // if(csvData.isEmpty)csvData = "id,name,age,address,email,phone";

    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDocumentDir.path}/file.csv';
      final file = File(filePath);
      await file.writeAsString(csvData);

      debugPrint('csvData : $csvData');
      setState(() {
        attachments.add(filePath);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create file in applicion directory'),
        ),
      );
    }
  }
}

class EmailService {
  Future<String> send(
      {String subject = '',
      List<String> recipients = const [],
      List<String> cc = const [],
      List<String> bcc = const [],
      String body = '',
      List<String>? attachmentPaths,
      bool isHTML = false}) async {
    final email = Email(
        subject: subject,
        body: body,
        attachmentPaths: attachmentPaths,
        recipients: recipients,
        bcc: bcc,
        cc: cc,
        isHTML: isHTML);

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    return platformResponse;
    // if (!mounted) return;

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(platformResponse),
    //   ),
    // );
  }
}
