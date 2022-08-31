import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remake_storedata_to_spreadsheet/googlesheets.dart';
import 'package:remake_storedata_to_spreadsheet/sheetscolumn.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController feedbackController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
              ),
              TextFormField(
                controller: countryController,
              ),
              TextFormField(
                controller: feedbackController,
              ),
              GestureDetector(
                onTap: () async {
                  final feedback = {
                    SheetsColumn.name: nameController.text.trim(),
                    SheetsColumn.country: countryController.text.trim(),
                    SheetsColumn.feedback: feedbackController.text.trim(),
                  };

                  await SheetsFlutter.insert([feedback]);
                },
                child: Container(
                  height: 70,
                  width: 400,
                  color: Colors.red,
                  child: Center(child: Text('Send to Sheets')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
