import 'package:intl/intl.dart';

class CommentModel {

  int? _id;
  String? _author_name;
  String? _date;
  String? _author_avatar;
  String? _comment;

  CommentModel.fromJson(Map<dynamic, dynamic> json){
    _id = json['id'] ?? 0;
    _author_avatar = json['author_avatar_urls']?['24']?.toString();
    _date = DateFormat('hh:mm - dd/MM/yyyy').format(DateTime.parse(json['date']?.toString() ?? ''));
    _author_name = json['author_name']?.toString() ?? '';
    _comment = json['content']?['rendered']?.toString() ?? '';
  }

  int? get id => _id;
  String? get author_name => _author_name;
  String? get date => _date;
  String? get author_avatar => _author_avatar;
  String? get comment => _comment;

}