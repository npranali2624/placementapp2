import 'package:flutter/material.dart';

class StudentJobApplyPage extends StatefulWidget {
  final String jobTitle;
  final String company;

  const StudentJobApplyPage({
    super.key,
    required this.jobTitle,
    required this.company,
  });

  @override
  State<StudentJobApplyPage> createState() => _StudentJobApplyPageState();
}

class _StudentJobApplyPageState extends State<StudentJobApplyPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController coverLetterController = TextEditingController();

  final TextEditingController courseController = TextEditingController();
  final TextEditingController cgpaController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController toolsController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController projectsController = TextEditingController();
  final TextEditingController certificateController = TextEditingController();

  bool isAvailable = true;
  bool agreeTerms = false;

  static const Color focusBlue = Color(0xFF4A90E2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5EDE3),

      appBar: AppBar(
        title: const Text(
          "Student Job Apply",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFD5EDE3),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // HEADER CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF667EEA),
                    Color(0xFF764BA2),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.work, color: Color(0xFF667EEA)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.jobTitle,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        Text(widget.company,
                            style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _sectionCard("Personal Details", Icons.person, focusBlue, [
              _textField("Full Name", nameController),
              _textField("Email", emailController),
              _textField("Phone Number", phoneController),
              _textField("Current Course / Degree", courseController),
              _textField("CGPA / Percentage", cgpaController),
              _textField("Specialization", specializationController),
            ]),

            _sectionCard("Skills & Tools", Icons.code, focusBlue, [
              _textField("Skills (e.g. Flutter, Java)", skillsController),
              _textField("Tools / Technologies", toolsController),
            ]),

            _sectionCard("Profiles", Icons.link, focusBlue, [
              _textField("GitHub Link", githubController),
              _textField("LinkedIn Link", linkedinController),
            ]),

            _sectionCard("Experience", Icons.work, focusBlue, [
              _textField("Experience Details", experienceController),
            ]),

            _sectionCard("Projects", Icons.build, focusBlue, [
              _textField("Project Details", projectsController, maxLines: 3),
            ]),

            _sectionCard("Certificates / Achievements", Icons.emoji_events, focusBlue, [
              _textField("Certificates / Achievements", certificateController, maxLines: 3),
            ]),

            _sectionCard("Resume", Icons.upload_file, focusBlue, [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.attach_file),
                    SizedBox(width: 10),
                    Text("Upload Resume (PDF)"),
                  ],
                ),
              )
            ]),

            _sectionCard("Cover Letter", Icons.description, focusBlue, [
              _textField("Write something about yourself...",
                  coverLetterController, maxLines: 4),
            ]),

            _sectionCard("Availability", Icons.access_time, focusBlue, [
              SwitchListTile(
                value: isAvailable,
                onChanged: (val) {
                  setState(() => isAvailable = val);
                },
                title: const Text("Available to join immediately"),
              )
            ]),

            Row(
              children: [
                Checkbox(
                  value: agreeTerms,
                  onChanged: (val) {
                    setState(() => agreeTerms = val!);
                  },
                ),
                const Expanded(
                  child: Text("I agree to terms & conditions"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                if (!agreeTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please accept terms")),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Application Submitted")),
                );
              },
              child: Container(
                height: 55,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: const Center(
                  child: Text(
                    "Submit Application",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textField(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: focusBlue, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(
      String title, IconData icon, Color color, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ...children
        ],
      ),
    );
  }
}