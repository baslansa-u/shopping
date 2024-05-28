part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final Map<BrandDataModel, int> productCounts;

  const CounterState({required this.productCounts});

  @override
  List<Object?> get props => [productCounts];

  CounterState copyWith({Map<BrandDataModel, int>? productCounts}) {
    return CounterState(
      productCounts: productCounts ?? this.productCounts,
    );
  }
}
