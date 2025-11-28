import 'package:flutter/material.dart';
import 'package:mobprog_uas/services/widget_support.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lupa Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Masukkan email Anda untuk mereset password', style: AppWidget.headlinestyle(16)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final email = _emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan email')));
                  return;
                }
                // For this demo we just show a snackbar. Real app: send reset email or show next steps.
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Instruksi reset telah dikirim (demo)')));
                Navigator.pop(context);
              },
              child: const Text('Kirim Instruksi'),
            ),
          ],
        ),
      ),
    );
  }
}
