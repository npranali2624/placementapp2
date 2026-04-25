import 'package:flutter/material.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../pages/student_profile_page.dart';
import '../pages/student_openings_page.dart';
import '../pages/opening_view_details_page.dart';

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  // ── Palette ────────────────────────────────────────────────────────────────
  static const Color bgColor   = Color(0xFFF1F5F9);
  static const Color navyDark  = Color(0xFF1E3A8A);
  static const Color blue      = Color(0xFF2563EB);
  static const Color skyBlue   = Color(0xFF38BDF8);
  static const Color darkText  = Color(0xFF0F172A);
  static const Color subText   = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color chipGrey  = Color(0xFFF1F5F9);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [navyDark, blue, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  int _currentIndex = 0;

  // ── Job data — ALL keys match OpeningViewDetailsPage exactly ──────────────
  final List<Map<String, dynamic>> _jobs = [
    {
      'initial'      : 'T',
      'companyColor' : Color(0xFF2563EB),
      'companyBg'    : Color(0xFFEFF6FF),
      'openingType'  : 'Placement',
      'jobTime'      : 'Full Time',
      'experience'   : 'Fresher',
      'salaryMin'    : 4,
      'salaryMax'    : 6,
      'isSalary'     : true,
      'vacancies'    : 5,
      'postedDate'   : '5 hours ago',
      'qualification': 'B.Tech / MCA',
      'jobTitle'                : 'Software Engineer',
      'company'                 : 'TechCorp',
      'companyInitial'          : 'T',
      'location'                : 'San Francisco, USA',
      'timeConstraint'          : '30 days',
      'isFresher'               : true,
      'selectedQualifications'  : {'B.Tech', 'MCA'},
      'responsibilities'        : [
        'Design and develop scalable backend services',
        'Collaborate with cross-functional teams',
        'Write clean, maintainable code and unit tests',
        'Participate in code reviews and architecture discussions',
      ],
      'techRequirements'        : [
        'Java / Kotlin or Python',
        'REST APIs & Microservices',
        'SQL & NoSQL databases',
        'Git & CI/CD pipelines',
      ],
      'professionalRequirements': [
        'Strong problem-solving ability',
        'Excellent written and verbal communication',
        'Team player with ownership mindset',
      ],
      'terms': [
        '6-month probation period',
        'Performance-based appraisal cycle',
        'Relocation assistance provided',
      ],
    },
    {
      'initial'      : 'X',
      'companyColor' : Color(0xFFD97706),
      'companyBg'    : Color(0xFFFFFBEB),
      'openingType'  : 'Internship',
      'jobTime'      : 'Remote',
      'experience'   : '0–1 year',
      'salaryMin'    : 15000,
      'salaryMax'    : 25000,
      'isSalary'     : false,
      'vacancies'    : 2,
      'postedDate'   : '2 days ago',
      'qualification': 'Any Graduate',
      'jobTitle'                : 'UI/UX Designer',
      'company'                 : 'XYZ Solutions',
      'companyInitial'          : 'X',
      'location'                : 'Remote',
      'timeConstraint'          : '15 days',
      'isFresher'               : false,
      'expValue'                : '0–1',
      'expUnit'                 : 'year',
      'selectedQualifications'  : {'Any Graduate'},
      'responsibilities'        : [
        'Create wireframes, prototypes and high-fidelity mockups',
        'Conduct user research and usability testing',
        'Maintain and evolve the design system',
      ],
      'techRequirements'        : [
        'Figma & Adobe XD',
        'Basic HTML / CSS understanding',
        'Prototyping tools',
      ],
      'professionalRequirements': [
        'Creative thinking and attention to detail',
        'Empathy-driven design approach',
        'Ability to present design rationale clearly',
      ],
      'terms': [
        '3-month internship with certificate on completion',
        'Potential pre-placement offer based on performance',
      ],
    },
    {
      'initial'      : 'D',
      'companyColor' : Color(0xFF059669),
      'companyBg'    : Color(0xFFECFDF5),
      'openingType'  : 'Placement',
      'jobTime'      : 'Full Time',
      'experience'   : 'Fresher',
      'salaryMin'    : 5,
      'salaryMax'    : 8,
      'isSalary'     : true,
      'vacancies'    : 4,
      'postedDate'   : '3 hours ago',
      'qualification': 'B.Tech / MCA / M.Sc',
      'jobTitle'                : 'Flutter Developer',
      'company'                 : 'DEE Technologies',
      'companyInitial'          : 'D',
      'location'                : 'Bengaluru, India',
      'timeConstraint'          : '20 days',
      'isFresher'               : true,
      'selectedQualifications'  : {'B.Tech', 'MCA', 'M.Sc'},
      'responsibilities'        : [
        'Build cross-platform mobile apps using Flutter & Dart',
        'Integrate REST APIs and third-party SDKs',
        'Write widget and unit tests',
        'Collaborate with backend and design teams',
      ],
      'techRequirements'        : [
        'Flutter & Dart',
        'State management (Bloc / Riverpod)',
        'REST API integration',
        'Git & version control',
      ],
      'professionalRequirements': [
        'Self-motivated and proactive',
        'Good communication skills',
        'Ability to meet deadlines',
      ],
      'terms': [
        '6-month probation, performance-based conversion',
        'Follow company IP and NDA policies',
      ],
    },
    {
      'initial'      : 'A',
      'companyColor' : Color(0xFF7C3AED),
      'companyBg'    : Color(0xFFF5F3FF),
      'openingType'  : 'Hybrid',
      'jobTime'      : 'Full Time',
      'experience'   : '0–1 year',
      'salaryMin'    : 3,
      'salaryMax'    : 5,
      'isSalary'     : true,
      'vacancies'    : 6,
      'postedDate'   : '1 day ago',
      'qualification': 'B.Tech / MBA',
      'jobTitle'                : 'Data Analyst',
      'company'                 : 'Analytics Hub',
      'companyInitial'          : 'A',
      'location'                : 'Mumbai, India',
      'timeConstraint'          : '25 days',
      'isFresher'               : false,
      'expValue'                : '0–1',
      'expUnit'                 : 'year',
      'selectedQualifications'  : {'B.Tech', 'MBA'},
      'responsibilities'        : [
        'Analyse large datasets to extract business insights',
        'Build and maintain reporting dashboards',
        'Collaborate with stakeholders on data requirements',
        'Automate recurring reports using Python / SQL',
      ],
      'techRequirements'        : [
        'Python & Pandas',
        'SQL (MySQL / PostgreSQL)',
        'Tableau or Power BI',
        'Excel (advanced)',
      ],
      'professionalRequirements': [
        'Analytical thinking and attention to detail',
        'Strong presentation and storytelling skills',
        'Team collaboration',
      ],
      'terms': [
        'Hybrid work model — 3 days in office',
        'Performance-based hike after 6 months',
        'Health and travel benefits included',
      ],
    },
  ];

  // ── Helpers ────────────────────────────────────────────────────────────────
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );
  }

  void _openJobDetails(Map<String, dynamic> job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OpeningViewDetailsPage(opening: job),
      ),
    );
  }

  Color _typeBadgeColor(String type) {
    switch (type) {
      case 'Placement':  return const Color(0xFF2563EB);
      case 'Internship': return const Color(0xFF059669);
      case 'Hybrid':     return const Color(0xFF7C3AED);
      default:           return subText;
    }
  }

  Color _typeBadgeBg(String type) {
    switch (type) {
      case 'Placement':  return const Color(0xFFEFF6FF);
      case 'Internship': return const Color(0xFFECFDF5);
      case 'Hybrid':     return const Color(0xFFF5F3FF);
      default:           return chipGrey;
    }
  }

  BottomNavigationBarItem _navItem(IconData icon, String label, int index) {
    final bool isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      label: label,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: isSelected
            ? const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
        )
            : null,
        child: Icon(icon, color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      // ── Drawer ────────────────────────────────────────────────────────────
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(color: bgColor),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 26, color: blue),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Student",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text("student@email.com",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text("Settings",
                  style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Settings Clicked")),
                );
              },
            ),
            const Spacer(),
            InkWell(
              onTap: _logout,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text("Logout",
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── AppBar (Home tab only) ─────────────────────────────────────────────
      appBar: _currentIndex == 0
          ? AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search jobs, companies...",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: const [
          SizedBox(width: 10),
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
        ],
      )
          : null,

      // ── IndexedStack ───────────────────────────────────────────────────────
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomePage(),
          const Center(child: Text("Companies Page")),
          const StudentOpeningsPage(),
          const Center(child: Text("Apply Page")),
          const StudentProfilePage(),
        ],
      ),

      // ── Bottom Nav ─────────────────────────────────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          _navItem(Icons.home, "Dashboard", 0),
          _navItem(Icons.business, "Companies", 1),
          _navItem(Icons.work_outline, "Openings", 2),
          _navItem(Icons.assignment_turned_in, "Apply", 3),
          _navItem(Icons.person, "Profile", 4),
        ],
      ),
    );
  }

  // ── Home Page ──────────────────────────────────────────────────────────────
  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("GOOD MORNING",
                style: TextStyle(
                    color: Colors.grey, letterSpacing: 1, fontSize: 12)),
            const SizedBox(height: 4),
            const Text("Hi, Student!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              decoration: BoxDecoration(
                gradient: brandGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PLACEMENT SEASON 2025",
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text(
                    "Explore openings &\nlaunch your career.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Row(
              children: [
                _StatCard("28", "Companies", Icons.business, Color(0xFF2563EB)),
                _StatCard("54", "Openings", Icons.work, Color(0xFF06B6D4)),
                _StatCard("12", "Applied", Icons.assignment_turned_in,
                    Color(0xFF22C55E)),
              ],
            ),

            const SizedBox(height: 25),

            const Text("Recent Openings",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            ..._jobs.map((job) => _jobCard(job)),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── Job Card ───────────────────────────────────────────────────────────────
  Widget _jobCard(Map<String, dynamic> o) {
    final Color cardColor = o['companyColor'] as Color;
    final Color cardBg    = o['companyBg']    as Color;

    return GestureDetector(
      onTap: () => _openJobDetails(o),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 110,
                height: 110,
                decoration:
                BoxDecoration(color: cardBg, shape: BoxShape.circle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          o['initial'] as String,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(o['jobTitle'] as String,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: darkText)),
                          const SizedBox(height: 3),
                          Text(o['company'] as String,
                              style: const TextStyle(
                                  fontSize: 13, color: subText)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _typeBadgeBg(o['openingType'] as String),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        o['openingType'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _typeBadgeColor(o['openingType'] as String),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 14),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    _tag(Icons.location_on_rounded, o['location'] as String),
                    _tag(Icons.access_time_rounded, o['jobTime'] as String),
                    _tag(Icons.school_rounded, o['experience'] as String),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                      child: _statChip(
                        Icons.currency_rupee_rounded,
                        (o['isSalary'] as bool)
                            ? '${o['salaryMin']}–${o['salaryMax']} LPA'
                            : '₹${o['salaryMin']}–${o['salaryMax']}/mo',
                        chipGrey,
                        subText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _statChip(
                      Icons.people_alt_rounded,
                      '${o['vacancies']} Vacancies',
                      Color.fromRGBO(
                          cardColor.red, cardColor.green, cardColor.blue, 0.12),
                      cardColor,
                    ),
                  ]),
                  const SizedBox(height: 14),
                  Row(children: [
                    const Icon(Icons.schedule_rounded,
                        size: 12, color: textMuted),
                    const SizedBox(width: 4),
                    Text(
                      'Posted ${o['postedDate']}  ·  ${o['qualification']}',
                      style: const TextStyle(fontSize: 11, color: textMuted),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12, color: subText),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11, color: subText)),
      ]),
    );
  }

  Widget _statChip(IconData icon, String text, Color bg, Color fgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 13, color: fgColor),
        const SizedBox(width: 5),
        Text(text,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: fgColor)),
      ]),
    );
  }
}

// ── Stat Card ──────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String number;
  final String label;
  final IconData icon;
  final Color color;

  const _StatCard(this.number, this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(number,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}