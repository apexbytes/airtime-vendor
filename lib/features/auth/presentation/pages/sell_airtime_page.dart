import 'package:flutter/material.dart';

class SellAirtimePage extends StatefulWidget {
  const SellAirtimePage({super.key});

  @override
  State<SellAirtimePage> createState() => _SellAirtimePageState();
}

class _SellAirtimePageState extends State<SellAirtimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S e l l  A i r t i m e"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
    );
  }
}
