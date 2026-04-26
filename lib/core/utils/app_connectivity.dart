import 'dart:io';

class AppConnectivity {
  /// Check current internet connection status by trying to lookup google.com
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Get human-readable connection status
  static Future<String> getConnectionStatus() async {
    final isOnline = await isConnected();
    return isOnline ? 'Connected' : 'No Internet Connection';
  }
}

