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
  int know = 0;
  int forgot = 0;
  bool firstTime = true;
  bool showEng = true;
  List<EngRuWordsEntity> list;

  Future<List<EngRuWordsEntity>> getAll() async {
    final savedWords = await repo.getAll();
    savedWords.shuffle(new Random(DateTime.now().millisecondsSinceEpoch));
    savedWords
        .sort((a, b) => a.later.compareTo(b.later) + a.show.compareTo(b.show));
    return savedWords;
  }

  void init() async {
    list = await getAll();
  }

  void successGoNext() {
    final item = list[count];
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
    final item = list[count];
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
    final item = list[count];
    item.show = item.show + 1;
    _saveItem(item);

    listSize = words.length;
    if (count < listSize) {
      if (showEng) {
        topText = item.eng.toLowerCase();
      } else {
        topText = item.ru.toLowerCase();
      }
      bottomText = "";
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
}
