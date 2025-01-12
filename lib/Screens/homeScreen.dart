import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/Screens/categoryScreen.dart';
import 'package:newsapp/Screens/news_detailScreen.dart';
import 'package:newsapp/models/newschannelHeadlineModel.dart';
import 'package:newsapp/view-model/news_view_model.dart';

import '../models/category_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList{bbcNews,Bloomberg,Fortune,reuters,cnn,argaam}
class _HomeScreenState extends State<HomeScreen> {

  NewsViewModel newsViewModel=NewsViewModel();
  final format=DateFormat("MMMM , dd, yyyy");
  String name='bbc-news';
  FilterList? selectedItem;
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width*1;
    final height=MediaQuery.sizeOf(context).height*1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
            },
            icon: Image.asset("assets/images/category_icon.png",height: 30,width: 30,)),
        title: Text('News',style: GoogleFonts.poppins(fontSize:24,fontWeight:FontWeight.w700),),
      centerTitle: true,
        actions: [
        PopupMenuButton<FilterList>(
        initialValue: selectedItem,
        onSelected: (FilterList item){
          if(FilterList.bbcNews.name==item.name){
            name='bbc-news';
          }
           if(FilterList.reuters.name==item.name){
            name='reuters';
          }
           if(FilterList.Fortune.name==item.name){
            name='Fortune';
          }
           if(FilterList.cnn.name==item.name){
            name='cnn';
          }
           if(FilterList.argaam.name==item.name){
            name='argaam';
          }
           if(FilterList.Bloomberg.name==item.name){
            name='Bloomberg';
          }
     setState(() {

     });

        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
          const PopupMenuItem<FilterList>(
            value: FilterList.bbcNews,
            child: Text('bbcNews'),
          ),
          const PopupMenuItem<FilterList>(
            value: FilterList.argaam,
            child: Text('argaam'),
          ),
          const PopupMenuItem<FilterList>(
            value: FilterList.Bloomberg,
            child: Text('Bloomberg'),
          ),
          const PopupMenuItem<FilterList>(
            value: FilterList.cnn,
            child: Text('cnn'),
          ),
          const PopupMenuItem<FilterList>(
            value: FilterList.Fortune,
            child: Text('Fortune'),

          ),
          const PopupMenuItem<FilterList>(
            value: FilterList.reuters,
            child: Text('reuters'),
          ),
        ],
    ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: width,
                height: height*0.55,
                child: FutureBuilder<NewsChannelHeadlineModel>(
                  future: newsViewModel.fetchNewsChannelHeadlineApi(name),
                  builder: (BuildContext context, snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(
                              child: SpinKitCircle(size: 40,color: Colors.blue,),
                            );
                          }
                          else{
                             return ListView.builder(
                               scrollDirection: Axis.horizontal,
                                 itemCount:snapshot.data!.articles!.length ,
                                 itemBuilder: (context,index){
                                 DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                                   return InkWell(
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
                                     child: SizedBox(
                                       child: Stack(
                                         alignment: Alignment.center,
                                         children: [
                                           Container(
                                             height:height*0.6,
                                             width: width*0.9,
                                             padding: EdgeInsets.symmetric(
                                               horizontal: height*0.02,
                                     
                                             ),
                                             child: ClipRRect(
                                               borderRadius: BorderRadius.circular(15),
                                               child: CachedNetworkImage(
                                                 imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                                 fit: BoxFit.cover,
                                                 placeholder: (context,url)=>Container(child: spinKit2,),
                                                 errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.red,),
                                               ),
                                             ),
                                           ),
                                           Positioned(
                                             bottom: 20,
                                             child: Card(
                                               elevation: 5,
                                               color: Colors.white,
                                               shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(12),
                                     
                                               ),
                                               child: Padding(
                                                 padding: const EdgeInsets.all(15),
                                                 child: Container(
                                                   height: height*0.22,
                                                   alignment: Alignment.bottomCenter,
                                                   child: Column(
                                                     mainAxisAlignment: MainAxisAlignment.center,
                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       Container(
                                                         width: width*0.7,
                                                         child: Text(snapshot.data!.articles![index].title.toString(),
                                                           maxLines: 2,
                                                           overflow: TextOverflow.ellipsis,
                                     
                                                           style: GoogleFonts.poppins(fontSize:17,fontWeight:FontWeight.bold),),
                                                       ),
                                                       Spacer(),
                                                       Container(
                                                         width: width*0.7,
                                                         child: (
                                                             Row(
                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                               children: [
                                                                 Text( snapshot.data!.articles![index].source!.name.toString(),  maxLines: 2,
                                                                   overflow: TextOverflow.ellipsis,
                                     
                                                                   style: GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w700),),
                                                                 Text(format.format(dateTime),  maxLines: 2,
                                                                   overflow: TextOverflow.ellipsis,
                                     
                                                                   style: GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w500),)
                                                               ],
                                                             )
                                                         ),
                                                       )
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                   );
                             });
                          }
                  },

                ),
              ),
            ),
            FutureBuilder<CategoriesNewModel>(
              future: newsViewModel.fetchCategoryNewsApi('General'),
              builder: (BuildContext context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(size: 40,color: Colors.blue,),
                  );
                }
                else{
                  return ListView.builder(
        shrinkWrap: true,
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
          ],
        ),
      ),
    );
  }
}
const spinKit2= SpinKitFadingCircle(
  color: Colors.blue,
  size: 40,
);