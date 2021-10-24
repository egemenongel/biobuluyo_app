import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';

import 'package:biobuluyo_app/pages/add_marker.dart';
import 'package:biobuluyo_app/pages/home.dart';

import '../marker_manager.dart';
import 'package:biobuluyo_app/models/expense.dart';
import 'package:biobuluyo_app/models/expense_list.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _expenseListModel =
        Provider.of<ExpenseListModel>(context, listen: true);
    var _markerManager = Provider.of<MarkerManager>(context, listen: false);

    final _formKey = GlobalKey<FormState>();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController costController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController? dateController = TextEditingController();

    void _sendForm() {
      ExpenseModel expenseModel = ExpenseModel(
        description: descriptionController.text,
        cost: int.parse(costController.text),
        date: DateTime.parse(dateController.text),
        category: categoryController.text,
      );
      _expenseListModel.addExpense(expenseModel);
    }

    String? _costValidation(String? value) {
      if (value!.isEmpty) {
        return "This field cannot be empty";
      } else if (double.tryParse(value) == null) {
        return "Please type a number";
      }
    }

    String? _validation(String? value) {
      if (value!.isEmpty) {
        return "This field cannot be empty";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Cost"),
                    controller: costController,
                    keyboardType: TextInputType.number,
                    validator: (value) => _costValidation(value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Description"),
                    controller: descriptionController,
                    validator: (value) => _validation(value),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Category"),
                    controller: categoryController,
                    validator: (value) => _validation(value),
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    initialValue: "",
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    onChanged: (val) => dateController.text = val,
                    validator: (value) => _validation(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ExpenseModel expenseModel = ExpenseModel(
                            description: descriptionController.text,
                            cost: int.parse(costController.text),
                            date: DateTime.parse(dateController.text),
                            category: categoryController.text,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MarkerPage(
                                        expense: expenseModel,
                                      )));
                        }
                      },
                      child: const Text("Add Location")),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _sendForm();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        }
                      }),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
