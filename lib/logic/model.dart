class NoteModel {
  int id;
  String title;
  String description;
  String createdAt;
  bool isBinned;

  NoteModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.isBinned});
}
