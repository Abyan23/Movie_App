# 🎬 Movie Discovery App

Aplikasi Flutter untuk menjelajahi, mencari, dan menyimpan film favorit.

> 🚧 **Selesai** — Technical Study Case submission

## Tech Stack

- Flutter (stable)
- Provider (state management)
- SharedPreferences (local storage)

## Unit test 
- Mocktail
List test
1. Berhasil mengambil data film,
2. Gagal mengambil data film,
3. Pencarian data film berdasarkan string yang dimasukkan.

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

## Arsitektur

Menggunakan layer-based architecture:
- `data/models` — Model data
- `data/repositories` — Sumber data
- `providers` — State management
- `screens` — Tampilan UI

## Progress

- [✓] Screen 1 — Daftar Film
- [✓] Screen 2 — Pencarian Film
- [✓] Screen 3 — Detail Film
- [✓] Screen 4 — Favorit

## Penggunaan AI

Dibantu Claude (Anthropic) untuk memahami konsep Flutter dan Dart
dari nol, arsitektur project, dan review kode.