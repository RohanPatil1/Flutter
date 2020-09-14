import 'package:quizzinga/api_utils/code_vectors_utils.dart';
import 'package:quizzinga/data_model/category_model.dart';
import 'package:quizzinga/data_model/question_model.dart';
import 'package:quizzinga/screens/play_screen.dart';


//This will be used initState method so that we fetch stuff as soon as page is opened.
class UtilsRepository {
  ApiUtils apiUtils = ApiUtils();


  Future<List<Category>> get fetchCategoryList => apiUtils.fetchCategories();
  Future<List<Question>> get fetchQuestionList => apiUtils.fetchQuestions();
}
