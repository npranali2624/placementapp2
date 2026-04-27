import 'package:flutter/material.dart';
import '../pages/edit_student_profile_page.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  //  DATA
  static const String name    = "Rahul Sharma";
  static const String email   = "rahul.sharma@email.com";
  static const String phone   = "+91 98765 43210";
  static const String college = "MIT College of Engineering, Pune";
  static const String course  = "B.E. Computer Engineering";
  static const String year    = "3rd Year";
  static const String cgpa    = "8.5 / 10";
  static const String skills  = "Flutter, Dart, Python, Firebase";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              //PROFILE HEADER
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
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          "RS",
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
                        Text("Student · B.E. Computer Engg",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //CONTACT
              _sectionTitle("CONTACT"),
              _infoTile(Icons.email, "Email", email),
              _infoTile(Icons.phone, "Phone", phone),
              _infoTile(Icons.school, "College", college),

              const SizedBox(height: 20),

              // ACADEMIC DETAILS
              _sectionTitle("ACADEMIC DETAILS"),
              _infoTile(Icons.book, "Course", course),
              _infoTile(Icons.calendar_today, "Year", year),
              _infoTile(Icons.grade, "CGPA", cgpa),

              const SizedBox(height: 20),

              // SKILLS
              _sectionTitle("SKILLS"),
              _infoTile(Icons.code, "Technical Skills", skills),

              const SizedBox(height: 30),

              // UPDATE BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditStudentProfilePage(),
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

  //SECTION TITLE
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

  // INFO TILE
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