import 'package:flutter/material.dart';

class AddEditOpeningScreen extends StatefulWidget {
  final bool isEdit;
  const AddEditOpeningScreen({super.key, this.isEdit = true});

  @override
  State<AddEditOpeningScreen> createState() => _AddEditOpeningScreenState();
}

class _AddEditOpeningScreenState extends State<AddEditOpeningScreen>
    with SingleTickerProviderStateMixin {

  // ── Palette ────────────────────────────────────────────────────────────────
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

  // ── Controllers ────────────────────────────────────────────────────────────
  final _jobTitleCtrl         = TextEditingController(text: 'Backend Developer');
  final _vacanciesCtrl        = TextEditingController(text: '8');
  final _coordinatorIdCtrl    = TextEditingController(text: 'TC-HR-2025');
  final _salaryMinCtrl        = TextEditingController(text: '5');
  final _salaryMaxCtrl        = TextEditingController(text: '8');
  final _jobDescriptionCtrl   = TextEditingController(
      text: 'We are looking for a passionate Backend Developer to build scalable applications.');
  final _responsibilitiesCtrl = TextEditingController(
      text: 'Develop REST APIs, manage databases, perform code reviews');
  final _techReqCtrl          = TextEditingController(
      text: 'Node.js, PostgreSQL, Docker, REST, Git');
  final _professionalReqCtrl  = TextEditingController(
      text: 'Good communication, Problem solving, Teamwork');
  final _termsCtrl            = TextEditingController(
      text: '6 months probation, performance-based conversion, follow company policies');
  final _timeConstraintCtrl   = TextEditingController(text: '30 days');

  // ── Dropdown / Toggle State ────────────────────────────────────────────────
  String selectedOpeningType   = 'Placement';
  String selectedCompany       = 'Nexora Technologies';
  String selectedQualification = 'B.Tech / MCA / M.Sc';
  String selectedExperience    = 'Fresher';
  String selectedLocation      = 'Pune, Maharashtra';
  String selectedJobTime       = 'Full Time';

  final openingTypes   = ['Placement', 'Internship', 'Hybrid'];
  final companies      = ['Nexora Technologies', 'ABC Corp', 'DEE Technologies'];
  final qualifications = ['B.Tech / MCA / M.Sc', 'BCA / B.Sc', 'MBA', 'Any Graduate'];
  final experiences    = ['Fresher', '0–1 year', '1–3 years', '3+ years'];
  final locations      = ['Pune, Maharashtra', 'Mumbai, Maharashtra', 'Bengaluru, Karnataka', 'Remote'];
  final jobTimes       = ['Full Time', 'Part Time', 'Contract'];

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

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
    _jobTitleCtrl.dispose();
    _vacanciesCtrl.dispose();
    _coordinatorIdCtrl.dispose();
    _salaryMinCtrl.dispose();
    _salaryMaxCtrl.dispose();
    _jobDescriptionCtrl.dispose();
    _responsibilitiesCtrl.dispose();
    _techReqCtrl.dispose();
    _professionalReqCtrl.dispose();
    _termsCtrl.dispose();
    _timeConstraintCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDeco({String? hint}) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: textMuted, fontSize: 12),
    filled: true,
    fillColor: fieldBg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: blue, width: 1.5)),
  );

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w600, color: labelColor)),
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
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: textHead),
          decoration: _inputDeco(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: blue, size: 20),
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
              onTap: () => onSelect(opt),
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
                      ? [BoxShadow(
                      color: blue.withOpacity(0.30),
                      blurRadius: 8,
                      offset: const Offset(0, 3))]
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
        Expanded(child: _miniField(_salaryMinCtrl, isSalary ? 'Min LPA' : 'Min ₹')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('to',
              style: const TextStyle(
                  color: textMuted, fontWeight: FontWeight.w700, fontSize: 13)),
        ),
        Expanded(child: _miniField(_salaryMaxCtrl, isSalary ? 'Max LPA' : 'Max ₹')),
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

              // ── HEADER ────────────────────────────────────────────────────
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
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Center(
                        child: Icon(Icons.work_rounded, color: blue, size: 28)),
                  ),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      widget.isEdit ? "Add Opening" : "Add Opening",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(selectedCompany,
                        style:
                        const TextStyle(color: Colors.white70, fontSize: 13)),
                  ]),
                ]),
              ),

              const SizedBox(height: 20),

              // ── JOB DETAILS ──────────────────────────────────────────────
              _sectionTitle("JOB DETAILS"),
              _sectionCard(children: [
                _field('Job Title', _jobTitleCtrl),
                _field('Coordinator ID', _coordinatorIdCtrl,
                    hint: 'e.g. TC-HR-2025'),
                _dropdown('Company', selectedCompany, companies,
                    onChanged: (v) => setState(() => selectedCompany = v!)),
                _toggleRow('Opening Type', openingTypes, selectedOpeningType,
                        (v) => setState(() => selectedOpeningType = v)),
                _dropdown('Required Qualification', selectedQualification,
                    qualifications,
                    onChanged: (v) =>
                        setState(() => selectedQualification = v!)),
                Row(children: [
                  Expanded(
                    child: _field('No. of Vacancies', _vacanciesCtrl,
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _dropdown('Experience', selectedExperience, experiences,
                        onChanged: (v) =>
                            setState(() => selectedExperience = v!)),
                  ),
                ]),
              ]),

              const SizedBox(height: 16),

              // ── COMPENSATION ─────────────────────────────────────────────
              _sectionTitle("COMPENSATION"),
              _sectionCard(children: [_salaryRange()]),

              const SizedBox(height: 16),

              // ── LOCATION & SCOPE ─────────────────────────────────────────
              _sectionTitle("LOCATION & SCOPE"),
              _sectionCard(children: [
                _dropdown('Work Location', selectedLocation, locations,
                    onChanged: (v) => setState(() => selectedLocation = v!)),
                _toggleRow('Job Time', jobTimes, selectedJobTime,
                        (v) => setState(() => selectedJobTime = v)),
                _field('Time Constraint', _timeConstraintCtrl,
                    hint: 'e.g. 30 days'),
              ]),

              const SizedBox(height: 16),

              // ── JOB DESCRIPTION ──────────────────────────────────────────
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

              // ── RESPONSIBILITIES & REQUIREMENTS ──────────────────────────
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

              // ── TERMS & CONDITIONS ───────────────────────────────────────
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

              // ── SAVE BUTTON ──────────────────────────────────────────────
              GestureDetector(
                onTap: () {},
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
                      Icon(Icons.check_circle_rounded,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "SAVE OPENING",
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