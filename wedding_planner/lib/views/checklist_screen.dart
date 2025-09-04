import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/controllers/login_session.dart';
import 'package:wedding_planner/controllers/wedding_controller.dart';
import 'package:wedding_planner/views/booking_screen.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  WeddingController weddingController = Get.find();
  ScrollController mainScrollController = ScrollController();
  List<Map> venues = [];

  @override
  void initState() {
    super.initState();
    fetchVenues();
  }

  void fetchVenues() async {
    venues = [];
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance
            .collection("booked_venues")
            .doc(LoginSession.userEmail)
            .get();

    if (documentSnapshot.exists) {
      log("${documentSnapshot.data()}");
      final data = documentSnapshot.data();
      if (data is Map<String, dynamic>) {
        data.forEach((key, value) {
          venues.add(value);
        });
      }
      log("venues : $venues");
      setState(() {});
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Booked Venues",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          controller: mainScrollController,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemCount: venues.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                int baseAmt = 0, capacity = 0;
                for (Map x in weddingController.venues) {
                  if (x["name"] == venues[index]["name"]) {
                    baseAmt = x["price"];
                    capacity = x["capacity"];
                    break;
                  }
                }

                var res = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BookingScreen(
                        baseAmt: baseAmt,
                        capacity: capacity,
                        details: venues[index],
                        photography: venues[index]["photography"],
                        catering: venues[index]["catering"],
                        mehendi: venues[index]["mehendi"],
                        sangeet: venues[index]["sangeet"],
                        honeymoon: venues[index]["honeymoon"],
                        fromBooked: true,
                      );
                    },
                  ),
                );
                if (res == true) {
                  setState(() {
                    fetchVenues();
                  });
                }
              },
              child: Container(
                height: 70,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                const Spacer(),
                                Text.rich(
                                  TextSpan(
                                    text: "₹${venues[index]["total"]}",
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
                                        text: " - Total",
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
}
