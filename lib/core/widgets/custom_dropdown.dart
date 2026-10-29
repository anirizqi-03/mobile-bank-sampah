import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.icon,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.avatarBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.muted, size: 20),
          const SizedBox(width: 10),
          
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.muted, size: 20),
                hint: Text(
                  hintText,
                  style: const TextStyle(fontSize: 12, color: AppColors.hint),
                  overflow: TextOverflow.ellipsis,
                ),
                style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}