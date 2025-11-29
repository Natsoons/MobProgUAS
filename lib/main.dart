import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobprog_uas/providers/auth_provider.dart';
import 'package:mobprog_uas/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: '/home',
        onGenerateRoute: AppRouter.generate,
      ),
    );
  }
}
