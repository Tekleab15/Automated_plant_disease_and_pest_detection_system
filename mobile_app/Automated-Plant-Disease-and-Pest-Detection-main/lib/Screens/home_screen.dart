import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:plant_disease_detection/Database/database_helper.dart';
import 'dart:io';
import 'package:plant_disease_detection/Screens/plantDetailsScreen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _PlantDiseaseDetectionState createState() => _PlantDiseaseDetectionState();
}

class _PlantDiseaseDetectionState extends State<HomeScreen> {
  File? _image;
  bool _isLoading = false;
  String? _selectedPlant;
  List<dynamic> results = [];
  String plant = '';
  String recommendation = '';
  String predicted_class = '';
  double confidence = 0.0;
  final List<String> _plants = ['corn', 'apple', 'potato', 'cactus'];

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to show a dialog for image source selection
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose source',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Capture image
                _pickImage(ImageSource.camera);
              },
              child: Row(
                children: const [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Camera'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Upload from gallery
                _pickImage(ImageSource.gallery);
              },
              child: Row(
                children: const [
                  Icon(Icons.photo),
                  SizedBox(width: 8),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _SendDataToBackend() async {
    if (_image == null || _selectedPlant == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select an image and a plant type')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.8.194:8000/api/predict'),
      );

      // Add the image file to the request
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));

      // Add the selected plant type as part of the request
      request.fields['plant'] = _selectedPlant!;
      final streamedresponse =
          await request.send().timeout(const Duration(seconds: 100));
      final response = await http.Response.fromStream(streamedresponse);
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("recome :$responseData");
      plant = responseData['results']?[0]['plant'] ?? 'Unknown Plant';
      recommendation = responseData['results']?[0]['recommendation'] ??
          'No recommendation available';
      predicted_class =
          responseData['results']?[0]['predicted_class'] ?? 'Unknown Class';
      confidence = responseData['results']?[0]['confidence'] ?? 0.0;

      print("Plant type:$plant");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Image and plant type uploaded successfully')),
        );
        // Store data in SQLite database
        await DatabaseHelper()
            .insertRecommendation(_selectedPlant!, _image!.path);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const DiseaseInfoScreen()),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to upload image and plant type')),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request timed out or failed')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          ' Detection Page',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          "assets/images/leaf.jpg",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 71, 103, 169),
                        highlightColor: Colors.white,
                        child: const Text(
                          ' Community Based Technology!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        ' Diagnose infected plants with just one photo',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  SizedBox(height: 30),

                  // Dropdown for selecting plant type
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              prefixIcon: const Icon(Icons.eco),
                            ),
                            hint: const Text('Choose plant'),
                            value: _selectedPlant,
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedPlant = newValue;
                              });
                            },
                            items: _plants.map((plant) {
                              return DropdownMenuItem<String>(
                                value: plant,
                                child: Text(plant),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_selectedPlant != null)
                    Column(
                      children: [
                        Card(
                          // elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                _image == null
                                    ? const Text('No image selected.')
                                    : Image.file(_image!),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _showImageSourceDialog,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                    backgroundColor:
                                        const Color.fromARGB(255, 10, 111, 200),
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text(
                                    'Take image',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(156, 250, 185, 5)),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: _SendDataToBackend,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                    backgroundColor: const Color(0xFF0AC898),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('Detect'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: Column(children: [
                                    Row(children: [
                                      Text(
                                        "Plant Type: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(plant),
                                    ]),
                                    Row(children: [
                                      Text(
                                        "Recommendation: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(recommendation),
                                    ]),
                                    Row(
                                      children: [
                                        Text(
                                          "predicted_class: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(predicted_class),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Confidence: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("$confidence"),
                                      ],
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
