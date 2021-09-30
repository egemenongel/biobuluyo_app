import 'dart:async';
import 'dart:math';
import 'package:biobuluyo_app/marker_manager.dart';
import 'package:biobuluyo_app/models/expense_list.dart';
import 'package:provider/provider.dart';
import 'package:biobuluyo_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerPage extends StatefulWidget {
  const MarkerPage({Key? key}) : super(key: key);

  @override
  State<MarkerPage> createState() => MarkerState();
}

class MarkerState extends State<MarkerPage> {
  final List<Marker> _currentMarker = [];
  var _LatLng = const LatLng(40.8957472, 29.168124);
  var id = 0;
  var rnd = Random();
  late var randomColor = rnd.nextInt(360);
  var _marker;

  _handleTap(LatLng latLng) {
    setState(() {
      _marker = Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue((randomColor.toDouble())),
          markerId: MarkerId("id $id"),
          position: latLng,
          infoWindow: InfoWindow(title: latLng.toString()));
      _currentMarker.add(_marker);
      _LatLng = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _expenseListModel =
        Provider.of<ExpenseListModel>(context, listen: false);
    var _markerManager = Provider.of<MarkerManager>(context, listen: false);
    return Scaffold(
      body: GoogleMap(
        markers: Set.from(_currentMarker),
        onTap: _handleTap,
        initialCameraPosition: const CameraPosition(
            target: LatLng(40.9975443, 28.9243776), zoom: 8),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: ElevatedButton(
            onPressed: () {
              // _expenseListModel.loc = _LatLng.toString();
              //SUBMITTEN SONRA EKLENMELİ
              _markerManager.currentMarker = _marker;
              _markerManager.handleTap(_LatLng);

              // _markerManager.addMarker();
              debugPrint(
                  "LENGTH:" + _markerManager.markersList.length.toString());
              // print(_LatLng);
              Navigator.pop(context);
              // _expenseModel.setLocation(_LatLng);
            },
            child: const Text("Add this location"),
          ),
        ),
      ),
    );
  }
}
