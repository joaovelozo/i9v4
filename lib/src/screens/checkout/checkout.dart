import 'package:flutter/material.dart';
import 'package:i9/src/screens/dashboard/dashboard.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
              icon: Icon(Icons.dashboard))
        ],
      ),
    ));
  }
}
