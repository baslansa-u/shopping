// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shopping/scr/models/brands_model.dart';

// part 'cart_event.dart';
// part 'cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   CartBloc() : super(CartState()) {
//     on<IncrementQuantity>((event, emit) {
//       final updatedItems = Map<BrandDataModel, int>.from(state.items);
//       updatedItems[event.item] = (updatedItems[event.item] ?? 0) + 1;
//       emit(state.copyWith(items: updatedItems));
//     });

//     on<DecrementQuantity>((event, emit) {
//       final updatedItems = Map<BrandDataModel, int>.from(state.items);
//       if (updatedItems.containsKey(event.item) &&
//           updatedItems[event.item]! > 0) {
//         updatedItems[event.item] = updatedItems[event.item]! - 1;
//         if (updatedItems[event.item] == 0) {
//           updatedItems.remove(event.item);
//         }
//       }
//       emit(state.copyWith(items: updatedItems));
//     });
//   }
// }
