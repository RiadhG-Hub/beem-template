import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/settings_cubit.dart';
import '../controller/settings_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _baseUrlController = TextEditingController();
  String? _errorText;

  bool isValidUrl(String url) {
    final urlPattern = r'^(https?:\/\/)?' // optional http or https
        r'(([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,6})' // domain name
        r'(\/[^\s]*)?$'; // optional path
    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Current Base URL: ${state}"),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _baseUrlController,
                    decoration: InputDecoration(
                      hintText: "Enter base URL",
                      errorText: _errorText,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final inputUrl = _baseUrlController.text.trim();
                      if (isValidUrl(inputUrl)) {
                        setState(() {
                          _errorText = null;
                        });
                        context
                            .read<SettingsCubit>()
                            .updateBaseUrl(baseUrl: inputUrl);
                      } else {
                        setState(() {
                          _errorText = "Please enter a valid URL.";
                        });
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
