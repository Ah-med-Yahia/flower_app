import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/presentation/view_model/navigation_events.dart';

class HomeScreenStates {
  BaseState<HomeResponseEntity>? homeScreenStates;
  NavigationEvents? navigationEvent;

  HomeScreenStates({this.homeScreenStates, this.navigationEvent});

  HomeScreenStates copyWith({
    BaseState<HomeResponseEntity>? homeScreenStates,
    NavigationEvents? navigationEvent,
  }) {
    return HomeScreenStates(
      homeScreenStates: homeScreenStates ?? this.homeScreenStates,
      navigationEvent: navigationEvent,
    );
  }
}
