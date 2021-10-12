import 'package:bloc/bloc.dart';
import 'package:cupertino_nav/util/navbar_state.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'navstate_event.dart';
part 'navstate_state.dart';

class NavstateBloc extends Bloc<NavstateEvent, NavstateAbstractState> {
  NavstateBloc() : super(NavstateInitial()) {
    on<NavstateEvent>((event, emit) {
      if (state is NavstateState) {
        emit((state as NavstateState).copyWith(state: event.navbarState));
      } else {
        emit(NavstateState(navbarState: event.navbarState));
      }
    });
  }
}
