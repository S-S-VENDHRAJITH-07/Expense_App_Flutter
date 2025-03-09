import 'package:flutter/material.dart';
import 'package:more_in_flutter/widgets/bottomsheet.dart';
import 'package:more_in_flutter/widgets/chart/chart.dart';
import 'package:more_in_flutter/widgets/expenses_list.dart';
import 'package:more_in_flutter/models/expense.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(amount: 1000, category: Category.travel, date: DateTime.now(), title: 'Singapore Booking'),
    Expense(amount: 2000, category: Category.business, date: DateTime.now(), title: 'Meeting'),
    Expense(amount: 3000, category: Category.leisure, date: DateTime.now(), title: 'Cinema'),
    Expense(amount: 4000, category: Category.food, date: DateTime.now(), title: 'Chinese food')
  ];

  void _onAddPressedOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(registeredExpenses: _addExpense);
      },
    );
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense removed'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() {
            _registeredExpenses.insert(index, expense);
          });
        }),
      ),
    );
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('No expenses added yet'),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(expensesList: _registeredExpenses, removeExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () {
              _onAddPressedOverlay();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
      ),
    );
  }
}
