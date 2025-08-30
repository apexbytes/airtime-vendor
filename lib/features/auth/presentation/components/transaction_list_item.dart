import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:antelope/features/auth/domain/entities/transaction.dart';


class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    String title;
    IconData icon;
    Color iconColor;

    switch (transaction.type) {
      case TransactionType.airtimeSale:
        title = 'Airtime Sale';
        icon = Icons.shopping_cart; // Or any appropriate icon
        iconColor = Colors.green;
        break;
      case TransactionType.airtimeTransfer:
        title = 'Airtime Transfer';
        icon = Icons.send; // Or any appropriate icon
        iconColor = Colors.blue;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat('MMM d, yyyy - hh:mm a').format(transaction.dateTime),
                  style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              if (transaction.recipient != null)
                Text('To: ${transaction.recipient}',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              if (transaction.serviceProvider != null)
                Text('Provider: ${transaction.serviceProvider}',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            ],
          ),
          trailing: Text(
            '${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction.type == TransactionType.airtimeSale ? Colors.green : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
