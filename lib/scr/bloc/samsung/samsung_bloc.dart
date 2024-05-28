import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping/scr/models/samsung_model.dart';
import 'package:shopping/scr/services/brands_service.dart';

part 'samsung_event.dart';
part 'samsung_state.dart';

class SamsungBloc extends Bloc<SamsungEvent, SamsungState> {
  SamsungBloc() : super(SamsungInitial()) {
    on<SamsungInitialFetch>(_SamsungInitialFetch);
  }

  FutureOr<void> _SamsungInitialFetch(
      SamsungInitialFetch event, Emitter<SamsungState> emit) async {
    emit(BrandsLoadingState());
    try {
      List<BrandsSamsungDataModel> samsung =
          await BrandSamsungServices.fetchData();
      emit(SamsungLoadingSuccessState(samsung: samsung));
    } catch (e) {
      emit(BrandsLoadingFailure(error: e.toString()));
    }
  }
}
