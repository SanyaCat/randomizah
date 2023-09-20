import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const RandomizahApp());

class RandomizahApp extends StatelessWidget {
  const RandomizahApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Randomizah',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? randomNumbah;
  final minInputController = TextEditingController();
  final maxInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 2),
            // history of numbers
            // animate cards
      
            // NUMBAH
             
              SizedBox(
                height: 120,
                width: 120,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        randomNumbah != null ? randomNumbah.toString() : 'X',
                        style: theme.textTheme.displayLarge,
                      )
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 32),

            // GENERETAH
            FloatingActionButton.extended(
              onPressed: () {
                randomizeDatBiach();
              }, 
              label: Text(
                'Randomize!',
                style: theme.textTheme.headlineMedium
              ),
            ),
            // SizedBox(height: 32),
      
            //divider?
            
            // how many
            //slider?
      
            const SizedBox(height: 32),

            // MINAH/MAXAH
            //slider?
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberInputField(controller: minInputController, labelText: 'Min'),
                NumberInputField(controller: maxInputController, labelText: 'Max'),
              ],
            ),
      
            const Spacer(flex: 3),
          ],
        ),
      )
    );
  }

  void randomizeDatBiach() {
    Random random = Random();

    if (int.tryParse(minInputController.text) is! int
      || int.tryParse(maxInputController.text) is! int) {
      setState(() {
        randomNumbah = null;
      });
      return;
    }

    var min = int.parse(minInputController.text);
    var max = int.parse(maxInputController.text);

    if (min > max) {
      setState(() {
        randomNumbah = null;
      });
      return;
    }

    
    setState(() {
      randomNumbah = random.nextInt(max - min + 1) + min;
    });
  

  }
}

class NumberInputField extends StatelessWidget {
  const NumberInputField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
        child: TextField(
          controller: controller,
          maxLength: 3,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          style: Theme.of(context).textTheme.headlineMedium,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: labelText,
            counterText: '',
            suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(Icons.highlight_off),
            )
          ),
        ),
    );
  }
}
