import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isChecked = false;
  bool isDarkMode = false;
  String? selectedCategory;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1000),
      lastDate: DateTime(9000),
      initialDate: selectedDate ?? DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        title: const Text('Syarat & Ketentuan'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Menu Form',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_box_outlined),
              title: const Text('Checkbox'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.toggle_on_outlined),
              title: const Text('Switch'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.arrow_drop_down_circle_outlined),
              title: const Text('Dropdown'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today_outlined),
              title: const Text('Tanggal'),
              onTap: () {
                Navigator.pop(context);
                _pickDate();
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time_outlined),
              title: const Text('Jam'),
              onTap: () {
                Navigator.pop(context);
                _pickTime();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Saya menyetujui semua persyaratan yang berlaku',
              ),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
            ),
            Text(
              isChecked
                  ? 'Lanjutkan pendaftaran diperbolehkan'
                  : 'Anda belum bisa melanjutkan',
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Aktifkan Mode Gelap'),
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            Text(isDarkMode ? 'Mode Gelap Aktif' : 'Mode Terang Aktif'),
            const SizedBox(height: 16),
            DropdownMenu<String>(
              expandedInsets: EdgeInsets.zero,
              label: const Text('Pilih Kategori Produk'),
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'Elektronik', label: 'Elektronik'),
                DropdownMenuEntry(value: 'Pakaian', label: 'Pakaian'),
                DropdownMenuEntry(value: 'Makanan', label: 'Makanan'),
                DropdownMenuEntry(value: 'Lainnya', label: 'Lainnya'),
              ],
              onSelected: (String? value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            if (selectedCategory != null)
              Text('Anda memilih kategori: $selectedCategory'),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today_outlined),
              label: Text(
                selectedDate == null
                    ? 'Pilih Tanggal'
                    : MaterialLocalizations.of(context).formatMediumDate(
                        selectedDate!,
                      ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: _pickTime,
              icon: const Icon(Icons.access_time_outlined),
              label: Text(
                selectedTime == null
                    ? 'Pilih Jam'
                    : MaterialLocalizations.of(context).formatTimeOfDay(
                        selectedTime!,
                      ),
              ),
            ),
            const Divider(height: 32),
            const Text(
              'Hasil Pilihan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              isChecked
                  ? 'Persyaratan: Disetujui'
                  : 'Persyaratan: Belum disetujui',
            ),
            Text(
              isDarkMode ? 'Mode: Gelap' : 'Mode: Terang',
            ),
            Text('Kategori: ${selectedCategory ?? 'Belum dipilih'}'),
            Text(
              'Tanggal: ${selectedDate == null ? 'Belum dipilih' : MaterialLocalizations.of(context).formatMediumDate(selectedDate!)}',
            ),
            Text(
              'Jam: ${selectedTime == null ? 'Belum dipilih' : MaterialLocalizations.of(context).formatTimeOfDay(selectedTime!)}',
            ),
          ],
        ),
      ),
    );
  }
}