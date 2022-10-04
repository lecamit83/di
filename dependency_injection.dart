import 'battery.entity.dart';
import 'camera.entity.dart';
import 'monitor.entity.dart';
import 'phone.entity.dart';
import 'sim.entity.dart';

// Injector Object
class DIContainer {
  DIContainer._();
  static DIContainer? _instance;
  static DIContainer get instance {
    return _instance ??= DIContainer._();
  }

  Phone14ProMax get mLbAPhone14ProMax {
    IBattery _appleBattery = AppleBattery();
    IMonitor _lgMonitor = LGMonitor();
    Phone14ProMax _iPhone14 = Phone14ProMax(monitor: _lgMonitor, battery: _appleBattery);
    ISim _viettelSim = Viettel();
    _iPhone14.injectSim(_viettelSim);
    ICamera _camera = Camera12MP();
    _iPhone14.injectCamera(_camera);
    return _iPhone14;
  }

  Phone14ProMax get mAbAPhone14ProMax {
    IBattery _appleBattery = AppleBattery();
    IMonitor _appleMonitor = AppleMonitor();
    Phone14ProMax _iPhone14 = Phone14ProMax(monitor: _appleMonitor, battery: _appleBattery);
    ISim _viettelSim = Viettel();
    _iPhone14.injectSim(_viettelSim);
    ICamera _camera = Camera12MP();
    _iPhone14.injectCamera(_camera);
    return _iPhone14;
  }

  Phone14ProMax get mLbPPhone14ProMax {
    IMonitor _lgMonitor = LGMonitor();
    IBattery _pisenBattery = PisenBattery();
    Phone14ProMax _iPhone14 = Phone14ProMax(monitor: _lgMonitor, battery: _pisenBattery);
    ISim _viettelSim = Viettel();
    _iPhone14.injectSim(_viettelSim);
    ICamera _camera = Camera12MP();
    _iPhone14.injectCamera(_camera);
    return _iPhone14;
  }

  Phone14ProMax get mAbPPhone14ProMax {
    IBattery _pisenBattery = PisenBattery();
    IMonitor _appleMonitor = AppleMonitor();
    Phone14ProMax _iPhone14 = Phone14ProMax(monitor: _appleMonitor, battery: _pisenBattery);
    ISim _viettelSim = Viettel();
    _iPhone14.injectSim(_viettelSim);
    ICamera _camera = Camera12MP();
    _iPhone14.injectCamera(_camera);
    return _iPhone14;
  }
}

void main(List<String> args) {
  final Phone14ProMax iPhoneCamL = DIContainer.instance.mAbAPhone14ProMax;
  iPhoneCamL.show();
}
