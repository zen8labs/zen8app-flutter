import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/utils/utils.dart';

extension StreamDecoding<R extends Response> on Stream<R> {
  Stream<T> decode<T>(T Function(dynamic json) decoding, {String? keyPath}) {
    return map((res) {
      var data = res.data;
      final paths = keyPath?.split(".") ?? [];
      for (var path in paths) {
        data = data[path];
      }
      return decoding(data);
    });
  }

  Stream<List<T>> decodeList<T>(T Function(dynamic json) decoding,
      {String? keyPath}) {
    return map((res) {
      var data = res.data;
      final paths = keyPath?.split(".") ?? [];
      for (var path in paths) {
        data = data[path];
      }
      return (data as List).map((e) => decoding(e)).toList();
    });
  }
}

extension DioConfig on Dio {
  void setAuthCredential<Credential>({
    required Credential credential,
    required Authenticator<Credential> authenticator,
  }) {
    clearAuthCredential();
    _addNewAutoRetryInterceptor(credential, authenticator);
  }

  void clearAuthCredential() {
    interceptors.removeWhere((interceptor) {
      if (interceptor is AutoRetryInterceptor) {
        interceptor.dispose();
        return true;
      }
      return false;
    });
  }

  void _addNewAutoRetryInterceptor<Credential>(
    Credential credential,
    Authenticator<Credential> authenticator,
  ) {
    interceptors.insert(
      0,
      AutoRetryInterceptor(
        client: this,
        credential: credential,
        authenticator: authenticator,
      ),
    );
  }
}

extension DioStream on Dio {
  void _cancel(CancelToken? token) {
    token?.cancel('Stream subscription was canceled');
  }

  Stream<Response> getStream(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) {
    return Rx.defer(
      () {
        final cancelToken = CancelToken();
        return get(path,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken,
                onReceiveProgress: onReceiveProgress)
            .asStream()
            .doOnCancel(() => _cancel(cancelToken));
      },
      reusable: true,
    );
  }

  Stream<Response> postStream<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Rx.defer(
      () {
        final cancelToken = CancelToken();
        return post(path,
                data: data,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken,
                onSendProgress: onSendProgress,
                onReceiveProgress: onReceiveProgress)
            .asStream()
            .doOnCancel(() => _cancel(cancelToken));
      },
      reusable: true,
    );
  }

  Stream<Response> putStream(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Rx.defer(
      () {
        final cancelToken = CancelToken();
        return put(path,
                data: data,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken,
                onSendProgress: onSendProgress,
                onReceiveProgress: onReceiveProgress)
            .asStream()
            .doOnCancel(() => _cancel(cancelToken));
      },
      reusable: true,
    );
  }

  Stream<Response> deleteStream(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return Rx.defer(
      () {
        final cancelToken = CancelToken();
        return delete(path,
                data: data,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken)
            .asStream()
            .doOnCancel(() => _cancel(cancelToken));
      },
      reusable: true,
    );
  }

  Stream<Response> patchStream(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Rx.defer(
      () {
        final cancelToken = CancelToken();
        return patch(path,
                data: data,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken,
                onSendProgress: onSendProgress,
                onReceiveProgress: onReceiveProgress)
            .asStream()
            .doOnCancel(() => _cancel(cancelToken));
      },
      reusable: true,
    );
  }

  Stream<Response> downloadStream(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options? options,
  }) {
    return Rx.defer(
      () {
        final cancelToken = CancelToken();
        return download(urlPath, savePath,
                onReceiveProgress: onReceiveProgress,
                queryParameters: queryParameters,
                cancelToken: cancelToken,
                deleteOnError: deleteOnError,
                lengthHeader: lengthHeader,
                data: data,
                options: options)
            .asStream()
            .doOnCancel(() => _cancel(cancelToken));
      },
      reusable: true,
    );
  }
}
