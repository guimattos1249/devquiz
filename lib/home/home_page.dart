import 'package:dev_quiz/core/core.dart';
import 'package:dev_quiz/home/home_controller.dart';
import 'package:dev_quiz/home/widgets/appbar/app_bar_widget.dart';
import 'package:dev_quiz/home/widgets/level_button/level_button_widget.dart';
import 'package:dev_quiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';

import 'home_state.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    // controller.state = HomeState.loading;
    controller.initOjbects();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
    // controller.state = HomeState.success;
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidGet(user: controller.user!),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LevelButtonWidget(
                    label: 'Fácil',
                  ),
                  LevelButtonWidget(
                    label: 'Médio',
                  ),
                  LevelButtonWidget(
                    label: 'Difícil',
                  ),
                  LevelButtonWidget(
                    label: 'Perito',
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: controller.quizzes
                      .map(
                        (e) => QuizCardWidget(
                          title: e.title,
                          percent: e.questionAnswered / e.questions.length,
                          completed:
                              '${e.questionAnswered}/${e.questions.length}',
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
