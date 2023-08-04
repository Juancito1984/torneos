import 'package:cloud_firestore/cloud_firestore.dart';

class InitialDoc {
  final String title;
  final bool isActive;

  InitialDoc({this.isActive = true, this.title = ''});

  factory InitialDoc.fromDocument(DocumentSnapshot document) {
    return InitialDoc(
      isActive: document['isActive'],
      title: document['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'isActive': isActive,
        'title': title,
      };
}
