part of 'my_scaffold_bloc.dart';

@immutable
abstract class MyAbstractScaffoldState extends Equatable {
  const MyAbstractScaffoldState();
}

class MyScaffoldInitialState extends MyAbstractScaffoldState {
  @override
  List<Object?> get props => [];
}

@immutable
class MyScaffoldState extends MyAbstractScaffoldState {
  final ScaffoldProperties scaffoldProperties;
  final bool init;

  const MyScaffoldState({required this.scaffoldProperties, this.init = false}) : super();

  MyScaffoldState copyWith({ScaffoldProperties? state, bool? init}) {
    return MyScaffoldState(
        scaffoldProperties: state ?? scaffoldProperties, init: init ?? this.init);
  }

  @override
  List<Object?> get props => [scaffoldProperties];
}
