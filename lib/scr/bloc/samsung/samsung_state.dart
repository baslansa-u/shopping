part of 'samsung_bloc.dart';

abstract class SamsungState {}

class SamsungInitial extends SamsungState {}

class BrandsLoadingState extends SamsungState {}

class SamsungLoadingSuccessState extends SamsungState {
  final List<BrandsSamsungDataModel> samsung;

  SamsungLoadingSuccessState({required this.samsung});
}

class BrandsLoadingFailure extends SamsungState {
  final String error;
  BrandsLoadingFailure({required this.error});
}
