import 'package:flutter/material.dart';

import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Buscador extends StatefulWidget {
  @override
  _BuscadorState createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  late GoogleMapController _mapController;
  LatLng target = LatLng(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscador'),
      ),
      body: Column(
        children: <Widget>[
          AddressSearchTextField(
            country: "Bolivia",
            onDone: (AddressPoint point) {
              print(point.latitude);
              print(point.longitude);

              target = LatLng(point.latitude, point.longitude);
              _mapController.animateCamera(
                CameraUpdate.newLatLng(
                  target,
                ),
              );

              Navigator.of(context).pop();
            },
            hintText: '',
            noResultsText: '',
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(0, 0), zoom: 20),
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) => _mapController = controller,
            ),
          ),
        ],
      ),
    );
  }
}
