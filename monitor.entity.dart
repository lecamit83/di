abstract class IMonitor {
  void display();
}

class AppleMonitor extends IMonitor {
  @override
  void display() {
    print("Apple Monitor");
  }
}

class LGMonitor extends IMonitor {
  @override
  void display() {
    print("LG Monitor");
  }
}