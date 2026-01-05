# BookBridge App: Implementation Plan

This document outlines the phased implementation plan for the BookBridge Flutter application.

## Journal

*This section will be updated after each phase with a log of actions, learnings, surprises, and deviations from the plan.*

---

## Phase 1: Project Setup and Foundation

- [x] Create a Flutter package in the `book_bridge_app/` directory.
- [x] Remove boilerplate code from the new package, including the default `test` directory.
- [x] Update the `pubspec.yaml` file with the package description and set the version to `0.1.0`.

## Journal

### 2026-01-05 - Phase 1

- Created the Flutter project in `book_bridge_app/` directory. Had to rename the directory from `flutter/` to `book_bridge_app/` as `flutter` is a reserved keyword for package names.
- Removed the default `test` directory and cleared the content of `lib/main.dart`.
- Updated `pubspec.yaml` with the project description.
- Created `CHANGELOG.md` file with initial version `0.1.0`.
- [x] Create a placeholder `README.md` file.
- [x] Create a `CHANGELOG.md` file with an initial version of `0.1.0`.
- [ ] Commit the empty package to the current branch.
- [ ] Start the application on a preferred device using the `launch_app` tool.

After completing these tasks, the following steps will be taken:

- [ ] Run `dart fix --apply`.
- [ ] Run `dart analyze` and fix any issues.
- [ ] Run `dart format .`.
- [ ] Update this `IMPLEMENTATION.md` file with the current status and any learnings in the Journal.
- [ ] Use `git diff` to verify the changes and create a commit message for approval.
- [ ] Wait for user approval before proceeding to the next phase.

## Phase 2: Core Models and Services

- [ ] Create the domain models: `user_model.dart`, `book_model.dart`, `listing_model.dart`, `location_model.dart`.
- [ ] Create the Firebase services: `auth_service.dart`, `listing_service.dart`, `book_service.dart`, `user_service.dart`, `location_service.dart`.
- [ ] Create unit tests for the models and services.

After completing these tasks, the following steps will be taken:

- [ ] Run `dart fix --apply`.
- [ ] Run `dart analyze` and fix any issues.
- [ ] Run tests to ensure they all pass.
- [ ] Run `dart format .`.
- [ ] Reload the running application using `hot_reload`.
- [ ] Update this `IMPLEMENTATION.md` file with the current status and any learnings in the Journal.
- [ ] Use `git diff` to verify the changes and create a commit message for approval.
- [ ] Wait for user approval before proceeding to the next phase.

## Phase 3: Providers and Authentication

- [ ] Create the Riverpod providers: `auth_provider.dart`, `listing_provider.dart`.
- [ ] Implement the authentication flow using Google Sign-In.
- [ ] Create the `AuthGate` to manage the authentication state.

After completing these tasks, the following steps will be taken:

- [ ] Run `dart fix --apply`.
- [ ] Run `dart analyze` and fix any issues.
- [ ] Run tests to ensure they all pass.
- [I ] Run `dart format .`.
- [ ] Reload the running application using `hot_reload`.
- [ ] Update this `IMPLEMENTATION.md` file with the current status and any learnings in the Journal.
- [ ] Use `git diff` to verify the changes and create a commit message for approval.
- [ ] Wait for user approval before proceeding to the next phase.

## Phase 4: Listings Feature

- [ ] Implement the UI for displaying a list of book listings.
- [ ] Implement the UI for viewing the details of a single listing.
- [ ] Implement the UI for creating a new listing.
- [ ] Connect the UI to the `listing_provider` to manage state.

After completing these tasks, the following steps will be taken:

- [ ] Run `dart fix --apply`.
- [ ] Run `dart analyze` and fix any issues.
- [ ] Run tests to ensure they all pass.
- [ ] Run `dart format .`.
- [ ] Reload the running application using `hot_reload`.
- [ ] Update this `IMPLEMENTATION.md` file with the current status and any learnings in the Journal.
- [ ] Use `git diff` to verify the changes and create a commit message for approval.
- [ ] Wait for user approval before proceeding to the next phase.

## Phase 5: Finalization

- [x] Create a placeholder `README.md` file.
- [ ] Create a `GEMINI.md` file in the project directory that describes the app, its purpose, and implementation details.
- [ ] Ask the user to inspect the app and the code and say if they are satisfied with it, or if any modifications are needed.

After completing a task, if you added any TODOs to the code or didn't fully implement anything, make sure to add new tasks so that you can come back and complete them later.
