import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          // Row with Device Name and Switch
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    smartDeviceName,
                    style: GoogleFonts.bebasNeue(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: powerOn ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
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
