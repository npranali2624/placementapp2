import 'package:flutter/material.dart';

// ── Sample model so the page can receive a pre-populated opening ─────────────
class JobOpening {
  final String jobTitle;
  final String coordinatorId;
  final String company;
  final String openingType;
  final String qualification;
  final String vacancies;
  final String experience;
  final String salaryMin;
  final String salaryMax;
  final String location;
  final String jobTime;
  final String timeConstraint;
  final String jobDescription;
  final String responsibilities;
  final String techRequirements;
  final String professionalRequirements;
  final String terms;

  const JobOpening({
    required this.jobTitle,
    required this.coordinatorId,
    required this.company,
    required this.openingType,
    required this.qualification,
    required this.vacancies,
    required this.experience,
    required this.salaryMin,
    required this.salaryMax,
    required this.location,
    required this.jobTime,
    required this.timeConstraint,
    required this.jobDescription,
    required this.responsibilities,
    required this.techRequirements,
    required this.professionalRequirements,
    required this.terms,
  });
}

// ── Default dummy opening so the page can be opened without real data ─────────
const _dummyOpening = JobOpening(
  jobTitle: 'Backend Developer',
  coordinatorId: 'TC-HR-2025',
  company: 'Nexora Technologies',
  openingType: 'Placement',
  qualification: 'B.Tech / MCA / M.Sc',
  vacancies: '8',
  experience: 'Fresher',
  salaryMin: '5',
  salaryMax: '8',
  location: 'Pune, Maharashtra',
  jobTime: 'Full Time',
  timeConstraint: '30 days',
  jobDescription:
  'We are looking for a passionate Backend Developer to build scalable applications.',
  responsibilities:
  'Develop REST APIs, manage databases, perform code reviews',
  techRequirements: 'Node.js, PostgreSQL, Docker, REST, Git',
  professionalRequirements:
  'Good communication, Problem solving, Teamwork',
  terms:
  '6 months probation, performance-based conversion, follow company policies',
);

// ═══════════════════════════════════════════════════════════════════════════════
//  UpdateOpeningScreen
// ═══════════════════════════════════════════════════════════════════════════════
class UpdateOpeningScreen extends StatefulWidget {
  final JobOpening opening;

  const UpdateOpeningScreen({super.key, this.opening = _dummyOpening});

  @override
  State<UpdateOpeningScreen> createState() => _UpdateOpeningScreenState();
}

