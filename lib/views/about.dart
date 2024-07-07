import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'ResepKu hadir untuk memberikan solusi praktis dan modern bagi Anda yang sering kehilangan catatan resep masakan atau merasa repot dengan buku resep manual. Dengan ResepKu semua resep masakan favorit Anda dapat disimpan dengan rapi dan mudah diakses melalui smartphone.',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Informasi Tim',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            _buildTeamMember(
                'Asyifa Fauziyah', '2106062', 'assets/profile1.png'),
            const SizedBox(height: 16.0),
            _buildTeamMember(
                'Murni Lestari Rahmi', '2106035', 'assets/profile3.png'),
            const SizedBox(height: 16.0),
            _buildTeamMember(
                'Nabila Putri Nurhaliza', '2106074', 'assets/profile2.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String name, String id, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 40.0,
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Text(id,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
