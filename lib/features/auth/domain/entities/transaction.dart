enum TransactionType { airtimeSale, airtimeTransfer }

class Transaction {
  final TransactionType type;
  final DateTime dateTime;
  final double amount;
  final String currency; // e.g., "USD" or "ZWL"
  final String? recipient; // Optional: for transfers
  final String? serviceProvider; // Optional: for sales

  Transaction({
    required this.type,
    required this.dateTime,
    required this.amount,
    required this.currency,
    this.recipient,
    this.serviceProvider,
  });
}
