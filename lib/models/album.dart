class Photo {
  final String imageUrl;
  final String title;

  Photo(this.imageUrl, this.title);
}

class Album {
  final String title;
  final List<Photo> photos;

  Album(this.title, this.photos);
}
