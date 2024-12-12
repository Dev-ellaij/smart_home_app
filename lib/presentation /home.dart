import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required Center body}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final double horizontalPadding = 40;
  final double verticalPadding = 25;

  // List of smart devices
  final List<List<dynamic>> mySmartDevices = [
    ["Smart Light", "assets/images/lightbulb.png", true],
    ["Smart AC", "assets/images/Smart Ac.png", false],
    ["Smart TV", "assets/images/lightbulb.png", true],
    ["Smart Fan", "assets/images/lightbulb.png", false],
  ];

  // Toggle switch method
  void togglePower(int index, bool value) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Welcome Home,",
                      style: GoogleFonts.bebasNeue(fontSize: 20),
                    ),
                    Text(
                      "FLUTTER FAIRY,",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "Smart Devices",
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              // Grid of smart devices
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                itemCount: mySmartDevices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  return SmartDeviceBox(
                    smartDeviceName: mySmartDevices[index][0],
                    iconpath: mySmartDevices[index][1],
                    powerOn: mySmartDevices[index][2],
                    onChanged: (value) => togglePower(index, value),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmartDeviceBox extends StatelessWidget {
  final String smartDeviceName;
  final String iconpath;
  final bool powerOn;
  final void Function(bool)? onChanged;

  const SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.iconpath,
    required this.powerOn,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: powerOn ? Colors.grey[900] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon
          Image.asset(
            iconpath,
            height: 65,
            color: powerOn ? Colors.white : Colors.black,
          ),
          // Smart Device Name and Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Device Name
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    smartDeviceName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: powerOn ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              // Switch
              Transform.rotate(
                angle: pi / 2,
                child: CupertinoSwitch(
                  value: powerOn,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
