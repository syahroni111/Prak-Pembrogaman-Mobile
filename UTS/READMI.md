# 📖 Aplikasi Tafsir Tematik Al-Qur'an

Aplikasi mobile berbasis **Flutter** yang menampilkan **tafsir ayat Al-Qur’an berdasarkan tema** seperti _Rezeki_, _Sabar_, dan _Akhlak_.  
Dibuat sebagai **proyek UAS Praktikum Pemrograman Mobile**.

---

## 🎯 Tujuan

Membuat aplikasi Islami yang bermanfaat dan interaktif, dengan minimal 4 halaman:

1. Login Page
2. Home Page
3. Detail Page
4. Settings Page

---

## 📱 Fitur Utama

- Login / masuk sebagai tamu
- Pencarian tema Al-Qur’an
- Menampilkan ayat, terjemahan, dan tafsir sesuai tema
- Pengaturan tampilan (mode gelap, bahasa, font)
- Mengambil data dari file lokal `assets/db.json`

---

## 🗂 Struktur Folder

lib/
┣ models/ # Model data tema & ayat
┣ screens/ # Halaman utama aplikasi
┣ services/ # API service baca db.json
┣ widgets/ # Widget tampilan kartu
┗ main.dart # Entry point aplikasi
assets/
┗ db.json # Data dummy lokal

## ⚙️ Cara Menjalankan

1. Pastikan Flutter sudah terinstal
2. Tambahkan asset di `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/db.json
   ```

Jalankan:

flutter pub get
flutter run -d chrome

Data Dummy
Data diambil dari assets/db.json

👤 Pembuat

Nama: M. Abdulah Syahroni
NIM: 230605110200
Mata Kuliah: Praktikum Pemrograman Mobile E
Judul Proyek: Tafsir Tematik Al-Qur’an
