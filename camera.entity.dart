abstract class ICamera {
  void show();
  void takePhoto();
}

class Camera12MP extends ICamera {
  @override
  void show() {
    print("Camera 12MP");
  }
  
  @override
  void takePhoto() {
    print("Take Photo");
  }
}