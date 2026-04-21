import 'package:flutter/material.dart';
import '../widgets/company_field.dart';
import '../widgets/section_title.dart';

class EditStudentProfilePage extends StatefulWidget {
  const EditStudentProfilePage({super.key});

  @override
  State<EditStudentProfilePage> createState() =>
      _EditStudentProfilePageState();
}

class _EditStudentProfilePageState extends State<EditStudentProfilePage> {

  // same colors as AddWorkLocationPage
  static const Color bgPage = Color(0xFFD5EDE3);
  static const Color cardBg = Colors.white;

  // Profile icon color from CoordinatorDashboardPage bottom nav
  static const Color profileIconColor = Color(0xFF1ABC9C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPage,

      body: SafeArea(
        child: Column(
          children: [

            // APP BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: bgPage,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    // PERSONAL INFO CARD
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: "Personal Information"),

                          Opacity(
                            opacity: 0.7,
                            child: AbsorbPointer(
                              child: CompanyField(
                                label: "Full Name",
                                value: "Rahul Sharma",
                              ),
                            ),
                          ),

                          Opacity(
                            opacity: 0.7,
                            child: AbsorbPointer(
                              child: CompanyField(
                                label: "Email",
                                value: "rahul.sharma@email.com",
                              ),
                            ),
                          ),

                          Opacity(
                            opacity: 0.7,
                            child: AbsorbPointer(
                              child: CompanyField(
                                label: "Phone",
                                value: "+91 98765 43210",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // SKILLS CARD
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SectionTitle(title: "Technical Skills"),
                          CompanyField(
                            label: "Skills",
                            value: "Flutter, Dart, Python, Firebase",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // QUALIFICATION CARD
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SectionTitle(title: "Qualification"),
                          CompanyField(
                            label: "College Name",
                            value: "MIT College of Engineering, Pune",
                          ),
                          CompanyField(label: "Course", value: "B.E."),
                          CompanyField(label: "Branch", value: "Computer Engineering"),
                          CompanyField(label: "Year", value: "3rd Year"),
                          CompanyField(label: "CGPA", value: "8.5 / 10"),
                          CompanyField(label: "12th / Diploma %", value: "85%"),
                          CompanyField(label: "Year of Passing", value: "2025"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // DOCUMENT CARD
                    _card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SectionTitle(title: "Documents"),

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.upload_file,
                                color: profileIconColor,
                              ),
                              label: const Text("Upload Resume"),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.attach_file,
                                color: profileIconColor,
                              ),
                              label: const Text("Upload Documents"),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // SAVE BUTTON — teal to blue gradient
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF1ABC9C),
                              Color(0xFF3498DB),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
          ],
        ),
      ),
    );
  }

  // SAME CARD STYLE as AddWorkLocationPage
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}