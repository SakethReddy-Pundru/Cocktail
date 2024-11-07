# Cocktail
Sample SwiftUI Application with Static Data - The application follows the MVVM (Model-View-ViewModel) architecture combined with the Coordinator pattern to manage navigation.

This project is a SwiftUI-based iOS application for browsing and viewing details about various cocktails. It utilizes the MVVM architecture pattern alongside Combine for data management and a Coordinator pattern for handling navigation. The app is structured to be easily maintainable, with a clear separation between data, business logic, and user interface.

Key Features:

Main View:
The main screen displays a list of cocktails, organized by category (e.g., All, Alcoholic, Non-Alcoholic).
Each item in the list shows the cocktail's name and preparation time.
Tapping on a cocktail navigates to the detailed view of the selected cocktail.

Detail View:
The detail screen displays detailed information about the selected cocktail, including:
The cocktail's name, preparation time, and an image placeholder.
A description of the cocktail.
A list of ingredients.
The screen includes a back button, allowing the user to return to the main screen.

MVVM Architecture:
The project follows the MVVM (Model-View-ViewModel) pattern, separating the app into layers that handle data, UI, and business logic independently:
Model: Defines the structure of each cocktail, including properties like name, ingredients, and preparation time.
ViewModel: Manages data flow between the model and views. It contains business logic for fetching and displaying cocktail data.
View: SwiftUI views that render the UI based on the data provided by the ViewModel.

Combine Framework:
Combine is used to manage asynchronous data flow and state updates. The @Published properties in the ViewModels allow real-time data binding between the data and the UI components.

Coordinator Pattern:
A custom Coordinator pattern manages navigation between views, keeping the view hierarchy and navigation logic centralized and modular.
The coordinator determines whether the app displays the cocktail list screen or the detail screen based on user interaction.
