import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Screens/homeScreen.dart';
import 'package:newsapp/Screens/news_detailScreen.dart';
import 'package:newsapp/models/category_news_model.dart';
import 'package:newsapp/view-model/news_view_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NewsViewModel newsViewModel= NewsViewModel();
  final format=DateFormat('MMMM,dd,yyyy');
  String CategoryName='General';
  List<String>categoryList=[
    'general',
    'Entertainment',
    'Health',
    'Sports',
    'Technology',
    'Buisness'
  ];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width*1;
    final height=MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      appBar: AppBar(

      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount:categoryList.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: InkWell(
                        onTap: (){
                          CategoryName=categoryList[index];
                          setState(() {

                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:CategoryName==categoryList[index] ? Colors.blue:Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(child: Text(categoryList[index].toString(),style: GoogleFonts.poppins(fontSize:13,color:Colors.white),)),
                        ),
                        ),
                      ),
                    );
        }
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<CategoriesNewModel>(
                future: newsViewModel.fetchCategoryNewsApi(CategoryName),
                builder: (BuildContext context, snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(size: 40,color: Colors.blue,),
                    );
                  }
                  else{
                    return ListView.builder(

                        itemCount:snapshot.data!.articles!.length ,
                        itemBuilder: (context,index){
                          DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                         return Padding(
                           padding: const EdgeInsets.only(bottom: 15),
                           child: Row(
                             children: [
                               InkWell(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                                     newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                     newsTitle: snapshot.data!.articles![index].title.toString(),
                                     newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                     author: snapshot.data!.articles![index].author.toString(),
                                     description: snapshot.data!.articles![index].description.toString(),
                                     content: snapshot.data!.articles![index].content.toString(),
                                     source: snapshot.data!.articles![index].source!.name.toString(),)));
                                 },
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(15),
                                   child: CachedNetworkImage(
                                     imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                     fit: BoxFit.cover,
                                     height:height*0.18,
                                     width:width*0.3,
                                     placeholder: (context,url)=>Container(child: spinKit2,),
                                     errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.red,),
                                   ),
                                 ),
                               ),
                               Expanded(child: Container(
                                 height: height*0.18,
                                 padding: EdgeInsets.only(left: 15),
                                 child: Column(
                                   children: [

                                     Text(snapshot.data!.articles![index].title.toString(),
                                       maxLines: 3,
                                       overflow: TextOverflow.ellipsis,
                                       style: GoogleFonts.poppins(fontSize:14,color:Colors.black54,fontWeight:FontWeight.w400),),
                                    Spacer(),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(snapshot.data!.articles![index].source!.name.toString(),
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                           style: GoogleFonts.poppins(fontSize:10,color:Colors.black54,fontWeight:FontWeight.w700),),
                                         Text(format.format(dateTime),
                                           style: GoogleFonts.poppins(fontSize:10,color:Colors.black54,fontWeight:FontWeight.w700),)
                                          ],
                                     )

                                   ],
                                 ),
                               ))
                             ],
                           ),
                         );
                        });
                  }
                },
              
              ),
            ),

          ],

        ),
      )

    );
  }
}
