
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/components/components.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder:  (context,state) {return  Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller:searchController ,
                keyboardType:TextInputType.text ,
                validator: (String value)
                {
                  if(value.isEmpty)
                  {
                    return "search must not be empty" ;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "search",
                  prefixIcon: Icon(Icons.search)  ,

                ),

                onChanged: (value)
                {
                  NewsCubit.get(context).getSearch(value);
                },
              ),
            ),

        ConditionalBuilder
        (
        condition:NewsCubit.get(context).search.length >0  ,
        builder: (context) =>
        ListView.separated
        (
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>buildArticleItem(NewsCubit.get(context).search[index],context),
        separatorBuilder: (context, index) => Container(
        width: double.infinity ,
        height: 0.5,
        color: Colors.grey,
        ), itemCount: 18 ,
        ),
        fallback: (context)=> Center(child: CircularProgressIndicator())
        ),
          ],
        ),
      );
      },
    );


  }
}
