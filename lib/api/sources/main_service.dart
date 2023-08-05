import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:zen8app/core/core.dart';
import 'package:zen8app/utils/utils.dart';
import 'package:zen8app/models/models.dart';

class MainService {
  Stream<Page<Post>> getPosts(
      {required int page, required int pageSize, String? category}) {
    return Stream.value(Page(
        index: page,
        total: max(page, 5),
        items: List.generate(pageSize, (index) {
          var postId = page * 1000 + index;
          return Post(
            id: postId,
            title: 'Mock post title $postId',
          );
        }))).delay(const Duration(seconds: 1));
  }
}
