import 'package:flutter/material.dart';
import 'package:simple_calendar_events/models/event.dart';
import 'package:simple_calendar_events/services/database_service.dart';
import 'package:sqflite/sqflite.dart';

class EventService extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<Event>> getEventsForDate(DateTime date) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseService.tableName,
      where: 'date = ?',
      whereArgs: [date.toIso8601String().split('T')[0]],
    );

    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<void> addEvent(Event event) async {
    final db = await _databaseService.database;
    await db.insert(
      DatabaseService.tableName,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }
}