class _UpdateOpeningScreenState extends State<UpdateOpeningScreen>
    with SingleTickerProviderStateMixin {
  // ── Palette ─────────────────────────────────────────────────────────────────
  static const Color bgColor    = Color(0xFFF1F5F9);
  static const Color navyDark   = Color(0xFF1E3A8A);
  static const Color blue       = Color(0xFF2563EB);
  static const Color skyBlue    = Color(0xFF38BDF8);
  static const Color labelColor = Color(0xFF38BDF8);
  static const Color textHead   = Color(0xFF1E293B);
  static const Color textSub    = Color(0xFF64748B);
  static const Color textMuted  = Color(0xFF94A3B8);
  static const Color fieldBg    = Color(0xFFF1F5F9);
  static const Color cardBg     = Colors.white;
  static const Color accentOrange = Color(0xFFF97316);

  // ── Controllers ─────────────────────────────────────────────────────────────
  late final TextEditingController _jobTitleCtrl;
  late final TextEditingController _vacanciesCtrl;
  late final TextEditingController _coordinatorIdCtrl;
  late final TextEditingController _salaryMinCtrl;
  late final TextEditingController _salaryMaxCtrl;
  late final TextEditingController _jobDescriptionCtrl;
  late final TextEditingController _responsibilitiesCtrl;
  late final TextEditingController _techReqCtrl;
  late final TextEditingController _professionalReqCtrl;
  late final TextEditingController _termsCtrl;
  late final TextEditingController _timeConstraintCtrl;

  // ── Dropdown / Toggle State ──────────────────────────────────────────────────
  late String selectedOpeningType;
  late String selectedCompany;
  late String selectedQualification;
  late String selectedExperience;
  late String selectedLocation;
  late String selectedJobTime;

  final openingTypes   = ['Placement', 'Internship', 'Hybrid'];
  final companies      = ['Nexora Technologies', 'ABC Corp', 'DEE Technologies'];
  final qualifications = ['B.Tech / MCA / M.Sc', 'BCA / B.Sc', 'MBA', 'Any Graduate'];
  final experiences    = ['Fresher', '0–1 year', '1–3 years', '3+ years'];
  final locations      = [
    'Pune, Maharashtra',
    'Mumbai, Maharashtra',
    'Bengaluru, Karnataka',
    'Remote'
  ];
  final jobTimes = ['Full Time', 'Part Time', 'Contract'];

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();

    _jobTitleCtrl         = TextEditingController(text: widget.opening.jobTitle);
    _vacanciesCtrl        = TextEditingController(text: widget.opening.vacancies);
    _coordinatorIdCtrl    = TextEditingController(text: widget.opening.coordinatorId);
    _salaryMinCtrl        = TextEditingController(text: widget.opening.salaryMin);
    _salaryMaxCtrl        = TextEditingController(text: widget.opening.salaryMax);
    _jobDescriptionCtrl   = TextEditingController(text: widget.opening.jobDescription);
    _responsibilitiesCtrl = TextEditingController(text: widget.opening.responsibilities);
    _techReqCtrl          = TextEditingController(text: widget.opening.techRequirements);
    _professionalReqCtrl  = TextEditingController(text: widget.opening.professionalRequirements);
    _termsCtrl            = TextEditingController(text: widget.opening.terms);
    _timeConstraintCtrl   = TextEditingController(text: widget.opening.timeConstraint);

    selectedOpeningType   = widget.opening.openingType;
    selectedCompany       = widget.opening.company;
    selectedQualification = widget.opening.qualification;
    selectedExperience    = widget.opening.experience;
    selectedLocation      = widget.opening.location;
    selectedJobTime       = widget.opening.jobTime;

    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();

    for (final ctrl in _allControllers) {
      ctrl.addListener(_markChanged);
    }
  }

  List<TextEditingController> get _allControllers => [
    _jobTitleCtrl, _vacanciesCtrl, _coordinatorIdCtrl,
    _salaryMinCtrl, _salaryMaxCtrl, _jobDescriptionCtrl,
    _responsibilitiesCtrl, _techReqCtrl, _professionalReqCtrl,
    _termsCtrl, _timeConstraintCtrl,
  ];

  void _markChanged() {
    if (!_hasChanges) setState(() => _hasChanges = true);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    for (final ctrl in _allControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  InputDecoration _inputDeco({String? hint}) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: textMuted, fontSize: 12),
    filled: true,
    fillColor: fieldBg,
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: blue, width: 1.5)),
  );

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: labelColor)),
  );

  Widget _field(String label, TextEditingController ctrl,
      {String? hint, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label(label),
        TextField(
          controller: ctrl,
          keyboardType: keyboardType,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: textHead),
          decoration: _inputDeco(hint: hint),
        ),
      ]),
    );
  }

  Widget _textArea(String label, TextEditingController ctrl,
      {String? hint, int maxLines = 3}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label(label),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          style: const TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: textHead),
          decoration: _inputDeco(hint: hint),
        ),
      ]),
    );
  }

  Widget _dropdown(String label, String value, List<String> items,
      {required ValueChanged<String?> onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _label(label),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: textHead),
          decoration: _inputDeco(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: blue, size: 20),
          dropdownColor: Colors.white,
        ),
      ]),
    );
  }

  Widget _toggleRow(String label, List<String> options, String selected,
      ValueChanged<String> onSelect) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _label(label),
      Row(
        children: options.map((opt) {
          final sel = opt == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                onSelect(opt);
                _markChanged();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8, bottom: 14),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: sel
                      ? const LinearGradient(
                    colors: [navyDark, blue, skyBlue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                      : null,
                  color: sel ? null : fieldBg,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: sel
                      ? [
                    BoxShadow(
                        color: blue.withOpacity(0.30),
                        blurRadius: 8,
                        offset: const Offset(0, 3))
                  ]
                      : [],
                ),
                child: Center(
                  child: Text(opt,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: sel ? Colors.white : textSub)),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  Widget _salaryRange() {
    final isSalary = selectedOpeningType != 'Internship';
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _label(isSalary ? 'Salary Range (LPA)' : 'Stipend Range (₹/month)'),
      Row(children: [
        Expanded(
            child: _miniField(_salaryMinCtrl, isSalary ? 'Min LPA' : 'Min ₹')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('to',
              style: const TextStyle(
                  color: textMuted,
                  fontWeight: FontWeight.w700,
                  fontSize: 13)),
        ),
        Expanded(
            child: _miniField(_salaryMaxCtrl, isSalary ? 'Max LPA' : 'Max ₹')),
      ]),
    ]);
  }

  Widget _miniField(TextEditingController ctrl, String hint) => TextField(
    controller: ctrl,
    textAlign: TextAlign.center,
    keyboardType: TextInputType.number,
    style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w700, color: textHead),
    decoration: _inputDeco(hint: hint),
  );

  Widget _sectionTitle(String title) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title,
          style: const TextStyle(
              color: textHead,
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.4)),
    ),
  );

  Widget _sectionCard({required List<Widget> children}) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4)),
      ],
    ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );

  void _showSaveConfirm() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [
          Icon(Icons.edit_note_rounded, color: blue),
          SizedBox(width: 8),
          Text('Update Opening',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ]),
        content: const Text(
            'Are you sure you want to save the changes to this opening?',
            style: TextStyle(color: textSub, fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(children: [
                    Icon(Icons.check_circle_rounded,
                        color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Opening updated successfully!'),
                  ]),
                  backgroundColor: const Color(0xFF22C55E),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
              setState(() => _hasChanges = false);
            },
            child: const Text('Update',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
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
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              // ── HEADER ──────────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [navyDark, blue, skyBlue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:
                    const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Center(
                        child: Icon(Icons.edit_note_rounded,
                            color: blue, size: 28)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Update Opening",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(selectedCompany,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ]),
                  ),
                  if (_hasChanges)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentOrange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Unsaved',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                ]),
              ),

              const SizedBox(height: 20),

              _sectionTitle("JOB DETAILS"),
              _sectionCard(children: [
                _field('Job Title', _jobTitleCtrl),
                _field('Coordinator ID', _coordinatorIdCtrl,
                    hint: 'e.g. TC-HR-2025'),
                _dropdown('Company', selectedCompany, companies,
                    onChanged: (v) {
                      setState(() {
                        selectedCompany = v!;
                        _hasChanges = true;
                      });
                    }),
                _toggleRow('Opening Type', openingTypes, selectedOpeningType,
                        (v) => setState(() => selectedOpeningType = v)),
                _dropdown('Required Qualification', selectedQualification,
                    qualifications,
                    onChanged: (v) => setState(() {
                      selectedQualification = v!;
                      _hasChanges = true;
                    })),
                Row(children: [
                  Expanded(
                    child: _field('No. of Vacancies', _vacanciesCtrl,
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dropdown(
                        'Experience', selectedExperience, experiences,
                        onChanged: (v) => setState(() {
                          selectedExperience = v!;
                          _hasChanges = true;
                        })),
                  ),
                ]),
              ]),

              const SizedBox(height: 16),

              _sectionTitle("COMPENSATION"),
              _sectionCard(children: [_salaryRange()]),

              const SizedBox(height: 16),

              _sectionTitle("LOCATION & SCOPE"),
              _sectionCard(children: [
                _dropdown('Work Location', selectedLocation, locations,
                    onChanged: (v) => setState(() {
                      selectedLocation = v!;
                      _hasChanges = true;
                    })),
                _toggleRow('Job Time', jobTimes, selectedJobTime,
                        (v) => setState(() => selectedJobTime = v)),
                _field('Time Constraint', _timeConstraintCtrl,
                    hint: 'e.g. 30 days'),
              ]),

              const SizedBox(height: 16),

              _sectionTitle("JOB DESCRIPTION"),
              _sectionCard(children: [
                _textArea(
                  'Job Description',
                  _jobDescriptionCtrl,
                  hint: 'Describe the role and what you are looking for...',
                  maxLines: 4,
                ),
              ]),

              const SizedBox(height: 16),

              _sectionTitle("RESPONSIBILITIES & REQUIREMENTS"),
              _sectionCard(children: [
                _textArea('Responsibilities', _responsibilitiesCtrl,
                    hint: 'e.g. Develop REST APIs, manage databases...'),
                _textArea('Technical Requirements', _techReqCtrl,
                    hint: 'e.g. Flutter, Node.js, PostgreSQL, Git...'),
                _textArea('Professional Requirements', _professionalReqCtrl,
                    hint: 'e.g. Good communication, Problem solving...'),
              ]),

              const SizedBox(height: 16),

              _sectionTitle("TERMS & CONDITIONS"),
              _sectionCard(children: [
                _textArea(
                  'Terms & Conditions',
                  _termsCtrl,
                  hint:
                  'e.g. 6 months probation, performance-based conversion...',
                  maxLines: 4,
                ),
              ]),

              const SizedBox(height: 24),

              GestureDetector(
                onTap: _showSaveConfirm,
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [navyDark, blue, skyBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: blue.withOpacity(0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 6)),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.update_rounded,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "UPDATE OPENING",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            letterSpacing: 1.2),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ]),
          ),
        ),
      ),
    );
  }
}