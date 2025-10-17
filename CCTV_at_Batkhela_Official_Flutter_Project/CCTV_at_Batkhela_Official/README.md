
# CCTV at Batkhela Official - Flutter Source (Urdu + English)

This is a ready-to-edit Flutter project (sample) for **CCTV at Batkhela Official**.
It includes a bilingual UI (Urdu default, English toggle), splash screen assets, and contact links (WhatsApp, phone, email).

## Project structure (included)
```
lib/
  main.dart            # App entry - bilingual UI + splash
assets/
  logo.png             # Provided logo (used in splash & app)
  bg.webp              # Background (control room image) for splash
pubspec.yaml
README.md
```

---
## How to build APK (local - Android Studio or Flutter CLI)

1. Install Flutter SDK and Android toolchain: https://flutter.dev/docs/get-started/install
2. Open terminal and go to project folder:
   ```bash
   cd /path/to/CCTV_at_Batkhela_Official_Flutter_Project
   flutter pub get
   ```
3. Run on a connected device (debug):
   ```bash
   flutter run
   ```
4. Build release APK:
   ```bash
   flutter build apk --release
   ```
   Output APK: `build/app/outputs/flutter-apk/app-release.apk`

### Signing the APK for Play Store (optional)
1. Generate a signing key (if you don't have one):
   ```bash
   keytool -genkey -v -keystore ~/cctv_key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias cctv_key
   ```
2. Create `key.properties` in `android/` folder:
   ```properties
   storePassword=your_keystore_password
   keyPassword=your_key_password
   keyAlias=cctv_key
   storeFile=/full/path/to/cctv_key.jks
   ```
3. Update `android/app/build.gradle` signingConfigs to use `key.properties` (standard Flutter docs show where). Then build:
   ```bash
   flutter build apk --release
   ```

---
## Online build (Codemagic)
1. Create a GitHub repo from this project (or upload ZIP to a repo).
2. Sign up / log in to Codemagic: https://codemagic.io/
3. Connect your repo, select branch, choose Flutter workflow.
4. Configure signing (upload keystore or use Play App Signing) and start build.
5. Download APK from Artifacts when build finishes.

---
## Notes & Limitations
- This package **contains only source code and assets**. I cannot compile a production-signed APK inside this environment.
- The included sample is simple and meant to be edited/extended as needed.
- If you want, I can provide a step-by-step screen-by-screen guide for Codemagic settings or create the `key.properties` template for you.

---
Enjoy — if you want me to modify the UI, add forms, or prepare Play Store metadata, tell me what to add.
