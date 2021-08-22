
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Network/remote/dio_helper.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
import 'package:newsapp/modules/sports/sport_screen.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<BottomNavigationBarItem> bottomNavItem =
  [
    BottomNavigationBarItem(
      label: "Business",
      icon:Icon(Icons.business),
    ),
    BottomNavigationBarItem(
      label: "Sport",
        icon:Icon(Icons.sports,),
    ),
    BottomNavigationBarItem(
      label: "Science",
      icon:Icon(Icons.science,),
    ),

  ];


  List <Widget> screens =
  [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  List<String> titles =
  [
    "Business",
    "Sports",
    "Science",
    "Settting",
  ];

  List <dynamic> business = [];
  List <dynamic> sports = [];
  List <dynamic> science = [];

  void changeBottomNaBar(int index)
  {
     currentIndex= index;
     if(index == 0)getBusiness();
     if(index == 1)getSports();
     if(index == 2)getScience();

    emit(NewsBotoomNavStates());
  }

  void getBusiness()
  {
    emit(NewsLoadingBusinessStates());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country":"eg" ,
        "category":"business",
        "apikey":"65f7f556ec76449fa7dc7c0069f040ca",
      },
    ).then((value)
    {
      business = value.data["articles"];
      print(business[0]['title']);
      emit(NewsGetBusinessStates());
    });
  }
  void getSports()
  {
    emit(NewsLoadingSportsStates());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country":"eg" ,
          "category":"sports",
          "apikey":"65f7f556ec76449fa7dc7c0069f040ca",
        },
      ).then((value)
      {
        sports = value.data["articles"];
        print(sports[0]['title']);
        emit(NewsGetSportsStates());
      });
    }else { emit(NewsGetSportsStates());}

  }

  void getScience()
  {
    emit(NewsLoadingScienceStates());
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "science",
          "apikey": "65f7f556ec76449fa7dc7c0069f040ca",
        },
      ).then((value) {
        science = value.data["articles"];
        emit(NewsGetScienceStates());
      });
  }

  List<dynamic> search = [] ;

  void getSearch(String value)
  {
    emit(NewsLoadingSearchStates());

    DioHelper.getData(
      url: "v2/everything",
      query: {
        "q": "$value",
        "apikey": "65f7f556ec76449fa7dc7c0069f040ca",
      },
    ).then((value) {
      search= value.data["articles"];
      emit(NewsGetSearchStates());
    });
  }

}