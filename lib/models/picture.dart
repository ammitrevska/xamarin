class Picture{
  int id;
  String title;
  final String imageUrl;
  final String imageThumbnail;

  Picture({
    this.id = 0,
    required this.title,
    required this.imageUrl,
    required this.imageThumbnail
  });

  void updateTitle(String newTitle) {
    title = newTitle;
  }
}