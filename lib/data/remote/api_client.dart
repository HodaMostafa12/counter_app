import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../util/environment.dart';
import 'apis/base.api.dart';
import 'constants.dart';

final apiClientProvider = Provider((ref) => APIClient());

class APIClient {
  final dio = Dio();
  final cachingDio = Dio();

  final logger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      request: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90);

  Future<Res?> fetch<Req, Res>({
    required API api,
    Req? body,
    String? pathParam,
    Map<String, dynamic>? queryParameters,
    required Res Function(dynamic) mapper,
    bool cache = false,
    
  }) async {
    /* final deviceTypeName = Platform.operatingSystem;
    final lang = await LocalStorage.getString(APIConstants.lang);
    final token = await LocalStorage.getSecret(APIConstants.userTokenKey);
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString(); */
    
    final options = await cacheOptions();
    cachingDio.interceptors.add(DioCacheInterceptor(options: options));

    if (kDebugMode) {
      dio.interceptors.add(logger);
      cachingDio.interceptors.add(logger);
    }

    // final headers = {
    //   HttpHeaders.contentTypeHeader: 'application/json',
    //   if (DoctorsToken.token != null)
    //     APIConstants.authorization: "Bearer ${DoctorsToken.token}",
    // };
    Response response;
    final requestOptions = RequestOptions(
      baseUrl: "${Environment.baseUrl}/${api.path}${pathParam ?? ""}",
      method: api.method.name,
      queryParameters: queryParameters,
      data: body /*  != null ? BaseRequest<Req>(request: body) : null */,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    const timeout = Duration(seconds: APIConstants.timeout);

    response = cache
        ? await cachingDio.fetch(requestOptions).timeout(timeout)
        : await dio.fetch(requestOptions).timeout(timeout);

    return mapper(response.data);
  }

  Future<CacheOptions> cacheOptions() async {
    final tempDir = await getTemporaryDirectory();

    return CacheOptions(
      store: HiveCacheStore(tempDir.path),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );
  }
}

class BaseException implements Exception {
  final String message;

  BaseException(this.message);

  @override
  String toString() {
    return message;
  }
}
