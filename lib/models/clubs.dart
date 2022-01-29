class ClubModel {
  final String? id;
  final String? name;
  final String? desc;
  final String? members;
  final String? location;
  final String? img;
  final List<String>? categories;
  final List<dynamic>? admins;
  final bool? locked;

  ClubModel(
      {this.id,
      this.name,
      this.desc,
      this.members,
      this.location,
      this.img,
      this.categories,
      this.admins,
      this.locked});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'members': members,
      'location': location,
      'img': img,
      'categories': categories,
      'admins': admins,
      'locked': locked,
    };
  }

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
        members: json['members'],
        desc: json['desc'],
        categories: json['categories'],
        admins: json['admins'],
        img: json['img'],
        location: json['location'],
        name: json['name'],
        id: json['id'],
        locked: json['locked']);
  }

  ClubModel copyWith(ClubModel model) {
    return ClubModel(
      id: model.id ?? id,
      name: model.name ?? name,
      location: model.location ?? location,
      img: model.img ?? img,
      admins: model.admins ?? admins,
      categories: model.categories ?? categories,
      desc: model.desc ?? desc,
      members: model.members ?? members,
      locked: model.locked ?? locked,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ClubModel &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            desc == other.desc &&
            members == other.members &&
            location == other.location &&
            img == other.img &&
            categories == other.categories &&
            admins == other.admins &&
            locked == other.locked;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        desc.hashCode ^
        members.hashCode ^
        location.hashCode ^
        img.hashCode ^
        categories.hashCode ^
        admins.hashCode ^
        locked.hashCode;
  }

  @override
  String toString() {
    return 'ClubModel{name: $name, desc: $desc, members: $members, location: $location, img: $img, categories: $categories, admins: $admins, locked: $locked}';
  }
}
