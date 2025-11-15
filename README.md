# Simple Calendar with Events

A simple Flutter calendar application that allows users to add and view events on specific dates.

## Features

*   Display a calendar view.
*   Add events to specific dates.
*   View a list of events for the selected day.
*   Uses SQLite for local storage.
*   Uses Provider for state management.

## Getting Started

1.  Clone the repository.
2.  Run `flutter pub get` to install dependencies.
3.  Run `flutter run` to start the application.

## Folder Structure


lib/
├── main.dart
├── screens/
│   ├── calendar_screen.dart
│   └── event_list_screen.dart
├── models/
│   └── event.dart
├── services/
│   ├── database_service.dart
│   └── event_service.dart

