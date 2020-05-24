import 'package:owllangu/api_helper.dart';
import 'package:owllangu/database_helper.dart';
import 'package:owllangu/words.dart';

class WordsRepo {
  // make this a singleton class
  WordsRepo._privateConstructor();

  static final WordsRepo instance = WordsRepo._privateConstructor();

  final dbHelper = DatabaseHelper.instance;
  final api = ApiHelper.instance;

  void _insert(EngRuWords word) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnEng: word.eng,
      DatabaseHelper.columnRus: word.ru,
      DatabaseHelper.columnShowed: word.show,
      DatabaseHelper.columnKnow: word.know,
      DatabaseHelper.columnLater: word.later,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  Future<List<EngRuWordsEntity>> getAll() async {
    final savedWords = await dbHelper.queryAllWords();
    final networkWords = api.queryAllWords();
    print ("savedWords:= $savedWords");
    print ("networkWords:= $networkWords");

    //ToDo fix here> тут разные объекты в ссетах
    if (savedWords.length == networkWords.length) {
      return savedWords;
    } else {
      final savedSet = savedWords.toSet();
      final networkSet = networkWords.toSet();
      final diff = networkSet.difference(savedSet);
      diff.forEach((element) {
        print ("_insert:= $element");
        _insert(element);
      });
      return await dbHelper.queryAllWords();
    }
  }

  void update(EngRuWordsEntity word) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: word.id,
      DatabaseHelper.columnEng: word.eng,
      DatabaseHelper.columnRus: word.ru,
      DatabaseHelper.columnShowed: word.show,
      DatabaseHelper.columnKnow: word.know,
      DatabaseHelper.columnLater: word.later,
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete(EngRuWordsEntity word) async {
    final id = word.id;
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

}
