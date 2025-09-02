import 'package:flutter/material.dart';
import 'package:antelope/features/auth/presentation/components/my_button.dart';
import 'package:antelope/features/auth/presentation/components/my_custom_dialog.dart';
import 'package:antelope/features/auth/presentation/components/my_select_dropdown.dart';
import 'package:antelope/features/auth/presentation/components/my_textfield.dart';
import 'package:flutter/services.dart';


class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String? _selectedNetworkProvider;
  String? _selectedCurrency;
  final TextEditingController _recipientMobileController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // --- Data ---
  final List<String> _networkProviders = ['Netone', 'Econet', 'Telecel'];
  final List<String> _currencies = ['USD', 'ZWL'];
  // --- End Data ---

  void _processTransfer() async {
    // Basic Validation
    if (_selectedNetworkProvider == null ||
        _selectedCurrency == null ||
        _recipientMobileController.text.isEmpty ||
        _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount greater than 0.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // Add more specific mobile number validation if needed

    String summary =
        'You are about to transfer $_selectedCurrency ${amount.toStringAsFixed(2)} '
        'from your $_selectedNetworkProvider account to ${_recipientMobileController.text}.';

    final bool? isConfirmed = await showConfirmationDialog(
      context,
      title: 'Confirm Airtime Transfer',
      content: summary,
      confirmButtonText: 'Confirm',
      cancelButtonText: 'Cancel',
    );

    if (isConfirmed == true) {
      print('User Confirmed: Processing Transfer...');
      print('Network Provider: $_selectedNetworkProvider');
      print('Currency: $_selectedCurrency');
      print('Recipient Mobile: ${_recipientMobileController.text}');
      print('Amount: ${amount.toStringAsFixed(2)}');

      // --- Add your actual transfer API call here ---
      // bool success = await _myApiService.performTransfer(
      //   provider: _selectedNetworkProvider!,
      //   currency: _selectedCurrency!,
      //   recipientMobile: _recipientMobileController.text,
      //   amount: amount,
      // );
      // if (success) { ... } else { ... }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transfer to ${_recipientMobileController.text} initiated!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      // Optionally clear fields
      // setState(() {
      //   _selectedNetworkProvider = null;
      //   _selectedCurrency = null;
      //   _recipientMobileController.clear();
      //   _amountController.clear();
      // });
    } else {
      print('User Cancelled Transfer.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transfer cancelled.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _recipientMobileController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T r a n s f e r  A i r t i m e"),
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

              // 3. Recipient Mobile Number TextField
              MyTextfield(
                controller: _recipientMobileController,
                hintText: 'Recipient Mobile Number',
                obscureText: false,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 15),

              // 4. Amount TextField
              MyTextfield(
                controller: _amountController,
                hintText: 'Amount (e.g., 5.50)',
                obscureText: false,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                 FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 25),

              // 5. Process Button
              MyButton(
                onTap: _processTransfer,
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

