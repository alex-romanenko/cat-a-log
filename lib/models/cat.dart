class Cat {
  final String id;
  final String url;

  Cat({this.id, this.url});

  // GET /images/search
  factory Cat.fromJsonSearch(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      url: json['url'],
    );
  }

  // GET /favourites
  factory Cat.fromJsonFavourite(Map<String, dynamic> json) {
    return Cat(
      id: json['image']['id'],
      url: json['image']['url'],
    );
  }
}
