import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Theme Section
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme'),
            subtitle: const Text('Switch between light and dark themes'),
            trailing: Obx(() {
              // Assuming you have a GetX controller to handle the theme switching
              bool isDarkTheme = Get.isDarkMode;
              return Switch(
                value: isDarkTheme,
                onChanged: (value) {
                  if (value) {
                    Get.changeTheme(ThemeData.dark());
                  } else {
                    Get.changeTheme(ThemeData.light());
                  }
                },
              );
            }),
          ),
          const Divider(),

          // About Wollo University Section
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Wollo University'),
            subtitle: const Text('Learn more about Wollo University'),
            onTap: () {
              // Navigate to a page containing information about the university
              Get.to(() => const AboutWolloUniversityPage());
            },
          ),
          const Divider(),

          // App Info Section
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Info'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              // Display more app info or additional links if needed
              Get.to(() => const AppInfoPage());
            },
          ),
        ],
      ),
    );
  }
}

class AboutWolloUniversityPage extends StatelessWidget {
  const AboutWolloUniversityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Wollo University'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wollo University',
                style: Theme.of(context).textTheme.titleLarge, // Updated
              ),
              const SizedBox(height: 10),
              Text(
                'Wollo University is one of the public universities in Ethiopia. '
                'It is dedicated to providing quality higher education and '
                'conducting research to support the development of the country. '
                'The university offers a wide range of academic programs across '
                'various fields of study.',
                style: Theme.of(context).textTheme.bodyLarge, // Updated
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Version: 1.0.0',
              style: Theme.of(context).textTheme.titleLarge, // Updated
            ),
            const SizedBox(height: 10),
            Text(
              'This app is designed for Wollo University\'s GC Gallery to '
              'showcase the graduation class, achievements, and events. '
              'Developed using Flutter and GetX for navigation and state management.',
              style: Theme.of(context).textTheme.bodyLarge, // Updated
            ),
            // Additional information can be added here
          ],
        ),
      ),
    );
  }
}
