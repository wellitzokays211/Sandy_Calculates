import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // Importing math expression library
import 'package:sandy_calculates/buttons.dart';

// Stateful widget for the Calculator screen
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

// State class for managing calculator state and UI
class _CalculatorScreenState extends State<CalculatorScreen> {
  // Variables
  String equation = "0"; // Current equation
  String expression = ""; // Processed expression
  String result = "0"; // Calculation result

  @override
  Widget build(BuildContext context) {
    // Getting the screen size for responsive button layouts
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 201, 211, 208), // Background - Light purple
      body: SafeArea(
        child: Column(
          children: [
            // Add the image before the equation display area
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(
                'assets/brown.png', // Your image path
                height: 200, // Set the height of the image
              ),
            ),

            // Display area for the equation and result
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    blurRadius: 3,
                    spreadRadius: 0.0001,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // Align text to the right
                children: [
                  // Display the equation
                  Text(
                    equation.length > 22 ? equation.substring(0, 22) : equation,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                      height: 2), // Space between equation and result
                  // Display the result
                  Text(
                    equation.contains('/0')
                        ? result
                        : ((result.length > 15 && !result.contains("Error"))
                            ? result.substring(0, 15)
                            : result),
                    style: TextStyle(
                      fontSize: equation.contains('/0') ? 24 : 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Button layout area
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 2.0, // Horizontal gap between buttons
                runSpacing: 10.0, // Vertical gap between rows
                children: Btn.buttonValues
                    .map(
                      (value) => SizedBox(
                        width: (screenSize.width - 32 - (4 * 3)) /
                            4, // Calculate button width dynamically
                        height: screenSize.width / 5, // Set button height
                        child: buildButton(value), // Build each button
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build individual buttons
  Widget buildButton(String value) {
    Color textColor = getTextColor(value);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        margin: const EdgeInsets.all(4.0), // Add margin around the button
        decoration: BoxDecoration(
          color: getBtnColor(value), // Button's color
          borderRadius:
              BorderRadius.circular(50), // Circular shape for the button
          border: Border.all(
            color:
                Colors.black.withOpacity(0.5), // Black border around the button
            width: 2, // Thickness of the border
          ),
        ),
        child: Material(
          color: getBtnColor(value),
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Match circular shape
          ),
          child: InkWell(
            onTap: () => buttonPressed(value),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buttonPressed(String buttonText) {
    // Helper method to remove unnecessary decimal points
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "C") {
        // Clear all inputs
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        // Handle backspace
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        // Shift positive/negative sign
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        // Evaluate the entered equation
        expression = equation; // Copy the equation for processing
        expression = expression.replaceAll('x', '*'); // Replace 'x' with '*'
        expression = expression.replaceAll('÷', '/'); // Replace '÷' with '/'
        expression = expression.replaceAll('%', '*0.01'); // Handle '%' operator

        try {
          // Check for division by zero
          if (expression.contains('/0')) {
            if (expression == '0/0') {
              result = "Error"; // Specific case for 0/0
            } else {
              result = "Error: division by 0"; // General case for number/0
            }
          } else {
            Parser p = Parser(); // Math expression parser
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel(); // Context for variable evaluation
            result =
                '${exp.evaluate(EvaluationType.REAL, cm)}'; // Evaluate the expression
            if (expression.contains('%')) {
              result =
                  doesContainDecimal(result); // Remove unnecessary decimals
            }
          }
        } catch (e) {
          result = "Error"; // General error message
        }
      } else if (buttonText == ".") {
        // Ensure only one decimal point per number
        // Split the equation into parts based on operators
        List<String> parts = equation.split(RegExp(r'[\+\-\x÷]'));
        String lastPart = parts.isNotEmpty ? parts.last : "";

        if (!lastPart.contains('.')) {
          // Append decimal if no decimal exists in the current number
          equation += buttonText;
        }
      } else {
        // Handle operator logic to prevent multiple operators
        if (["+", "-", "x", "÷", "%"].contains(buttonText)) {
          if (["+", "-", "x", "÷", "%"]
              .contains(equation[equation.length - 1])) {
            // Replace the last operator if one exists
            equation = equation.substring(0, equation.length - 1) + buttonText;
          } else {
            // Append the operator if none exists
            equation += buttonText;
          }
        } else {
          // Append numeric input or other characters
          if (equation == "0") {
            equation = buttonText;
          } else {
            equation += buttonText;
          }
        }
      }
    });
  }

  // Method to determine button colors
  Color getBtnColor(value) {
    return [Btn.clr].contains(value)
        ? const Color.fromARGB(255, 116, 238, 249) // Red for clear button
        : [Btn.del].contains(value)
            ? const Color.fromARGB(255, 186, 231, 221) // Green for delete
            : [
                Btn.per,
                Btn.multiply,
                Btn.add,
                Btn.subtract,
                Btn.divide,
                Btn.ans,
              ].contains(value)
                ? const Color.fromARGB(
                    255, 211, 194, 184) // Purple for operators
                : const Color.fromARGB(221, 255, 255, 255); // White for numbers
  }

  // Method to determine button text colors
  Color getTextColor(value) {
    return [
      Btn.clr,
      Btn.del,
      Btn.per,
      Btn.multiply,
      Btn.divide,
      Btn.subtract,
      Btn.add,
      Btn.ans,
    ].contains(value)
        ? const Color.fromARGB(255, 0, 0, 0) // White text for operation buttons
        : Colors.black; // Black text for number buttons
  }
}
