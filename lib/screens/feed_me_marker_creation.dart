import 'package:flutter/material.dart';
import 'package:ogive/api_callers/post.dart';
import 'package:ogive/models/user_location.dart';
import 'package:toast/toast.dart';
import 'package:numberpicker/numberpicker.dart';
import '../session_manager.dart';

class MarkerCreation extends StatefulWidget {
  @override
  _MarkerCreationState createState() => _MarkerCreationState();
}

class _MarkerCreationState extends State<MarkerCreation> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  NumberPicker integerNumberPicker;
  List<DropdownMenuItem<int>> _dropDownMenuItems;
  int _quantity = 1;
  int _priority = 1;
  List<int> priorities;
  @override
  void initState() {
    super.initState();
    priorities = [1, 3, 5, 7, 10];
    _dropDownMenuItems = buildDropDownMenuItems(priorities);
    _initializeNumberPickers();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.greenAccent, Colors.yellowAccent],
      )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.info,
                color: Colors.blue,
                size: 40,
              )),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _name,
            decoration: InputDecoration(
              labelText: 'name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _description,
            decoration: InputDecoration(
              labelText: 'describe it',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Quantity: $_quantity'),
          SizedBox(
            height: 10,
          ),
          RaisedButton.icon(
              onPressed: _showIntDialog,
              icon: Icon(Icons.touch_app),
              label: Text('Change Quantity')),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Priority: '),
              DropdownButton(
                value: _priority,
                items: _dropDownMenuItems,
                onChanged: onChangedDropdownItem,
                icon: Icon(Icons.arrow_drop_down),
                hint: Text('Select Priority'),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            child: Text('Create Marker'),
            onPressed: () async {
              UserLocation userLocation = new UserLocation();
              SessionManager sessionManager = new SessionManager();
              if (userLocation.getLatLng() == null)
                await userLocation.getUserLocation();
              Map<String, dynamic> map = await createMarker(
                  userLocation.getLatLng().latitude,
                  userLocation.getLatLng().longitude,
                  sessionManager.getUser().getID(),
                  _name.value.text,
                  _description.value.text,
                  _quantity,
                  _priority);
              if (map.values.elementAt(0) == 'done') {
                Toast.show('Thank You!', context,duration: 7);
                Navigator.pop(context);
              } else {
                Toast.show('Please fill all the required Data', context);
              }
            },
          )
        ],
      ),
    ));
  }

  void _initializeNumberPickers() {
    integerNumberPicker = new NumberPicker.horizontal(
      initialValue: _quantity,
      minValue: 1,
      maxValue: 10,
      step: 1,
      onChanged: (value) => setState(() => _quantity = value),
    );
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new Theme(
            data: ThemeData.dark(),
            child: NumberPickerDialog.integer(
                minValue: 1,
                maxValue: 10,
                step: 1,
                initialIntegerValue: _quantity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                )));
      },
    ).then((num value) {
      if (value != null) {
        print('Modifying Number $value');
        setState(() => _quantity = value);
      }
    });
  }

  List<DropdownMenuItem<int>> buildDropDownMenuItems(List<int> priorities) {
    List<DropdownMenuItem<int>> list = List();
    for (int priority in priorities) {
      list.add(
        DropdownMenuItem(
          value: priority,
          child: Text('${priority.toString()}'),
        ),
      );
    }
    return list;
  }

  void onChangedDropdownItem(value) {
    setState(() {
      _priority = value;
    });
  }
}
