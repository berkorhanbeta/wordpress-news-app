class CategoryModel {

  CategoryModel(){
    _id = 0;
    _name = 'Latest';
    _parent = 99999;
  }

  int? _id;
  String? _name;
  int? _parent;

  CategoryModel.fromJson(Map<dynamic, dynamic> json){
    _id = json['id'] ?? 9999;
    _name = json['name']?.toString() ?? '';
    _parent = json['parent'] ?? 99999;
  }

  String? get name => _name;
  int? get id => _id;
  int? get parent => _parent;

}