import 'package:flutter/material.dart';
import '../models/aero_note.dart';
import 'dart:math';

class NoteProvider with ChangeNotifier {
  final List<AeroNote> _notes = [];

  List<AeroNote> get activeNotes => 
      _notes.where((note) => !note.isArchived).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  List<AeroNote> get archivedNotes => 
      _notes.where((note) => note.isArchived).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  void addNote(String title, String content, Color color) {
    if (title.isEmpty && content.isEmpty) return;
    
    final newNote = AeroNote(
      id: DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(1000).toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      color: color,
    );
    
    _notes.add(newNote);
    notifyListeners();
  }

  void updateNote(String id, String title, String content, Color color) {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(
        title: title,
        content: content,
        color: color,
      );
      notifyListeners();
    }
  }

  void toggleArchive(String id) {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] = _notes[index].copyWith(isArchived: !_notes[index].isArchived);
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}
