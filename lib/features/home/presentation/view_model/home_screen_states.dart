import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/presentation/view_model/ui_events.dart';

class HomeScreenStates {
  BaseState<HomeResponseEntity>? homeScreenStates;
  UIEvents? navigationEvent;
  bool isSearching;

  HomeScreenStates({
    this.homeScreenStates,
    this.navigationEvent,
    this.isSearching = false,
  });

  HomeScreenStates copyWith({
    BaseState<HomeResponseEntity>? homeScreenStates,
    UIEvents? navigationEvent,
    bool? isSearching,
  }) {
    return HomeScreenStates(
      homeScreenStates: homeScreenStates ?? this.homeScreenStates,
      navigationEvent: navigationEvent,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
