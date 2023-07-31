import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_projects/constants.dart';
import 'package:flutter_projects/models/mapMarker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class LocationPicker extends StatefulWidget {
  LocationPicker({super.key,onLocationPickerChange});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}


class _LocationPickerState extends State<LocationPicker>
    with TickerProviderStateMixin {
  var currentLocation = LatLng(10.0, 10.0);

  void _handleOk() {

    Navigator.pop(context, currentLocation);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(10.0, 10.0),
        onTap: (x, l) => setState(() {
          currentLocation = l;
        }),
        minZoom: 5,
        maxZoom: 18,
        zoom: 9.2,
          screenSize: Size(80, 80)
      ),
      nonRotatedChildren: [
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/achrefs9/clk8vymdc00og01qy28vg3fin/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWNocmVmczkiLCJhIjoiY2xrOHZhbHFtMDdpbjNlbzVib3EzNWZ4MSJ9.cS91fXGH_gJUcL_XNx8mxw',
          additionalOptions: const {
            'accessToken':
                'pk.eyJ1IjoiYWNocmVmczkiLCJhIjoiY2xrOHZhbHFtMDdpbjNlbzVib3EzNWZ4MSJ9.cS91fXGH_gJUcL_XNx8mxw',
            'id': 'mapbox.mapbox-streets-v7'
          },
        ),
        Positioned(
            left: 0,
            right: 0,
            top: 2,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: const Color.fromARGB(255, 30, 29, 29),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () => _handleOk(),
                      child: Text("submit"),
                    )),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            )),
        MarkerLayer(
          markers: [
            Marker(
              height: 40,
              width: 40,
              point: currentLocation,
              builder: (_) {
                return GestureDetector(
                    onTap: () {
                      setState(() => {});
                    },
                    child: Image.asset(
                      'assets/red_marker.png',
                    ));
              },
            ),
          ],
        ),
      ],
    );
  }
}
