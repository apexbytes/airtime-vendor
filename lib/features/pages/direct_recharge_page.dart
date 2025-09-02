import 'package:flutter/material.dart';

import 'package:antelope/features/auth/presentation/components/my_button.dart';
import 'package:antelope/features/auth/presentation/components/my_custom_dialog.dart';
import 'package:antelope/features/auth/presentation/components/my_select_dropdown.dart';
import 'package:antelope/features/auth/presentation/components/my_textfield.dart';
import 'package:flutter/services.dart';

class DirectRechargePage extends StatefulWidget {
  const DirectRechargePage({super.key});

  @override
  State<DirectRechargePage> createState() => _DirectRechargePageState();
}

class _DirectRechargePageState extends State<DirectRechargePage> {
  // State variables for dropdowns
  String? _selectedNetworkProvider;
  String? _selectedCurrency;
  double? _selectedDenomination;

  // Controller for the TextField
  final TextEditingController _recipientMobileController = TextEditingController();

  // Data for dropdowns
  final List<String> _networkProviders = ['Netone', 'Econet', 'Telecel'];
  final List<String> _currencies = ['USD', 'ZWL'];
  final List<double> _denominations = [0.10, 0.20, 0.50, 1, 2, 5, 10, 20, 50];

  // Inside _DirectRechargePageState class

  void _processRecharge() async {
    // Basic Validation (optional but recommended)
    if (_selectedNetworkProvider == null ||
        _selectedCurrency == null ||
        _selectedDenomination == null ||
        _recipientMobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String summary =
        'You are about to buy $_selectedNetworkProvider $_selectedCurrency ${_selectedDenomination?.toStringAsFixed(2)} for ${_recipientMobileController.text}.';

    final bool? isConfirmed = await showConfirmationDialog(
      context,
      title: 'Confirm Airtime Sale',
      content: summary,
      confirmButtonText: 'Confirm',
      cancelButtonText: 'Cancel',
    );

    if (isConfirmed == true) {
      // User confirmed, proceed with the actual recharge logic
      print('User Confirmed: Processing Recharge...');
      print('Network Provider: $_selectedNetworkProvider');
      print('Currency: $_selectedCurrency');
      print('Denomination: $_selectedDenomination');
      print('Recipient Mobile: ${_recipientMobileController.text}');

      // Replace with your actual API call or recharge logic
      // For example:
      // bool success = await _myApiService.performRecharge(
      //   provider: _selectedNetworkProvider!,
      //   currency: _selectedCurrency!,
      //   denomination: _selectedDenomination!,
      //   mobileNumber: _recipientMobileController.text,
      // );

      // if (success) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Recharge for ${_recipientMobileController.text} successful!'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      //   // Optionally clear fields or navigate away
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Recharge failed. Please try again.'),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // }

      // For now, just show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Recharge for ${_recipientMobileController.text} initiated!',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // User cancelled
      print('User Cancelled Recharge.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recharge cancelled.'),
        ),
      );
    }
  }


  @override
  void dispose() {
    _recipientMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("D i r e c t  R e c h a r g e"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 1. Network Provider Dropdown
              MySelectDropdown<String>(
                hintText: 'Select Network Provider',
                value: _selectedNetworkProvider,
                items: _networkProviders.map((String provider) {
                  return DropdownMenuItem<String>(
                    value: provider,
                    child: Text(provider),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedNetworkProvider = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),

              // 2. Currency Dropdown
              MySelectDropdown<String>(
                hintText: 'Select Currency',
                value: _selectedCurrency,
                items: _currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrency = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),

              // 3. Airtime Denominations Dropdown
              MySelectDropdown<double>(
                hintText: 'Select Airtime Denomination',
                value: _selectedDenomination,
                items: _denominations.map((double denomination) {
                  return DropdownMenuItem<double>(
                    value: denomination,
                    child: Text(denomination.toStringAsFixed(2)),
                  );
                }).toList(),
                onChanged: (double? newValue) {
                  setState(() {
                    _selectedDenomination = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),

              // 4. Recipient Mobile TextField
              MyTextfield(
                controller: _recipientMobileController,
                hintText: 'Recipient Mobile Number',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                obscureText: false,
              ),
              const SizedBox(height: 25),

              // 5. Process Button
              MyButton(
                onTap: _processRecharge,
                text: 'P R O C E S S',
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
