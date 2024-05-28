part of 'apple_bloc.dart';

abstract class AppleState {}

class AppleInitial extends AppleState {}

class BrandsLoadingState extends AppleState {}

class AppleLoadingSuccessState extends AppleState {
  final List<BrandsAppleDataModel> apple;

  AppleLoadingSuccessState({required this.apple});
}

class BrandsLoadingFailure extends AppleState {
  final String error;
  BrandsLoadingFailure({required this.error});
}
