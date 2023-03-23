import 'package:bloc/bloc.dart';

class SidebarMenuCubit extends Cubit<int> {
  SidebarMenuCubit({this.init = 1}) : super(init);
  int init;

  void changeState(param) => emit(init = param);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
