import 'dart:convert';

class PepolResponse {
  PepolResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory PepolResponse.fromJson(String str) => PepolResponse.fromMap(json.decode(str));

  factory PepolResponse.fromMap(Map<String, dynamic> json) => PepolResponse(
    id: json["id"],
    cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
  );
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  get picPepol {
    if(this.profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${ this.profilePath }';
    
    return 'https://www.pngitem.com/pimgs/m/99-998739_dale-engen-person-placeholder-hd-png-download.png';
  }

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
    castId: json["cast_id"] == null ? null : json["cast_id"],
    character: json["character"] == null ? null : json["character"],
    creditId: json["credit_id"],
    order: json["order"] == null ? null : json["order"],
    department: json["department"] == null ? null : json["department"],
    job: json["job"] == null ? null : json["job"],
  );
}
