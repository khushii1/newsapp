import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:newsapp/models/newschannelHeadlineModel.dart';

import '../models/category_news_model.dart';
class NewsRepository{
  Future<NewsChannelHeadlineModel>fetchNewsChannelHeadlineApi(String name)async{
    String url='https://newsapi.org/v2/top-headlines?sources=${name}&apiKey=a25e0d989ac44462a23767c3b94876a8';
    final response=await http.get(Uri.parse(url));
    print(response.body);
    if(response.statusCode==200){
        final body=jsonDecode(response.body);
        return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception("error");

  }
  Future<CategoriesNewModel>fetchCategoryNewsApi(String category)async{
    String url='https://newsapi.org/v2/everything?q=${category}&apiKey=a25e0d989ac44462a23767c3b94876a8';
    final response=await http.get(Uri.parse(url));
    print(response.body);
    if(response.statusCode==200){
      final body=jsonDecode(response.body);
      return CategoriesNewModel.fromJson(body);
    }
    throw Exception("error");
  }
}