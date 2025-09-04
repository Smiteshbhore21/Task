import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/controllers/login_session.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    required this.baseAmt,
    required this.capacity,
    required this.details,
    required this.fromBooked,
    this.photography = false,
    this.catering = false,
    this.mehendi = false,
    this.sangeet = false,
    this.honeymoon = false,
    super.key,
  });
  final int baseAmt, capacity;
  final Map details;
  final bool photography, catering, mehendi, sangeet, honeymoon, fromBooked;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool photography = false,
      catering = false,
      mehendi = false,
      sangeet = false,
      honeymoon = false;

  @override
  void initState() {
    super.initState();
    photography = widget.photography;
    catering = widget.catering;
    mehendi = widget.mehendi;
    sangeet = widget.sangeet;
    honeymoon = widget.honeymoon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 241, 244, 1),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_rounded, size: 30),
        ),
        title: Text(
          "Booking Venue",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 241, 244, 1),
      ),
      body: Column(
        children: [
          CheckboxListTile(
            title: Text(
              "Photography",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              "+₹30,000",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            fillColor:
                photography
                    ? const WidgetStatePropertyAll(
                      Color.fromRGBO(228, 26, 94, 1),
                    )
                    : null,
            value: photography,
            onChanged: (bool? value) {
              setState(() {
                photography = !photography;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              "Catering",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              "+₹200/Person",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            fillColor:
                catering
                    ? const WidgetStatePropertyAll(
                      Color.fromRGBO(228, 26, 94, 1),
                    )
                    : null,
            value: catering,
            onChanged: (bool? value) {
              setState(() {
                catering = !catering;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              "Mehendi",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              "+₹3000",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            fillColor:
                mehendi
                    ? const WidgetStatePropertyAll(
                      Color.fromRGBO(228, 26, 94, 1),
                    )
                    : null,
            value: mehendi,
            onChanged: (bool? value) {
              setState(() {
                mehendi = !mehendi;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              "Sangeet",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              "+₹7000",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            fillColor:
                sangeet
                    ? const WidgetStatePropertyAll(
                      Color.fromRGBO(228, 26, 94, 1),
                    )
                    : null,
            value: sangeet,
            onChanged: (bool? value) {
              setState(() {
                sangeet = !sangeet;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              "Honeymoon",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              "+₹30,000",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            fillColor:
                honeymoon
                    ? const WidgetStatePropertyAll(
                      Color.fromRGBO(228, 26, 94, 1),
                    )
                    : null,
            value: honeymoon,
            onChanged: (bool? value) {
              setState(() {
                honeymoon = !honeymoon;
              });
            },
          ),
          const Spacer(),

          Text(
            "Total: ₹${accumulate(widget.baseAmt, widget.capacity)}",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            height: 115,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 25),
            decoration: const BoxDecoration(boxShadow: [
               
              ],
            ),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("booked_venues")
                    .doc(LoginSession.userEmail)
                    .set({
                      widget.details["name"]: {
                        "total": accumulate(widget.baseAmt, widget.capacity),
                        "photography": photography,
                        "catering": catering,
                        "mehendi": mehendi,
                        "sangeet": sangeet,
                        "honeymoon": honeymoon,
                        "name": widget.details["name"],
                      },
                    });

                if (context.mounted) {
                  if (widget.fromBooked) {
                    Navigator.pop(context, true);
                  } else {
                    int count = 0;
                    Navigator.of(context).popUntil((route) {
                      return count++ == 2;
                    });
                  }
                }
              },
              style: const ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(55, 220)),
                backgroundColor: WidgetStatePropertyAll(
                  Color.fromRGBO(228, 26, 94, 1),
                ),
              ),
              child: Text(
                "Proceed",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int accumulate(int baseAmt, int capacity) {
    int total = baseAmt;
    if (photography) total += 30000;
    if (catering) total += (capacity * 200);
    if (mehendi) total += 3000;
    if (sangeet) total += 7000;
    if (honeymoon) total += 30000;
    return total;
  }
}
