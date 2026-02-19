import 'package:flower_app/config/base_state/base_state.dart';

class LogoutStates {
  BaseState<void>? logoutState;

  LogoutStates({this.logoutState});

  LogoutStates copyWith({BaseState<void>? logoutState}) {
    return LogoutStates(logoutState: logoutState);
  }
}
