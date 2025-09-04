import "dart:developer";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import "../controllers/wedding_controller.dart";
import "./detailed_screen.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  WeddingController weddingController = Get.find();
  ScrollController mainScrollController = ScrollController();
  List<Map> venues = [];

  double budgetFilter = 500000;
  double capacityFilter = 100;

  @override
  void initState() {
    super.initState();
    filter(budgetFilter, capacityFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "Let’s find your best \nwedding venue",
            style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wedding Venues",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  filterBottomSheet(context);
                },
                child: Text(
                  "Filter",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color.fromRGBO(228, 26, 94, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          controller: mainScrollController,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemCount: venues.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) => DetailedScreen(details: venues[index]),
                  ),
                );
              },
              child: Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(228, 26, 94, 0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Image.network(
                        venues[index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venues[index]["name"],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                  size: 20,
                                ),
                                Text(
                                  venues[index]["location"],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: const Color.fromRGBO(90, 90, 90, 1),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.reduce_capacity,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                  size: 20,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  "${venues[index]["capacity"]} Capacity",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: const Color.fromRGBO(90, 90, 90, 1),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                Text.rich(
                                  TextSpan(
                                    text: "${venues[index]["price"]}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: const Color.fromRGBO(
                                        228,
                                        26,
                                        94,
                                        1,
                                      ),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "/Day",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: const Color.fromRGBO(
                                            72,
                                            72,
                                            72,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> filterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: const Color.fromRGBO(255, 241, 244, 1),
      context: context,
      builder: (context) {
        double budgetSliderValue = budgetFilter;
        double capacitySliderValue = capacityFilter;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Adjust Budget",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    inactiveColor: const Color.fromRGBO(228, 26, 94, 0.2),
                    activeColor: const Color.fromRGBO(228, 26, 94, 1),
                    value: budgetSliderValue,
                    min: 40000,
                    max: 500000,
                    divisions: 10,
                    label: budgetSliderValue.round().toString(),
                    onChanged: (double value) {
                      modalSetState(() {
                        budgetSliderValue = value;
                      });
                    },
                  ),
                  Text("Selected Budget: ${budgetSliderValue.round()}"),
                  const SizedBox(height: 10),
                  const Text(
                    "Adjust Capacity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    inactiveColor: const Color.fromRGBO(228, 26, 94, 0.2),
                    activeColor: const Color.fromRGBO(228, 26, 94, 1),
                    value: capacitySliderValue,
                    min: 100,
                    max: 10000,
                    divisions: 50,
                    label: capacitySliderValue.round().toString(),
                    onChanged: (double value) {
                      modalSetState(() {
                        capacitySliderValue = value;
                      });
                    },
                  ),
                  Text("Selected Capacity: ${capacitySliderValue.round()}"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        budgetFilter = budgetSliderValue;
                        capacityFilter = capacitySliderValue;
                        weddingController.changeNavBarVisiblity(true);
                        filter(budgetFilter, capacityFilter);
                      });
                      Navigator.of(context).pop();
                    },
                    style: const ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(220, 55)),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(228, 26, 94, 1),
                      ),
                    ),
                    child: Text(
                      "Apply",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void filter(double budget, double capacity) {
    log("in filter fun");
    if (budget >= 500000 && capacity <= 100) {
      venues = weddingController.venues;
      return;
    }
    venues = [];
    for (Map x in weddingController.venues) {
      if (x["price"] <= budget && capacity <= x["capacity"]) {
        venues.add(x);
      }
    }
    log("${venues.length}");
    return;
  }
}
