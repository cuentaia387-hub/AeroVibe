import 'package:flutter/material.dart';

class AeroNote {
  final String id;
  String title;
  String content;
  DateTime createdAt;
  bool isArchived;
  Color color;

  AeroNote({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.isArchived = false,
    this.color = Colors.white,
  });

  // Create a copy with updated fields
  AeroNote copyWith({
    String? title,
    String? content,
    bool? isArchived,
    Color? color,
  }) {
    return AeroNote(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      isArchived: isArchived ?? this.isArchived,
      color: color ?? this.color,
    );
  }
}
