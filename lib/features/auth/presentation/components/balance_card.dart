import 'package:flutter/material.dart';

class BalanceCard extends StatefulWidget {
  final double usdBalance;
  final double zwlBalance;
  final String serviceProvider;
  final String initialCurrency; // USD or ZWL

  const BalanceCard({
    super.key,
    required this.usdBalance,
    required this.zwlBalance,
    required this.serviceProvider,
    this.initialCurrency = 'USD',
  });

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  late String _currentCurrency;
  late double _displayedBalance;

  @override
  void initState() {
    super.initState();
    _currentCurrency = widget.initialCurrency;
    _updateDisplayedBalance();
  }

  void _updateDisplayedBalance() {
    if (_currentCurrency == 'USD') {
      _displayedBalance = widget.usdBalance;
    } else if (_currentCurrency == 'ZWL') {
      _displayedBalance = widget.zwlBalance;
    }
  }

  void _toggleCurrency() {
    setState(() {
      if (_currentCurrency == 'USD') {
        _currentCurrency = 'ZWL';
      } else {
        _currentCurrency = 'USD';
      }
      _updateDisplayedBalance();
    });
  }

  String get _currencySymbol {
    if (_currentCurrency == 'USD') {
      return '\$';
    } else if (_currentCurrency == 'ZWL') {
      return 'ZWL\$';
    }
    return '';
  }

  String get _nextCurrency {
    return _currentCurrency == 'USD' ? 'ZWL' : 'USD';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: _toggleCurrency,
        child: Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.serviceProvider,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_currencySymbol${_displayedBalance.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to switch to $_nextCurrency',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


