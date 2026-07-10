enum PracticeType {
  meditation,
  chanting,
  scripture,
  focus;

  String get label => switch (this) {
        PracticeType.meditation => '禪修',
        PracticeType.chanting => '念佛',
        PracticeType.scripture => '誦經',
        PracticeType.focus => '專注',
      };
}
