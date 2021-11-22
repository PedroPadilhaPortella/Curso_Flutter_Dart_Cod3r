import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (cyx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  "Nenhuma transação cadastrada.",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 30),
                Container(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(transaction: tr, onRemove: onRemove);
            },
          );
  }
}
