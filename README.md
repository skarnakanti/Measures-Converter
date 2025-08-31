# Measures Converter

A Flutter app that converts values between common units across multiple measure types:
- Length (meters, kilometers, miles, feet, inches)
- Weight (kilograms, grams, pounds, ounces)
- Volume (liters, milliliters, gallons (US), cups)
- Temperature (Celsius, Fahrenheit, Kelvin)
- Area (square meters, square feet, acres, square kilometers)

This project was prepared for the "Construct Your First Flutter App using Dart" assignment. It follows best practices: separation of UI, models, and utility logic.

## Project structure
See the top-level `lib/` folder:
- `main.dart` — application entry point
- `screens/home_screen.dart` — main UI with cards and controls
- `widgets/` — small UI widgets used by the screen
- `models/unit.dart` — unit model
- `utils/converters.dart` — conversion logic (all conversions)

## Features
- Clean Material UI, responsive cards
- Separate conversion functions per measure (easy to extend)
- Input validation with friendly error messages
- At least five conversion categories implemented
- Easily extendable to add more units or measures

## How to run
1. Make sure Flutter SDK is installed. (https://docs.flutter.dev/get-started/install)
2. From the project root:
   ```bash
   flutter pub get
   flutter run
