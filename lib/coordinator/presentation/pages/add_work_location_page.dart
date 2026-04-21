import 'package:flutter/material.dart';

class AddWorkLocationPage extends StatefulWidget {
  final String companyName;
  const AddWorkLocationPage({
    super.key,
    this.companyName = 'Nexora Technologies',
  });

  @override
  State<AddWorkLocationPage> createState() => _AddWorkLocationPageState();
}

class _AddWorkLocationPageState extends State<AddWorkLocationPage> {

  static const Color bgColor = Color(0xFFF1F5F9);

  final List<Map<String, TextEditingController>> _locations = [];

  String selectedCompany = 'Nexora Technologies';
  final List<String> companies = [
    'Nexora Technologies',
    'ABC Corp',
    'DEE Technologies',
  ];

  @override
  void initState() {
    super.initState();
    _addLocation();
  }

  void _addLocation() {
    setState(() {
      _locations.add({
        'address': TextEditingController(),
        'contactpersonname': TextEditingController(),
        'contactNumber': TextEditingController(),
        'mail': TextEditingController(),
      });
    });
  }

  void _removeLocation(int index) {
    if (_locations.length == 1) return;
    setState(() {
      _locations.removeAt(index);
    });
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

              /// 🔷 HEADER (NEW UI)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1E3A8A),
                      Color(0xFF2563EB),
                      Color(0xFF38BDF8),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 12),

                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.location_on,
                          color: Color(0xFF2563EB)),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCompany,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Add multiple work locations",
                            style: TextStyle(color: Colors.white70),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔷 COMPANY DROPDOWN
              _sectionTitle("COMPANY"),
              _card(
                child: _dropdown(
                  selectedCompany,
                  companies,
                      (val) => setState(() => selectedCompany = val!),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔷 LOCATION CARDS
              ..._locations.asMap().entries.map((entry) {
                return _locationCard(entry.key, entry.value);
              }),

              const SizedBox(height: 12),

              /// 🔷 ADD LOCATION BUTTON
              GestureDetector(
                onTap: _addLocation,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xFF2563EB)),
                  ),
                  child: const Center(
                    child: Text(
                      "Add Another Location",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔷 SAVE BUTTON
              GestureDetector(
                onTap: _onSave,
                child: Container(
                  height: 55,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1E3A8A),
                        Color(0xFF2563EB),
                        Color(0xFF38BDF8),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Center(
                    child: Text(
                      "SAVE LOCATIONS",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔷 LOCATION CARD
  Widget _locationCard(
      int index, Map<String, TextEditingController> loc) {
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
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Location ${index + 1}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _removeLocation(index),
                icon: const Icon(Icons.delete, color: Colors.red),
              )
            ],
          ),

          _field("Address", loc['address']!),
          _field("Contact Person", loc['contactpersonname']!),
          _field("Phone", loc['contactNumber']!),
          _field("Email", loc['mail']!),
        ],
      ),
    );
  }

  /// 🔷 FIELD (LOGIN STYLE)
  Widget _field(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF38BDF8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF1F5F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFF2563EB),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔷 DROPDOWN (LOGIN STYLE)
  Widget _dropdown(String value, List<String> items,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF2563EB),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Locations Saved")),
    );
  }
}