import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String username;
  final String dob;
  final String municipality;
  final String province;
  final String pictureUrl;
  final int userId;
  final int gender;

  const CustomListTile({
    Key? key,
    required this.username,
    required this.dob,
    required this.municipality,
    required this.province,
    required this.pictureUrl,
    required this.userId,
    required this.gender,
  }) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.red[50],
        child: ExpansionTile(
          title: Text(widget.username),
          initiallyExpanded: isExpanded,
          children: [
            ListTile(
                title: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        width: 80,
                        height: 80,
                        widget.pictureUrl,
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(
                  width: 18,
                ),
                Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User Id:  ${widget.userId.toString()}'),
                        Text(
                            'Gender: ${widget.gender == 1 ? 'Male' : 'Female'}'),
                        Text(
                            'Location: ${widget.municipality}, ${widget.province}'),
                        Text('DOB: ${widget.dob.split('T')[0]}'),
                      ],
                    )),
              ],
            )),
          ],
        ));
  }
}
