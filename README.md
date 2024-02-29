# ThermStats

ThermStats is a Flutter-based Android application designed to fetch, display, and analyze temperature data from a predefined endpoint. This application is an excellent showcase of Flutter's capabilities in handling network requests, managing state, and rendering dynamic user interfaces. Users can view temperatures, highlight individuals with elevated temperatures, and visualize age-related temperature statistics.

## Features

- Fetch and display user temperature data from a remote endpoint.
- Highlight users with temperatures above 37°C.
- Sort and filter users based on name, age, or temperature.
- Visual representation of temperature data through a scatter plot chart.

## Getting Started

Follow the flutter main page for setting up your environment: https://flutter.dev/docs/get-started/install

## Application Structure

- `user_list_page.dart`: Manages the display of user data, including filtering and sorting functionalities.
- `dashboard_page.dart`: Provides an animated welcome message and serves as the landing page of the application.
- `base_layout.dart`: Handles the main layout and navigation between different sections of the app.
- `user_chart_page.dart`: Displays a scatter plot chart comparing user age to temperature.

For more detailed information on how to navigate and utilise the application, refer to the comments within each Dart file which explain the functionalities and logic in greater detail.
