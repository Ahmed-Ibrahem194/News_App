import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/Network/local/cash_helper.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/layout/news_app/cubit_theme/state_theme.dart';

class ThemeCubit extends Cubit <StatesTheme>
{
  ThemeCubit() : super(initialStatesTheme());

 static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool fromShared})
  {
    if(fromShared != null)
      {
      isDark = fromShared;
      emit(NewsChangeAppModeStates());
      }
    else{
          isDark = !isDark;
          CashHelper.putData(key: "isDark", value: isDark).then((value)
          {
          emit(NewsChangeAppModeStates());
          });
          }
  }
}