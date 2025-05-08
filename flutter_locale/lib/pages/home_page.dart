import 'package:flutter/material.dart';
import 'package:flutter_locale/cubits/localization_cubit.dart';
import 'package:flutter_locale/pages/widgets/language_dropdown.dart';

import '../core/di/locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationCubit = getIt<LocalizationCubit>();
    final translations = localizationCubit.getTranslations(
      localizationCubit.state.languageCode,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(translations['title']),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          LanguageDropdown(
            currentLanguageCode: localizationCubit.state.languageCode,
            onLanguageChanged: (value) {
              localizationCubit.changeLocale(value);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white, // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/exploration.jpg',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              translations['body'],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  backgroundColor: Colors.deepPurple[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded button
                  ),
                ),
                child: Text(
                  translations['buttonText'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
