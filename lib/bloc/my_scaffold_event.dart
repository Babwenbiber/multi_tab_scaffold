part of 'my_scaffold_bloc.dart';

@immutable
class MyScaffoldEvent extends Equatable{
  final ScaffoldProperties scaffoldProperties;

  const MyScaffoldEvent(this.scaffoldProperties);

  @override
  List<Object?> get props => [];
}
