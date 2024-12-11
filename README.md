# Sandy_Calculates
A cute, fun, and simple calculator app built with Flutter! 

It's time to escape that generic way of counting 1,2,3s with Sandy's adorable design!

---

## Features

- 🧮 Perform basic arithmetic operations: Addition, Subtraction, Multiplication, Division.
- 🧑‍💻 Clear and delete buttons to reset or remove the last entered input.
- 🎨 Cute and colorful design with dynamic display areas for the equation and result.
- 🌸 Enhanced, style with line friends theme. 
- 📱 Responsive layout that looks great on different screen sizes.

---

## Requirements

- Flutter 2.0 or higher
- Dart 2.0 or higher
---

## Installation

Follow these steps to set up **Sandy Calculates** on your local machine:

1. Clone this repository:
    ```bash
    git clone https://github.com/wellitzokays211/Sandy_Calculates.git
    ```

2. Navigate to the project directory:
    ```bash
    cd Sandy_Calculates
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app:
    ```bash
    flutter run
    ```

---

## How to Use

1. 🧮 **Enter Numbers**: Tap the number buttons to enter the digits of your calculation.
2. ➕ ➖ ✖️ ➗ **Operators**: Tap the operator buttons (+, -, *, /) to perform operations.
3. ✅ **Calculate**: Hit the "=" button to get your result.
4. 🧹 **Clear**: Tap the "C" button to reset everything.
5. 🧨 **Delete**: Tap the "⌫" button to remove the last entered character.
6. ⚖️ **Toggle Sign**: Use the "+/-" button to change the sign of the number.

---

## Code Explanation

### Main Widget - **`Calscreen`**:
   - This is the core of **Sandy Calculates**, where all the action happens. It includes the number buttons, operator buttons, and the display area for the equation and result.

### Button Builder - **`buildButton`**:
   - The cute button design comes from this function, which dynamically generates each button with a custom style and handles user interaction.

### Button Press Logic - **`buttonPressed`**:
   - Handles user input by updating the equation, calculating the result, or clearing/deleting as needed.
### Color & Style - **`getBtnColor` & `getTextColor`**:
   - These functions assign fun, colorful styles to the buttons, making sure that each button is visually appealing and user-friendly.

---

## Contributing

If you have ideas to make **Sandy Calculates** even more adorable or functional, feel free to fork the repository and submit a pull request.

---

## Acknowledgments

- **Flutter** for making it easy to build cross-platform apps.
- **Dart** for providing a solid foundation for the app's logic.💖

---

**Happy Calculating with Sandy!!** 
