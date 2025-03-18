This Flutter application is designed for managing customer data with a login system, local database storage, and Google Maps integration.

🔹 Features
1️⃣ Login Page

User authentication with validation.
Only valid credentials (user@maxmobility.in / Abc@#123) allow access.
2️⃣ Customer List Page

Displays customer details (Image, Name, Mobile No, Email, Geo Address).
Data is fetched from the local database.
Google Maps integration: Clicking the map icon navigates to the customer's location from the user’s current location.
3️⃣ Add Customer Page

Allows users to add a new customer with the following details:
✔️ Full Name
✔️ Mobile No
✔️ Email ID
✔️ Address
✔️ Latitude & Longitude (Fetched via Geolocator)
✔️ Geo Address (Automatically captured)
✔️ Customer Image (With validation)
Data is stored in the local database.
4️⃣ Navigation & UI

Floating Action Button (FAB) on the Customer List page to navigate to the Add Customer page.
Implemented using BLoC Pattern or GetX for state management.
🛠 Tech Stack
Flutter (Dart)
State Management: BLoC / GetX
Database: Local Storage (Hive/Sqflite)
Google Maps API
Geolocator Package (For fetching user location)
🚀 Getting Started
Clone the repository.
Run flutter pub get to install dependencies.
Add required permissions in AndroidManifest.xml.
Run the app using flutter run.
This project provides an efficient and scalable approach to managing customers while ensuring smooth navigation and data handling.