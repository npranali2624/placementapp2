import 'package:flutter/material.dart';

class ApplicantDetailsPage extends StatefulWidget {
  final Map<String, dynamic> applicant;
  final Color companyColor;
  final int applicantIndex;

  const ApplicantDetailsPage({
    super.key,
    required this.applicant,
    required this.companyColor,
    required this.applicantIndex,
  });

  @override
  State<ApplicantDetailsPage> createState() => _ApplicantDetailsPageState();
}

class _ApplicantDetailsPageState extends State<ApplicantDetailsPage>
    with SingleTickerProviderStateMixin {

  static const Color bgColor   = Color(0xFFF1F5F9);
  static const Color navyDark  = Color(0xFF1E3A8A);
  static const Color blue      = Color(0xFF2563EB);
  static const Color skyBlue   = Color(0xFF38BDF8);
  static const Color darkText  = Color(0xFF0F172A);
  static const Color subText   = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [navyDark, blue, skyBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const List<Color> _solidColors = [
    Color(0xFF2563EB), Color(0xFF7C3AED), Color(0xFFDC2626),
    Color(0xFF059669), Color(0xFFD97706), Color(0xFF0891B2),
    Color(0xFF9333EA), Color(0xFF16A34A), Color(0xFFEA580C),
    Color(0xFF0F172A),
  ];

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  String _str(String key) {
    final v = widget.applicant[key];
    if (v == null) return '';
    return v.toString().trim();
  }

  bool _has(String key)           => _str(key).isNotEmpty;
  bool _hasAny(List<String> keys) => keys.any(_has);

  Color _statusColor(String s) {
    switch (s) {
      case 'Shortlisted':  return const Color(0xFF059669);
      case 'Under Review': return const Color(0xFFD97706);
      case 'Applied':      return const Color(0xFF2563EB);
      case 'Rejected':     return const Color(0xFFDC2626);
      default:             return subText;
    }
  }

  Color _statusBg(String s) {
    switch (s) {
      case 'Shortlisted':  return const Color(0xFFECFDF5);
      case 'Under Review': return const Color(0xFFFFFBEB);
      case 'Applied':      return const Color(0xFFEFF6FF);
      case 'Rejected':     return const Color(0xFFFEF2F2);
      default:             return const Color(0xFFF1F5F9);
    }
  }

  IconData _statusIcon(String s) {
    switch (s) {
      case 'Shortlisted':  return Icons.check_circle_rounded;
      case 'Under Review': return Icons.hourglass_top_rounded;
      case 'Applied':      return Icons.send_rounded;
      case 'Rejected':     return Icons.cancel_rounded;
      default:             return Icons.circle_outlined;
    }
  }

  String _statusDescription(String s) {
    switch (s) {
      case 'Shortlisted':  return 'Candidate has been shortlisted for the next round';
      case 'Under Review': return 'Application is currently being reviewed by HR';
      case 'Applied':      return 'Application received and under consideration';
      case 'Rejected':     return 'Application was not selected this time';
      default:             return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final a      = widget.applicant;
    final status = _has('status') ? _str('status') : 'Applied';

    final Color avatarColor =
    _solidColors[widget.applicantIndex % _solidColors.length];

    final bool interviewAttended = a['interviewAttended'] as bool? ?? false;
    final bool isFinalised = status == 'Shortlisted' || status == 'Rejected';
    final bool chipBlue    = isFinalised;
    final bool chipGreen   = !isFinalised && interviewAttended;

    final bool isAvailable = a['isAvailable'] as bool? ?? true;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: brandGradient,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(children: [
                      Row(children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 62, height: 62,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              _has('avatar') ? _str('avatar') : '?',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: blue),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_str('name'),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text(_str('branch'),
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 13)),
                              ]),
                        ),
                      ]),

                      const SizedBox(height: 14),

                      Row(children: [
                        _headerStatusPill(status),
                        if (_has('year')) ...[
                          const SizedBox(width: 8),
                          _headerPill(Icons.school_rounded, _str('year')),
                        ],
                        if (_has('cgpa')) ...[
                          const SizedBox(width: 8),
                          _headerPill(Icons.grade_rounded, 'CGPA ${_str('cgpa')}'),
                        ],
                      ]),
                    ]),
                  ),

                  const SizedBox(height: 20),

                  _sectionLabel('APPLICATION STATUS'),
                  _card(
                    child: Row(children: [
                      Container(
                        width: 46, height: 46,
                        decoration: BoxDecoration(
                          color: _statusBg(status),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(_statusIcon(status),
                            color: _statusColor(status), size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(status,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: _statusColor(status))),
                              const SizedBox(height: 3),
                              Text(_statusDescription(status),
                                  style: const TextStyle(
                                      fontSize: 12, color: subText)),
                            ]),
                      ),
                    ]),
                  ),

                  const SizedBox(height: 16),

                  _sectionLabel('PERSONAL DETAILS'),
                  _card(
                    child: Column(children: [
                      _detailRow(Icons.person_rounded,  'Full Name',    _str('name')),
                      _divider(),
                      _detailRow(Icons.email_rounded,   'Email',        _str('email')),
                      _divider(),
                      _detailRow(Icons.phone_rounded,   'Phone Number', _str('phone')),
                    ]),
                  ),

                  const SizedBox(height: 16),

                  _sectionLabel('ACADEMIC DETAILS'),
                  _card(
                    child: Column(children: [
                      _detailRow(Icons.school_rounded,
                          'Branch',            _str('branch')),
                      _divider(),
                      _detailRow(Icons.menu_book_rounded,
                          'Course / Degree',   _str('course')),
                      _divider(),
                      _detailRow(Icons.calendar_today_rounded,
                          'Year',              _str('year')),
                      _divider(),
                      _detailRow(Icons.grade_rounded,
                          'CGPA / Percentage', _str('cgpa')),
                      if (_has('specialization')) ...[
                        _divider(),
                        _detailRow(Icons.book_rounded,
                            'Specialization',  _str('specialization')),
                      ],
                    ]),
                  ),

                  const SizedBox(height: 16),

                  if (_hasAny(['skills', 'tools'])) ...[
                    _sectionLabel('SKILLS & TOOLS'),
                    _card(
                      child: Column(children: [
                        if (_has('skills'))
                          _detailRow(Icons.code_rounded,
                              'Technical Skills',      _str('skills')),
                        if (_has('skills') && _has('tools')) _divider(),
                        if (_has('tools'))
                          _detailRow(Icons.build_rounded,
                              'Tools / Technologies',  _str('tools')),
                      ]),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_hasAny(['github', 'linkedin'])) ...[
                    _sectionLabel('PROFILES'),
                    _card(
                      child: Column(children: [
                        if (_has('github'))
                          _detailRow(Icons.code_rounded,
                              'GitHub',   _str('github'), isLink: true),
                        if (_has('github') && _has('linkedin')) _divider(),
                        if (_has('linkedin'))
                          _detailRow(Icons.link_rounded,
                              'LinkedIn', _str('linkedin'), isLink: true),
                      ]),
                    ),
                    const SizedBox(height: 16),
                  ],


                  if (_has('experience')) ...[
                    _sectionLabel('EXPERIENCE'),
                    _card(
                      child: _detailRow(
                          Icons.work_history_rounded,
                          'Experience Details',
                          _str('experience'),
                          multiLine: true),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_has('projects')) ...[
                    _sectionLabel('PROJECTS'),
                    _card(
                      child: _detailRow(
                          Icons.build_circle_rounded,
                          'Project Details',
                          _str('projects'),
                          multiLine: true),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_has('certificates')) ...[
                    _sectionLabel('CERTIFICATES / ACHIEVEMENTS'),
                    _card(
                      child: _detailRow(
                          Icons.emoji_events_rounded,
                          'Certificates & Achievements',
                          _str('certificates'),
                          multiLine: true),
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_has('coverLetter')) ...[
                    _sectionLabel('COVER LETTER'),
                    _card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: brandGradient,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.description_rounded,
                                    color: Colors.white, size: 16),
                              ),
                              const SizedBox(width: 10),
                              const Text('Cover Letter',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: darkText)),
                            ]),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _str('coverLetter'),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: subText,
                                    height: 1.6),
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 16),
                  ],

                  _sectionLabel('AVAILABILITY'),
                  _card(
                    child: Row(children: [
                      Container(
                        width: 46, height: 46,
                        decoration: BoxDecoration(
                          color: isAvailable
                              ? const Color(0xFFECFDF5)
                              : const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(
                          isAvailable
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          color: isAvailable
                              ? const Color(0xFF059669)
                              : const Color(0xFFDC2626),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Available to Join Immediately',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: darkText)),
                            const SizedBox(height: 3),
                            Text(
                              isAvailable
                                  ? 'Yes, can join right away'
                                  : 'No, needs some time',
                              style: TextStyle(
                                fontSize: 12,
                                color: isAvailable
                                    ? const Color(0xFF059669)
                                    : const Color(0xFFDC2626),
                              ),
                            ),
                          ]),
                    ]),
                  ),

                  const SizedBox(height: 16),

                  _sectionLabel('TELEPHONIC INTERVIEW'),
                  _card(
                    child: Row(children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 46, height: 46,
                        decoration: BoxDecoration(
                          gradient: chipBlue
                              ? const LinearGradient(
                            colors: [Color(0xFF22D3EE), Color(0xFF06B6D4)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : chipGreen
                              ? const LinearGradient(
                            colors: [Color(0xFF059669), Color(0xFF34D399)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : const LinearGradient(
                            colors: [Color(0xFFE2E8F0), Color(0xFFF1F5F9)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(Icons.phone_in_talk_rounded,
                            size: 20,
                            color: (chipBlue || chipGreen)
                                ? Colors.white
                                : textMuted),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Telephonic Interview',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: darkText)),
                              const SizedBox(height: 3),
                              Text(
                                chipBlue
                                    ? 'Interview done — moved to next stage'
                                    : chipGreen
                                    ? 'Attended — HR call completed'
                                    : 'Pending — HR call not done yet',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: chipBlue
                                      ? const Color(0xFF06B6D4)
                                      : chipGreen
                                      ? const Color(0xFF059669)
                                      : textMuted,
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: 10, height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: chipBlue
                              ? const Color(0xFF06B6D4)
                              : chipGreen
                              ? const Color(0xFF059669)
                              : const Color(0xFFCBD5E1),
                        ),
                      ),
                    ]),
                  ),

                  if (_has('resumeUrl')) ...[
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // TODO: open/download resume
                      },
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: brandGradient,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: blue.withValues(alpha: 0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.download_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text('View / Download Resume',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(children: [
      Container(
        width: 4, height: 16,
        decoration: BoxDecoration(
          gradient: brandGradient,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      const SizedBox(width: 8),
      Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: subText)),
    ]),
  );

  Widget _card({required Widget child}) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: child,
  );

  Widget _detailRow(IconData icon, String label, String value,
      {bool multiLine = false, bool isLink = false}) {
    final String display = value.isNotEmpty ? value : '—';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
          crossAxisAlignment:
          multiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 16, color: blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            fontSize: 11,
                            color: textMuted,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 3),
                    Text(display,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isLink ? blue : darkText,
                            height: 1.4,
                            decoration: isLink
                                ? TextDecoration.underline
                                : TextDecoration.none)),
                  ]),
            ),
          ]),
    );
  }

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Divider(height: 1, color: Color(0xFFF1F5F9)),
  );

  Widget _headerStatusPill(String status) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(_statusIcon(status), size: 12, color: Colors.white),
      const SizedBox(width: 5),
      Text(status,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white)),
    ]),
  );

  Widget _headerPill(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: Colors.white),
      const SizedBox(width: 5),
      Text(text,
          style: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.w600)),
    ]),
  );
}