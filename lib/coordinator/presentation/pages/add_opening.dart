import 'package:flutter/material.dart';

class AddEditOpeningScreen extends StatefulWidget {
  final bool isEdit;
  const AddEditOpeningScreen({super.key, this.isEdit = true});

  @override
  State<AddEditOpeningScreen> createState() => _AddEditOpeningScreenState();
}

class _AddEditOpeningScreenState extends State<AddEditOpeningScreen>
    with SingleTickerProviderStateMixin {

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

  final _jobTitleCtrl       = TextEditingController(text: 'Backend Developer');
  final _vacanciesCtrl      = TextEditingController(text: '8');
  final _salaryMinCtrl      = TextEditingController(text: '5');
  final _salaryMaxCtrl      = TextEditingController(text: '8');
  final _timeConstraintCtrl = TextEditingController(text: '30 days');
  final _expValueCtrl       = TextEditingController();

  final List<TextEditingController> _responsibilityControllers = [];
  final List<TextEditingController> _techReqControllers        = [];
  final List<TextEditingController> _profReqControllers        = [];
  final List<TextEditingController> _termsControllers          = [];

  String selectedOpeningType = 'Placement';
  String selectedCompany     = 'Nexora Technologies';
  String selectedLocation    = 'Pune, Maharashtra';
  String selectedJobTime     = 'Full Time';

  final List<String> qualifications = [
    'B.Tech', 'MCA', 'M.Sc', 'BCA', 'B.Sc',
    'MBA', 'B.Com', 'M.Tech', 'Diploma', 'Any Graduate',
  ];
  final Set<String> selectedQualifications = {};

  bool   isFresher       = true;
  String selectedExpUnit = 'Months';

  final openingTypes = ['Placement', 'Internship', 'Hybrid'];
  final companies    = ['Nexora Technologies', 'ABC Corp', 'DEE Technologies'];
  final locations    = ['Pune, Maharashtra', 'Mumbai, Maharashtra', 'Bengaluru, Karnataka', 'Remote'];
  final jobTimes     = ['Full Time', 'Part Time', 'Contract'];

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;

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
    _salaryMinCtrl.dispose();
    _salaryMaxCtrl.dispose();
    _timeConstraintCtrl.dispose();
    _expValueCtrl.dispose();
    for (final c in [
      ..._responsibilityControllers,
      ..._techReqControllers,
      ..._profReqControllers,
      ..._termsControllers,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _addItem(List<TextEditingController> list) =>
      setState(() => list.add(TextEditingController()));

  void _removeItem(List<TextEditingController> list, int index) {
    setState(() {
      list[index].dispose();
      list.removeAt(index);
    });
  }

  static const LinearGradient _primaryGradient = LinearGradient(
    colors: [navyDark, blue, skyBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient _badgeGradient = LinearGradient(
    colors: [navyDark, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient _serialBadgeGradient = LinearGradient(
    colors: [Color(0xFF22D3EE), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  InputDecoration _inputDeco({String? hint}) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: textMuted, fontSize: 12),
    filled: true,
    fillColor: fieldBg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
              onTap: () => onSelect(opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8, bottom: 14),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: sel ? _primaryGradient : null,
                  color: sel ? null : fieldBg,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: sel
                      ? [BoxShadow(
                      color: blue.withValues(alpha: 0.30),
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

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            gradient: _primaryGradient,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                color: textHead,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 0.5)),
      ],
    ),
  );

  Widget _sectionCard({required List<Widget> children}) => Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4)),
      ],
    ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );

  // ── Salary Range ───────────────────────────────────────────────────────────
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
                  color: textMuted,
                  fontWeight: FontWeight.w700,
                  fontSize: 13)),
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

  Widget _qualificationCapsules() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Required Qualification'),
          const SizedBox(height: 2),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: qualifications.map((q) {
              final isSel = selectedQualifications.contains(q);
              return GestureDetector(
                onTap: () => setState(() => isSel
                    ? selectedQualifications.remove(q)
                    : selectedQualifications.add(q)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSel ? _primaryGradient : null,
                    color: isSel ? null : fieldBg,
                    borderRadius: BorderRadius.circular(30),
                    border: isSel
                        ? null
                        : Border.all(color: blue.withValues(alpha: 0.25), width: 1),
                    boxShadow: isSel
                        ? [BoxShadow(
                        color: blue.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2))]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSel) ...[
                        const Icon(Icons.check_rounded, color: Colors.white, size: 13),
                        const SizedBox(width: 4),
                      ],
                      Text(q,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isSel ? Colors.white : textSub)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (selectedQualifications.isEmpty) ...[
            const SizedBox(height: 6),
            const Row(children: [
              Icon(Icons.info_outline_rounded, size: 12, color: textMuted),
              SizedBox(width: 4),
              Text('Select one or more qualifications',
                  style: TextStyle(
                      fontSize: 11,
                      color: textMuted,
                      fontWeight: FontWeight.w500)),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _experienceSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Experience Required'),
          Row(
            children: ['Fresher', 'Experienced'].map((opt) {
              final sel = (opt == 'Fresher') == isFresher;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => isFresher = opt == 'Fresher'),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8, bottom: 12),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: sel ? _primaryGradient : null,
                      color: sel ? null : fieldBg,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: sel
                          ? [BoxShadow(
                          color: blue.withValues(alpha: 0.30),
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SizeTransition(sizeFactor: anim, child: child)),
            child: isFresher
                ? const SizedBox.shrink()
                : Column(
              key: const ValueKey('exp_fields'),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Experience Duration'),
                Row(children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _expValueCtrl,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textHead),
                      decoration: _inputDeco(hint: 'e.g. 6'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: ['Months', 'Years'].map((unit) {
                        final sel = unit == selectedExpUnit;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => selectedExpUnit = unit),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                gradient: sel ? _primaryGradient : null,
                                color: sel ? null : fieldBg,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: sel
                                    ? [BoxShadow(
                                    color: blue.withValues(alpha: 0.30),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3))]
                                    : [],
                              ),
                              child: Center(
                                child: Text(unit,
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
                  ),
                ]),
                if (_expValueCtrl.text.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: blue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: blue.withValues(alpha: 0.25), width: 1),
                    ),
                    child: Text(
                      '${_expValueCtrl.text} $selectedExpUnit experience required',
                      style: const TextStyle(
                          fontSize: 12,
                          color: blue,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dynamicListSection({
    required String sectionTitle,
    required String itemLabel,
    required String hintText,
    required List<TextEditingController> controllers,
    required IconData sectionIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(sectionTitle),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controllers.asMap().entries.map((entry) {
                final i    = entry.key;
                final ctrl = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: _serialBadgeGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: ctrl,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: textHead),
                          decoration: _inputDeco(hint: hintText),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _removeItem(controllers, i),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.delete_outline_rounded,
                              color: Colors.red.shade400, size: 18),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              if (controllers.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(children: [
                    Icon(sectionIcon, size: 15, color: textMuted),
                    const SizedBox(width: 8),
                    Text('No $itemLabel added yet. Tap + to add.',
                        style: const TextStyle(
                            fontSize: 12,
                            color: textMuted,
                            fontWeight: FontWeight.w500)),
                  ]),
                ),
              GestureDetector(
                onTap: () => _addItem(controllers),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: blue, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                          color: blue.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          gradient: _badgeGradient,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.add_rounded,
                            color: Colors.white, size: 15),
                      ),
                      const SizedBox(width: 8),
                      Text('Add $itemLabel',
                          style: const TextStyle(
                              color: blue,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: _primaryGradient,
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
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Add Opening",
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
                ]),
              ),

              const SizedBox(height: 20),

              _sectionTitle("JOB DETAILS"),
              _sectionCard(children: [
                _dropdown('Company', selectedCompany, companies,
                    onChanged: (v) => setState(() => selectedCompany = v!)),
                _field('Job Title', _jobTitleCtrl),
                _toggleRow('Opening Type', openingTypes, selectedOpeningType,
                        (v) => setState(() => selectedOpeningType = v)),
                _qualificationCapsules(),
                _field('No. of Vacancies', _vacanciesCtrl,
                    keyboardType: TextInputType.number),
                _experienceSection(),
              ]),

              _sectionTitle("COMPENSATION"),
              _sectionCard(children: [_salaryRange()]),

              _sectionTitle("LOCATION & SCOPE"),
              _sectionCard(children: [
                _dropdown('Work Location', selectedLocation, locations,
                    onChanged: (v) => setState(() => selectedLocation = v!)),
                _toggleRow('Job Time', jobTimes, selectedJobTime,
                        (v) => setState(() => selectedJobTime = v)),
                _field('Time Constraint', _timeConstraintCtrl,
                    hint: 'e.g. 30 days'),
              ]),

              _dynamicListSection(
                sectionTitle: 'RESPONSIBILITIES',
                itemLabel: 'Responsibility',
                hintText: 'e.g. Manage database schema and migrations...',
                controllers: _responsibilityControllers,
                sectionIcon: Icons.checklist_rounded,
              ),

              _dynamicListSection(
                sectionTitle: 'TECHNICAL REQUIREMENTS',
                itemLabel: 'Tech Skill',
                hintText: 'e.g. Node.js, PostgreSQL, Docker...',
                controllers: _techReqControllers,
                sectionIcon: Icons.code_rounded,
              ),

              _dynamicListSection(
                sectionTitle: 'PROFESSIONAL REQUIREMENTS',
                itemLabel: 'Prof. Skill',
                hintText: 'e.g. Strong communication skills...',
                controllers: _profReqControllers,
                sectionIcon: Icons.psychology_outlined,
              ),

              _dynamicListSection(
                sectionTitle: 'TERMS & CONDITIONS',
                itemLabel: 'Term',
                hintText: 'e.g. 6 months probation period...',
                controllers: _termsControllers,
                sectionIcon: Icons.gavel_rounded,
              ),

              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    gradient: _primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: blue.withValues(alpha: 0.35),
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