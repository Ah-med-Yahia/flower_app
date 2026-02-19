import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/tabs/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/tabs/home/presentation/view_model/ui_events.dart';

class HomeScreenStates {
  BaseState<HomeResponseEntity>? homeScreenStates;
  UIEvents? navigationEvent;

  HomeScreenStates({this.homeScreenStates, this.navigationEvent});

  HomeScreenStates copyWith({
    BaseState<HomeResponseEntity>? homeScreenStates,
    UIEvents? navigationEvent,
  }) {
    return HomeScreenStates(
      homeScreenStates: homeScreenStates ?? this.homeScreenStates,
      navigationEvent: navigationEvent,
    );
  }
}
