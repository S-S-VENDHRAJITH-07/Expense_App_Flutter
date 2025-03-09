import 'package:flutter/material.dart';
import 'package:more_in_flutter/models/expense.dart';
import 'package:more_in_flutter/widgets/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.removeExpense});
  final void Function(Expense expense) removeExpense;
  final List<Expense> expensesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: expensesList.length,
        itemBuilder: (ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
            ),
            key: ValueKey(expensesList[index]),
            onDismissed: (direction) {
              // Remove the item from the list
              removeExpense(expensesList[index]);
              // Optionally show a snackbar or some feedback
            },
            child: ExpenseItem(expense: expensesList[index])));
  }
}
