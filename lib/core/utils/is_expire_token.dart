import 'dart:convert';

bool isExpireToken(String? token) {
  try {
    if (token == null) {
      return true;
    }
    final parts = token.split('.');
    if (parts.length != 3) return true;

    final payload = json.decode(
      utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
    );

    final exp = payload['exp'];
    if (exp == null) return true;

    // Handle both int and string exp values
    final int expInt = exp is int ? exp : int.tryParse(exp.toString()) ?? 0;
    if (expInt == 0) return true;

    final expiryDate = DateTime.fromMillisecondsSinceEpoch(expInt * 1000);

    return DateTime.now().isAfter(expiryDate);
  } catch (e) {
    print('Error checking token expiry: $e');
    return true;
  }
}
