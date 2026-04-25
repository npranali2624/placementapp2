import 'package:flutter/material.dart';

class RegisterCompanyPage extends StatefulWidget {
  const RegisterCompanyPage({super.key});

  @override
  State<RegisterCompanyPage> createState() => _RegisterCompanyPageState();
}

class _RegisterCompanyPageState extends State<RegisterCompanyPage> {
  // ── Palette ────────────────────────────────────────────────────────────────
  static const Color bgColor    = Color(0xFFF1F5F9);
  static const Color navyDark   = Color(0xFF1E3A8A);
  static const Color blue       = Color(0xFF2563EB);
  static const Color skyBlue    = Color(0xFF38BDF8);
  static const Color labelColor = Color(0xFF38BDF8);

  // Controllers – Basic Info
  final _companyNameCtrl  = TextEditingController(text: "Nexora Technologies Pvt. Ltd.");
  final _strengthCtrl     = TextEditingController(text: "350 employees");
  final _companyEmailCtrl = TextEditingController(text: "hr@nexoratech.com");

  // Multiple work locations
  final List<Map<String, TextEditingController>> _locations = [];

  @override
  void initState() {
    super.initState();
    _addLocation(); // start with one location
  }

  void _addLocation() {
    setState(() {
      _locations.add({
        'address':       TextEditingController(),
        'hrContact':     TextEditingController(),
        'contactNumber': TextEditingController(),
        'email':         TextEditingController(),
      });
    });
  }

  void _removeLocation(int index) {
    if (_locations.length == 1) return; // keep at least one
    setState(() {
      for (final ctrl in _locations[index].values) ctrl.dispose();
      _locations.removeAt(index);
    });
  }

  @override
  void dispose() {
    _companyNameCtrl.dispose();
    _strengthCtrl.dispose();
    _companyEmailCtrl.dispose();
    for (final loc in _locations) {
      for (final ctrl in loc.values) ctrl.dispose();
    }
    super.dispose();
  }

  // ── Labeled Field ──────────────────────────────────────────────────────────
  Widget _field({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: labelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: bgColor,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: blue, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Section Title ──────────────────────────────────────────────────────────
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }

  // ── Section Card ───────────────────────────────────────────────────────────
  Widget _sectionCard({required List<Widget> children}) {
    return Container(
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
        children: children,
      ),
    );
  }

  // ── Location Card ──────────────────────────────────────────────────────────
  Widget _locationCard(int index, Map<String, TextEditingController> loc) {
    final isFirst = index == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          // Card header row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [navyDark, blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isFirst ? "Primary Location" : "Location ${index + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              if (!isFirst)
                GestureDetector(
                  onTap: () => _removeLocation(index),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade400,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),

          _field(
            label: "Address",
            controller: loc['address']!,
          ),
          _field(
            label: "Contact Person",
            controller: loc['hrContact']!,
          ),
          _field(
            label: "Contact Number",
            controller: loc['contactNumber']!,
            keyboardType: TextInputType.phone,
          ),
          _field(
            label: "Location Email",
            controller: loc['email']!,
            keyboardType: TextInputType.emailAddress,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // ── HEADER ───────────────────────────────────────────────────
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
                      child: const Center(
                        child: Icon(
                          Icons.business_rounded,
                          color: blue,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register Company",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Fill in the company details",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── BASIC INFORMATION ────────────────────────────────────────
              _sectionTitle("BASIC INFORMATION"),
              _sectionCard(children: [
                _field(
                  label: "Company Name",
                  controller: _companyNameCtrl,
                ),
                _field(
                  label: "Company Strength",
                  controller: _strengthCtrl,
                ),
                _field(
                  label: "Official Company Email",
                  controller: _companyEmailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
              ]),

              const SizedBox(height: 20),

              // ── WORK LOCATIONS ───────────────────────────────────────────
              _sectionTitle("WORK LOCATIONS"),

              ..._locations.asMap().entries.map(
                    (entry) => _locationCard(entry.key, entry.value),
              ),

              // ── ADD ANOTHER LOCATION BUTTON ──────────────────────────────
              GestureDetector(
                onTap: _addLocation,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: blue, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: blue.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_location_alt_rounded,
                          color: blue, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Add Another Location",
                        style: TextStyle(
                          color: blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── REGISTER BUTTON ──────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  // TODO: handle registration
                },
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
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}