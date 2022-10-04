abstract class IBattery {
  void health();
}

class AppleBattery extends IBattery {
  @override
  void health() {
    print("Apple Battery");
  }
}

class PisenBattery extends IBattery {
  @override
  void health() {
    print("Pisen Battery");
  }
}