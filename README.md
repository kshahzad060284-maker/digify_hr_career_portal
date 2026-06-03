# Digify HR — Career Portal

A cross-platform **Flutter** application that serves as the public-facing career portal for the **Digify HR** ecosystem. Candidates use this portal to discover open roles, manage their profiles, and submit job applications that flow into the Digify HR system.

---

## Overview

The Career Portal is a **linked companion project** to Digify HR. It connects to the same backend services and hiring workflows used inside Digify HR, giving candidates a dedicated experience while recruiters and HR teams continue to work in the core HR platform.

| Audience       | Purpose                                                             |
| -------------- | ------------------------------------------------------------------- |
| **Candidates** | Browse jobs, create and maintain a profile, and apply for positions |
| **Digify HR**  | Receives applications and candidate data through integrated APIs    |

### What candidates can do

- **Browse jobs** — View published openings from your organization
- **Create a profile** — Register and maintain personal and professional details
- **Apply for jobs** — Submit applications through the portal into Digify HR
- **Track activity** — Dashboard-oriented overview of portal engagement (in progress)

---

## SDK & toolchain

| Component        | Version / requirement                          |
| ---------------- | ---------------------------------------------- |
| **Dart SDK**     | `^3.12.1` (see `pubspec.yaml`)                 |
| **Flutter**      | `stable` (managed via [FVM](https://fvm.app/)) |
| **Package name** | `career_portal`                                |
| **App version**  | `1.0.0+1`                                      |

### Recommended setup

This repository uses **FVM** to pin the Flutter SDK. Install FVM, then from the project root:

```bash
fvm install
fvm use
fvm flutter pub get
```

If you do not use FVM, ensure your local Flutter channel matches **stable** and satisfies the Dart constraint above.

---

## Architecture

The project follows **Clean Architecture** with a **feature-first** layout. Responsibilities are split so UI stays thin, business rules live in the domain/application layers, and API access stays in the data layer.

| Layer            | Responsibility                                               |
| ---------------- | ------------------------------------------------------------ |
| **Presentation** | Widgets, layouts, routing; Riverpod consumers & providers    |
| **Application**  | Use cases, orchestration; shared providers where appropriate |
| **Domain**       | Entities, repository contracts, business rules               |
| **Data**         | DTOs, remote/local data sources, repository implementations  |

### State management — Riverpod

**[Riverpod](https://riverpod.dev/)** is the sole state-management solution for this project.

| Practice       | Guideline                                                                             |
| -------------- | ------------------------------------------------------------------------------------- |
| **Providers**  | `Notifier` / `AsyncNotifier` for feature and app state                                |
| **Location**   | `presentation/providers/` or `application/` depending on scope                        |
| **UI**         | `ConsumerWidget` / `ConsumerStatefulWidget`; avoid `setState` except local UI toggles |
| **Async data** | `AsyncValue.when` / `maybeWhen` for loading, data, and error                          |
| **App root**   | Wrap the app with `ProviderScope` in `main.dart`                                      |

Keep providers small and composable. Business logic stays out of widgets — providers call use cases and repositories.

### Design principles

- **Feature modules** under `lib/features/<feature>/`
- **Shared infrastructure** under `lib/core/` (networking, theme, routing, localization)
- **Reusable UI** under `lib/shared/widgets/`
- **Riverpod** for all shared and feature state
- **go_router** for declarative navigation
- **Dio** for HTTP with centralized error handling (`AppService`)
- **English & Arabic** localization with RTL support
- **Responsive layouts** for mobile, tablet, and desktop (web-first dashboard)

---

## Project structure

```
lib/
├── app/                          # App root (MaterialApp.router, theme, l10n)
├── core/
│   ├── config/                   # App identity, API base URL, timeouts
│   ├── extensions/               # BuildContext helpers (theme, breakpoints)
│   ├── localization/
│   │   ├── l10n/                 # ARB source files (en, ar)
│   │   └── generated/            # Generated AppLocalizations
│   ├── network/                  # AppService (Dio), endpoints, exceptions
│   ├── router/                   # go_router routes and route names
│   ├── services/
│   │   ├── responsive/           # Breakpoints, ScreenUtil design sizes
│   │   └── toast/                # ToastService (user notifications)
│   └── theme/                    # AppColors, AppTheme, typography
├── features/
│   ├── dashboard/
│   │   ├── application/        # Use cases (optional)
│   │   ├── domain/               # Models & repository contracts
│   │   ├── data/                 # API sources & repository impl
│   │   └── presentation/
│   │       ├── providers/        # Riverpod Notifier / AsyncNotifier providers
│   │       ├── pages/
│   │       ├── layouts/
│   │       └── widgets/
│   └── jobs/
│       └── …                     # Same layer pattern per feature
├── shared/
│   └── widgets/                  # Common UI (buttons, avatar, loaders, …)
└── gen/                          # Generated assets (assets.gen.dart)

assets/
├── fonts/                        # Inter font family
├── icons/                        # SVG icons (dashboard, job detail, …)
└── logos/
```

### Routes

| Path        | Screen      | Description               |
| ----------- | ----------- | ------------------------- |
| `/`         | Dashboard   | Home / candidate overview |
| `/jobs`     | Jobs        | Browse open positions     |
| `/jobs/:id` | Job details | View a role and apply     |

---

## Tech stack

| Category         | Packages                                                                      |
| ---------------- | ----------------------------------------------------------------------------- |
| **State**        | `flutter_riverpod`, `riverpod_annotation` (codegen, optional)                 |
| **UI**           | `flutter_screenutil`, `gap`, `flutter_svg`, `skeletonizer`, `flutter_spinkit` |
| **Navigation**   | `go_router`                                                                   |
| **Networking**   | `dio`                                                                         |
| **Localization** | `flutter_localizations`, `intl`                                               |
| **Quality**      | `flutter_lints`, `flutter_test`                                               |

---

## Getting started

### Prerequisites

- Flutter SDK (**stable**, via FVM or local install)
- Dart **3.12.1+**
- A configured **Digify HR API** base URL (when integrating backend calls)

### Install dependencies

```bash
fvm flutter pub get
```

### Run the app

```bash
# Web (primary target for dashboard layouts)
fvm flutter run -d chrome

# iOS / Android / macOS
fvm flutter run
```

### Run with API configuration

Pass environment values at build/run time using `--dart-define`:

```bash
fvm flutter run \
  --dart-define=API_BASE_URL=https://your-api.example.com \
  --dart-define=API_KEY=your-api-key
```

| Define         | Description                               |
| -------------- | ----------------------------------------- |
| `API_BASE_URL` | Base URL for Digify HR / portal APIs      |
| `API_KEY`      | API key (if required by your environment) |
| `API_SECRET`   | API secret (if required)                  |
| `APP_SECRET`   | Application secret (if required)          |

Defaults and timeouts are defined in `lib/core/config/app_config.dart`.

---

## Localization

Strings are managed with Flutter’s **gen-l10n** workflow.

| Item             | Location                           |
| ---------------- | ---------------------------------- |
| Source ARB files | `lib/core/localization/l10n/`      |
| Generated code   | `lib/core/localization/generated/` |
| Config           | `l10n.yaml`                        |

**Supported locales:** English (`en`), Arabic (`ar`)

Regenerate localizations after editing ARB files:

```bash
fvm flutter gen-l10n
```

Use `AppLocalizations` in widgets — avoid hardcoding user-visible copy.

---

## Development

### Analyze

```bash
fvm flutter analyze
```

### Test

```bash
fvm flutter test
```

### Code generation (assets)

When asset or codegen configuration changes:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Integration with Digify HR

This portal is designed to work **alongside** the Digify HR system:

1. **Job postings** — Roles published in Digify HR appear on the portal for candidates.
2. **Candidate profiles** — Registration and profile data align with HR candidate records.
3. **Applications** — Submissions from the portal are sent to Digify HR for review and pipeline management.

API contracts and authentication are configured through `AppService` and `lib/core/network/api_endpoints.dart`. Wire new features through repositories and use cases per the Clean Architecture layout above.

---

## Contributing

1. Follow the architecture and conventions in `.cursorrules` (Clean Architecture, **Riverpod-only** state, localization, theming, `ToastService` for notifications).
2. Keep features under `lib/features/<feature>/` with clear layer separation.
3. Add or update ARB strings for all user-facing text (EN + AR).
4. Run `fvm flutter analyze` and `fvm flutter test` before opening a pull request.

---

## Related

- **Digify HR** — Core HR platform (parent / linked system)
- **Career Portal** — This repository (`career_portal`)

---

<p align="center">
  <sub>Built with Flutter for Digify HR · Career Portal v1.0.0</sub>
</p>
