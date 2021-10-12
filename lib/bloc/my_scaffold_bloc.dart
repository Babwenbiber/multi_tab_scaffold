import 'package:bloc/bloc.dart';
import 'package:cupertino_nav/util/scaffold_properties.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'my_scaffold_event.dart';
part 'my_scaffold_state.dart';

class MyScaffoldBloc extends Bloc<MyScaffoldEvent, MyAbstractScaffoldState> {
  MyScaffoldBloc() : super(MyScaffoldInitialState()) {
    on<MyScaffoldEvent>((event, emit) {
      if (state is MyScaffoldState) {
        emit((state as MyScaffoldState).copyWith(state: event.scaffoldProperties));
      } else {
        emit(MyScaffoldState(scaffoldProperties: event.scaffoldProperties));
      }
    });
  }
}
