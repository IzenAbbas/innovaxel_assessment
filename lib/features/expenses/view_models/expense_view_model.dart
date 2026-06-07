import 'dart:async';
import 'package:flutter/material.dart';
import '../../../data/models/expense.dart';
import '../repository/expense_repository.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository _repository = ExpenseRepository();

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  StreamSubscription<List<Expense>>? _expensesSubscription;

  double get totalExpenses {
    double total = 0.0;
    for (final expense in _expenses) {
      total += expense.amount;
    }
    return total;
  }

  void listenToExpenses(String userId) {
    if (userId.isEmpty) {
      _expenses = [];
      _expensesSubscription?.cancel();
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _expensesSubscription?.cancel();
    _expensesSubscription = _repository
        .getExpenses(userId)
        .listen(
          (expenseList) {
            _expenses = expenseList;
            _isLoading = false;
            _errorMessage = null;
            notifyListeners();
          },
          onError: (error) {
            _isLoading = false;
            _errorMessage = error.toString();
            notifyListeners();
          },
        );
  }

  Future<bool> addExpense({
    required String title,
    required double amount,
    required String category,
    required DateTime dateTime,
    required String userId,
    String? notes,
  }) async {
    _setLoading(true);
    try {
      final expense = Expense(
        id: '',
        title: title,
        amount: amount,
        category: category,
        dateTime: dateTime,
        userId: userId,
        notes: notes,
      );
      await _repository.addExpense(expense);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<bool> updateExpense({
    required String id,
    required String title,
    required double amount,
    required String category,
    required DateTime dateTime,
    required String userId,
    String? notes,
  }) async {
    _setLoading(true);
    try {
      final expense = Expense(
        id: id,
        title: title,
        amount: amount,
        category: category,
        dateTime: dateTime,
        userId: userId,
        notes: notes,
      );
      await _repository.updateExpense(expense);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  Future<bool> deleteExpense(String userId, String expenseId) async {
    _setLoading(true);
    try {
      await _repository.deleteExpense(userId, expenseId);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _expensesSubscription?.cancel();
    super.dispose();
  }
}
