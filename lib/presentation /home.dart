import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Homepage extends StatefulWidget {
  final dynamic body;

  const Homepage({Key? key, required this.body}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isSubscribed = false; // Track subscription status
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSubscriptionStatus();
  }

  Future<void> _checkSubscriptionStatus() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Fetch subscription status
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      setState(() {
        isSubscribed =
            customerInfo.entitlements.all['entl4bd4bbffe4']?.isActive ?? false;
      });
    } catch (e) {
      print('Error fetching subscription info: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Method to handle subscription purchase
  Future<void> _makePurchase() async {
    try {
      // Replace 'your_product_id' with your actual product ID
      List<StoreProduct> products =
          await Purchases.getProducts(['your_product_id']);
      if (products.isNotEmpty) {
        StoreProduct product = products.first;
        await Purchases.purchaseProduct(product.identifier);
        _checkSubscriptionStatus(); // Refresh subscription status
      } else {
        print('No products found.');
      }
    } catch (e) {
      print('Error during purchase: $e');
    }
  }

  // List of smart devices with icons
  final List<List<dynamic>> mySmartDevices = [
    ["Smart Light", Icons.lightbulb, true],
    ["Smart AC", Icons.ac_unit, false],
    ["Smart TV", Icons.tv, true],
    ["Smart Fan", Icons.toys, false],
  ];

  // Toggle switch method for smart devices
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
              // Add Loading Indicator while fetching subscription status
              if (isLoading) const Center(child: CircularProgressIndicator()),
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
              // Show subscription status
              if (isSubscribed)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'You are subscribed to premium features!',
                    style: GoogleFonts.bebasNeue(fontSize: 20),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: _makePurchase,
                  child: const Text("Subscribe to Premium"),
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
                    icon: mySmartDevices[index][1],
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

class SmartDeviceBox extends StatefulWidget {
  final String smartDeviceName;
  final IconData icon;
  final bool powerOn;
  final void Function(bool)? onChanged;

  const SmartDeviceBox({
    super.key,
    required this.smartDeviceName,
    required this.icon,
    required this.powerOn,
    this.onChanged,
  });

  @override
  State<SmartDeviceBox> createState() => _SmartDeviceBoxState();
}

class _SmartDeviceBoxState extends State<SmartDeviceBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.powerOn) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(SmartDeviceBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.powerOn) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.powerOn ? Colors.grey[900] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Animated Icon
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Icon(
                  widget.icon,
                  size: 65,
                  color: widget.powerOn ? Colors.white : Colors.black,
                ),
              );
            },
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
                    widget.smartDeviceName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: widget.powerOn ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              // Switch
              Transform.rotate(
                angle: pi / 2,
                child: CupertinoSwitch(
                  value: widget.powerOn,
                  onChanged: widget.onChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
