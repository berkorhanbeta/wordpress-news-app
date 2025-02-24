class SearchModel {

  int? _id;
  String? _title;

  SearchModel.fromJson(Map<dynamic, dynamic> json) {
    _id = json['id'] ?? 0;
    _title = json['title']?.toString() ?? '';
  }

  int? get id => _id;
  String? get title => _title;

}

