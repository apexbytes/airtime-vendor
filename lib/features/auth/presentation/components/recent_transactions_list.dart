import 'package:flutter/material.dart';
import 'package:antelope/features/auth/presentation/components/transaction_list_item.dart';
import 'package:antelope/features/auth/domain/entities/transaction.dart';


class RecentTransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const RecentTransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("No recent transactions."),
        ),
      );
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionListItem(transaction: transactions[index]);
      },
    );
  }
}