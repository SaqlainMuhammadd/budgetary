import 'package:get/get.dart';

class CalculatorController extends GetxController {
  static CalculatorController get to => Get.find();

  List<String> operators = ["+", "-", "×", "÷"];
  List<String> hist = [];
  var history = "", output = "", answer = 0.0;
  void click1() {
    if (double.parse(output) != 0.0) {
      output += "1";
    } else {
      output = "1";
    }
    update();
  }

  void click2() {
    if (double.parse(output) != 0.0) {
      output += "2";
    } else {
      output = "2";
    }
    update();
  }

  void click3() {
    if (double.parse(output) != 0.0) {
      output += "3";
    } else {
      output = "3";
    }
    update();
  }

  void click4() {
    if (double.parse(output) != 0.0) {
      output += "4";
    } else {
      output = "4";
    }
    update();
  }

  void click5() {
    if (double.parse(output) != 0.0) {
      output += "5";
    } else {
      output = "5";
    }
    update();
  }

  void click6() {
    if (double.parse(output) != 0.0) {
      output += "6";
    } else {
      output = "6";
    }
    update();
  }

  void click7() {
    if (double.parse(output) != 0.0) {
      output += "7";
    } else {
      output = "7";
    }
    update();
  }

  void click8() {
    if (double.parse(output) != 0.0) {
      output += "8";
    } else {
      output = "8";
    }
    update();
  }

  void click9() {
    if (double.parse(output) != 0.0) {
      output += "9";
    } else {
      output = "9";
    }
    update();
  }

  void click0() {
    if (double.parse(output) != 0.0) {
      output += "0";
    } else {
      output = "0";
    }
    update();
  }

  void clickDot() {
    output += ".";
    update();
  }

  void clear() {
    history = "";
    output = "0";
    answer = 0.0;
    hist = [];
    update();
  }

  void sign() {
    if (double.parse(output) == 0.0) {
    } else {
      if (output[0] == '-') {
        output = output.substring(1);
      } else {
        output = '-' + output;
      }
    }
    update();
  }

  void percent() {
    double percent = 0.0;
    percent = answer / 100;
    history = answer.toString() + " ÷ 100 =";
    output = percent.toString();
    update();
  }

  String getTape() {
    return hist.join(" ");
  }

  bool isOperator(String s) {
    return (operators.contains(s));
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != null;
  }

  void equals() {
    if (hist.length <= 3) {
      hist.add(output);
    }
    history = getTape() + " =";
    var opr1, opr2, op;
    opr1 = double.parse(hist.removeAt(0));
    op = hist.removeAt(0);
    opr2 = double.parse(hist.removeAt(0));
    switch (op) {
      case "+":
        answer = opr1 + opr2;
        break;
      case "-":
        answer = opr1 - opr2;
        break;
      case "×":
        answer = opr1 * opr2;
        break;
      case "÷":
        answer = opr1 / opr2;
        break;
      default:
    }
    output = answer.toString();
    hist.insert(0, answer.toString());
    update();
  }

  void add() {
    answer = double.parse(output);
    hist.add(output);
    hist.add("+");
    if (hist.length >= 3) {
      output = "0";
      equals();
    }
    output = "0";
    history = getTape();
    update();
  }

  void sub() {
    answer = double.parse(output);
    hist.add(output);
    hist.add("-");
    if (hist.length >= 3) {
      output = "0";
      equals();
    }
    output = "0";
    history = getTape();
    update();
  }

  void div() {
    answer = double.parse(output);
    hist.add(output);
    hist.add("÷");
    if (hist.length >= 3) {
      output = "0";
      equals();
    }
    output = "0";
    history = getTape();
    update();
  }

  void mul() {
    answer = double.parse(output);
    hist.add(output);
    hist.add("×");
    if (hist.length >= 3) {
      output = "0";
      equals();
    }
    output = "0";
    history = getTape();
    update();
  }
}
