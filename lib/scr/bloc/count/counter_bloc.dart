import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping/scr/models/brands_model.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(productCounts: {})) {
    on<AddProductEvent>(_onAddProductEvent);
    on<RemoveProductEvent>(_onRemoveProductEvent);
  }

  FutureOr<void> _onAddProductEvent(
      AddProductEvent event, Emitter<CounterState> emit) {
    final productCounts =
        Map<BrandDataModel, int>.from(state.productCounts); //สำเนา

    productCounts[event.product] = (productCounts[event.product] ?? 0) + 1;
    emit(state.copyWith(productCounts: productCounts));
  }

  FutureOr<void> _onRemoveProductEvent(
      RemoveProductEvent event, Emitter<CounterState> emit) {
    final productCountsa =
        Map<BrandDataModel, int>.from(state.productCounts); // สำเนา

// ตรวจสอบว่าจำนวนสินค้าก่อนหน้าที่ลบออกไป
    if ((productCountsa[event.product] ?? 0) > 1) {
      productCountsa[event.product] = (productCountsa[event.product] ?? 0) - 1;
      emit(state.copyWith(productCounts: productCountsa));
    } else {
      productCountsa.remove(event.product);
      emit(state.copyWith(productCounts: productCountsa));
    }
  }
}
