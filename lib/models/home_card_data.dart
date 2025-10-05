class HomeCardData {
  String? title, icon, text1, text2, background;
  bool? locked;

  HomeCardData({
    this.title,
    this.icon,
    this.text1,
    this.background,
    this.text2,
    this.locked = false
  });
}