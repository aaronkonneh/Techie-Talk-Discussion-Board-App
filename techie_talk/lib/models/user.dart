class FbUser {
  String? key;
  String id;
  String name;
  DateTime timeWhenCreated;
  bool deleted;

  FbUser({
    this.key,
    required this.id,
    required this.name,
    required this.timeWhenCreated,
    this.deleted = false,
  });

  static FbUser fromJson(key, value) => FbUser(
        key: key,
        id: value['id'],
        name: value['name'],
        timeWhenCreated: value['timeWhenCreated'].toDate(),
        deleted: value['deleted'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "timeWhenCreated": timeWhenCreated,
        "deleted": deleted,
      };
}
