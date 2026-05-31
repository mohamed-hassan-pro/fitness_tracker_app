import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/activity.dart';
import '../blocs/activity_cubit.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({Key? key}) : super(key: key);

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _caloriesController = TextEditingController();
  String _selectedType = 'Running';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text('Add Activity', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField(_titleController, 'Activity Title', Icons.title),
              const SizedBox(height: 16),
              _buildDropdown(),
              const SizedBox(height: 16),
              _buildTextField(_durationController, 'Duration (minutes)', Icons.timer, isNumber: true),
              const SizedBox(height: 16),
              _buildTextField(_caloriesController, 'Calories Burned', Icons.local_fire_department, isNumber: true),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _submitActivity,
                  child: const Text('Save Activity', style: TextStyle(color: Color(0xFF1E1E2C), fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.cyanAccent),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.3)), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.cyanAccent), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedType,
      dropdownColor: const Color(0xFF2C2C3E),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Activity Type',
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.category, color: Colors.cyanAccent),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.3)), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.cyanAccent), borderRadius: BorderRadius.circular(12)),
      ),
      items: ['Running', 'Cycling', 'Weightlifting', 'Swimming', 'Yoga']
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      onChanged: (val) {
        if (val != null) setState(() => _selectedType = val);
      },
    );
  }

  void _submitActivity() {
    if (_titleController.text.isEmpty || _durationController.text.isEmpty || _caloriesController.text.isEmpty) return;

    final activity = Activity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      type: _selectedType,
      durationMinutes: int.tryParse(_durationController.text) ?? 0,
      caloriesBurned: double.tryParse(_caloriesController.text) ?? 0.0,
      date: DateTime.now(),
    );

    context.read<ActivityCubit>().addActivity(activity);
    Navigator.pop(context);
  }
}
