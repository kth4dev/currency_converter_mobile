# Currency Converter

Offline-first currency converter app built with Flutter.

[Download APK](https://bit.ly/3Nr7LAv)

## Tech Stack

| Feature | Technology |
|---------|------------|
| Language | Dart |
| Architecture | Clean Architecture + MVVM + BLoC |
| Networking | Dio |
| Database | Drift |
| DI | GetIt |
| UI | Material3 |
| Testing | Bloc Test, Widget Test |
| Linting | Flutter Lints |

## Setup

### 1. Prerequisites
- Flutter SDK 3.38+ (Dart 3.10.7+)

### 2. Environment Configuration

Create `.env` file in project root:

```env
API_KEY=your_currencyfreaks_api_key
```

> Get API key from [CurrencyFreaks](https://currencyfreaks.com/)

### 3. Install & Run

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Testing

```bash
flutter test
```

## Features

- Offline-first with local caching
- Live currency rates from CurrencyFreaks API
- "Last Updated" / "Using Cached Data" indicator
- Saved currency conversion (USD → EUR)
- All supported currencies list
- Currency calculator
- Dark/Light theme (Material3)
