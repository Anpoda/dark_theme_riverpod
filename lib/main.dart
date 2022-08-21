import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: DarkModeExample()));
}

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider.notifier).state;
  return themeMode == ThemeMode.dark;
});

// ignore: use_key_in_widget_constructors
class DarkModeExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.notifier).state;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Тёмная тема",
                    style: TextStyle(fontSize: 22),
                  ),
                  Consumer(builder: (context, ref, child) {
                    final isDarkMode = ref.watch(isDarkModeProvider);
                    return CupertinoSwitch(
                        value: isDarkMode,
                        onChanged: (value) {
                          if (value) {
                            ref.refresh(themeModeProvider.notifier).state =
                                ThemeMode.dark;
                          } else {
                            ref.refresh(themeModeProvider.notifier).state =
                                ThemeMode.light;
                          }
                        });
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
