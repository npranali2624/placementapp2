import 'package:flutter/material.dart';
import '../pages/student_job_apply_page.dart';

class OpeningViewDetailsPage extends StatelessWidget {
  final Map<String, dynamic> opening;

  // ── Simulated logged-in student profile ───────────────────────────────────
  // Replace this with your actual profile provider / auth state
  static const Map<String, String> _studentProfile = {
    'name':           'Rahul Sharma',
    'email':          'rahul.sharma@email.com',
    'phone':          '+91 98765 43210',
    'course':         'B.E. Computer Engineering',
    'cgpa':           '8.5 / 10',
    'specialization': 'Computer Engineering',
  };

  const OpeningViewDetailsPage({super.key, required this.opening});

  // ── Palette ────────────────────────────────────────────────────────────────
  static const Color bgColor    = Color(0xFFF1F5F9);
  static const Color navyDark   = Color(0xFF1E3A8A);
  static const Color blue       = Color(0xFF2563EB);
  static const Color skyBlue    = Color(0xFF38BDF8);
  static const Color labelColor = Color(0xFF38BDF8);
  static const Color darkText   = Color(0xFF0F172A);
  static const Color textHead   = Color(0xFF1E293B);
  static const Color subText    = Color(0xFF64748B);
  static const Color textMuted  = Color(0xFF94A3B8);
  static const Color cardBg     = Colors.white;

  static const LinearGradient _primaryGradient = LinearGradient(
    colors: [navyDark, blue, skyBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient _serialBadgeGradient = LinearGradient(
    colors: [Color(0xFF22D3EE), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Data helpers ───────────────────────────────────────────────────────────

  String _str(String key, [String fallback = '—']) {
    final v = opening[key];
    if (v == null || v.toString().trim().isEmpty) return fallback;
    return v.toString();
  }

  List<String> _list(String key) {
    final v = opening[key];
    if (v == null) return [];
    if (v is List) return v.map((e) => e.toString()).toList();
    return [];
  }

  Set<String> _set(String key) {
    final v = opening[key];
    if (v == null) return {};
    if (v is Set) return v.map((e) => e.toString()).toSet();
    if (v is List) return v.map((e) => e.toString()).toSet();
    return {};
  }

  // ── Widget helpers ─────────────────────────────────────────────────────────

  Widget _sectionTitle(BuildContext context, String title) => Padding(
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
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: labelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: darkText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _chipBadge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      gradient: _primaryGradient,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: blue.withValues(alpha: 0.25),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_rounded, color: Colors.white, size: 12),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );

  Widget _dynamicListCard(
      BuildContext context, {
        required String sectionTitle,
        required List<String> items,
        required String emptyMessage,
        required IconData emptyIcon,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(context, sectionTitle),
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
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: items.isEmpty
              ? Row(
            children: [
              Icon(emptyIcon, size: 15, color: textMuted),
              const SizedBox(width: 8),
              Text(
                emptyMessage,
                style: const TextStyle(
                  fontSize: 12,
                  color: textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.asMap().entries.map((entry) {
              final i    = entry.key;
              final text = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: _serialBadgeGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: textHead,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ── Apply Now Button ───────────────────────────────────────────────────────

  Widget _applyNowButton(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StudentJobApplyPage(
            jobTitle:    _str('jobTitle'),
            company:     _str('company'),
            profileData: _studentProfile,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Apply Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_outward_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    ),
  );

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final Color cardColor = (opening['companyColor'] as Color?) ?? blue;

    final bool   isSalary    = opening['openingType'] != 'Internship';
    final String salaryLabel =
    isSalary ? 'Salary Range (LPA)' : 'Stipend Range (₹/month)';

    final Set<String>  qualifications           = _set('selectedQualifications');
    final List<String> responsibilities         = _list('responsibilities');
    final List<String> techRequirements         = _list('techRequirements');
    final List<String> professionalRequirements = _list('professionalRequirements');
    final List<String> terms                    = _list('terms');

    final bool   isFresher      = opening['isFresher'] as bool? ?? true;
    final String experienceText = isFresher
        ? 'Fresher'
        : '${_str('expValue')} ${_str('expUnit')} experience required';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── HEADER ────────────────────────────────────────────────────
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
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: opening['companyInitial'] != null
                            ? Text(
                          opening['companyInitial'] as String,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: cardColor,
                          ),
                        )
                            : const Icon(Icons.work_rounded,
                            color: blue, size: 28),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _str('jobTitle'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _str('company'),
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

              // ── JOB DETAILS ───────────────────────────────────────────────
              _sectionTitle(context, 'JOB DETAILS'),
              _sectionCard(children: [
                _infoRow('Company',          _str('company')),
                _infoRow('Job Title',        _str('jobTitle')),
                _infoRow('No. of Vacancies', _str('vacancies')),
                _infoRow('Experience',       experienceText),
                _infoRow('Opening Type',     _str('openingType')),
                if (qualifications.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Required Qualification',
                          style: TextStyle(
                            fontSize: 12,
                            color: labelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                          qualifications.map((q) => _chipBadge(q)).toList(),
                        ),
                      ],
                    ),
                  ),
                ] else
                  _infoRow('Required Qualification', '—'),
              ]),

              // ── COMPENSATION ──────────────────────────────────────────────
              _sectionTitle(context, 'COMPENSATION'),
              _sectionCard(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    salaryLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      color: labelColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            _str('salaryMin'),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: textHead,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'to',
                        style: TextStyle(
                          color: textMuted,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            _str('salaryMax'),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: textHead,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),

              // ── LOCATION & SCOPE ──────────────────────────────────────────
              _sectionTitle(context, 'LOCATION & SCOPE'),
              _sectionCard(children: [
                _infoRow('Work Location',   _str('location')),
                _infoRow('Job Time',        _str('jobTime')),
                _infoRow('Time Constraint', _str('timeConstraint')),
              ]),

              // ── RESPONSIBILITIES ──────────────────────────────────────────
              _dynamicListCard(
                context,
                sectionTitle: 'RESPONSIBILITIES',
                items: responsibilities,
                emptyMessage: 'No responsibilities added.',
                emptyIcon: Icons.checklist_rounded,
              ),

              // ── TECHNICAL REQUIREMENTS ────────────────────────────────────
              _dynamicListCard(
                context,
                sectionTitle: 'TECHNICAL REQUIREMENTS',
                items: techRequirements,
                emptyMessage: 'No technical requirements added.',
                emptyIcon: Icons.code_rounded,
              ),

              // ── PROFESSIONAL REQUIREMENTS ─────────────────────────────────
              _dynamicListCard(
                context,
                sectionTitle: 'PROFESSIONAL REQUIREMENTS',
                items: professionalRequirements,
                emptyMessage: 'No professional requirements added.',
                emptyIcon: Icons.psychology_outlined,
              ),

              // ── TERMS & CONDITIONS ────────────────────────────────────────
              _dynamicListCard(
                context,
                sectionTitle: 'TERMS & CONDITIONS',
                items: terms,
                emptyMessage: 'No terms & conditions added.',
                emptyIcon: Icons.gavel_rounded,
              ),

              const SizedBox(height: 8),

              // ── APPLY NOW BUTTON ──────────────────────────────────────────
              _applyNowButton(context),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}