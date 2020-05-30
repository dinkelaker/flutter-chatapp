# chatapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Backend configuration

## Firebase database rule

These rules enable a simple protection of user specific data:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Only the user itself can change its own user data
		match /users/{uid} {
      allow write: if request.auth != null && request.auth.uid == uid;    
    }

		// All users can read other users
    match /users/{uid} {
      allow read: if request.auth != null;    
    }

		// Only authenticated user can read and create any documents in chats
		match /chats/{document=**} {
      allow read, create: if request.auth != null;
    }
  }
}
```
