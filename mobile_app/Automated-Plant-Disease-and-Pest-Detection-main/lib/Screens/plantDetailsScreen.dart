import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:plant_disease_detection/Database/database_helper.dart';
import 'package:shimmer/shimmer.dart';

class DiseaseInfoScreen extends StatefulWidget {
  const DiseaseInfoScreen({super.key});

  @override
  _DiseaseInfoScreenState createState() => _DiseaseInfoScreenState();
}

class _DiseaseInfoScreenState extends State<DiseaseInfoScreen> {
  File? _image;
  List<dynamic>? data = [];
  String plantName = '';
  String diseaseName = '';
  List<String> symptoms = [];
  String cause = '';
  String detectionMechanisms = '';
  String recommendedTreatment = '';
  String preventiveMeasure = '';

  @override
  void initState() {
    super.initState();
    _checkConnectionAndLoadData();
  }

  Future<void> _checkConnectionAndLoadData() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.mobile ||
        // ignore: unrelated_type_equality_checks
        connectivityResult == ConnectivityResult.wifi) {
      // If connected to the internet, load data from API
      _fetchDataValueFromAPI();
    } else {
      // If offline, load data from local JSON
      _loadJsonData();
    }
  }

// functional method of the loading data from offline Json

  Future<void> _loadJsonData() async {
    // Load JSON file from assets
    String jsonString =
        await rootBundle.loadString('assets/jsonFiles/recommendationJson.json');

    // Decode JSON
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    setState(() {
      data = jsonMap['plants'];
    });
    print("Loaded offline data: $data");
  }

  Future<void> _fetchDataValueFromAPI() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.8.194:8000/api/predict'));

      if (response.statusCode == 200) {
        print(" this is data from backend Taddie $response");
        final apiData = json.decode(response.body);
        print(response.body);

        setState(() {
          plantName = apiData['plantName'] ?? 'Unknown';
          diseaseName = apiData['diseaseName'] ?? 'Unknown';
          symptoms = List<String>.from(apiData['symptoms'] ?? []);
          cause = apiData['cause'] ?? 'Unknown';
          detectionMechanisms = apiData['detectionMechanisms'] ?? 'Unknown';
          recommendedTreatment = apiData['recommendedTreatment'] ?? 'Unknown';
          preventiveMeasure = apiData['preventiveMeasure'] ?? 'Unknown';
        });
        print("Loaded online data: $apiData");
      } else {
        print('Failed to fetch data from API: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching data from API: $e");
      _loadJsonData();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Plant Disease Detail",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: data == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // we will display the image here
                    // Hero(
                    //   tag: 'plant-image',
                    //   child: _image == null
                    //       ? const Text('No image selected.')
                    //       : Image.file(_image!, height: 200, width: 200),
                    // ),
                    // const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () => _pickImage(ImageSource.gallery),
                    //   child: const Text('Edit Image'),
                    // ),
                    const SizedBox(height: 40),
                    const Text(
                      'Disease Information',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 400,
                      child: PageView(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              final plant = data![index];
                              final diseases =
                                  plant['diseases'] as List<dynamic>;

                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Display plant name
                                      Text(
                                        plant['plantName'] ?? 'Unknown Plant',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      // Display diseases for each plant
                                      ...diseases.map((disease) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                disease['diseaseName'] ??
                                                    'Unknown Disease',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                  "Symptoms: ${disease['symptoms']?.join(', ') ?? 'No symptoms available'}"),
                                              Text(
                                                  "Causes: ${disease['causes']?.join(', ') ?? 'No causes available'}"),
                                              Text(
                                                  "Detection Mechanism: ${disease['detectionMechanism'] ?? 'Unknown'}"),
                                              Text(
                                                  "Recommended Treatment: ${disease['recommendedTreatment']?.join(', ') ?? 'No treatment available'}"),
                                              Text(
                                                  "Preventive Measures: ${disease['preventiveMeasures']?.join(', ') ?? 'No preventive measures available'}"),
                                              const Divider(
                                                  thickness: 1,
                                                  color: Colors.grey),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          buildGradientCard('Plant Name', plantName),
                          buildGradientCard('Disease Name', diseaseName),
                          buildGradientCard('Symptoms', symptoms.join(', ')),
                          buildGradientCard('Cause', cause),
                          buildGradientCard(
                              'Detection Mechanisms', detectionMechanisms),
                          buildGradientCard(
                              'Recommended Treatment', recommendedTreatment),
                          buildGradientCard(
                              'Preventive Measure', preventiveMeasure),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildGradientCard(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
