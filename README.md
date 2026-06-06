# innovaxel_assessment

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Folder Architecture

Our app is organized into three main areas inside the `lib/` directory to keep the code clean and easy to manage:

- **`core/`**: This folder contains app-wide configurations and helpers that are shared across the entire application.
  - `theme/`: Deals with the app's look and feel, such as colors, dark mode, and UI constants.
  - `utils/`: Contains handy helper functions, like date formatters and currency formatters.

- **`data/`**: This is the data layer, responsible for managing where our data comes from and what it looks like.
  - `local_db/`: Handles the local database setup (e.g., SQLite, Hive, or SharedPreferences) to store data on the device.
  - `models/`: Defines the structures for our data objects (e.g., what an Expense looks like with its ID, title, amount, etc.).

- **`features/`**: This is where the actual features of our app live. Each feature (like `expenses`) has its own self-contained folder.
  - `repository/`: Acts as a bridge between the data layer (like the database) and our user interface.
  - `view_models/`: Contains the logic that connects our data to the screen (State Management).
  - `views/`: The actual screens and user interface elements that the user interacts with.
    - `widgets/`: Small, reusable UI components like custom buttons or expense cards.
