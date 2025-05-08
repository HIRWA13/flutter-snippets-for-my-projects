import 'package:flutter/material.dart';

class LanguageDropdown extends StatelessWidget {
  final String currentLanguageCode;
  final Function(String) onLanguageChanged;

  const LanguageDropdown({
    super.key,
    required this.currentLanguageCode,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> supportedLanguages = [
      {"code": "en", "name": "English"},
      {"code": "de", "name": "German"},
      {"code": "zh", "name": "Chinese"},
      {"code": "es", "name": "Spanish"},
    ];

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: DropdownButton<String>(
        value: currentLanguageCode,
        items:
            supportedLanguages.map((language) {
              return DropdownMenuItem(
                value: language["code"],
                child: Text(
                  language["name"]!,
                  style: TextStyle(
                    color:
                        currentLanguageCode == language["code"]
                            ? Colors.deepPurple[400]
                            : Colors.black,
                    fontWeight:
                        currentLanguageCode == language["code"]
                            ? FontWeight.bold
                            : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
        onChanged: (value) {
          if (value != null) {
            onLanguageChanged(value);
          }
        },
        dropdownColor: Colors.white,
        icon: Icon(Icons.language, color: Colors.deepPurple[400]),
        underline: Container(height: 1, color: Colors.deepPurple[400]),
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
