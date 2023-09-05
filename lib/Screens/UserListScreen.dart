import 'dart:convert';

import 'package:coding_test/Components/customButton.dart';
import 'package:coding_test/Components/customListTile.dart';
import 'package:coding_test/models/userModel.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int pageNr = 1;
  final apiUrl = 'https://www.motesplatsen.se/api/v1/test/users?pageNr=';
  List<User> users = [];
  bool isLoading = false;

  Future<void> fetchData(int page) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('$apiUrl$page'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<User> fetchedUsers =
          jsonData.map((userJson) => User.fromJson(userJson)).toList();

      //users refreshed whebever page numebr changes
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(pageNr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: const Center(
            child: Text(
          'Mötesplatsen',
        )),
      ),
      body: Column(
        children: [
          // Buttons to change page number and view additional data
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                  text: 'Previous',
                  color: Colors.red[300]!,
                  onPressed: () {
                    if (pageNr > 1) {
                      setState(() {
                        pageNr--;
                      });
                      fetchData(pageNr);
                    }
                  },
                )),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                    child: CustomButton(
                  text: 'Next',
                  color: Colors.red[300]!,
                  onPressed: () {
                    setState(() {
                      pageNr++;
                    });
                    fetchData(pageNr);
                  },
                )),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await fetchData(pageNr);
              },
              child: ListView.builder(
                itemCount: users.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == users.length) {
                    if (isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const SizedBox();
                    }
                  }
                  final user = users[index];
                  return CustomListTile(
                    username: user.username,
                    userId: user.userId,
                    gender: user.gender,
                    dob: user.dateOfBirth,
                    municipality: user.municipality,
                    province: user.province,
                    pictureUrl: user.pictureUrl,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
