import 'dart:collection';

class CacheResponse {
  LinkedHashMap<String, dynamic>? homePageDashBoardData;

  // ----------------------------------------------------------------------- //
  static CacheResponse? _instance;
  static CacheResponse get instance => _instance ??= CacheResponse();
  static setNullInstance() => _instance = null;
// ----------------------------------------------------------------------- //
}
