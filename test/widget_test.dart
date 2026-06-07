import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innovaxel_assessment/data/models/expense.dart';

void main() {
  group('Expense Model Tests', () {
    test('Expense model properties', () {
      final dateTime = DateTime.now();
      final expense = Expense(
        id: '1',
        title: 'Lunch',
        amount: 15.5,
        category: 'Food',
        dateTime: dateTime,
        userId: 'user_123',
        notes: 'Delicious burger',
      );

      expect(expense.id, '1');
      expect(expense.title, 'Lunch');
      expect(expense.amount, 15.5);
      expect(expense.category, 'Food');
      expect(expense.dateTime, dateTime);
      expect(expense.userId, 'user_123');
      expect(expense.notes, 'Delicious burger');
    });

    test('Expense getIcon returns correct icon for categories', () {
      final expenseFood = Expense(
        id: '1',
        title: 'Coffee',
        amount: 4.5,
        category: 'Food & Drinks',
        dateTime: DateTime.now(),
        userId: 'user_123',
      );

      final expenseShopping = Expense(
        id: '2',
        title: 'Shirt',
        amount: 25.0,
        category: 'Shopping',
        dateTime: DateTime.now(),
        userId: 'user_123',
      );

      final expenseOther = Expense(
        id: '3',
        title: 'Random',
        amount: 10.0,
        category: 'UnknownCategory',
        dateTime: DateTime.now(),
        userId: 'user_123',
      );

      expect(expenseFood.getIcon(), Icons.local_cafe_outlined);
      expect(expenseShopping.getIcon(), Icons.shopping_bag_outlined);
      expect(expenseOther.getIcon(), Icons.monetization_on_outlined);
    });

    test('Expense toFirestore map representation', () {
      final dateTime = DateTime.now();
      final expense = Expense(
        id: '1',
        title: 'Taxi',
        amount: 12.0,
        category: 'Transport',
        dateTime: dateTime,
        userId: 'user_123',
        notes: 'Business trip',
      );

      final map = expense.toFirestore();
      expect(map['title'], 'Taxi');
      expect(map['amount'], 12.0);
      expect(map['category'], 'Transport');
      expect(map['userId'], 'user_123');
      expect(map['notes'], 'Business trip');
    });
  });
}
