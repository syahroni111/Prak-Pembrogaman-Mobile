# 📖 Tafsir Tematik Al-Qur'an: Final Project UAS Mobile Programming

Aplikasi mobile berbasis **Flutter** yang menampilkan **tafsir ayat Al-Qur’an berdasarkan tema** (seperti Rezeki, Sabar, dan Akhlak). Proyek ini berfokus pada implementasi integrasi **RESTful API** dan manajemen _state asynchronous_ untuk memenuhi kriteria wajib Ujian Akhir Semester (UAS).

| Status Proyek               | Komponen Kunci              | Hosting API       |
| :-------------------------- | :-------------------------- | :---------------- |
| ✅ **Selesai & Fungsional** | Flutter, Dart, HTTP Package | Vercel Serverless |

---

## 🎯 Tujuan Proyek (Pemenuhan Kriteria UAS)

Proyek ini telah memenuhi semua kriteria wajib UAS, meliputi:

1.  **Integrasi API (HTTP Request):** Mengambil data tema dan ayat secara _real-time_ menggunakan _package_ `http`.
2.  **JSON Serialization:** Melakukan _parsing_ data JSON dari API ke **Model Class** (`ThemeModel`, `VerseModel`).
3.  **Asynchronous UI & State Management:** Menerapkan **`FutureBuilder`** untuk menangani **Loading State**, **Success State**, dan **Error State** (koneksi putus).
4.  **Fitur Pencarian/Filter:** Implementasi fitur pencarian tema di **Home Page** dan _client-side filtering_ untuk ayat di **Detail Page**.

---

## 📱 Fitur Fungsional Aplikasi

Aplikasi dibangun minimal dengan 4 halaman utama:

- **Splash Page:** Tampilan pembuka aplikasi.
- **Login & Register Page:** Formalitas autentikasi menggunakan simulasi `Future.delayed` (selalu sukses).
- **Home Page:** Menampilkan daftar tema dari API dengan fitur **Pencarian Tema** (filtrasi sisi klien).
- **Theme Detail Page:** Menampilkan daftar ayat (`VerseModel`) yang relevan dengan tema yang dipilih, diambil dan difilter dari API.
- **Settings Page:** Pengaturan tampilan (mode gelap, ukuran _font_, bahasa) dan fungsi _Logout_.

---

## 📡 Daftar Endpoint API yang Digunakan

Data aplikasi disajikan dari _file_ JSON statis yang di-_host_ melalui Vercel _Serverless_.

**Base URL API:** `https://tafsirtematik-api.vercel.app/`

| No. | Tujuan                | Metode | Endpoint Relatif | Keterangan                                                                                        |
| :-- | :-------------------- | :----- | :--------------- | :------------------------------------------------------------------------------------------------ |
| 1   | Mengambil Daftar Tema | `GET`  | `/themes`        | Mengambil semua daftar tema.                                                                      |
| 2   | Mengambil Daftar Ayat | `GET`  | `/verses`        | Mengambil semua ayat. **Filtrasi berdasarkan `themeId` dilakukan di dalam `ApiService` Flutter.** |
| 3   | Login/Register        | N/A    | (Simulasi Lokal) | Fungsi disimulasikan (`Future.delayed`) dan selalu mengembalikan sukses.                          |

---

## 🗂 Struktur Folder Kunci

| Folder/File     | Peran                  | Catatan Implementasi                                                                                              |
| :-------------- | :--------------------- | :---------------------------------------------------------------------------------------------------------------- |
| `lib/services/` | Logika Komunikasi Data | Berisi **`api_service.dart`** yang mengisolasi _Base URL_ Vercel dan logika **Client-Side Filtering** untuk ayat. |
| `lib/models/`   | Model Data             | Berisi `theme_model.dart` dan `verse_model.dart` untuk **JSON Serialization**.                                    |
| `lib/screens/`  | Halaman Aplikasi       | Berisi `home_page.dart` dan `theme_detail_page.dart` dengan implementasi **`FutureBuilder`**.                     |
| `lib/widgets/`  | Widget Tampilan        | Berisi `theme_card.dart` dan `verse_card.dart`.                                                                   |

---

## 💻 Cara Instalasi dan Menjalankan Proyek

### Prasyarat

- **Flutter SDK** (Versi stabil terbaru).
- **Git** terinstal.
- **Terminal** atau **Git Bash** untuk menjalankan perintah.

### Langkah-Langkah

1.  **Clone Repositori:**

    ```bash
    git clone [LINK REPO GITHUB ANDA]
    cd [NAMA FOLDER PROYEK]
    ```

2.  **Dapatkan Dependensi:**

    ```bash
    flutter pub get
    ```

3.  **Jalankan Aplikasi:**
    Pastikan Anda memiliki _emulator_ atau perangkat terhubung.
    ```bash
    flutter run
    ```
    _(Gunakan `flutter run -d chrome` jika Anda ingin menguji di browser.)_

> **PENTING:** Proses Login/Register akan selalu berhasil (formalitas) agar Anda dapat langsung menguji fungsionalitas pengambilan data tema dan ayat.

---

## 👤 Pembuat Proyek

- **Nama:** M. Abdulah Syahroni
- **NIM:** 230605110200
- **Mata Kuliah:** Praktikum Pemrograman Mobile E
- **Judul Proyek:** Tafsir Tematik Al-Qur’an
