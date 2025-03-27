enum VgcScreenEnum {
  coffees('/coffees'),
  favorites('/favorites'),
  detailFavorite('/favorites/detailFavorite');

  const VgcScreenEnum(this.path);
  final String path;

  String get initSlash => '/$path';

  String getSegments(int number) {
    final parts = path.split('/');
    if (number <= parts.length) {
      return parts.getRange(parts.length - number, parts.length).join('/');
    }
    return '';
  }
}
