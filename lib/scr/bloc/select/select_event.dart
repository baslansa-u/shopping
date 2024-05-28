part of 'select_bloc.dart';

abstract class SelectEvent extends Equatable {
  const SelectEvent();

  @override
  List<Object> get props => [];
}

// class ToggleSelection extends SelectEvent {
//   final BrandDataModel item;
//   const ToggleSelection(this.item);
//   @override
//   List<Object> get props => [item];
// }

class Add extends SelectEvent {
  final BrandDataModel item;

  const Add(this.item);
  @override
  List<Object> get props => [item];
}
