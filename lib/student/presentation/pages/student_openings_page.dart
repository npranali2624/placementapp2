import 'package:flutter/material.dart';
import '../pages/opening_view_details_page.dart';

class StudentOpeningsPage extends StatefulWidget {
  const StudentOpeningsPage({super.key});

  @override
  State<StudentOpeningsPage> createState() => _StudentOpeningsPageState();
}

class _StudentOpeningsPageState extends State<StudentOpeningsPage>
    with SingleTickerProviderStateMixin {

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

  //  Search / Filter State
  bool _isSearching   = false;
  String _searchQuery = '';
  String _activeFilter = 'All';
  final TextEditingController _searchCtrl = TextEditingController();

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  //Sample Openings Data
  final List<Map<String, dynamic>> _openings = [
    {
      'initial'                 : 'T',
      'companyColor'            : Color(0xFF2563EB),
      'companyBg'               : Color(0xFFEFF6FF),
      'openingType'             : 'Placement',
      'jobTime'                 : 'Full Time',
      'experience'              : 'Fresher',
      'salaryMin'               : 4,
      'salaryMax'               : 6,
      'isSalary'                : true,
      'vacancies'               : 5,
      'postedDate'              : '5 hours ago',
      'qualification'           : 'B.Tech / MCA',
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
      'initial'                 : 'X',
      'companyColor'            : Color(0xFFD97706),
      'companyBg'               : Color(0xFFFFFBEB),
      'openingType'             : 'Internship',
      'jobTime'                 : 'Remote',
      'experience'              : '0–1 year',
      'salaryMin'               : 15000,
      'salaryMax'               : 25000,
      'isSalary'                : false,
      'vacancies'               : 2,
      'postedDate'              : '2 days ago',
      'qualification'           : 'Any Graduate',
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
      'initial'                 : 'D',
      'companyColor'            : Color(0xFF059669),
      'companyBg'               : Color(0xFFECFDF5),
      'openingType'             : 'Placement',
      'jobTime'                 : 'Full Time',
      'experience'              : 'Fresher',
      'salaryMin'               : 5,
      'salaryMax'               : 8,
      'isSalary'                : true,
      'vacancies'               : 4,
      'postedDate'              : '3 hours ago',
      'qualification'           : 'B.Tech / MCA / M.Sc',
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
      'initial'                 : 'A',
      'companyColor'            : Color(0xFF7C3AED),
      'companyBg'               : Color(0xFFF5F3FF),
      'openingType'             : 'Hybrid',
      'jobTime'                 : 'Full Time',
      'experience'              : '0–1 year',
      'salaryMin'               : 3,
      'salaryMax'               : 5,
      'isSalary'                : true,
      'vacancies'               : 6,
      'postedDate'              : '1 day ago',
      'qualification'           : 'B.Tech / MBA',
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
    {
      'initial'                 : 'N',
      'companyColor'            : Color(0xFFDC2626),
      'companyBg'               : Color(0xFFFEF2F2),
      'openingType'             : 'Internship',
      'jobTime'                 : 'Part Time',
      'experience'              : 'Fresher',
      'salaryMin'               : 10000,
      'salaryMax'               : 18000,
      'isSalary'                : false,
      'vacancies'               : 3,
      'postedDate'              : '4 days ago',
      'qualification'           : 'Any Graduate',
      'jobTitle'                : 'Backend Developer',
      'company'                 : 'Nexora Technologies',
      'companyInitial'          : 'N',
      'location'                : 'Pune, Maharashtra',
      'timeConstraint'          : '10 days',
      'isFresher'               : true,
      'selectedQualifications'  : {'Any Graduate'},
      'responsibilities'        : [
        'Develop REST APIs and manage databases',
        'Write unit and integration tests',
        'Participate in code reviews',
      ],
      'techRequirements'        : [
        'Node.js or Python',
        'PostgreSQL / MySQL',
        'Git & version control',
      ],
      'professionalRequirements': [
        'Good communication skills',
        'Problem-solving mindset',
        'Ability to work independently',
      ],
      'terms': [
        '3-month internship with certificate on completion',
        'Potential pre-placement offer based on performance',
      ],
    },
  ];

  final List<String> _filters = ['All', 'Placement', 'Internship', 'Hybrid'];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredOpenings {
    return _openings.where((o) {
      final matchesType   = _activeFilter == 'All' || o['openingType'] == _activeFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          (o['jobTitle'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (o['company']  as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
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

  void _openDetail(Map<String, dynamic> opening) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OpeningViewDetailsPage(opening: opening),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(children: [

            //TOP BAR
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(children: [

                if (!_isSearching)
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLACEMENT CELL',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'All Openings',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (_isSearching)
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.07),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchCtrl,
                        autofocus: true,
                        onChanged: (val) => setState(() => _searchQuery = val),
                        decoration: InputDecoration(
                          hintText: 'Search job title or company...',
                          hintStyle: const TextStyle(color: subText, fontSize: 13),
                          prefixIcon: const Icon(Icons.search_rounded,
                              color: subText, size: 20),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? GestureDetector(
                            onTap: () => setState(() {
                              _searchQuery = '';
                              _searchCtrl.clear();
                            }),
                            child: const Icon(Icons.close_rounded,
                                color: subText, size: 18),
                          )
                              : null,
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(width: 8),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      if (!_isSearching) {
                        _searchQuery = '';
                        _searchCtrl.clear();
                      }
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _isSearching ? blue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.07),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      _isSearching ? Icons.close_rounded : Icons.search_rounded,
                      color: _isSearching ? Colors.white : subText,
                      size: 20,
                    ),
                  ),
                ),
              ]),
            ),

            const SizedBox(height: 16),

            // FILTER CHIPS
            SizedBox(
              height: 36,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final f        = _filters[i];
                  final isActive = f == _activeFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _activeFilter = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: isActive ? brandGradient : null,
                        color: isActive ? null : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: isActive
                                ? blue.withOpacity(0.25)
                                : Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isActive ? Colors.white : subText,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // COUNT LINE
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Row(children: [
                Text(
                  '${_filteredOpenings.length} opening${_filteredOpenings.length == 1 ? '' : 's'} found',
                  style: const TextStyle(fontSize: 12, color: textMuted),
                ),
              ]),
            ),

            const SizedBox(height: 8),

            // OPENING LIST
            Expanded(
              child: _filteredOpenings.isEmpty
                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.work_off_rounded,
                        size: 54, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    Text(
                      _searchQuery.isNotEmpty
                          ? 'No results for "$_searchQuery"'
                          : 'No openings in this category',
                      style: const TextStyle(color: subText, fontSize: 14),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                itemCount: _filteredOpenings.length,
                itemBuilder: (context, i) =>
                    _openingCard(_filteredOpenings[i]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  //Opening Card
  Widget _openingCard(Map<String, dynamic> o) {
    final Color cardColor = o['companyColor'] as Color;
    final Color cardBg    = o['companyBg']    as Color;

    return GestureDetector(
      onTap: () => _openDetail(o),
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
        child: Stack(children: [
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
                        o['companyInitial'] as String,
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
                        Text(
                          o['jobTitle'] as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),
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

                GestureDetector(
                  onTap: () => _openDetail(o),
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      gradient: brandGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        'View Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
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
        ]),
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
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: fgColor)),
      ]),
    );
  }
}