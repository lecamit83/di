import 'battery.entity.dart';
import 'camera.entity.dart';
import 'monitor.entity.dart';
import 'phone.entity.dart';
import 'sim.entity.dart';

typedef FactoryFunction<T> = T Function();

class _ServiceFactory<T extends Object> {
  final FactoryFunction<T>? creationFunction;
  T? instance;

  _ServiceFactory({this.creationFunction, this.instance});

  T getObject() {
    instance = creationFunction!();
    return instance!;
  }
}

class Cache {
  final Map<String?, Map<String, _ServiceFactory>> _cache = {};
}

abstract class ServiceLocator {
  static ServiceLocator _instance = _ServiceLocatorImpl();
  static ServiceLocator get instance => _instance;

  final Cache data = Cache();

  void registerFactory<T extends Object>(
    FactoryFunction<T> factoryFunction, {
    String? instanceTypeName,
  });

  T get<T extends Object>({String? instanceName});
}

class _ServiceLocatorImpl extends ServiceLocator {
  @override
  void registerFactory<T extends Object>(FactoryFunction<T> factoryFunction,
      {String? instanceTypeName}) {
    _register(factoryFunction: factoryFunction, instanceName: instanceTypeName);
  }

  void _register<T extends Object>({
    FactoryFunction<T>? factoryFunction,
    String? instanceName,
    T? instance,
  }) {
    final _serviceFactory =
        _ServiceFactory(creationFunction: factoryFunction, instance: instance);

    data._cache
        .putIfAbsent(instanceName, () => {T.toString(): _ServiceFactory<T>()});

    data._cache[instanceName]![T.toString()] = _serviceFactory;
  }

  @override
  T get<T extends Object>({String? instanceName}) {
    final instanceFactory = _findFactoryByNameAndType<T>(instanceName);
    if (instanceFactory == null) {
      throw Exception("Not Found Element");
    }

    return instanceFactory.getObject();
  }

  _ServiceFactory<T>? _findFactoryByNameAndType<T extends Object>(
      String? instanceName) {
    _ServiceFactory<T>? instanceFactory =
        data._cache[instanceName]![T.toString()] as _ServiceFactory<T>;
    return instanceFactory;
  }
}

final locator = ServiceLocator.instance;

void setUpLocator() {
  /// Register ICamera
  locator.registerFactory<ICamera>(
    () => Camera12MP(),
  );

  /// Register ISim
  locator.registerFactory<ISim>(
    () => Viettel(),
  );

  /// Register IBattery
  locator.registerFactory<IBattery>(
    () => AppleBattery(),
  );

  locator.registerFactory<IBattery>(
    () => PisenBattery(),
    instanceTypeName: "PisenBattery",
  );

  /// Register IMonitor
  locator.registerFactory<IMonitor>(
    () => AppleMonitor(),
  );

  locator.registerFactory<IMonitor>(
    () => LGMonitor(),
    instanceTypeName: "LGMonitor",
  );

  /// Register IPhone
  locator.registerFactory<IPhone>(
    () {
      final instance = Phone14ProMax(
        battery: locator.get<IBattery>(),
        monitor: locator.get<IMonitor>(),
      );
      instance.injectSim(locator.get<ISim>());
      instance.injectCamera(locator.get<ICamera>());
      return instance;
    },
  );

  locator.registerFactory<IPhone>(
    () {
      final instance = Phone14ProMax(
        battery: locator.get<IBattery>(instanceName: "PisenBattery"),
        monitor: locator.get<IMonitor>(instanceName: "LGMonitor"),
      );
      instance.injectSim(locator.get<ISim>());
      instance.injectCamera(locator.get<ICamera>());
      return instance;
    },
    instanceTypeName: "PisenBattery-LGMonitor-IPhone-14-ProMax",
  );
  locator.registerFactory<IPhone>(
    () {
      final instance = Phone14ProMax(
        battery: locator.get<IBattery>(instanceName: "PisenBattery"),
        monitor: locator.get<IMonitor>(),
      );
      instance.injectSim(locator.get<ISim>());
      instance.injectCamera(locator.get<ICamera>());
      return instance;
    },
    instanceTypeName: "PisenBattery-AppleMonitor-IPhone-14-ProMax",
  );

  locator.registerFactory<IPhone>(
    () {
      final instance = Phone14ProMax(
        battery: locator.get<IBattery>(),
        monitor: locator.get<IMonitor>(instanceName: "LGMonitor"),
      );
      instance.injectSim(locator.get<ISim>());
      instance.injectCamera(locator.get<ICamera>());
      return instance;
    },
    instanceTypeName: "AppleBattery-LGMonitor-IPhone-14-ProMax",
  );
}

void main(List<String> args) {
  setUpLocator();
  final iPhoneCamL = locator.get<IPhone>();
  iPhoneCamL.show();
}
