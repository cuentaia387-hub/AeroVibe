# AeroVibe 🌊

> An authentic **Frutiger Aero** flutter app featuring bright, optimistic nature themes and real-time weather data.

![Frutiger Aero](https://img.shields.io/badge/Design-Frutiger%20Aero-4ECDC4?style=for-the-badge)
![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B?style=for-the-badge&logo=flutter)
![Android](https://img.shields.io/badge/Android-APK%20Ready-3DDC84?style=for-the-badge&logo=android)

---

## ✨ About AeroVibe

**AeroVibe** is a nature & weather dashboard app built to perfectly emulate the **Frutiger Aero** design aesthetic of the mid-2000s/early 2010s. It focuses on the bright, optimistic side of the aesthetic:

- 🫧 **Animated Glass Bubbles** — transparent, wobbly spheres with glossy white highlights
- 🪟 **Real Glassmorphism** — heavy backdrop blur with white translucency borders
- ✨ **Skeuomorphic Gloss** — 3D buttons that scale down on tap with bright top reflections
- 🌊 **Bright Sky Gradients** — sky blues, bright cyans, grass greens
- 🌍 **Real-Time Data** — fetches live 7-day weather using the Open-Meteo API and Geolocator

---

## 📱 Screens & Features

| Screen | Core Functionality |
|--------|----------------|
| **Splash** | Pulsing geometric rings, animated bubbles, gradient mask logo |
| **Home** | `SingleChildScrollView`, real-time API temperature, interaction demo button |
| **Weather** | 7-day detailed `CustomScrollView` forecast from Open-Meteo |
| **Explore** | Interactive `SliverGrid` photo gallery with bottom sheet popups |
| **Settings** | Custom-drawn `AnimatedContainer` Frutiger switches and sliders |

---

## 🚀 Building the APK via GitHub Actions

The best way to get the app on your phone is simply by using the pre-configured GitHub workflow.

1. Init Git in the `App/` folder and push to your repo:
   ```bash
   git init
   git add .
   git commit -m "Bright Frutiger Aero update"
   git remote add origin https://github.com/YOUR_USER/AeroVibe.git
   git push -u origin main
   ```
2. In GitHub, go to **Actions** → **Build Flutter APK** (left sidebar).
3. If it didn't run automatically, click **Run workflow**.
4. Wait 5 minutes.
5. Download `aerovibe-release-apk` from the **Artifacts** section at the bottom of the run page.

---

## 📦 Core Dependencies

- `http` & `geolocator` — For real location and Open-Meteo weather API
- `google_fonts` — For runtime Nunito loading (no local assets needed)
- `animate_do` & `flutter_animate` — For entrance and loop animations
- `glass_kit` — For glassmorphism wrappers

---

<div align="center">
  Redesigned with bright 🌊 and authentic <strong>Frutiger Aero</strong> gloss.
</div>
