import 'package:zen8app/utils/utils.dart';

class Page<E> extends PageType<E> {
  int index;
  int total;
  List<E> items;

  Page({
    required this.index,
    required this.total,
    required this.items,
  });

  factory Page.fromJson(int page, Map<String, dynamic> json,
      E Function(Map<String, dynamic> itemJson) itemFromJson) {
    return Page(
      index: page,
      total: json['pages'],
      items: (json['items'] as List).map((e) => itemFromJson(e)).toList(),
    );
  }

  @override
  bool get hasMore => index < total;
}
