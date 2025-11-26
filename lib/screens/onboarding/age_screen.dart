import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import 'home_screen_redirect.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  double _age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.base,
      appBar: AppBar(title: const Text('Your Age')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How old are you?', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 48),
            Text('${_age.toInt()} years', style: Theme.of(context).textTheme.headlineLarge),
            Slider(
              value: _age,
              min: 15,
              max: 80,
              divisions: 65,
              onChanged: (v) => setState(() => _age = v),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreenRedirect()));
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
