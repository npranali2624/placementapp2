import 'package:flutter/material.dart';

class CompanyViewDetailsPage extends StatefulWidget {
  final Map<String, dynamic> company;

  const CompanyViewDetailsPage({super.key, required this.company});

  @override
  State<CompanyViewDetailsPage> createState() => _CompanyViewDetailsPageState();
}

class _CompanyViewDetailsPageState extends State<CompanyViewDetailsPage>
    with SingleTickerProviderStateMixin {

  static const Color bgColor   = Color(0xFFF1F5F9);
  static const Color navy      = Color(0xFF1E3A8A);
  static const Color blue      = Color(0xFF2563EB);
  static const Color skyBlue   = Color(0xFF38BDF8);
  static const Color darkText  = Color(0xFF0F172A);
  static const Color subText   = Color(0xFF64748B);
  static const Color labelColor = Color(0xFF38BDF8);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [navy, blue, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  int _selectedLocationIndex = 0;

  final List<Map<String, String>> _workLocations = [
    {
      'city': 'Pune, Maharashtra',
      'address': 'Plot 47, Hinjewadi Phase 2, Pune - 411057',
      'hrContact': 'Priya Sharma',
      'contactNumber': '+91 98765 43210',
      'locationEmail': 'pune.hr@nexoratech.com',
    },
    {
      'city': 'Mumbai, Maharashtra',
      'address': 'Level 12, BKC Tower, Bandra Kurla Complex, Mumbai - 400051',
      'hrContact': 'Rahul Mehta',
      'contactNumber': '+91 98123 45678',
      'locationEmail': 'mumbai.hr@nexoratech.com',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color cardColor = widget.company['color'] as Color;
    final Color cardBg    = widget.company['bgColor'] as Color;

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
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [navy, blue, skyBlue],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      children: [

                        Row(
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
                            const Spacer(),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  widget.company['initial'] as String,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: cardColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.company['name'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${widget.company['type']} Company",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.circle,
                                            color: Color(0xFF4ADE80), size: 8),
                                        SizedBox(width: 5),
                                        Text(
                                          'Active',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            _headerStat(
                                Icons.people_outline_rounded,
                                widget.company['strength'] as String,
                                'Strength'),
                            const SizedBox(width: 10),
                            _headerStat(
                                Icons.work_outline_rounded,
                                "${widget.company['openings']} Open",
                                'Openings'),
                            const SizedBox(width: 10),
                            _headerStat(
                                Icons.location_on_outlined,
                                '${_workLocations.length}',
                                'Locations'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  _sectionTitle("BASIC INFORMATION"),
                  _sectionCard(children: [
                    _infoRow(Icons.business_rounded, 'Company Name',
                        widget.company['name'] as String),
                    _divider(),
                    _infoRow(Icons.category_outlined, 'Industry Type',
                        widget.company['type'] as String),
                    _divider(),
                    _infoRow(Icons.people_outline_rounded, 'Company Strength',
                        widget.company['strength'] as String),
                    _divider(),
                    _infoRow(Icons.mail_outline_rounded, 'Official Email',
                        widget.company['email'] as String),
                  ]),

                  const SizedBox(height: 16),

                  _sectionTitle("WORK LOCATIONS"),

                  // Location tab selector
                  if (_workLocations.length > 1) ...[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_workLocations.length, (i) {
                          final selected = i == _selectedLocationIndex;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedLocationIndex = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 10, bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: selected ? brandGradient : null,
                                color: selected ? null : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: selected
                                        ? blue.withOpacity(0.30)
                                        : Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Location ${i + 1}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color:
                                  selected ? Colors.white : subText,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],

                  // Location detail card
                  _sectionCard(children: [
                    _infoRow(Icons.location_city_rounded, 'City',
                        _workLocations[_selectedLocationIndex]['city']!),
                    _divider(),
                    _infoRow(Icons.map_outlined, 'Full Address',
                        _workLocations[_selectedLocationIndex]['address']!),
                    _divider(),
                    _infoRow(Icons.person_outline_rounded, 'HR Contact Person',
                        _workLocations[_selectedLocationIndex]['hrContact']!),
                    _divider(),
                    _infoRow(Icons.phone_outlined, 'Contact Number',
                        _workLocations[_selectedLocationIndex]['contactNumber']!),
                    _divider(),
                    _infoRow(Icons.alternate_email_rounded, 'Location Email',
                        _workLocations[_selectedLocationIndex]['locationEmail']!),
                  ]),

                  const SizedBox(height: 16),

                  _sectionTitle("ACTIVE OPENINGS"),
                  _openingsCard(cardColor, cardBg),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerStat(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              gradient: brandGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: darkText,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: blue, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: labelColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: darkText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, color: Color(0xFFF1F5F9));
  }

  Widget _openingsCard(Color cardColor, Color cardBg) {
    final List<Map<String, String>> openings = [
      {
        'title': 'Software Engineer',
        'type': 'Full Time',
        'deadline': '3d left',
        'salary': '44 LPA',
        'cgpa': '7.5+',
      },
      {
        'title': 'Product Manager',
        'type': 'Full Time',
        'deadline': '7d left',
        'salary': '36 LPA',
        'cgpa': '7.0+',
      },
    ];

    return Column(
      children: openings.map((job) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(Icons.work_outline_rounded,
                    color: cardColor, size: 22),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            job['title']!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.access_time_rounded,
                                  size: 12, color: blue),
                              const SizedBox(width: 4),
                              Text(
                                job['deadline']!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      job['type']!,
                      style: const TextStyle(
                          fontSize: 12, color: subText),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        _jobChip('₹ ${job['salary']}', bgColor),
                        const SizedBox(width: 8),
                        _jobChip('CGPA ${job['cgpa']}', bgColor),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _jobChip(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: subText,
        ),
      ),
    );
  }
}