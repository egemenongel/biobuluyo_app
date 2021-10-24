import 'package:flutter/foundation.dart';
import 'package:biobuluyo_app/models/expense.dart';

class ExpenseListModel extends ChangeNotifier {
  List<ExpenseModel> expenseList = [];
  int totalExpense = 0;
  var listIndex = 0;
  int markerId = 0;
  String category = "";

  addExpense(ExpenseModel expenseModel) {
    expenseList.add(expenseModel);
    // totalExpense += expenseModel.cost!;
    notifyListeners();
  }

  removeExpense(index) {
    expenseList.removeAt(index);
    notifyListeners();
  }

  editExpense(index, ExpenseModel expenseModel) {
    expenseList[index] = expenseModel;
    notifyListeners();
  }

  clearList() {
    expenseList.clear();
    notifyListeners();
  }
}
