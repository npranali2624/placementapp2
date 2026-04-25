import 'package:flutter/material.dart';

class EditStudentProfilePage extends StatefulWidget {
  const EditStudentProfilePage({super.key});

  @override
  State<EditStudentProfilePage> createState() =>
      _EditStudentProfilePageState();
}

class _EditStudentProfilePageState extends State<EditStudentProfilePage> {

  static const Color bgColor = Color(0xFFF1F5F9);

  Widget _field({
    required String label,
    required String value,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF38BDF8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: value,
            enabled: enabled,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFF2563EB),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// HEADER
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
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          "RS",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Edit Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text("Update your details",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// PERSONAL INFORMATION
              _sectionTitle("PERSONAL INFORMATION"),
              _sectionCard(children: [
                _field(label: "Full Name", value: "Rahul Sharma", enabled: false),
                _field(label: "Email", value: "rahul.sharma@email.com", enabled: false),
                _field(label: "Phone", value: "+91 98765 43210", enabled: false),
              ]),

              const SizedBox(height: 16),

              /// ACADEMIC DETAILS
              _sectionTitle("ACADEMIC DETAILS"),
              _sectionCard(children: [
                _field(label: "College Name", value: "MIT College of Engineering, Pune"),
                _field(label: "Course", value: "B.E."),
                _field(label: "Branch", value: "Computer Engineering"),
                _field(label: "Year", value: "3rd Year"),
                _field(label: "CGPA", value: "8.5 / 10"),
                _field(label: "12th / Diploma %", value: "85%"),
                _field(label: "Year of Passing", value: "2025"),
              ]),

              const SizedBox(height: 16),

              /// TECHNICAL SKILLS
              _sectionTitle("TECHNICAL SKILLS"),
              _sectionCard(children: [
                _field(label: "Skills", value: "Flutter, Dart, Python, Firebase"),
              ]),

              const SizedBox(height: 16),

              /// DOCUMENTS
              _sectionTitle("DOCUMENTS"),
              _sectionCard(children: [
                _uploadButton("Upload Resume", Icons.upload_file),
                _uploadButton("Upload Documents", Icons.attach_file),
              ]),

              const SizedBox(height: 24),

              /// SAVE BUTTON
              GestureDetector(
                onTap: () {},
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
                      "Save Changes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
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

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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

  Widget _sectionCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _uploadButton(String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: const Color(0xFF2563EB)),
        label: Text(
          text,
          style: const TextStyle(color: Color(0xFF2563EB)),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          side: const BorderSide(color: Color(0xFF2563EB)),
          backgroundColor: const Color(0xFFE0F2FE),
        ),
      ),
    );
  }
}