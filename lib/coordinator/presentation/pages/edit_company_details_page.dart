import 'package:flutter/material.dart';

class EditCompanyDetailsPage extends StatefulWidget {
  final Map<String, dynamic> company;

  const EditCompanyDetailsPage({super.key, required this.company});

  @override
  State<EditCompanyDetailsPage> createState() => _EditCompanyDetailsPageState();
}

class _EditCompanyDetailsPageState extends State<EditCompanyDetailsPage>
    with SingleTickerProviderStateMixin {

  // ── Palette ────────────────────────────────────────────────────────────────
  static const Color bgColor    = Color(0xFFF1F5F9);
  static const Color navy       = Color(0xFF1E3A8A);
  static const Color blue       = Color(0xFF2563EB);
  static const Color skyBlue    = Color(0xFF38BDF8);
  static const Color darkText   = Color(0xFF0F172A);
  static const Color subText    = Color(0xFF64748B);
  static const Color labelColor = Color(0xFF38BDF8);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [navy, blue, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  final List<String> _industryTypes = [
    'Product', 'Finance', 'Design', 'Tech', 'Startup',
    'Healthcare', 'Manufacturing', 'Consulting', 'E-Commerce', 'Other',
  ];

  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _strengthCtrl;
  late TextEditingController _openingsCtrl;
  late TextEditingController _locationCtrl;
  late String _selectedType;

  late List<Map<String, TextEditingController>> _workLocationControllers;
  int _selectedLocationIndex = 0;

  late List<Map<String, TextEditingController>> _openingControllers;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();

    _nameCtrl     = TextEditingController(text: widget.company['name']     as String? ?? '');
    _emailCtrl    = TextEditingController(text: widget.company['email']    as String? ?? '');
    _strengthCtrl = TextEditingController(text: widget.company['strength'] as String? ?? '');
    _openingsCtrl = TextEditingController(text: (widget.company['openings'] ?? '').toString());
    _locationCtrl = TextEditingController(text: widget.company['location'] as String? ?? '');
    _selectedType = widget.company['type'] as String? ?? _industryTypes.first;

    _workLocationControllers = [
      {
        'city':          TextEditingController(text: 'Pune, Maharashtra'),
        'address':       TextEditingController(text: 'Plot 47, Hinjewadi Phase 2, Pune - 411057'),
        'hrContact':     TextEditingController(text: 'Priya Sharma'),
        'contactNumber': TextEditingController(text: '+91 98765 43210'),
        'locationEmail': TextEditingController(text: 'pune.hr@nexoratech.com'),
      },
      {
        'city':          TextEditingController(text: 'Mumbai, Maharashtra'),
        'address':       TextEditingController(text: 'Level 12, BKC Tower, Bandra Kurla Complex, Mumbai - 400051'),
        'hrContact':     TextEditingController(text: 'Rahul Mehta'),
        'contactNumber': TextEditingController(text: '+91 98123 45678'),
        'locationEmail': TextEditingController(text: 'mumbai.hr@nexoratech.com'),
      },
    ];

    _openingControllers = [
      {
        'title':    TextEditingController(text: 'Software Engineer'),
        'type':     TextEditingController(text: 'Full Time'),
        'deadline': TextEditingController(text: '3d left'),
        'salary':   TextEditingController(text: '44 LPA'),
        'cgpa':     TextEditingController(text: '7.5+'),
      },
      {
        'title':    TextEditingController(text: 'Product Manager'),
        'type':     TextEditingController(text: 'Full Time'),
        'deadline': TextEditingController(text: '7d left'),
        'salary':   TextEditingController(text: '36 LPA'),
        'cgpa':     TextEditingController(text: '7.0+'),
      },
    ];
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _strengthCtrl.dispose();
    _openingsCtrl.dispose();
    _locationCtrl.dispose();
    for (final loc in _workLocationControllers) {
      loc.values.forEach((c) => c.dispose());
    }
    for (final op in _openingControllers) {
      op.values.forEach((c) => c.dispose());
    }
    super.dispose();
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    final updatedCompany = Map<String, dynamic>.from(widget.company);
    updatedCompany['name']     = _nameCtrl.text.trim();
    updatedCompany['email']    = _emailCtrl.text.trim();
    updatedCompany['strength'] = _strengthCtrl.text.trim();
    updatedCompany['openings'] = int.tryParse(_openingsCtrl.text.trim()) ?? 0;
    updatedCompany['location'] = _locationCtrl.text.trim();
    updatedCompany['type']     = _selectedType;
    updatedCompany['initial']  = _nameCtrl.text.trim().isNotEmpty
        ? _nameCtrl.text.trim()[0].toUpperCase()
        : widget.company['initial'];

    _showSuccessSnackbar();
    Navigator.pop(context, updatedCompany);
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: brandGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: blue.withOpacity(0.35),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'Company details updated successfully!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Discard changes?',
            style: TextStyle(fontWeight: FontWeight.w700, color: darkText)),
        content: const Text(
          'You have unsaved changes. Are you sure you want to go back?',
          style: TextStyle(color: subText, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep Editing',
                style: TextStyle(color: blue, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _sectionTitle('BASIC INFORMATION'),
                      _sectionCard(children: [
                        _field(
                          label: 'Company Name',
                          controller: _nameCtrl,
                          hint: 'e.g. Nexora Technologies',
                          validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        _dropdownField(),
                        _field(
                          label: 'Company Strength',
                          controller: _strengthCtrl,
                          hint: 'e.g. 350 employees',
                          validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        _field(
                          label: 'Official Email',
                          controller: _emailCtrl,
                          hint: 'e.g. hr@company.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        _field(
                          label: 'Primary Location',
                          controller: _locationCtrl,
                          hint: 'e.g. Pune, Maharashtra',
                          validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        _field(
                          label: 'Total Openings',
                          controller: _openingsCtrl,
                          hint: 'e.g. 5',
                          keyboardType: TextInputType.number,
                          isLast: true,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Required';
                            if (int.tryParse(v.trim()) == null)
                              return 'Enter a valid number';
                            return null;
                          },
                        ),
                      ]),
                      const SizedBox(height: 16),
                      _sectionTitle('WORK LOCATIONS'),
                      _locationTabBar(),
                      _locationCard(),
                      const SizedBox(height: 16),
                      _sectionTitle('ACTIVE OPENINGS'),
                      _openingsSection(),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _saveChanges,
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: brandGradient,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: blue.withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final Color cardColor = widget.company['color'] as Color;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(colors: [navy, blue, skyBlue]),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && mounted) Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
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
                widget.company['initial'] as String? ?? '?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: cardColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Edit Company',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(widget.company['name'] as String? ?? '',
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    String hint = '',
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isLast = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: labelColor, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            style: const TextStyle(fontSize: 14, color: darkText, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              filled: true,
              fillColor: bgColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: blue, width: 1.5)),
              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.red, width: 1.2)),
              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Industry Type', style: TextStyle(fontSize: 12, color: labelColor, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedType,
            isExpanded: true,
            style: const TextStyle(fontSize: 14, color: darkText, fontWeight: FontWeight.w500),
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: bgColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: blue, width: 1.5)),
            ),
            items: _industryTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
            onChanged: (val) => setState(() => _selectedType = val ?? _selectedType),
          ),
        ],
      ),
    );
  }

  Widget _locationTabBar() {
    if (_workLocationControllers.length <= 1) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_workLocationControllers.length, (i) {
            final selected = i == _selectedLocationIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedLocationIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  gradient: selected ? brandGradient : null,
                  color: selected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: selected ? blue.withOpacity(0.28) : Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: Text('Location ${i + 1}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: selected ? Colors.white : subText)),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _locationCard() {
    final loc = _workLocationControllers[_selectedLocationIndex];
    return _sectionCard(children: [
      _field(label: 'City', controller: loc['city']!, hint: 'e.g. Pune, Maharashtra', validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
      _field(label: 'Full Address', controller: loc['address']!, hint: 'Street, Area, City - Pincode', maxLines: 2, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
      _field(label: 'HR Contact Person', controller: loc['hrContact']!, hint: 'e.g. Priya Sharma', validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
      _field(label: 'Contact Number', controller: loc['contactNumber']!, hint: 'e.g. +91 98765 43210', keyboardType: TextInputType.phone, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
      _field(label: 'Location Email', controller: loc['locationEmail']!, hint: 'e.g. pune.hr@company.com', keyboardType: TextInputType.emailAddress, isLast: true, validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Required';
        if (!v.contains('@')) return 'Enter a valid email';
        return null;
      }),
    ]);
  }

  Widget _openingsSection() {
    return Column(
      children: List.generate(_openingControllers.length, (i) {
        final op = _openingControllers[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                decoration: BoxDecoration(color: bgColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(18))),
                child: Row(
                  children: [
                    Container(
                      width: 34, height: 34,
                      decoration: BoxDecoration(gradient: brandGradient, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.work_outline_rounded, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Text('Opening ${i + 1}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: darkText)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _field(label: 'Job Title', controller: op['title']!, hint: 'e.g. Software Engineer', validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                    _field(label: 'Employment Type', controller: op['type']!, hint: 'e.g. Full Time / Internship', validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                    _field(label: 'Application Deadline', controller: op['deadline']!, hint: 'e.g. 7d left', validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                    _field(label: 'CTC / Salary', controller: op['salary']!, hint: 'e.g. 44 LPA', validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                    _field(label: 'Min. CGPA Required', controller: op['cgpa']!, hint: 'e.g. 7.5+', isLast: true, validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _sectionCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: Column(children: children),
    );
  }
}