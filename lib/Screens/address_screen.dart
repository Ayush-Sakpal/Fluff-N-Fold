import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import '../components/marker_data.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  final MapController _mapController = MapController();

  List<MarkerData> _markerData = [];
  List<Marker> _marker = [];
  LatLng? selectedPosition;
  LatLng? myLocation;
  LatLng? draggedPosition;
  bool _isDragging = false;
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  Future<Position> determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    
    if(!serviceEnabled){
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("Location permissions are denied");
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error("Location permissions are permanently denied");
    }

    return await Geolocator.getCurrentPosition();
  }

  void showCurrentLocation() async{
    try{
      Position position = await determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLatLng, 15);

      setState(() {
        myLocation = currentLatLng;
      });
    }
    catch(e){
      print(e);
    }
  }

  void addMarker(LatLng position, String title, String description){
    setState(() {
      final markerData = MarkerData(position: position, title: title, description: description);
      
      _markerData.add(markerData);
      _marker.add(
        Marker(
            point: position,
            width: 80,
            height: 80,
            child: GestureDetector(
              onTap: (){},
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2)
                        )
                      ]
                    ),
                    child: Text(
                        title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                    size: 40,
                  )
                ],
              ),
            )
        )
      );
    });
  }

  void showMarkerDialog(BuildContext context, LatLng position){
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Add Marker"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(labelText: "Description"),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancel")
        ),
        TextButton(
            onPressed: (){
              addMarker(position, titleController.text, descController.text);
            },
            child: Text("Save")
        ),
      ],
    ));
  }

  void showMArkerInfo(MarkerData markerData){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(markerData.title),
          content: Text(markerData.description),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)
            )
          ],
        )
    );
  }

  Future<void> searchPlaces(String query) async{
    if(query.isEmpty){
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final url = 'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if(data.isNotEmpty){
      setState(() {
        _searchResults = data;
      });
    }
    else{
      setState(() {
        _searchResults = [];
      });
    }
  }

  void moveToLocation(double lat, double lng){
    LatLng location = LatLng(lat, lng);
    _mapController.move(location, 15.0);
    setState(() {
      selectedPosition = location;
      _searchResults = [];
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener((){
      searchPlaces(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
                options: MapOptions(
                  initialZoom: 13.0,
                  onTap: (tapPosition, LatLng){
                    selectedPosition = LatLng;
                    draggedPosition = selectedPosition;
                  }
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(markers: _marker),
        
                  if(_isDragging && draggedPosition == null)
                    MarkerLayer(markers: [
                      Marker(
                          point: draggedPosition!,
                          width: 80,
                          height: 80,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.indigo,
                            size: 40,
                          )
                      )
                    ]),
                  if(myLocation != null)
                    MarkerLayer(markers: [
                      Marker(
                          point: myLocation!,
                          width: 80,
                          height: 80,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 40,
                          )
                      )
                    ])
        
                ]
            ),
            
            Positioned(
              top: 40,
                left: 15,
                right: 15,
                child: Column(
                  children: [
                    SizedBox(
                      height: 55,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search Place...",
                            filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none
                          ),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: _isSearching
                              ? IconButton(
                              onPressed: (){
                                _searchController.clear();
                                setState(() {
                                  _isSearching = false;
                                  _searchResults = [];
                                });
                              },
                              icon: Icon(Icons.clear)) : null
                        ),
                        onTap: (){
                          setState(() {
                            _isSearching = true;
                          });
                        },
                      ),
                    ),

                    if(_isSearching && _searchResults.isNotEmpty)
                      Container(
                        color: Colors.white,
                        child: ListView.builder(
                          shrinkWrap: true,
                            itemCount: _searchResults.length,
                            itemBuilder: (ctx, index){
                              final place = _searchResults[index];
                              return ListTile(
                                title: Text(place['display_name'],),
                                onTap: (){
                                  final lat = double.parse(place['lat']);
                                  final lng  = double.parse(place['lng']);
                                  moveToLocation(lat, lng);
                                },
                              );
                            }

                        ),
                      )

                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
