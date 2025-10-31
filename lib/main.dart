import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/search_screen.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const Care247App());
}

class Care247App extends StatelessWidget {
  const Care247App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Care247 Customer Search',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            home: const SearchScreen(),
          );
        },
      ),
    );
  }
}
