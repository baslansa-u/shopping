import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping/scr/models/brands_model.dart';
part 'select_event.dart';
part 'select_state.dart';

class SelectBloc extends Bloc<SelectEvent, SelectState> {
  SelectBloc() : super(const SelectState([])) {
    on<Add>(_Add);
  }

  void _Add(Add event, Emitter<SelectState> emit) {
    final List<BrandDataModel> updatedSelection =
        List<BrandDataModel>.from(state.selectedItems);

    final index =
        updatedSelection.indexWhere((item) => item.id == event.item.id);
    updatedSelection.removeAt(index);
    emit(SelectState(updatedSelection));
  }
}
