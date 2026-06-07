import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime dateTime;
  final String userId;
  final String? notes;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.dateTime,
    required this.userId,
    this.notes,
  });

  factory Expense.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Expense(
      id: doc.id,
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      category: data['category'] ?? 'Others',
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'dateTime': Timestamp.fromDate(dateTime),
      'userId': userId,
      if (notes != null) 'notes': notes,
    };
  }

  IconData getIcon() {
    switch (category.toLowerCase()) {
      case 'food':
      case 'food & drinks':
        return Icons.local_cafe_outlined;
      case 'shopping':
        return Icons.shopping_bag_outlined;
      case 'transportation':
      case 'transport':
        return Icons.directions_car_filled_outlined;
      case 'utilities':
        return Icons.receipt_long_outlined;
      case 'entertainment':
        return Icons.movie_outlined;
      case 'savings':
      case 'investment':
        return Icons.savings_outlined;
      default:
        return Icons.monetization_on_outlined;
    }
  }
}
