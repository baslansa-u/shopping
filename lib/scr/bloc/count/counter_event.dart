part of 'counter_bloc.dart';

class CounterEvent {}

class AddProductEvent extends CounterEvent {
  final BrandDataModel product;

  AddProductEvent(this.product);
}

class RemoveProductEvent extends CounterEvent {
  final BrandDataModel product;

  RemoveProductEvent(this.product);
}
