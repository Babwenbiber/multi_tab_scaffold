part of 'navstate_bloc.dart';

@immutable
abstract class NavstateAbstractState extends Equatable {
  const NavstateAbstractState();
}

class NavstateInitial extends NavstateAbstractState {
  @override
  List<Object?> get props => [];
}

@immutable
class NavstateState extends NavstateAbstractState {
  final NavbarState navbarState;
  final bool init;

  const NavstateState({required this.navbarState, this.init = false}) : super();

  NavstateState copyWith({NavbarState? state, bool? init}) {
    return NavstateState(
        navbarState: state ?? navbarState, init: init ?? this.init);
  }

  @override
  List<Object?> get props => [navbarState];
}
