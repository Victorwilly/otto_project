// here we have the settings for prod
// ignore_for_file: prefer_interpolation_to_compose_strings, unused_element

const String _prodUrl = '';

// here we have the settings for dev
// const String _devUrl = '40.67.166.30:8003';
// const String customUrl = '40.67.166.30:8003';


const String _devUrl = 'otto-api.sbscuk.co.uk';
const String customUrl = 'otto-api.sbscuk.co.uk';

// here we have the settings for staging
// const String _devUrl = 'stagingapi.crcdataanalytics.com';
// const String customUrl = 'stagingapi.crcdataanalytics.com';

class AppConfig {
  AppConfig();

  // Given we cannot switch between live and dev in the live-app
  // it should be done manually here instead.
  static bool isProd = false;

  static int storeCacheDebounceSeconds = 3;

  static int profilePictureTimestamp = DateTime.now().millisecondsSinceEpoch;

  static String versionNumber = '0.0.1 (1)';

  static String get apiProtocol {
    return AppConfig.isProd ? 'http' : 'http';
  }

  ///modified for current application
  static String apiDomain({bool? isAuth = false}) {
    // AppConfig.isAuth = isAuth!;
    return isAuth! ? customUrl : _devUrl;
  }

  // static String apiPath(String path) {
  //   return (path.startsWith('api/') ? path.substring(1) : path);
  // }

  static String apiPath(String path) {
    return '/api/v1/' +
        (path.startsWith('/') ? path.substring(1) : path);
  }

  static String apiFullPath(String path) {
    return AppConfig.apiProtocol +
        '://' +
        AppConfig.apiDomain() +
        '/api/' +
        (path.startsWith('/') ? path.substring(1) : path);
  }
}
