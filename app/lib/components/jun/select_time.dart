// ----------------------------------------------------------------------------- //
import 'package:flutter/material.dart';
// ----------------------------------------------------------------------------- //

class SelectTime extends StatelessWidget {
// ------------------------------ Property ------------------------------------- //
  final int selectedHour;
  final void Function(int) onHourChanged;
  const SelectTime({super.key, required this.selectedHour, required this.onHourChanged});
// ----------------------------------------------------------------------------- //
  @override
  Widget build(BuildContext context) {
// ----------------------------------------------------------------------------- //
    final now = DateTime.now();
    final currentHour = now.hour; // 현재 시각
    final hours = List.generate(12, (i) => (currentHour + i) % 24);
// ----------------------------------------------------------------------------- //
    return DropdownButtonFormField<int>(
      value: selectedHour,
      onChanged: (value) {
        if (value != null) {
          onHourChanged(value); // 선택한 시를 외부로 전달
        }
      },
      decoration: InputDecoration(
        labelText: '시간 선택',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: hours.map((hour) {
        return DropdownMenuItem(
          value: hour,
          child: Text('$hour시'),
        );
      }).toList(),
    );
  } // build
} // class