import 'package:flutter_bloc/flutter_bloc.dart';

class TodoMenuCubit extends Cubit {
  TodoMenuCubit({this.init = 1}) : super(init);
  int init;

  void changeState(param) => emit(init = param);

  @override
  void onChange(Change change) {
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
