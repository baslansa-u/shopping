import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping/scr/models/apple_model.dart';
import 'package:shopping/scr/services/brands_service.dart';

part 'apple_event.dart';
part 'apple_state.dart';

class AppleBloc extends Bloc<AppleEvent, AppleState> {
  AppleBloc() : super(AppleInitial()) {
    on<AppleInitialFetch>(_AppleInitialFetch);
  }

  FutureOr<void> _AppleInitialFetch(
      AppleInitialFetch event, Emitter<AppleState> emit) async {
    emit(BrandsLoadingState());
    try {
      List<BrandsAppleDataModel> apple = await BrandAppleServices.fetchData();
      emit(AppleLoadingSuccessState(apple: apple));
    } catch (e) {
      emit(BrandsLoadingFailure(error: e.toString()));
    }
  }
}
