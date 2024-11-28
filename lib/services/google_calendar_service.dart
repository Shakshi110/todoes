
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleCalendarService {
  final _storage = const FlutterSecureStorage();
  static const _scopes = [CalendarApi.calendarScope];

  /// Authenticate and return an instance of the Calendar API
  Future<CalendarApi?> authenticate() async {
    final clientId = ClientId(
      "1008901234800-nvufc0dthrm11igc8u43vjf4a2h6rq14.apps.googleusercontent.com",
      "",
    );

    try {
      // Get an authenticated HTTP client using user consent
      var client = await clientViaUserConsent(clientId, _scopes, (url) async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      });

      return CalendarApi(client);
    } catch (e) {
      print("Authentication error: $e");
      return null;
    }
  }
}





