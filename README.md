# WeatherApp

# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Architecture](#architecture)
4. [Structure](#structure)
5. [Designs](#designs)
6. [Dependencies](#dependencies)
7. [API](#api)

# WeatherApp


# Description
<p>WeatherApp take home assignement is completed using SwiftUI<br>

# Getting started
<p>
1. Make sure you have the Xcode version 15.0 or above installed on your computer.<br>
2. Minimum iOS target: 15.0.<br>
3. Clone the Project from the given repository <br>
4. No need to run pod install as no dependencies are added<br>
5. Open the WeatherApp.xcodeproj in Xcode.<br>
6. Run the active scheme.<br>
7. You should see HomeView with searchbar on top of the screen.<br>
8. You can search from the Searchbar and corresponding to your search city data is shown.<br>
9. On clicking the city card detailed View of same city is available showing current temperature, humidity percentage, UV value, feels like temperature, location and corresponding waether type in the form of image is shown.<br>
10. Last searched City data is stored in the app and is used asgain to show the data listed in point number 9. on app restart.<br>

# Architecture
* WeatherApp project is implemented using the <strong>Model-View-ViewModel (MVVM)</strong> architecture pattern.
* WeatherApp project is implemented using the <strong>Combine</strong> framework.
* SwiftUI is used and has necessary design for the UI.
* ViewModel has any necessary data or business logic needed to generate the WeatherData on HomeView.
* View is responsible for displaying WeatherData on HomeView.
* Model is available, whenever ViewModel sends new updates.<br><br>


# Structure 
* "Home": The source code files for a specific module. Files within a module folder are organized into subfolders, such as "Views" or "Models".
* "APIServices": Files or classes related to communicating with an external API. This could include code for making HTTP requests to a web server, parsing responses, and handling any errors that may occur.
* "Helper": Files or resources that are shared across multiple parts of the project. Such as globalUtilities, and Extensions. Non-code files that are used by the project. These can include images and Color types of assets.


# Designs
<p>WeatherApp project UI is developed using [Figma Designs](https://www.figma.com/design/0zySCKWbyeRO805ifaz1lr/Weather-App-Test-Task?node-id=0-1)</p>

# Dependencies
* No dependencies or third party libraries are used in this app


# API 
* We are using a REST API 
* We are using **WeatherAPI.com** to fetch weather data:
    - API Documentation: [WeatherAPI Documentation](https://www.weatherapi.com/docs/).
    - Free tier includes current weather data with:
        - **Temperature**.
        - **Weather condition** (including an icon URL).
        - **Humidity (%).**
        - **UV index.**
        - **Feels like** temperature.
