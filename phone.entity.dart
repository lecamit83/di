import 'battery.entity.dart';
import 'camera.entity.dart';
import 'monitor.entity.dart';
import 'sim.entity.dart';

mixin SimInjection {
  void injectSim(ISim sim);
}

mixin CameraInjection {
  void injectCamera(ICamera camera);
}

/// Dependency Object
abstract class IPhone with SimInjection, CameraInjection {
  // Inteface Injection
  IBattery? _battery;
  IMonitor? _monitor;
  ISim? _sim;
  /// Dependent Object
  ICamera? _camera;
  void show();
}

class Phone14ProMax extends IPhone {
  /// Constructor Injection
  Phone14ProMax({required IBattery battery,required IMonitor monitor}) {
    this._battery = battery;
    this._monitor = monitor;
  }

  void takePhoto() {
    this._camera?.takePhoto();
  }

  @override
  void show() {
    this._battery?.health();
    this._monitor?.display();
    this._sim?.show();
    this._camera?.show();
  }
  
  /// Setter Injection
  @override
  void injectSim(ISim sim) {
    this._sim = sim;
  }

  @override
  void injectCamera(ICamera camera) {
    this._camera = camera;
  }
}