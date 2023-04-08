import 'package:boxfile/model/bookdatabase.dart';

class Book implements DatabaseModel {
  int? id;
  String? created;
  String? title;
  String? content;
  Book({
    this.id,
    required this.created,
    required this.title,
    required this.content,
  });
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created': created,
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Book{created: $created, title: $title, content: $content}';
  }

  String getdate() {
    return '$created';
  }

  String gettitle() {
    return '$title';
  }

  String getid() {
    return '$id';
  }

  String getcontent() {
    return '$content';
  }
}
