part of 'samsung_bloc.dart';

abstract class SamsungEvent extends Equatable {
  const SamsungEvent();

  @override
  List<Object> get props => [];
}

class SamsungInitialFetch extends SamsungEvent {}
