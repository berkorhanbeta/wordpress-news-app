import 'package:intl/intl.dart';

class PostModel {

  PostModel(){}

  int? _id;
  String? _title;
  String? _image;
  String? _date;
  String? _content;
  String? _category;

  PostModel.fromJson(Map<dynamic, dynamic> json) {
    _id = json['id'] ?? 12312312;
    _title = json['title']['rendered']?.toString() ?? '';
    _content = json['content']['rendered']?.toString() ?? '';
    _date = DateFormat('hh:mm - dd/MM/yyyy').format(DateTime.parse(json['date']?.toString() ?? ''));
    if(!json.toString().contains('_embedded')){
      _image = json['_links']['wp:featuredmedia']?[0]?['href']?.toString() ?? '';
      _category = json['_links']['wp:term']?[0]?[0]?['name']?.toString() ?? '';
    } else {
      _category = json['_embedded']['wp:term']?[0]?[0]?['name']?.toString() ?? '';
      _image = json['_embedded']['wp:featuredmedia']?[0]?['source_url']?.toString() ?? '';
    }

  }

  String? get title => _title;
  String? get image => _image;
  String? get date => _date;
  String? get content => _content;
  String? get category => _category;
  int? get id => _id;

  set newImage(String url){
    _image = url;
  }

}