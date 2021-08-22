
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return
      BlocConsumer<NewsCubit,NewsStates> (
      listener: (context,state){},
        builder: (context,state)
       {
          return ConditionalBuilder
            (
          condition:NewsCubit.get(context).business.length >0  ,
          builder: (context) =>
              ListView.separated
                (
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>buildArticleItem(NewsCubit.get(context).business[index],context),
                separatorBuilder: (context, index) => Container(
                  width: double.infinity ,
                  height: 0.5,
                  color: Colors.grey,
              ), itemCount: 18 ,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator())
        );
        },
        );
  }
}
