enum Env { dev, stg, prod }

class Config {
  String baseUrl;
  Config({required this.baseUrl});

  factory Config.env(Env env) {
    switch (env) {
      case Env.dev:
        return dev;
      case Env.stg:
        return stg;
      case Env.prod:
        return prod;
    }
  }

  static Config get dev => Config(
        baseUrl: 'https://dtsmartag.try0.xyz',
      );

  static Config get stg => Config(
        baseUrl: 'https://dtsmartag.try0.xyz',
      );

  static Config get prod => Config(
        baseUrl: 'https://dtsmartag.try0.xyz',
      );
}
