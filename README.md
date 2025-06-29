# Flutter Project—Momra

This project is a test application developed for PixelField,
showcasing a robust and scalable Flutter application structure.

## Project Overview

The PixelField Test project is built with **Flutter** to demonstrate best practices in mobile app development,
including clean architecture, modular design, and efficient state management.
It is designed for scalability, maintainability, and ease of testing.

## Architecture

The project adheres to **Clean Architecture**, streamlined to balance simplicity and functionality.
It is divided into the following layers:

- **Presentation**: UI components and state management.
- **Domain**: Business logic, use cases, and entities.
- **Data**: Repositories, data sources, and models.

The app is modularized to facilitate unit testing and future feature additions.
Each module is independent, reducing coupling and improving maintainability.

## State Management

State management is implemented using the **BLoC** pattern via the `flutter_bloc` package.
This approach separates business logic from the UI, ensuring:

- Reactive UI updates based on state changes.
- Scalable and maintainable code.
- Easy testing of business logic.

The `equatable` package is used to optimize object comparisons, reducing unnecessary rebuilds in the UI.

## Dependency Injection

Dependency injection is handled using `get_it` and `injectable`. This combination:

- Simplifies dependency management and initialization.
- Promotes modularity by injecting dependencies where needed.
- Reduces boilerplate code through `injectable`’s code generation.

## Data Handling

Data management is robust and efficient, leveraging the following tools:

- **Drift**: A reactive ORM for SQLite, used for local database operations. It provides type-safe queries and efficient caching.
- **Dartz**: A functional programming library that uses the `Either` type for graceful error handling.
- **Connectivity**: The `internet_connection_checker` package monitors network status, enabling the app to handle offline scenarios effectively.

## Code Generation

To minimize boilerplate and enhance maintainability, the project uses:

- **Freezed**: Generates immutable data classes and union types for state management and data models.
- **JsonSerializable**: Automates JSON serialization/deserialization for seamless API integration.
- **Injectable**: Generates dependency injection code for `get_it`.
- **Drift**: Generates database code from table definitions.

### Code Generation Commands

Run the following commands to generate the necessary code:

1. **Activate `flutter_gen` for asset generation**:
   ```bash
   dart pub global activate flutter_gen
   ```

2. **Generate code for Freezed, JsonSerializable, Injectable, and Drift**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Generate localization files**:
   ```bash
   flutter gen-l10n
   ```

4. **Generate app icons**:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

5. **Update app name**:
   ```bash
   dart run names_launcher:change
   ```

6. **Manage versioning with `pub_version_plus`**:
    - Activate the tool:
      ```bash
      dart pub global activate pub_version_plus
      ```
    - Update version (choose one):
      ```bash
      pubversion patch  # Increments patch version (e.g., 0.0.X)
      pubversion minor  # Increments minor version (e.g., 0.X.0)
      pubversion major  # Increments major version (e.g., X.0.0)
      pubversion build  # Increments build number (e.g., 0.0.0+X)
      pubversion get    # Displays current version
      pubversion set <version>  # Sets a specific version
      ```
7. **Change application package**:
   ```bash
   dart run change_app_package_name:main com.ministerOfficeCTS.momra
   ```



## Best Practices & Recommendations

- **Linting**: Use `flutter_lints` to enforce coding standards. Configure rules in `analysis_options.yaml` as needed.
- **Testing**: Write unit and widget tests using `flutter_test` to ensure code reliability.
- **Version Control**: Use `pub_version_plus` to manage versioning consistently.
- **Modularization**: Continue adding features as independent modules to maintain scalability.
- **Error Handling**: Leverage `dartz` for robust error management in all data operations.

## Getting Started

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Execute the code generation commands listed above.
4. Run the app using `flutter run`.

This project is designed to be a solid foundation for further development,
with a focus on clean code, scalability, and maintainability.


when remove 4 at the beging and 4 from the end and covert it to mp4