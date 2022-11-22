class Env {
  static late Env _current;
  static Env get current => _current;

  String baseUrl;
  Env({required this.baseUrl});

  static Future<void> loadDevConfigs() async {
    _current = Env(baseUrl: "https://backend.wayarmy.net");
  }

  static Future<void> loadStgConfigs() async {
    _current = Env(baseUrl: "https://backend.wayarmy.net");
  }

  static Future<void> loadProdConfigs() async {
    _current = Env(baseUrl: "https://api2.vinmec.com");
  }
}
