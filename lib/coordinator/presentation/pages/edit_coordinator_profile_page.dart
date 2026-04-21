import 'package:flutter/material.dart';

class EditCoordinatorProfilePage extends StatefulWidget {
  const EditCoordinatorProfilePage({super.key});

  @override
  State<EditCoordinatorProfilePage> createState() =>
      _EditCoordinatorProfilePageState();
}

class _EditCoordinatorProfilePageState
    extends State<EditCoordinatorProfilePage> {

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
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 12),

                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          "PD",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
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
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// PERSONAL
              _sectionTitle("PERSONAL INFORMATION"),
              _sectionCard(children: [
                _field(label: "Full Name", value: "Priya Deshmukh", enabled: false),
                _field(label: "Email", value: "coordinator@email.com", enabled: false),
                _field(label: "Phone", value: "+91 98765 12345", enabled: false),
                _field(label: "Gender", value: "Female", enabled: false),
                _field(label: "Date of Birth", value: "10 Jan 1995", enabled: false),
                _field(label: "Address", value: "Pune, Maharashtra", enabled: false),
              ]),

              const SizedBox(height: 16),

              /// PROFESSIONAL
              _sectionTitle("PROFESSIONAL DETAILS"),
              _sectionCard(children: [
                _field(label: "Role", value: "Placement Coordinator"),
                _field(label: "Department", value: "Training & Placement Cell"),
                _field(label: "Organization", value: "MIT College of Engineering"),
                _field(label: "Experience", value: "5 Years"),
              ]),

              const SizedBox(height: 16),

              /// WORK SUMMARY
              _sectionTitle("WORK SUMMARY"),
              _sectionCard(children: [
                _field(label: "Companies Managed", value: "28"),
                _field(label: "Openings Created", value: "54"),
                _field(label: "Students Handled", value: "196"),
              ]),

              const SizedBox(height: 16),

              /// DOCUMENTS (✅ FIXED TO BLUE)
              _sectionTitle("DOCUMENTS"),
              _sectionCard(children: [
                _uploadButton("Upload Profile Photo", Icons.upload_file),
                _uploadButton("Upload ID / Authorization Letter", Icons.attach_file),
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

  /// 🔵 UPDATED BLUE BUTTON
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
          backgroundColor: const Color(0xFFE0F2FE), // 🔵 light blue bg
        ),
      ),
    );
  }
}