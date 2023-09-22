import 'package:flutter/material.dart';
import 'package:fourth_homework/next_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_generator/word_generator.dart';

final wordGenerator = WordGenerator();
List<String> nouns = wordGenerator.randomNouns(30);

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  bool _isTicked = false;
  bool _isDarkMode = false;

  String myText = "Click the button below to toggle dark mode";
  Icon myIcon = const Icon(Icons.light_mode);

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      if (_isDarkMode == false) {
        myText = "Click the button below to toggle dark mode";
        myIcon = const Icon(Icons.light_mode);
      } else {
        myText = "Click the button below to toggle light mode";

        myIcon = const Icon(Icons.dark_mode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              useMaterial3: true,
            )
          : ThemeData.light().copyWith(
              useMaterial3: true,
            ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dark Mode Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Icon(myIcon.icon),
              Text(myText),
              Switch(
                  inactiveThumbColor: Colors.black,
                  value: _isDarkMode,
                  onChanged: (value) {
                    _toggleDarkMode();
                  }),
              Container(
                height: 350,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(26, 128, 92, 228),
                    Color.fromARGB(28, 232, 228, 243),
                  ]),
                ),
                child: Scrollbar(
                  thickness: 12,
                  thumbVisibility: true,
                  child: ListView.builder(
                      itemCount: nouns.length,
                      itemBuilder: ((context, index) {
                        return Center(
                            child: Text(
                          nouns[index],
                          style: GoogleFonts.sacramento(
                            fontSize: 30,
                          ),
                        ));
                      })),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Checkbox(
                      value: _isTicked,
                      onChanged: (value) {
                        setState(() {
                          _isTicked = !_isTicked;
                        });
                      }),
                  Text(
                    "I have read all the names above",
                    style: GoogleFonts.lato(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_isTicked) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const NextScreen();
                      }));
                    } else {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text("Tick the Checkbox"),
                              content: const Text(
                                  "\"Read all the names in the list\""),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("Okay"))
                              ],
                            );
                          });
                    }
                  },
                  child: const Text("Next Page"))
            ],
          ),
        ),
      ),
    );
  }
}
