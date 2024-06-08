import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello/domain/api_utils/api_error_handler.dart';
import 'package:hello/domain/api_utils/api_service.dart';

class TestDioScreen extends StatefulWidget {
  const TestDioScreen({super.key});

  @override
  State<TestDioScreen> createState() => _TestDioScreenState();
}

class _TestDioScreenState extends State<TestDioScreen> {
  List<dynamic> users = [];

  @override
  initState() {
    print('initiState');
    super.initState();
    fetchUsers();
  }

  dynamic fetchUsers() async {
    try {
      final response = await ApiService().getRequest('/users');
      if (response.statusCode == 200) {
        users = response.data;
        print('>>>>>>>>>users>>>>>>> ${response.data}');
      }
      print('hello');
      setState(() {});
    } on DioException catch (e) {
      print('eeeeeee ::: ${ApiErrorHandler.handle(e)}');
      return ApiErrorHandler.handle(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dio TEst"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await fetchUsers();
                print('clicks');
              },
              child: const Text('Get Users')),
          Expanded(
              child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Text(users[index]['name']);
            },
          ))
        ],
      ),
    );
  }
}
