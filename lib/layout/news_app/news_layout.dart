

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Network/remote/dio_helper.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/search/search.dart';

import 'cubit/cubit.dart';
import 'cubit_theme/cubit_theme.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return
       BlocConsumer<NewsCubit, NewsStates>(
        listener: ( context, state) {  },
        builder: ( context, state)
        {
          return Scaffold(
          appBar: AppBar(
            title:Text("News App"),
            actions: [IconButton(
                onPressed:()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),
                  ),
                  );
                },
                icon: Icon(Icons.search)
            ),
              IconButton(
                  onPressed: ()
                  {
                   ThemeCubit.get(context).changeAppMode();
                  },
                  icon:Icon (Icons.brightness_4_outlined,),
              ),
            ],
          ),


          body:NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex] ,

          bottomNavigationBar: BottomNavigationBar(
            currentIndex:NewsCubit.get(context).currentIndex ,
            onTap:(index)
            {
              NewsCubit.get(context).changeBottomNaBar(index);
            },
            items: NewsCubit.get(context).bottomNavItem,

          ),

        );
          },

    );
  }
}
