import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
final uuid=Uuid();

enum Category {food ,travel ,leisure, business}
final formatter=DateFormat.yMd();
const  categoryIcons={
Category.food:Icons.dining,
Category.travel:Icons.flight_takeoff,
Category.leisure:Icons.movie,
Category.business:Icons.work

};
class Expense {
  Expense({
    
    required this.title,
    required this.amount,
    required this.date,
    required this.category
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
}


class ExpenseBucket{
  ExpenseBucket({required this.expenses,required this.category});
  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category): 
  expenses=allExpenses.where((element) => element.category==category).toList();
  final List<Expense> expenses;
  final Category category;
  double get getAmount{
    double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;
    }
    return sum;
}
}