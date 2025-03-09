
import 'package:flutter/material.dart';
import 'package:more_in_flutter/models/expense.dart' as expense;
import 'package:intl/intl.dart';

final formatter=DateFormat.yMd();

class NewExpense extends StatefulWidget{
    const NewExpense({super.key,required this.registeredExpenses});
    final void Function(expense.Expense newExpense) registeredExpenses;
    State<StatefulWidget> createState(){
      return _NewExpenseState();
    }

}
class _NewExpenseState extends State<NewExpense>{
  final _titleController=TextEditingController();
  final _amountController=TextEditingController();
  DateTime? selectedDate;
   expense.Category _selectedCategory=expense.Category.leisure;

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }
  void _submitForm(){
    final title=_titleController.text;
    final number=double.tryParse(_amountController.text);
    bool NumberIsInvalid=number==null || number<=0;
    if(title.trim().isEmpty || NumberIsInvalid || selectedDate==null){

      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: const Text(
        'Invalid Input'
        ),
        content: 
         const Text(
          'Please enter valid inputs!'
          ),
          actions: [
            TextButton(
              child:const Text('Okay'),
            onPressed:(){
              Navigator.pop(ctx);
            })
          ],
      )
      );
      return;
    }
    final exp=expense.Expense(title:_titleController.text,amount:number,category:_selectedCategory,date:selectedDate??DateTime.now());
    widget.registeredExpenses(exp);
    Navigator.pop(context);

  }
  
  
  
  void _datePicker() async {
    final now=DateTime.now();
    final initialDate=DateTime(now.year-1,now.month,now.day);
    
    final date=await showDatePicker(context: context,initialDate: now,firstDate: initialDate,lastDate:now);
    setState(() {
      selectedDate=date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace=MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraints){
      final width=constraints.maxWidth;
      return   Container(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: 
          EdgeInsets.fromLTRB(16,48,16,keyboardSpace+16),
          child:Column(
            children: [
              if(width >=600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                                    controller: _titleController,
                                    maxLength: 60,
                                    decoration:const  InputDecoration(
                    label:Text('Enter Title')
                                    ),
                                  ),
                  ),
              SizedBox(width: 10,),
               Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller:_amountController,
                      decoration: const InputDecoration(
                        prefixText:'\$' ,
                        label: Text('Amount')
                      )
                    ),
                  ),
                ],
              )
              else
              TextField(
                controller: _titleController,
                maxLength: 60,
                decoration:const  InputDecoration(
                  label:Text('Enter Title')
                ),
              ),
              if(width >=600)
              Row(children: [
                
                    DropdownButton(
                    value: _selectedCategory,
                    items: expense.Category.values.map((cat)=> DropdownMenuItem(child:Text(cat.name.toUpperCase()),value:cat)).toList()
                  , 
                  onChanged: (category){
                    if(category==null){
                      return;
        
                    }
                    setState((){
                      _selectedCategory=category;
                    });
        
                  }),
                  Expanded(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(selectedDate==null?"No Date selected":formatter.format(selectedDate!)),
                        IconButton(
                          onPressed: (){
                            _datePicker();
        
                        }, 
                        icon: Icon(Icons.calendar_month))
                      ],
                      
                      ) 
                    ),

              ],)
              else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller:_amountController,
                      decoration: const InputDecoration(
                        prefixText:'\$' ,
                        label: Text('Amount')
                      )
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(selectedDate==null?"No Date selected":formatter.format(selectedDate!)),
                        IconButton(
                          onPressed: (){
                            _datePicker();
        
                        }, 
                        icon: Icon(Icons.calendar_month))
                      ],
                      
                      ) 
                    )
        
                ],
              ),
        
              const SizedBox(height: 16,),
              if(width>=600)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 
                 
                  
                ElevatedButton(onPressed: (){
                  _submitForm();
                }, 
                child:
                const  Text('Save Expense'),
                
                ),
                SizedBox(width: 4,),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                }, 
                child: const Text('Cancel',
                )
                )
              ],)
              else
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: expense.Category.values.map((cat)=> DropdownMenuItem(child:Text(cat.name.toUpperCase()),value:cat)).toList()
                  , 
                  onChanged: (category){
                    if(category==null){
                      return;
        
                    }
                    setState((){
                      _selectedCategory=category;
                    });
        
                  }),
                  const Spacer(),
                  
                ElevatedButton(onPressed: (){
                  _submitForm();
                }, 
                child:
                const  Text('Save Expense')
                ),
                SizedBox(width: 4,),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                }, 
                child: const Text('Cancel',
                )
                )
              ],)
            ],
          )
          ),
      ),
    );

    });
    
  }
}