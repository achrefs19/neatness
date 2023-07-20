import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart' as latLng;

class Geo extends StatelessWidget {
  const Geo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Neatness',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          body: new FlutterMap(
            options: MapOptions(
              center: latLng.LatLng(10.0, 10.0),
              zoom: 9.2,
            ),
            nonRotatedChildren: [
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: 'https://api.mapbox.com/styles/v1/achrefs9/clk8vymdc00og01qy28vg3fin/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWNocmVmczkiLCJhIjoiY2xrOHZhbHFtMDdpbjNlbzVib3EzNWZ4MSJ9.cS91fXGH_gJUcL_XNx8mxw',
                additionalOptions: {
                  'accessToken':
                  'pk.eyJ1IjoiYWNocmVmczkiLCJhIjoiY2xrOHZhbHFtMDdpbjNlbzVib3EzNWZ4MSJ9.cS91fXGH_gJUcL_XNx8mxw',
                  'id':
                  'mapbox.mapbox-streets-v7'
                },
              ),
            ],),
        )

    );
  }
}
