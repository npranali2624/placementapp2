import 'package:flutter/material.dart';
import 'applicant_details_page.dart';

class OpeningApplicantsPage extends StatefulWidget {
  final Map<String, dynamic> opening;

  const OpeningApplicantsPage({super.key, required this.opening});

  @override
  State<OpeningApplicantsPage> createState() => _OpeningApplicantsPageState();
}

class _OpeningApplicantsPageState extends State<OpeningApplicantsPage>
    with SingleTickerProviderStateMixin {

  // ── Palette ────────────────────────────────────────────────────────────────
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

  String _activeFilter = 'All';
  final List<String> _statusFilters = [
    'All', 'Applied', 'Under Review', 'Shortlisted', 'Rejected'
  ];

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _applicants {
    final raw = widget.opening['applicants'] as List? ?? [];
    return raw.cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> get _filtered {
    if (_activeFilter == 'All') return _applicants;
    return _applicants.where((a) => a['status'] == _activeFilter).toList();
  }

  void _toggleInterviewAttended(Map<String, dynamic> applicant) {
    setState(() {
      applicant['interviewAttended'] =
      !(applicant['interviewAttended'] as bool? ?? false);
    });
  }

  // ✅ Now accepts index and passes it to ApplicantDetailsPage
  void _openApplicantDetails(Map<String, dynamic> a, Color companyColor, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ApplicantDetailsPage(
              applicant: a,
              companyColor: companyColor,
              applicantIndex: index, // ✅ fixes the "required parameter" error
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  // ── Status Styling ─────────────────────────────────────────────────────────
  Color _statusColor(String status) {
    switch (status) {
      case 'Shortlisted':  return const Color(0xFF059669);
      case 'Under Review': return const Color(0xFFD97706);
      case 'Applied':      return const Color(0xFF2563EB);
      case 'Rejected':     return const Color(0xFFDC2626);
      default:             return subText;
    }
  }

  Color _statusBg(String status) {
    switch (status) {
      case 'Shortlisted':  return const Color(0xFFECFDF5);
      case 'Under Review': return const Color(0xFFFFFBEB);
      case 'Applied':      return const Color(0xFFEFF6FF);
      case 'Rejected':     return const Color(0xFFFEF2F2);
      default:             return const Color(0xFFF1F5F9);
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Shortlisted':  return Icons.check_circle_rounded;
      case 'Under Review': return Icons.hourglass_top_rounded;
      case 'Applied':      return Icons.send_rounded;
      case 'Rejected':     return Icons.cancel_rounded;
      default:             return Icons.circle_outlined;
    }
  }

  int _countOf(String status) =>
      _applicants.where((a) => a['status'] == status).length;

  @override
  Widget build(BuildContext context) {
    final Color cardColor = (widget.opening['companyColor'] as Color?) ?? blue;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(children: [

            // ── HEADER ────────────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.all(16),
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
                    width: 52, height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        widget.opening['companyInitial'] ?? '?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: cardColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.opening['jobTitle'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 3),
                          Text(widget.opening['company'] ?? '',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ]),
                  ),
                ]),

                const SizedBox(height: 16),

                Row(children: [
                  _headerChip('Applied',     _countOf('Applied'),      const Color(0xFF60A5FA)),
                  const SizedBox(width: 8),
                  _headerChip('Review',      _countOf('Under Review'), const Color(0xFFFBBF24)),
                  const SizedBox(width: 8),
                  _headerChip('Shortlisted', _countOf('Shortlisted'),  const Color(0xFF34D399)),
                  const SizedBox(width: 8),
                  _headerChip('Rejected',    _countOf('Rejected'),     const Color(0xFFF87171)),
                ]),
              ]),
            ),

            // ── FILTER TABS ───────────────────────────────────────────────
            SizedBox(
              height: 38,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _statusFilters.length,
                // ✅ Fixed: single underscore for unused params
                separatorBuilder: (_, i) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final f = _statusFilters[i];
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
                                ? blue.withValues(alpha: 0.25)
                                : Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(f,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isActive ? Colors.white : subText)),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
              child: Row(children: [
                Text(
                  '${_filtered.length} candidate${_filtered.length == 1 ? '' : 's'}',
                  style: const TextStyle(fontSize: 12, color: textMuted),
                ),
              ]),
            ),

            // ── APPLICANT LIST ────────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_search_rounded,
                          size: 54, color: Colors.grey[300]),
                      const SizedBox(height: 12),
                      Text(
                        'No candidates with "$_activeFilter" status',
                        style: const TextStyle(
                            color: subText, fontSize: 14),
                      ),
                    ]),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                itemCount: _filtered.length,
                // ✅ Fixed: named param so index is clearly passed through
                itemBuilder: (context, index) =>
                    _applicantCard(_filtered[index], cardColor, index),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // ── Header chip ────────────────────────────────────────────────────────────
  Widget _headerChip(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          Text('$count',
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 18)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }

  static const List<Color> _solidColors = [
    Color(0xFF2563EB), Color(0xFF7C3AED), Color(0xFFDC2626),
    Color(0xFF059669), Color(0xFFD97706), Color(0xFF0891B2),
    Color(0xFF9333EA), Color(0xFF16A34A), Color(0xFFEA580C),
    Color(0xFF0F172A),
  ];

  // ── Applicant Card ─────────────────────────────────────────────────────────
  Widget _applicantCard(Map<String, dynamic> a, Color companyColor, int index) {
    final status             = a['status'] as String;
    final bool interviewAttended = a['interviewAttended'] as bool? ?? false;
    final Color avatarColor  = _solidColors[index % _solidColors.length];
    final bool isFinalised   = status == 'Shortlisted' || status == 'Rejected';
    final bool chipBlue      = isFinalised;
    final bool chipGreen     = !isFinalised && interviewAttended;
    final bool chipPending   = !isFinalised && !interviewAttended;

    return GestureDetector(
      onTap: () => _openApplicantDetails(a, companyColor, index), // ✅ pass index
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: avatarColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(a['avatar'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                            child: Text(a['name'],
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: darkText)),
                          ),
                          const Icon(Icons.chevron_right_rounded,
                              size: 18, color: textMuted),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _statusBg(status),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(_statusIcon(status),
                                      size: 11,
                                      color: _statusColor(status)),
                                  const SizedBox(width: 4),
                                  Text(status,
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: _statusColor(status))),
                                ]),
                          ),
                        ]),
                        const SizedBox(height: 4),
                        Text(a['branch'],
                            style: const TextStyle(
                                fontSize: 12, color: subText)),
                        const SizedBox(height: 8),
                        Row(children: [
                          _infoChip(Icons.school_rounded, a['year']),
                          const SizedBox(width: 8),
                          _infoChip(Icons.grade_rounded, 'CGPA: ${a['cgpa']}'),
                        ]),
                      ]),
                ),
              ]),

              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 10),

              Row(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 32, height: 32,
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
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    Icons.phone_in_talk_rounded,
                    size: 15,
                    color: (chipBlue || chipGreen)
                        ? Colors.white
                        : const Color(0xFF94A3B8),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Telephonic Interview',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: darkText)),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            chipBlue
                                ? 'Interview done — moved to next stage'
                                : chipGreen
                                ? 'Attended — HR call completed'
                                : 'Pending — HR call not done yet',
                            key: ValueKey('$chipBlue-$chipGreen'),
                            style: TextStyle(
                              fontSize: 10,
                              color: chipBlue
                                  ? const Color(0xFF06B6D4)
                                  : chipGreen
                                  ? const Color(0xFF059669)
                                  : textMuted,
                            ),
                          ),
                        ),
                      ]),
                ),

                GestureDetector(
                  onTap: isFinalised ? null : () => _toggleInterviewAttended(a),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: chipBlue
                          ? const LinearGradient(
                        colors: [Color(0xFF22D3EE), Color(0xFF06B6D4)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                          : chipGreen
                          ? const LinearGradient(
                        colors: [Color(0xFF059669), Color(0xFF34D399)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                          : null,
                      color: chipPending ? const Color(0xFFF1F5F9) : null,
                      borderRadius: BorderRadius.circular(10),
                      border: chipPending
                          ? Border.all(color: const Color(0xFFCBD5E1), width: 1)
                          : null,
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(
                        chipBlue || chipGreen
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 13,
                        color: (chipBlue || chipGreen)
                            ? Colors.white
                            : const Color(0xFF94A3B8),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        chipBlue
                            ? 'Done'
                            : chipGreen
                            ? 'Attended'
                            : 'Mark',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: (chipBlue || chipGreen)
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: subText),
      const SizedBox(width: 4),
      Text(text,
          style: const TextStyle(
              fontSize: 11,
              color: subText,
              fontWeight: FontWeight.w500)),
    ]),
  );
}