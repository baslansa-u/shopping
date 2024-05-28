part of 'select_bloc.dart';

class SelectState extends Equatable {
  final List<BrandDataModel> selectedItems;

  const SelectState(this.selectedItems);

  @override
  List<Object> get props => selectedItems;
}
