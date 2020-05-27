import 'dart:math';

import 'package:owllangu/words.dart';
import 'package:owllangu/wordsRepo.dart';

class WordsViewModel {
  WordsViewModel._privateConstructor();

  static final WordsViewModel instance = WordsViewModel._privateConstructor();
  final repo = WordsRepo.instance;

  int count = 0;
  int listSize = 0;
  String topText = "";
  String bottomText = "";
  String currentStats = "";
  int know = 0;
  int forgot = 0;
  bool firstTime = true;
  bool showEng = true;
  List<EngRuWordsEntity> words;

  Future<List<EngRuWordsEntity>> getAll() async {
    final savedWords = await repo.getAll();
    savedWords.shuffle(new Random(DateTime.now().millisecondsSinceEpoch));
    print("savedWords before := $savedWords");
    savedWords.sort((a, b) => (a.know - a.later) - (b.know - b.later));
    print("savedWords:= $savedWords");
    return savedWords;
  }

  Future init() async {
    words = await getAll();
    _getNewItems();
  }

  void successGoNext() {
    final item = words[count];
    item.know = item.know + 1;
    _saveItem(item);

    count += 1;
    know += 1;
    _getNewItems();
  }

  void _saveItem(EngRuWordsEntity item) {
    repo.update(item);
  }

  void notSuccessGoNext() {
    final item = words[count];
    item.later = item.later + 1;
    _saveItem(item);

    forgot += 1;
    words.add(words[count]);
    count += 1;
    _getNewItems();
  }

  void changeLanguage() {
    showEng = !showEng;
    _getNewItems();
  }

  void _getNewItems() {
    listSize = words.length;
    if (count < listSize) {
      final item = words[count];
      item.show = item.know + item.later;
      _saveItem(item);

      if (showEng) {
        topText = item.eng.toLowerCase();
      } else {
        topText = item.ru.toLowerCase();
      }
      bottomText = "";
      currentStats = "${item.know}/${item.later}";
    } else {
      topText = "Thats all";
      bottomText = "Thats all";
    }
  }

  void showTranslation() {
    if (bottomText == "") {
      if (showEng) {
        bottomText = words[count].ru.toLowerCase();
      } else {
        bottomText = words[count].eng.toLowerCase();
      }
    } else {
      bottomText = "";
    }
  }

  void revert() {
    //ToDo криво работает тогда know и forgot
    if (count > 0) {
      count -= 1;
      _getNewItems();
    }
  }
}
