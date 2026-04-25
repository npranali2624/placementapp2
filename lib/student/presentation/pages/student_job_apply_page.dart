import 'package:flutter/material.dart';

class StudentJobApplyPage extends StatefulWidget {
  final String jobTitle;
  final String company;

  /// Pre-filled, non-editable data coming from the student's profile.
  /// Keys expected: name, email, phone, course, cgpa, specialization
  final Map<String, String> profileData;

  const StudentJobApplyPage({
    super.key,
    required this.jobTitle,
    required this.company,
    this.profileData = const {},
  });

  @override
  State<StudentJobApplyPage> createState() => _StudentJobApplyPageState();
}

class _StudentJobApplyPageState extends State<StudentJobApplyPage> {

  // ── Editable controllers ───────────────────────────────────────────────────
  final TextEditingController skillsController       = TextEditingController();
  final TextEditingController coverLetterController  = TextEditingController();
  final TextEditingController toolsController        = TextEditingController();
  final TextEditingController githubController       = TextEditingController();
  final TextEditingController linkedinController     = TextEditingController();
  final TextEditingController experienceController   = TextEditingController();
  final TextEditingController projectsController     = TextEditingController();
  final TextEditingController certificateController  = TextEditingController();

  bool isAvailable = true;
  bool agreeTerms  = false;

  // ── Palette (mirrors OpeningViewDetailsPage) ───────────────────────────────
  static const Color bgColor   = Color(0xFFF1F5F9);
  static const Color navyDark  = Color(0xFF1E3A8A);
  static const Color blue      = Color(0xFF2563EB);
  static const Color skyBlue   = Color(0xFF38BDF8);
  static const Color textHead  = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF94A3B8);

  static const LinearGradient _primaryGradient = LinearGradient(
    colors: [navyDark, blue, skyBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Helper to safely read profile data
  String _profile(String key) => widget.profileData[key] ?? '';

  @override
  void dispose() {
    skillsController.dispose();
    coverLetterController.dispose();
    toolsController.dispose();
    githubController.dispose();
    linkedinController.dispose();
    experienceController.dispose();
    projectsController.dispose();
    certificateController.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── HEADER ──────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: _primaryGradient,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(Icons.work_rounded,
                            color: blue, size: 28),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.jobTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.company,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── PERSONAL DETAILS (locked) ────────────────────────────────
              _sectionTitle('PERSONAL DETAILS'),
              _sectionCard(
                icon: Icons.person_rounded,
                children: [
                  _lockedField('Full Name',               _profile('name')),
                  _lockedField('Email',                   _profile('email')),
                  _lockedField('Phone Number',            _profile('phone')),
                  _lockedField('Current Course / Degree', _profile('course')),
                  _lockedField('CGPA / Percentage',       _profile('cgpa')),
                  _lockedField('Specialization',          _profile('specialization')),
                ],
              ),

              // ── SKILLS & TOOLS ───────────────────────────────────────────
              _sectionTitle('SKILLS & TOOLS'),
              _sectionCard(
                icon: Icons.code_rounded,
                children: [
                  _editableField('Skills (e.g. Flutter, Java)', skillsController),
                  _editableField('Tools / Technologies',        toolsController),
                ],
              ),

              // ── PROFILES ────────────────────────────────────────────────
              _sectionTitle('PROFILES'),
              _sectionCard(
                icon: Icons.link_rounded,
                children: [
                  _editableField('GitHub Link',   githubController),
                  _editableField('LinkedIn Link', linkedinController),
                ],
              ),

              // ── EXPERIENCE ──────────────────────────────────────────────
              _sectionTitle('EXPERIENCE'),
              _sectionCard(
                icon: Icons.work_history_rounded,
                children: [
                  _editableField('Experience Details', experienceController,
                      maxLines: 3),
                ],
              ),

              // ── PROJECTS ────────────────────────────────────────────────
              _sectionTitle('PROJECTS'),
              _sectionCard(
                icon: Icons.build_rounded,
                children: [
                  _editableField('Project Details', projectsController,
                      maxLines: 3),
                ],
              ),

              // ── CERTIFICATES ─────────────────────────────────────────────
              _sectionTitle('CERTIFICATES / ACHIEVEMENTS'),
              _sectionCard(
                icon: Icons.emoji_events_rounded,
                children: [
                  _editableField('Certificates / Achievements',
                      certificateController,
                      maxLines: 3),
                ],
              ),

              // ── RESUME ──────────────────────────────────────────────────
              _sectionTitle('RESUME'),
              _sectionCard(
                icon: Icons.upload_file_rounded,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: file picker
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: blue.withValues(alpha: 0.25),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: _primaryGradient,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.attach_file_rounded,
                                color: Colors.white, size: 16),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upload Resume',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: textHead,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'PDF format preferred',
                                style: TextStyle(
                                    fontSize: 11, color: textMuted),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Icon(Icons.chevron_right_rounded,
                              color: textMuted.withValues(alpha: 0.6)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ── COVER LETTER ─────────────────────────────────────────────
              _sectionTitle('COVER LETTER'),
              _sectionCard(
                icon: Icons.description_rounded,
                children: [
                  _editableField(
                      'Write something about yourself…',
                      coverLetterController,
                      maxLines: 5),
                ],
              ),

              // ── AVAILABILITY ─────────────────────────────────────────────
              _sectionTitle('AVAILABILITY'),
              _sectionCard(
                icon: Icons.access_time_rounded,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Available to join immediately',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textHead,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isAvailable
                                  ? 'Yes, I can join right away'
                                  : 'No, I need some time',
                              style: TextStyle(
                                fontSize: 11,
                                color: isAvailable ? blue : textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isAvailable,
                        activeColor: blue,
                        onChanged: (val) =>
                            setState(() => isAvailable = val),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // ── TERMS CHECKBOX ───────────────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        value: agreeTerms,
                        activeColor: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onChanged: (val) =>
                            setState(() => agreeTerms = val!),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'I agree to the terms & conditions and confirm that all information provided is accurate.',
                        style: TextStyle(
                          fontSize: 12,
                          color: textHead,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── SUBMIT BUTTON ────────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  if (!agreeTerms) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please accept terms & conditions'),
                        backgroundColor: Colors.red.shade400,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Application Submitted Successfully! 🎉'),
                      backgroundColor: const Color(0xFF22C55E),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: _primaryGradient,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: blue.withValues(alpha: 0.40),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit Application',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

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
        Text(
          title,
          style: const TextStyle(
            color: textHead,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );

  Widget _sectionCard({
    required IconData icon,
    required List<Widget> children,
  }) =>
      Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );

  /// Non-editable, profile-sourced field
  Widget _lockedField(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.isNotEmpty ? value : '—',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: value.isNotEmpty
                        ? textHead
                        : textMuted,
                  ),
                ),
              ),
              const Icon(Icons.lock_outline_rounded,
                  size: 14, color: textMuted),
            ],
          ),
        ),
      ],
    ),
  );

  /// Editable text field
  Widget _editableField(
      String hint,
      TextEditingController controller, {
        int maxLines = 1,
      }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13, color: textHead),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
            const TextStyle(fontSize: 13, color: textMuted),
            filled: true,
            fillColor: const Color(0xFFF8FAFF),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: blue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 12),
          ),
        ),
      );
}