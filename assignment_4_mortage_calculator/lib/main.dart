import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MortgageApp());
}

class MortgageApp extends StatelessWidget {
  const MortgageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mortgage Calculator',
      home: const MortgageHomePage(),
    );
  }
}

// Model class
class Mortgage {
  double amount = 100000;
  int years = 30;
  double rate = 0.035; // 3.5%

  double monthlyPayment() {
    int numberOfPayments = years * 12;

    if (numberOfPayments == 0) {
      return 0;
    }

    if (rate == 0) {
      return amount / numberOfPayments;
    }

    double monthlyRate = rate / 12;

    return amount * monthlyRate / (1 - (1 / pow(1 + monthlyRate, numberOfPayments)));
  }

  double totalPayment() {
    return monthlyPayment() * years * 12;
  }
}

class MortgageHomePage extends StatefulWidget {
  const MortgageHomePage({super.key});

  @override
  State<MortgageHomePage> createState() => _MortgageHomePageState();
}

class _MortgageHomePageState extends State<MortgageHomePage> {
  final Mortgage mortgage = Mortgage();

  bool termsAccepted = false;

  String money(double value) {
    return '\$${value.toStringAsFixed(2)}';
  }

  void openModifyScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ModifyScreen(mortgage: mortgage);
        },
      ),
    );

    setState(() {});
  }

  void showTermsDialog(bool? value) async {
    if (value != true) {
      setState(() {
        termsAccepted = false;
      });
      return;
    }

    bool? accepted = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Terms and Conditions'),
          content: const Text(
            'Do you agree to the terms and conditions?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Agree'),
            ),
          ],
        );
      },
    );

    setState(() {
      termsAccepted = accepted == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage Calculator'),
        backgroundColor: Colors.green[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mortgage Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'Amount: ${money(mortgage.amount)}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            Text(
              'Years: ${mortgage.years}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            Text(
              'Interest Rate: ${(mortgage.rate * 100).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            Text(
              'Monthly Payment: ${money(mortgage.monthlyPayment())}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            Text(
              'Total Payment: ${money(mortgage.totalPayment())}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Terms and Conditions'),
              value: termsAccepted,
              onChanged: showTermsDialog,
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: openModifyScreen,
                child: const Text('Modify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModifyScreen extends StatefulWidget {
  final Mortgage mortgage;

  const ModifyScreen({
    super.key,
    required this.mortgage,
  });

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  late TextEditingController amountController;
  late TextEditingController yearsController;

  late double selectedRate;

  @override
  void initState() {
    super.initState();

    amountController = TextEditingController(
      text: widget.mortgage.amount.toString(),
    );

    yearsController = TextEditingController(
      text: widget.mortgage.years.toString(),
    );

    selectedRate = widget.mortgage.rate;
  }

  @override
  void dispose() {
    amountController.dispose();
    yearsController.dispose();
    super.dispose();
  }

  void saveChanges() {
    double? amount = double.tryParse(amountController.text);
    int? years = int.tryParse(yearsController.text);

    if (amount == null || years == null || amount < 0 || years < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid values.'),
        ),
      );
      return;
    }

    widget.mortgage.amount = amount;
    widget.mortgage.years = years;
    widget.mortgage.rate = selectedRate;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modify Mortgage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: yearsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Years',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Select Interest Rate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: 53,
                itemBuilder: (context, index) {
                  double ratePercent = 2 + (index * 0.25);
                  double rateDecimal = ratePercent / 100;

                  return RadioListTile<double>(
                    title: Text(
                      '${ratePercent.toStringAsFixed(2)}%',
                    ),
                    value: rateDecimal,
                    groupValue: selectedRate,
                    onChanged: (value) {
                      setState(() {
                        selectedRate = value!;
                      });
                    },
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveChanges,
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}