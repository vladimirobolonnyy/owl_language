class EngRuWords {
  EngRuWords(this.eng, this.ru, this.show, this.know, this.later);

  final String eng;
  final String ru;
  final int show;
  final int know;
  final int later;

  @override
  String toString() => 'EngRuWords[$eng, $ru]';
}

class EngRuWordsEntity {
  EngRuWordsEntity(
      this.id, this.eng, this.ru, this.show, this.know, this.later);

  final String eng;
  final String ru;
  final int id;
  int show;
  int know;
  int later;

  @override
  String toString() => 'EngRuWordsEntity[$id, $eng, $ru, $show, $know, $later]';
}
