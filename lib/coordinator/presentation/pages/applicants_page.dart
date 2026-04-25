import 'package:flutter/material.dart';
import 'opening_applicants_page.dart';

class ApplicantsPage extends StatefulWidget {
  const ApplicantsPage({super.key});

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage>
    with SingleTickerProviderStateMixin {

  static const Color bgColor   = Color(0xFFF1F5F9);
  static const Color navyDark  = Color(0xFF1E3A8A);
  static const Color blue      = Color(0xFF2563EB);
  static const Color skyBlue   = Color(0xFF38BDF8);
  static const Color darkText  = Color(0xFF0F172A);
  static const Color textHead  = Color(0xFF1E293B);
  static const Color subText   = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [navyDark, blue, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  bool _isSearching   = false;
  String _searchQuery = '';
  String _activeFilter = 'All';
  final TextEditingController _searchCtrl = TextEditingController();

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  final List<Map<String, dynamic>> _openings = [
    {
      'jobTitle'       : 'Backend Developer',
      'company'        : 'Nexora Technologies',
      'companyInitial' : 'N',
      'companyColor'   : Color(0xFF2563EB),
      'companyBg'      : Color(0xFFEFF6FF),
      'openingType'    : 'Placement',
      'jobTime'        : 'Full Time',
      'location'       : 'Pune, Maharashtra',
      'salaryMin'      : 5,
      'salaryMax'      : 8,
      'isSalary'       : true,
      'vacancies'      : 8,
      'postedDate'     : '2 days ago',
      'applicants': [
        {'name': 'Aarav Sharma',   'branch': 'Computer Science', 'year': '4th Year', 'cgpa': '8.7', 'status': 'Shortlisted',  'avatar': 'A'},
        {'name': 'Priya Patel',    'branch': 'Information Tech', 'year': '4th Year', 'cgpa': '9.1', 'status': 'Under Review', 'avatar': 'P'},
        {'name': 'Rohan Mehta',    'branch': 'Computer Science', 'year': '4th Year', 'cgpa': '7.9', 'status': 'Applied',      'avatar': 'R'},
        {'name': 'Sneha Kulkarni', 'branch': 'MCA',              'year': 'Final',    'cgpa': '8.4', 'status': 'Shortlisted',  'avatar': 'S'},
        {'name': 'Karan Joshi',    'branch': 'Computer Science', 'year': '4th Year', 'cgpa': '8.0', 'status': 'Rejected',     'avatar': 'K'},
      ],
    },
    {
      'jobTitle'       : 'Flutter Developer',
      'company'        : 'Adobe Systems',
      'companyInitial' : 'A',
      'companyColor'   : Color(0xFFDC2626),
      'companyBg'      : Color(0xFFFEF2F2),
      'openingType'    : 'Internship',
      'jobTime'        : 'Part Time',
      'location'       : 'Bengaluru, Karnataka',
      'salaryMin'      : 15000,
      'salaryMax'      : 25000,
      'isSalary'       : false,
      'vacancies'      : 3,
      'postedDate'     : '5 days ago',
      'applicants': [
        {'name': 'Neha Gupta',    'branch': 'Information Tech', 'year': '3rd Year', 'cgpa': '8.9', 'status': 'Applied',      'avatar': 'N'},
        {'name': 'Amit Verma',    'branch': 'Computer Science', 'year': '3rd Year', 'cgpa': '7.5', 'status': 'Under Review', 'avatar': 'A'},
        {'name': 'Tanvi Desai',   'branch': 'BCA',              'year': 'Final',    'cgpa': '8.2', 'status': 'Shortlisted',  'avatar': 'T'},
      ],
    },
    {
      'jobTitle'       : 'Data Analyst',
      'company'        : 'Goldman Sachs',
      'companyInitial' : 'G',
      'companyColor'   : Color(0xFF7C3AED),
      'companyBg'      : Color(0xFFF5F3FF),
      'openingType'    : 'Placement',
      'jobTime'        : 'Full Time',
      'location'       : 'Mumbai, Maharashtra',
      'salaryMin'      : 10,
      'salaryMax'      : 15,
      'isSalary'       : true,
      'vacancies'      : 5,
      'postedDate'     : '1 week ago',
      'applicants': [
        {'name': 'Divya Singh',   'branch': 'MBA',              'year': '2nd Year', 'cgpa': '8.6', 'status': 'Shortlisted',  'avatar': 'D'},
        {'name': 'Rahul Nair',    'branch': 'Computer Science', 'year': '4th Year', 'cgpa': '9.0', 'status': 'Applied',      'avatar': 'R'},
        {'name': 'Pooja Reddy',   'branch': 'MBA',              'year': '2nd Year', 'cgpa': '8.3', 'status': 'Under Review', 'avatar': 'P'},
        {'name': 'Siddharth Rao', 'branch': 'Information Tech', 'year': '4th Year', 'cgpa': '7.8', 'status': 'Applied',      'avatar': 'S'},
        {'name': 'Meera Iyer',    'branch': 'MBA',              'year': '2nd Year', 'cgpa': '9.2', 'status': 'Shortlisted',  'avatar': 'M'},
        {'name': 'Aditya Kumar',  'branch': 'Computer Science', 'year': '4th Year', 'cgpa': '8.1', 'status': 'Rejected',     'avatar': 'A'},
      ],
    },
    {
      'jobTitle'       : 'DevOps Engineer',
      'company'        : 'Microsoft India',
      'companyInitial' : 'M',
      'companyColor'   : Color(0xFF059669),
      'companyBg'      : Color(0xFFECFDF5),
      'openingType'    : 'Hybrid',
      'jobTime'        : 'Full Time',
      'location'       : 'Hyderabad, Telangana',
      'salaryMin'      : 12,
      'salaryMax'      : 18,
      'isSalary'       : true,
      'vacancies'      : 4,
      'postedDate'     : '3 days ago',
      'applicants': [
        {'name': 'Vikram Bhat',   'branch': 'Computer Science', 'year': '4th Year', 'cgpa': '8.8', 'status': 'Applied',      'avatar': 'V'},
        {'name': 'Ishaan Tiwari', 'branch': 'Information Tech', 'year': '4th Year', 'cgpa': '8.5', 'status': 'Shortlisted',  'avatar': 'I'},
        {'name': 'Nisha Pillai',  'branch': 'MCA',              'year': 'Final',    'cgpa': '9.3', 'status': 'Under Review', 'avatar': 'N'},
      ],
    },
    {
      'jobTitle'       : 'UI/UX Designer',
      'company'        : 'DEE Technologies',
      'companyInitial' : 'D',
      'companyColor'   : Color(0xFFD97706),
      'companyBg'      : Color(0xFFFFFBEB),
      'openingType'    : 'Internship',
      'jobTime'        : 'Full Time',
      'location'       : 'Pune, Maharashtra',
      'salaryMin'      : 10000,
      'salaryMax'      : 18000,
      'isSalary'       : false,
      'vacancies'      : 2,
      'postedDate'     : '4 days ago',
      'applicants': [
        {'name': 'Zara Khan',     'branch': 'BCA',              'year': 'Final',    'cgpa': '8.0', 'status': 'Applied',      'avatar': 'Z'},
        {'name': 'Dev Malhotra',  'branch': 'Computer Science', 'year': '3rd Year', 'cgpa': '7.6', 'status': 'Under Review', 'avatar': 'D'},
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

  List<Map<String, dynamic>> get _filtered {
    return _openings.where((o) {
      final matchesType   = _activeFilter == 'All' || o['openingType'] == _activeFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          (o['jobTitle'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (o['company']  as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesType && matchesSearch;
    }).toList();
  }

  int get _totalApplicants =>
      _filtered.fold(0, (sum, o) => sum + (o['applicants'] as List).length);

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
      default:           return const Color(0xFFF1F5F9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(children: [

                if (!_isSearching)
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PLACEMENT CELL',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5)),
                        SizedBox(height: 2),
                        Text('Applicants',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: darkText)),
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
                            color: Colors.black.withValues(alpha: 0.07),
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
                          prefixIcon: const Icon(Icons.search_rounded, color: subText, size: 20),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? GestureDetector(
                            onTap: () => setState(() {
                              _searchQuery = '';
                              _searchCtrl.clear();
                            }),
                            child: const Icon(Icons.close_rounded, color: subText, size: 18),
                          )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(width: 8),

                GestureDetector(
                  onTap: () => setState(() {
                    _isSearching = !_isSearching;
                    if (!_isSearching) { _searchQuery = ''; _searchCtrl.clear(); }
                  }),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _isSearching ? blue : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.07),
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

            // ── SUMMARY STRIP ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: brandGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(children: [
                  _summaryItem(Icons.work_outline_rounded,
                      '${_filtered.length}', 'Openings'),
                  _vDivider(),
                  _summaryItem(Icons.people_alt_rounded,
                      '$_totalApplicants', 'Applicants'),
                  _vDivider(),
                  _summaryItem(Icons.business_rounded,
                      '${_filtered.map((o) => o['company']).toSet().length}', 'Companies'),
                ]),
              ),
            ),

            const SizedBox(height: 14),

            // ── FILTER CHIPS ──────────────────────────────────────────────
            SizedBox(
              height: 36,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final f = _filters[i];
                  final isActive = f == _activeFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _activeFilter = f),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: isActive ? brandGradient : null,
                        color: isActive ? null : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: isActive
                                ? blue.withValues(alpha: 0.25)
                                : Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(f,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isActive ? Colors.white : subText)),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // ── COUNT LINE ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Row(children: [
                Text(
                  '${_filtered.length} opening${_filtered.length == 1 ? '' : 's'} · $_totalApplicants total applicants',
                  style: const TextStyle(fontSize: 12, color: textMuted),
                ),
              ]),
            ),

            const SizedBox(height: 8),

            // ── LIST ──────────────────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.people_outline_rounded,
                      size: 54, color: Colors.grey[300]),
                  const SizedBox(height: 12),
                  Text(
                    _searchQuery.isNotEmpty
                        ? 'No results for "$_searchQuery"'
                        : 'No openings in this category',
                    style: const TextStyle(color: subText, fontSize: 14),
                  ),
                ]),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                itemCount: _filtered.length,
                itemBuilder: (_, i) => _openingCard(_filtered[i]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // ── Summary Item ───────────────────────────────────────────────────────────
  Widget _summaryItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ]),
    );
  }

  Widget _vDivider() => Container(
    width: 1, height: 36,
    color: Colors.white.withValues(alpha: 0.25),
    margin: const EdgeInsets.symmetric(horizontal: 4),
  );

  // ── Opening Card ───────────────────────────────────────────────────────────
  Widget _openingCard(Map<String, dynamic> o) {
    final Color cardColor  = o['companyColor'] as Color;
    final Color cardBg     = o['companyBg']    as Color;
    final List  applicants = o['applicants']   as List;
    final int   count      = applicants.length;

    final int shortlisted = applicants
        .where((a) => a['status'] == 'Shortlisted').length;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OpeningApplicantsPage(opening: o),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(children: [
          // Decorative circle
          Positioned(
            top: -20, right: -20,
            child: Container(
              width: 110, height: 110,
              decoration: BoxDecoration(color: cardBg, shape: BoxShape.circle),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              // ── Company + Title Row ──────────────────────────────────
              Row(children: [
                Container(
                  width: 52, height: 52,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(o['companyInitial'],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(o['jobTitle'],
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: darkText)),
                    const SizedBox(height: 3),
                    Text(o['company'],
                        style: const TextStyle(fontSize: 13, color: subText)),
                  ]),
                ),
                // Opening type badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _typeBadgeBg(o['openingType']),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(o['openingType'],
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _typeBadgeColor(o['openingType']))),
                ),
              ]),

              const SizedBox(height: 14),

              // ── Applicant Count Strip ────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(children: [
                  // Avatar stack preview
                  SizedBox(
                    width: (count > 3 ? 3 : count) * 22.0 + 8,
                    height: 28,
                    child: Stack(
                      children: List.generate(count > 3 ? 3 : count, (i) {
                        final a = applicants[i];
                        return Positioned(
                          left: i * 20.0,
                          child: Container(
                            width: 28, height: 28,
                            decoration: BoxDecoration(
                              color: cardColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(a['avatar'],
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 12, color: subText),
                        children: [
                          TextSpan(
                            text: '$count',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: darkText,
                                fontSize: 14),
                          ),
                          const TextSpan(text: ' applicants  ·  '),
                          TextSpan(
                            text: '$shortlisted shortlisted',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: cardColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: subText, size: 18),
                ]),
              ),

              const SizedBox(height: 12),

              // ── View Applicants Button ───────────────────────────────
              Container(
                height: 46,
                decoration: BoxDecoration(
                  gradient: brandGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.people_alt_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('View Applicants',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                  ]),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}