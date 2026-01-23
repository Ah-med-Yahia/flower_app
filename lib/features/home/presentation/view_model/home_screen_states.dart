import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

class HomeScreenStates {
  BaseState<HomeResponseEntity>? homeScreenStates;

  HomeScreenStates({this.homeScreenStates});
  HomeScreenStates copyWith({BaseState<HomeResponseEntity>? homeScreenStates}) {
    return HomeScreenStates(
      homeScreenStates: homeScreenStates ?? this.homeScreenStates,
    );
  }
}
