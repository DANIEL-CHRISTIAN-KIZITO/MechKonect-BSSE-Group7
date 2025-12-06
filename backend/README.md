# MechKonect Backend Logic

This folder contains all the backend logic for the MechKonect Flutter application. This includes data models, repositories, services, and API integration code.

## Structure

```
backend/
├── lib/
│   ├── core/
│   │   └── constants/
│   │       └── api_endpoints.dart      # API endpoint definitions
│   └── data/
│       ├── models/                     # Data models (User, Mechanic, Booking, Payment, Review)
│       ├── repositories/               # Data access layer (Auth, Booking, Mechanic, Payment)
│       ├── services/                   # Core services (API, Local Storage, Location, Notifications)
│       └── dev/
│           └── seed_data.dart          # Development seed data
└── README.md
```

## Components

### Models (`lib/data/models/`)

- **user_model.dart**: User data model with authentication fields
- **mechanic_model.dart**: Mechanic profile and workshop information
- **booking_model.dart**: Booking request and status tracking
- **payment_model.dart**: Payment transactions and wallet management
- **review_model.dart**: User reviews and ratings for mechanics

### Repositories (`lib/data/repositories/`)

- **auth_repository.dart**: Authentication logic (Phone OTP, Google Sign-In, Anonymous)
- **booking_repository.dart**: Booking CRUD operations with offline support
- **mechanic_repository.dart**: Mechanic search, filtering, and location-based queries
- **payment_repository.dart**: Wallet management and payment processing

### Services (`lib/data/services/`)

- **api_service.dart**: Retrofit-based API client for backend communication
- **local_storage_service.dart**: SQLite database for offline-first architecture
- **location_service.dart**: GPS and geocoding services
- **notification_service.dart**: Firebase Cloud Messaging integration

### Constants (`lib/core/constants/`)

- **api_endpoints.dart**: All API endpoint definitions and base URL configuration

### Development (`lib/data/dev/`)

- **seed_data.dart**: Sample data for testing and development

## API Endpoints

The application expects a REST API with the following endpoints (defined in `api_endpoints.dart`):

### Authentication

- `POST /auth/login` - Phone number login
- `POST /auth/register` - User registration
- `POST /auth/verify-otp` - OTP verification
- `POST /auth/resend-otp` - Resend OTP
- `POST /auth/google` - Google Sign-In
- `POST /auth/logout` - Logout
- `POST /auth/refresh` - Refresh token

### User

- `GET /user/profile` - Get user profile
- `PUT /user/profile` - Update user profile
- `PUT /user/phone` - Update phone number

### Mechanics

- `GET /mechanics` - Get all mechanics (with filters)
- `GET /mechanics/{id}` - Get mechanic details
- `GET /mechanics/{id}/reviews` - Get mechanic reviews
- `GET /mechanics/nearby` - Get nearby mechanics
- `GET /mechanics/search` - Search mechanics

### Bookings

- `POST /bookings` - Create booking
- `GET /bookings` - Get bookings (with filters)
- `GET /bookings/{id}` - Get booking details
- `PUT /bookings/{id}/status` - Update booking status
- `GET /bookings/{id}/track` - Track booking location
- `GET /bookings/history` - Get booking history
- `DELETE /bookings/{id}/cancel` - Cancel booking

### Payments

- `GET /payments/wallet/balance` - Get wallet balance
- `POST /payments/wallet/add` - Add funds to wallet
- `GET /payments/transactions` - Get transaction history
- `POST /payments/process` - Process payment

### Reviews

- `POST /reviews` - Create review
- `GET /reviews/{id}` - Get review details

### Emergency

- `POST /emergency` - Emergency SOS request
- `GET /emergency/contacts` - Get emergency contacts

## Database Schema

The local storage service uses SQLite with the following tables:

- `users` - User accounts
- `mechanics` - Mechanic profiles
- `bookings` - Booking records
- `payments` - Payment transactions
- `reviews` - User reviews

## Dependencies

This backend logic requires the following Flutter packages:

- `dio` - HTTP client
- `retrofit` - REST API client generator
- `json_annotation` - JSON serialization
- `sqflite` - SQLite database
- `firebase_auth` - Firebase authentication
- `google_sign_in` - Google Sign-In
- `geolocator` - Location services
- `geocoding` - Geocoding services
- `firebase_messaging` - Push notifications
- `flutter_secure_storage` - Secure token storage
- `shared_preferences` - Local preferences
- `connectivity_plus` - Network connectivity
- `permission_handler` - Permission management

## Usage

This backend logic is designed to work with the MechKonect Flutter mobile application. The code follows a clean architecture pattern with:

1. **Data Layer**: Models, repositories, and services
2. **Repository Pattern**: Abstracts data sources (API and local storage)
3. **Offline-First**: Local storage with sync capability
4. **Type Safety**: Strong typing with Dart models

## Notes

- The API service uses Retrofit for type-safe API calls
- All models are JSON serializable using `json_annotation`
- Local storage provides offline support with automatic sync
- Location services handle GPS permissions and geocoding
- Notification service integrates with Firebase Cloud Messaging

