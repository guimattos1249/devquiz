import 'package:dev_quiz/home/home_repository.dart';
import 'package:dev_quiz/home/home_state.dart';
import 'package:dev_quiz/shared/models/quiz_model.dart';
import 'package:dev_quiz/shared/models/user_model.dart';
import 'package:flutter/foundation.dart';

class HomeController {
  ValueNotifier<HomeState> stateNotifier =
      ValueNotifier<HomeState>(HomeState.empty);

  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel> quizzes = [];

  final repository = HomeRepository();

  Future getUser() async {
    // state = HomeState.loading;
    user = await repository.getUser();
    // state = HomeState.success;
  }

  Future getQuizzes() async {
    // state = HomeState.loading;
    quizzes = await repository.getQuizzes();
    // state = HomeState.success;
  }

  void initOjbects() async {
    state = HomeState.loading;
    await getUser();
    await getQuizzes();
    state = HomeState.success;
  }
}
