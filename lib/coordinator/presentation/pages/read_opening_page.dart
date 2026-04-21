import 'package:flutter/material.dart';
import '../pages/opening_view_details_page.dart';

class ReadOpeningsPage extends StatefulWidget {
  const ReadOpeningsPage({super.key});

  @override
  State<ReadOpeningsPage> createState() => _ReadOpeningsPageState();
}

class _ReadOpeningsPageState extends State<ReadOpeningsPage>
    with SingleTickerProviderStateMixin {

  // ── Palette ────────────────────────────────────────────────────────────────
  static const Color bgColor   = Color(0xFFF1F5F9);
  static const Color navyDark  = Color(0xFF1E3A8A);
  static const Color blue      = Color(0xFF2563EB);
  static const Color skyBlue   = Color(0xFF38BDF8);
  static const Color darkText  = Color(0xFF0F172A);
  static const Color textHead  = Color(0xFF1E293B);
  static const Color subText   = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color chipGrey  = Color(0xFFF1F5F9);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [navyDark, blue, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Search / Filter State ──────────────────────────────────────────────────
  bool _isSearching    = false;
  String _searchQuery  = '';
  String _activeFilter = 'All';
  final TextEditingController _searchCtrl = TextEditingController();

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  // ── Sample Openings Data ───────────────────────────────────────────────────
  final List<Map<String, dynamic>> _openings = [
    {
      'jobTitle'        : 'Backend Developer',
      'company'         : 'Nexora Technologies',
      'companyInitial'  : 'N',
      'companyColor'    : Color(0xFF2563EB),
      'companyBg'       : Color(0xFFEFF6FF),
      'openingType'     : 'Placement',
      'jobTime'         : 'Full Time',
      'location'        : 'Pune, Maharashtra',
      'experience'      : 'Fresher',
      'qualification'   : 'B.Tech / MCA / M.Sc',
      'vacancies'       : 8,
      'salaryMin'       : 5,
      'salaryMax'       : 8,
      'isSalary'        : true,
      'description'     : 'We are looking for a passionate Backend Developer to build scalable applications.',
      'responsibilities': 'Develop REST APIs, manage databases, perform code reviews',
      'techReq'         : 'Node.js, PostgreSQL, Docker, REST, Git',
      'professionalReq' : 'Good communication, Problem solving, Teamwork',
      'terms'           : '6 months probation, performance-based conversion, follow company policies',
      'timeConstraint'  : '30 days',
      'postedDate'      : '2 days ago',
    },
    {
      'jobTitle'        : 'Flutter Developer',
      'company'         : 'Adobe Systems',
      'companyInitial'  : 'A',
      'companyColor'    : Color(0xFFDC2626),
      'companyBg'       : Color(0xFFFEF2F2),
      'openingType'     : 'Internship',
      'jobTime'         : 'Part Time',
      'location'        : 'Bengaluru, Karnataka',
      'experience'      : '0–1 year',
      'qualification'   : 'B.Tech / MCA / M.Sc',
      'vacancies'       : 3,
      'salaryMin'       : 15000,
      'salaryMax'       : 25000,
      'isSalary'        : false,
      'description'     : 'Seeking a motivated Flutter intern to build cross-platform mobile applications.',
      'responsibilities': 'Develop UI components, integrate APIs, write unit tests',
      'techReq'         : 'Flutter, Dart, REST APIs, Git',
      'professionalReq' : 'Self-motivated, Attention to detail, Communication',
      'terms'           : '3 months internship, certificate on completion',
      'timeConstraint'  : '15 days',
      'postedDate'      : '5 days ago',
    },
    {
      'jobTitle'        : 'Data Analyst',
      'company'         : 'Goldman Sachs',
      'companyInitial'  : 'G',
      'companyColor'    : Color(0xFF7C3AED),
      'companyBg'       : Color(0xFFF5F3FF),
      'openingType'     : 'Placement',
      'jobTime'         : 'Full Time',
      'location'        : 'Mumbai, Maharashtra',
      'experience'      : '1–3 years',
      'qualification'   : 'MBA',
      'vacancies'       : 5,
      'salaryMin'       : 10,
      'salaryMax'       : 15,
      'isSalary'        : true,
      'description'     : 'Join our analytics team to drive insights from large financial datasets.',
      'responsibilities': 'Data modelling, reporting dashboards, stakeholder presentations',
      'techReq'         : 'Python, SQL, Tableau, Excel',
      'professionalReq' : 'Analytical thinking, Presentation skills, Teamwork',
      'terms'           : '6 months probation, performance-based hike, health benefits',
      'timeConstraint'  : '20 days',
      'postedDate'      : '1 week ago',
    },
    {
      'jobTitle'        : 'DevOps Engineer',
      'company'         : 'Microsoft India',
      'companyInitial'  : 'M',
      'companyColor'    : Color(0xFF059669),
      'companyBg'       : Color(0xFFECFDF5),
      'openingType'     : 'Hybrid',
      'jobTime'         : 'Full Time',
      'location'        : 'Hyderabad, Telangana',
      'experience'      : '1–3 years',
      'qualification'   : 'B.Tech / MCA / M.Sc',
      'vacancies'       : 4,
      'salaryMin'       : 12,
      'salaryMax'       : 18,
      'isSalary'        : true,
      'description'     : 'Looking for a DevOps engineer to streamline our CI/CD pipelines.',
      'responsibilities': 'Manage CI/CD, cloud infra, automate deployments',
      'techReq'         : 'Azure, Docker, Kubernetes, Terraform, Git',
      'professionalReq' : 'Problem solving, Collaboration, Ownership mindset',
      'terms'           : 'Remote-friendly, 3 months contract extendable',
      'timeConstraint'  : '25 days',
      'postedDate'      : '3 days ago',
    },
    {
      'jobTitle'        : 'UI/UX Designer',
      'company'         : 'DEE Technologies',
      'companyInitial'  : 'D',
      'companyColor'    : Color(0xFFD97706),
      'companyBg'       : Color(0xFFFFFBEB),
      'openingType'     : 'Internship',
      'jobTime'         : 'Full Time',
      'location'        : 'Pune, Maharashtra',
      'experience'      : 'Fresher',
      'qualification'   : 'Any Graduate',
      'vacancies'       : 2,
      'salaryMin'       : 10000,
      'salaryMax'       : 18000,
      'isSalary'        : false,
      'description'     : 'Creative UI/UX intern needed to design intuitive user experiences.',
      'responsibilities': 'Wireframing, prototyping, user research, design systems',
      'techReq'         : 'Figma, Adobe XD, Basic HTML/CSS',
      'professionalReq' : 'Creativity, Empathy, Attention to detail',
      'terms'           : '6 months internship, potential PPO',
      'timeConstraint'  : '10 days',
      'postedDate'      : '4 days ago',
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

  // ── Opening Type Badge Colors ──────────────────────────────────────────────
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

  // ── Navigate to full detail page ───────────────────────────────────────────
  void _openDetail(Map<String, dynamic> opening) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OpeningViewDetailsPage(opening: opening),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(children: [

            // ── TOP BAR ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(children: [

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.07),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: subText, size: 20),
                  ),
                ),

                const SizedBox(width: 12),

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
                          'Openings',
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

            // ── FILTER CHIPS ───────────────────────────────────────────────
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

            // ── COUNT LINE ─────────────────────────────────────────────────
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

            // ── OPENING LIST ───────────────────────────────────────────────
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

  // ── Opening Card ───────────────────────────────────────────────────────────
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
                        o['companyInitial'],
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
                          o['jobTitle'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(o['company'],
                            style: const TextStyle(
                                fontSize: 13, color: subText)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _typeBadgeBg(o['openingType']),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      o['openingType'],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _typeBadgeColor(o['openingType']),
                      ),
                    ),
                  ),
                ]),

                const SizedBox(height: 14),

                Wrap(spacing: 8, runSpacing: 8, children: [
                  _tag(Icons.location_on_rounded, o['location']),
                  _tag(Icons.access_time_rounded, o['jobTime']),
                  _tag(Icons.school_rounded, o['experience']),
                ]),

                const SizedBox(height: 12),

                Row(children: [
                  Expanded(
                    child: _statChip(
                      Icons.currency_rupee_rounded,
                      o['isSalary']
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

                // ── View Details → navigates to OpeningViewDetailsPage ────
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