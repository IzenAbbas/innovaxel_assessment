import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/expense.dart';

class ExpenseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _userExpensesRef(String userId) {
    return _firestore.collection('users').doc(userId).collection('expenses');
  }

  Stream<List<Expense>> getExpenses(String userId) {
    return _userExpensesRef(userId)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Expense.fromFirestore(doc)).toList();
    });
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await _userExpensesRef(expense.userId).add(expense.toFirestore());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateExpense(Expense expense) async {
    try {
      await _userExpensesRef(expense.userId)
          .doc(expense.id)
          .update(expense.toFirestore());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteExpense(String userId, String expenseId) async {
    try {
      await _userExpensesRef(userId).doc(expenseId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
