part of 'navstate_bloc.dart';

@immutable
class NavstateEvent extends Equatable{
  final NavbarState navbarState;

  const NavstateEvent(this.navbarState);

  @override
  List<Object?> get props => [];
}
