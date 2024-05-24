import '../models/category_news_model.dart';
import '../models/newschannelHeadlineModel.dart';
import '../repositories/news_repository.dart';

class NewsViewModel{
  final _rep=NewsRepository();
  Future<NewsChannelHeadlineModel>fetchNewsChannelHeadlineApi(String name) async{
    final response=await _rep.fetchNewsChannelHeadlineApi(name);
    return response;
}
Future<CategoriesNewModel> fetchCategoryNewsApi(String category)async{
    final response=await _rep.fetchCategoryNewsApi(category);
    return response;
}
}