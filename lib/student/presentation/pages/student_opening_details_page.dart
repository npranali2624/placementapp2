import 'package:flutter/material.dart';
import '../pages/student_job_apply_page.dart';

class StudentOpeningDetailsPage extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String type;
  final String salary;

  const StudentOpeningDetailsPage({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5EDE3),

      appBar: AppBar(
        title: const Text(
          "Opening Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFD5EDE3),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.bookmark_border, color: Colors.black),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // HEADER CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF26A69A),
                    Color(0xFF2ECC71),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "T",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF26A69A),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              company,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "5 Openings",
                          style: TextStyle(fontSize: 11),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(location,
                          style: const TextStyle(color: Colors.white70)),

                      const SizedBox(width: 12),

                      const Icon(Icons.work,
                          size: 18, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(type,
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    children: [
                      _chip(type),
                      _chip("On-site"),
                      _chip("Placement"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // GRID DETAILS
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _infoItem(Icons.school, "Qualification", "B.E / B.Tech", const Color(0xFF42A5F5)),
                      _infoItem(Icons.work, "Experience", "Fresher", const Color(0xFFE67E22)),
                      _infoItem(Icons.people, "Vacancies", "5", const Color(0xFF2ECC71)),
                      _infoItem(Icons.currency_rupee, "Salary", salary, const Color(0xFF26A69A)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      _infoItem(Icons.access_time, "Job Type", type, const Color(0xFF8E44AD)),
                      _infoItem(Icons.badge, "Coordinator", "TC-HR-2025", const Color(0xFF1ABC9C)),
                      _infoItem(Icons.timer, "Time", "Full Time", const Color(0xFFFF8A00)),
                      _infoItem(Icons.location_city, "Location", location, const Color(0xFF26A69A)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            _section("Job Description", Icons.description, const Color(0xFF26A69A), [
              "We are looking for a passionate Software Engineer.",
              "Work on scalable and high-performance applications.",
            ]),

            _section("Responsibilities", Icons.check_circle, const Color(0xFF2ECC71), [
              "Develop scalable applications",
              "Collaborate with teams",
              "Write clean code",
              "Debug issues",
            ]),

            _section("Technical Requirements", Icons.code, const Color(0xFF42A5F5), [
              "Flutter / Dart",
              "REST APIs",
              "Git",
              "Firebase (optional)",
            ]),

            _section("Professional Requirements", Icons.person, const Color(0xFFE67E22), [
              "Good communication",
              "Problem solving",
              "Teamwork",
            ]),

            _section("Terms & Conditions", Icons.verified, const Color(0xFF8E44AD), [
              "6 months probation",
              "Performance-based conversion",
              "Follow company policies",
            ]),

            const SizedBox(height: 20),

            // APPLY BUTTON
            Row(
              children: [
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.share),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentJobApplyPage(
                            jobTitle: title,
                            company: company,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF42A5F5),
                            Color(0xFF26A69A),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          "Apply Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }

  static Widget _infoItem(
      IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  static Widget _section(
      String title, IconData icon, Color color, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Text("• ", style: TextStyle(color: color)),
                Expanded(child: Text(e)),
              ],
            ),
          ))
        ],
      ),
    );
  }
}