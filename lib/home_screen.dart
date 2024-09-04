import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoController =
      TextEditingController(text: "1");
  List<WaterTrack> waterTrackList = [];

  MyAlertDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: AlertDialog(
            title: Text("Alert!"),
            content: Text("Do you want to delete"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Tracker"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaterTrackCounter(),
          const SizedBox(
            height: 24,
          ),
          Expanded(child: _buildWaterTrackListView())
        ],
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        final WaterTrack waterTrack = waterTrackList[index];
        return ListTile(
          title:
              Text("${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute}"),
          subtitle: Text(
              "${waterTrack.dateTime.day}/${waterTrack.dateTime.month}/${waterTrack.dateTime.year}"),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
              child: Text("${waterTrack.noOfGlasses}")),
          trailing: IconButton(
              onPressed: () {
                MyAlertDialog(context);
              },
              icon: Icon(Icons.delete_outline_rounded)),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          "Glass/s",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 50,
                child: TextField(
                  controller: _glassNoController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                )),
          ],
        ),
        TextButton(onPressed: _addNewWaterTrack, child: const Text("Add")),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlasses;
    }
    return counter;
  }

  void _addNewWaterTrack() {
    if (_glassNoController.text.isEmpty) {
      _glassNoController.text = "1";
    }
    final int noOFGlasses = int.tryParse(_glassNoController.text) ?? 1;
    WaterTrack waterTrack =
        WaterTrack(noOfGlasses: noOFGlasses, dateTime: DateTime.now());
    waterTrackList.add(waterTrack);
    setState(() {});
  }
}

class WaterTrack {
  final int noOfGlasses;
  final DateTime dateTime;

  WaterTrack({required this.noOfGlasses, required this.dateTime});
}
