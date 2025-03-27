enum VgcScreenEnum {
  root('/'),
  favorites('favorites');

  const VgcScreenEnum(this.path);
  final String path;

  String get initSlash => '/$path';
}
