import 'package:flutter/material.dart';
import 'food_service.dart';
import 'dart:math';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final FoodService foodService = FoodService();
  String imageUrl = '';
  String category = 'burger'; // Default category
  bool isLoading = true;
  String errorMessage = '';
  int imageIndex = 0;

  // Function to get a random image each time
  void fetchImage() async {
    setState(() {
      isLoading = true;
      errorMessage = ''; // Clear previous errors
    });
    try {
      final result = await foodService.fetchFoodImage(category, imageIndex);
      setState(() {
        imageUrl = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load image: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foodish App mouhib '),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 196, 19),
        elevation: 5,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlue,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50, // Light background
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        value: category,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        items: foodService.images.keys.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(
                              category.toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                        onChanged: (newCategory) {
                          setState(() {
                            category = newCategory!;
                            imageUrl = '';
                            isLoading = true;
                            imageIndex = Random().nextInt(foodService
                                .images[category]!.length); // Random index
                          });
                          fetchImage();
                        },
                        underline: Container(), // Remove default underline
                        isExpanded: true, // Makes dropdown take full width
                      ),
                    ),
                    const SizedBox(height: 20),
                    errorMessage.isNotEmpty
                        ? Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                          )
                        : (isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.blueAccent,
                                strokeWidth: 6,
                              )
                            : imageUrl.isNotEmpty
                                ? Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height:
                                            300, // Increased height for bigger images
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          border: Border.all(
                                              color: Colors.blue.shade200,
                                              width: 2),
                                          image: DecorationImage(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit
                                                .contain, // Image will be contained
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            imageIndex = Random().nextInt(
                                                foodService.images[category]!
                                                    .length); // Random index for category
                                            isLoading = true;
                                          });
                                          fetchImage();
                                        },
                                        child: const Text('Next'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.greenAccent.shade700,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text('No image available')),
                  ],
                ),
              ),
            ),
          ),
          // The banner at the extreme bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.greenAccent.shade700,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'This application is created and developed by Mouhib Teyeb',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
