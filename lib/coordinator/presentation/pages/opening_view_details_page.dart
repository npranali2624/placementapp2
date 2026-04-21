import 'package:flutter/material.dart';

// TODO: Replace this with your full OpeningViewDetailsPage code when ready
class OpeningViewDetailsPage extends StatelessWidget {
  final Map<String, dynamic> opening;

  const OpeningViewDetailsPage({super.key, required this.opening});

  static const Color bgColor  = Color(0xFFF1F5F9);
  static const Color navyDark = Color(0xFF1E3A8A);
  static const Color blue     = Color(0xFF2563EB);
  static const Color skyBlue  = Color(0xFF38BDF8);
  static const Color darkText = Color(0xFF0F172A);
  static const Color subText  = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    final Color cardColor = opening['companyColor'] as Color;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
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
                        child: Text(
                          opening['companyInitial'] ?? '?',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: cardColor,
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
                            opening['jobTitle'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            opening['company'] ?? '',
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

              // ── DETAILS CARD ─────────────────────────────────────────────────
              _detailCard('Job Details', [
                _row('Opening Type', opening['openingType'] ?? ''),
                _row('Job Time',     opening['jobTime']     ?? ''),
                _row('Location',     opening['location']    ?? ''),
                _row('Experience',   opening['experience']  ?? ''),
                _row('Qualification',opening['qualification']?? ''),
                _row('Vacancies',    '${opening['vacancies'] ?? ''}'),
                _row(
                  opening['isSalary'] == true ? 'Salary (LPA)' : 'Stipend (₹/mo)',
                  '${opening['salaryMin']}–${opening['salaryMax']}',
                ),
                _row('Time Constraint', opening['timeConstraint'] ?? ''),
              ]),

              const SizedBox(height: 16),

              _detailCard('Description', [
                _paragraph(opening['description'] ?? ''),
              ]),

              const SizedBox(height: 16),

              _detailCard('Responsibilities', [
                _paragraph(opening['responsibilities'] ?? ''),
              ]),

              const SizedBox(height: 16),

              _detailCard('Technical Requirements', [
                _paragraph(opening['techReq'] ?? ''),
              ]),

              const SizedBox(height: 16),

              _detailCard('Professional Requirements', [
                _paragraph(opening['professionalReq'] ?? ''),
              ]),

              const SizedBox(height: 16),

              _detailCard('Terms & Conditions', [
                _paragraph(opening['terms'] ?? ''),
              ]),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: darkText,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF38BDF8),
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
  }

  Widget _paragraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: subText,
        height: 1.5,
      ),
    );
  }
}