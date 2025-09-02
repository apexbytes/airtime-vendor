import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:antelope/features/auth/presentation/components/my_button.dart';
import 'package:antelope/features/auth/presentation/components/my_custom_dialog.dart';
import 'package:antelope/features/auth/presentation/components/my_select_dropdown.dart';
import 'package:antelope/features/auth/presentation/components/my_textfield.dart';



class RechargeVoucherPage extends StatefulWidget {
  const RechargeVoucherPage({super.key});

  @override
  State<RechargeVoucherPage> createState() => _RechargeVoucherPageState();
}

class _RechargeVoucherPageState extends State<RechargeVoucherPage> {
  String? _selectedNetworkProvider;
  String? _selectedVoucher; // Assuming voucher details might be strings for now
  final TextEditingController _quantityController = TextEditingController(text: "1"); // Default to 1

  // --- Mock Data ---
  // In a real app, this data might come from an API or a local database
  final List<String> _networkProviders = ['Netone', 'Econet', 'Telecel'];

  // This would likely be more complex, perhaps a Map or List of custom objects
  // Key: Network Provider, Value: List of Voucher Strings or Objects
  final Map<String, List<String>> _availableVouchers = {
    'Netone': ['Netone USD 1', 'Netone USD 2', 'Netone USD 5', 'Netone ZWL 100'],
    'Econet': ['Econet USD 1', 'Econet USD 3', 'Econet USD 5', 'Econet ZWL 200'],
    'Telecel': ['Telecel USD 0.50', 'Telecel USD 1', 'Telecel ZWL 50'],
  };

  List<DropdownMenuItem<String>> _getVoucherDropdownItems() {
    if (_selectedNetworkProvider == null || !_availableVouchers.containsKey(_selectedNetworkProvider)) {
      return []; // Return empty list if no provider selected or no vouchers for provider
    }
    return _availableVouchers[_selectedNetworkProvider]!
        .map((String voucher) => DropdownMenuItem<String>(
      value: voucher,
      child: Text(voucher),
    ))
        .toList();
  }
  // --- End Mock Data ---

  @override
  void initState() {
    super.initState();
    // Add listener to ensure quantity is always at least 1
    _quantityController.addListener(() {
      final text = _quantityController.text;
      if (text.isNotEmpty) {
        final value = int.tryParse(text);
        if (value != null && value < 1) {
          _quantityController.text = '1';
          _quantityController.selection = TextSelection.fromPosition(
              TextPosition(offset: _quantityController.text.length));
        }
      }
    });
  }


  void _processVoucherPurchase() async {
    if (_selectedNetworkProvider == null ||
        _selectedVoucher == null ||
        _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final int quantity = int.tryParse(_quantityController.text) ?? 1;
    if (quantity < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quantity must be at least 1.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String summary =
        'You are about to buy $quantity x "$_selectedVoucher" for $_selectedNetworkProvider.';

    final bool? isConfirmed = await showConfirmationDialog(
      context,
      title: 'Confirm Voucher Purchase',
      content: summary,
      confirmButtonText: 'Confirm',
      cancelButtonText: 'Cancel',
    );

    if (isConfirmed == true) {
      print('User Confirmed: Processing Voucher Purchase...');
      print('Network Provider: $_selectedNetworkProvider');
      print('Voucher: $_selectedVoucher');
      print('Quantity: $quantity');

      // --- Add your actual voucher purchase API call here ---
      // bool success = await _myApiService.purchaseVoucher(
      //   provider: _selectedNetworkProvider!,
      //   voucher: _selectedVoucher!,
      //   quantity: quantity,
      // );
      // if (success) { ... } else { ... }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Voucher purchase for $_selectedVoucher (Qty: $quantity) initiated!',
          ),
          backgroundColor: Colors.green,
        ),
      );
      // Optionally clear fields or navigate
      // setState(() {
      //   _selectedNetworkProvider = null;
      //   _selectedVoucher = null;
      //   _quantityController.text = "1";
      // });
    } else {
      print('User Cancelled Voucher Purchase.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Voucher purchase cancelled.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> voucherItems = _getVoucherDropdownItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text("R e c h a r g e  V o u c h e r"),
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
                    _selectedVoucher = null; // Reset voucher when provider changes
                    voucherItems = _getVoucherDropdownItems(); // Update voucher items
                  });
                },
              ),
              const SizedBox(height: 15),

              // 2. Available Airtime Vouchers Dropdown
              MySelectDropdown<String>(
                hintText: 'Select Available Airtime Voucher',
                value: _selectedVoucher,
                items: voucherItems,
                onChanged: _selectedNetworkProvider == null ? null : (String? newValue) {
                  setState(() {
                    _selectedVoucher = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),

              // 3. Quantity TextField
              MyTextfield(
                controller: _quantityController,
                hintText: 'Quantity (e.g., 1)',
                obscureText: false,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly, // Allow only digits
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) return newValue;
                    final number = int.tryParse(newValue.text);
                    if (number != null && number < 1) {
                      // If user tries to enter 0 or less, keep old value or set to 1
                      return oldValue.text == "0" ? const TextEditingValue(text: "1") : oldValue;
                    }
                    return newValue;
                  }),
                ],
              ),
              const SizedBox(height: 25),

              // 4. Process Button
              MyButton(
                onTap: _processVoucherPurchase,
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
