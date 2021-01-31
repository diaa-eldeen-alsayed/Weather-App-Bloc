import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter a City"),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: TextFormField(
                controller: _cityTextController,
                decoration: InputDecoration(
                    labelText: "Enter a city ", hintText: "Example: Chicago"),
              ),
            )),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.pop(context, _cityTextController.text);
                })
          ],
        ),
      ),
    );
  }
}
