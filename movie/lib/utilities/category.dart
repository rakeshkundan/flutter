class Category {
  String text;
  bool isChecked;
  bool isSeeAll;
  String searchId;
  Category({
    this.text = "Text",
    this.isChecked = false,
    this.isSeeAll = false,
    this.searchId = 'now_playing',
  });
  void toggleIsChecked() {
    isChecked = !isChecked;
  }

  void toggleIsSeeAll() {
    isSeeAll = !isSeeAll;
  }
}
