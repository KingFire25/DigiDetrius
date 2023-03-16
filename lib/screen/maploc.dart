// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'constants.dart';

class mapLocation extends StatefulWidget{
  const mapLocation({super.key});

  @override
  State<mapLocation> createState() => _mapLocationState();
}

class _mapLocationState extends State<mapLocation> {
  late Uint8List markerIcon;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  void func()async{
  markerIcon = await getBytesFromAsset('assets/images/bus.png', 100);
  }

  
  LocationData? currentLocation;
  void getCurrentLocation()async{
    Location location = Location();
    location.getLocation().then((location) => currentLocation = location);
    
    GoogleMapController gmapCont = await _controller.future;
    
    location.onLocationChanged.listen((newLoc) { 
      currentLocation = newLoc; 
      gmapCont.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 13.5,
          target: LatLng(newLoc.latitude!, newLoc.longitude!))));

      setState(() {});
      });
  }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
  Completer<GoogleMapController> _controller = Completer();
  
  static const LatLng src = LatLng(37.4220656, -122.0862837),
      dest = LatLng(37.33429383, -122.06600055),ms=LatLng(37.4116375, -122.0716626);
  GoogleMapPolyline polyline = GoogleMapPolyline(apiKey: api_key);
  List<LatLng> polyCoord = [];
  void getPoints() async{
    PolylinePoints points = PolylinePoints();
    PolylineResult res = await points.getRouteBetweenCoordinates(api_key,
    PointLatLng(src.latitude, src.longitude),PointLatLng(dest.latitude, dest.longitude));

    if(res.points.isNotEmpty){
        res.points.forEach(
          (PointLatLng point) => 
          polyCoord.add(LatLng(point.latitude,point.longitude))
          );
        setState(() {});
      }
    }
  
  @override
  void initState(){
    getCurrentLocation();
    func();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Maps"),
          elevation: 0,
        ),
        body: currentLocation == null ? 
        const Center(child: Text("Loading")) : 
        GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),zoom: 13.5),
          markers: {
            Marker(markerId: const MarkerId("current"),position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            icon: BitmapDescriptor.fromBytes(markerIcon)),
            const Marker(markerId: MarkerId("source"),position:src,),
            const Marker(
              markerId: MarkerId("ms"),
              position: ms,
            )
          },
          onMapCreated: (mapController) {
            _controller.complete(mapController);
          } ,
        ),
      ),
    );
  }
}