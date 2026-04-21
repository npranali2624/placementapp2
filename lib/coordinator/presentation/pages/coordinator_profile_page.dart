import 'package:flutter/material.dart';
import '../pages/edit_coordinator_profile_page.dart';

class CoordinatorProfilePage extends StatelessWidget {
  const CoordinatorProfilePage({super.key});

  // 🔹 DATA
  static const String name       = "Priya Deshmukh";
  static const String email      = "coordinator@email.com";
  static const String phone      = "+91 98765 12345";
  static const String gender     = "Female";
  static const String dob        = "10 Jan 1995";
  static const String address    = "Pune, Maharashtra";
  static const String role       = "Placement Coordinator";
  static const String department = "Training & Placement Cell";
  static const String college    = "MIT College of Engineering";
  static const String experience = "5 Years";
  static const String companies  = "28";
  static const String drives     = "54";
  static const String students   = "196";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      // ✅ No AppBar, no BottomNavigationBar — dashboard owns those
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// 🔷 PROFILE HEADER
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1E3A8A),
                      Color(0xFF2563EB),
                      Color(0xFF38BDF8),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          "PD",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text("Placement Coordinator · TPO",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔷 STATS
              Row(
                children: [
                  _statCard("Companies", companies),
                  _statCard("Openings", drives),
                  _statCard("Applicants", students),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔷 CONTACT
              _sectionTitle("CONTACT"),
              _infoTile(Icons.email, "Email", email),
              _infoTile(Icons.phone, "Phone", phone),
              _infoTile(Icons.school, "College", college),

              const SizedBox(height: 20),

              /// 🔷 PERSONAL DETAILS
              _sectionTitle("PERSONAL DETAILS"),
              _infoTile(Icons.person, "Gender", gender),
              _infoTile(Icons.cake, "Date of Birth", dob),
              _infoTile(Icons.location_on, "Address", address),

              const SizedBox(height: 20),

              /// 🔷 PROFESSIONAL DETAILS
              _sectionTitle("PROFESSIONAL DETAILS"),
              _infoTile(Icons.work, "Role", role),
              _infoTile(Icons.apartment, "Department", department),
              _infoTile(Icons.business, "Organization", college),
              _infoTile(Icons.timeline, "Experience", experience),

              const SizedBox(height: 30),

              /// 🔷 UPDATE BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditCoordinatorProfilePage(),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1E3A8A),
                        Color(0xFF2563EB),
                        Color(0xFF38BDF8),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Center(
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 STAT CARD
  Widget _statCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  /// 🔹 SECTION TITLE
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 🔹 INFO TILE
  Widget _infoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE0F2FE),
            child: Icon(icon, color: const Color(0xFF2563EB)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}