import 'dart:async';

void main() {
  print(Utils().timestamp(11));
}

class Utils {
  String timestamp(int to) {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(0, to);
  }

  void delayed(int millis) {
    Future.delayed(Duration(milliseconds: millis), () {
      // Do something
    });
  }

  void inlineDelay(int millis) async =>
      ({await Future.delayed(Duration(milliseconds: millis))});

  //run code one time by specific time
  void delay(int sec) {
    Timer(
      Duration(seconds: sec),
      () {
        print("Yeah, this line is printed after 1 seconds");
      },
    );
  }

  //repeat code after 5 second
  void repeatAfter(int sec) {
    Timer.periodic(
      Duration(seconds: sec),
      (timer) {
        print(DateTime.now());
      },
    );
  }
}
