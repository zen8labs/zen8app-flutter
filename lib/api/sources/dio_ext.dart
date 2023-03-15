import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zen8app/tools/extensions/extendable.dart';

extension StreamDecoding<R extends Response> on Stream<R> {
  Stream<T> decode<T>(T Function(dynamic data) decoding) {
    return map((res) => decoding(res.data));
  }

  Stream<List<T>> decodeList<T>(List<T> Function(List<dynamic> data) decoding) {
    return map((res) => decoding(res.data));
  }
}

extension DioExt on Extendable<Dio> {
  void _cancel(CancelToken? token) {
    token?.cancel('Stream subscription was canceled');
  }

  Stream<Response> getStream(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return Rx.defer(
      () => base
          .get(path,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onReceiveProgress: onReceiveProgress)
          .asStream()
          .doOnCancel(() => _cancel(cancelToken)),
      reusable: true,
    );
  }

  Stream<Response> postStream<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Rx.defer(
      () => base
          .post(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .asStream()
          .doOnCancel(() => _cancel(cancelToken)),
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
      () => base
          .put(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .asStream()
          .doOnCancel(() => _cancel(cancelToken)),
      reusable: true,
    );
  }

  Stream<Response> deleteStream(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return Rx.defer(
      () => base
          .put(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken)
          .asStream()
          .doOnCancel(() => _cancel(cancelToken)),
      reusable: true,
    );
  }

  Stream<Response> patchStream(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Rx.defer(
      () => base
          .patch(path,
              data: data,
              queryParameters: queryParameters,
              options: options,
              cancelToken: cancelToken,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress)
          .asStream()
          .doOnCancel(() => _cancel(cancelToken)),
      reusable: true,
    );
  }

  Stream<Response> downloadStream(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options? options,
  }) {
    return Rx.defer(
      () => base
          .download(urlPath, savePath,
              onReceiveProgress: onReceiveProgress,
              queryParameters: queryParameters,
              cancelToken: cancelToken,
              deleteOnError: deleteOnError,
              lengthHeader: lengthHeader,
              data: data,
              options: options)
          .asStream()
          .doOnCancel(() => _cancel(cancelToken)),
      reusable: true,
    );
  }
}
