import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/home_response_entity.dart';
import 'ui_events.dart';

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
