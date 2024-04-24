class Picture{
  String title;
  final String imageUrl;
  final String imageThumbnail;

  Picture({
    required this.title,
    required this.imageUrl,
    required this.imageThumbnail
  });

  void updateTitle(String newTitle) {
    title = newTitle;
  }
}