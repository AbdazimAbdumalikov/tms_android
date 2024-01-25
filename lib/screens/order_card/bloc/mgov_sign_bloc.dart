// import 'package:equatable/equatable.dart';
// import 'package:europharm_flutter/network/models/dto_models/response/mgov_sign.dart';
// import 'package:europharm_flutter/network/repository/global_repository.dart';
// import 'package:europharm_flutter/screens/order_card/bloc/mgov_sign_event.dart';
// import 'package:europharm_flutter/screens/order_card/bloc/mgov_sign_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class MgovSignBloc extends Bloc<MgovSignEvent, MgovSignState> {
//   final GlobalRepository globalRepository; // Замените YourRepositoryClass на реальный класс репозитория
//
//   MgovSignBloc({required this.globalRepository}) : super(MgovSignInitial());
//
//   @override
//   Stream<MgovSignState> mapEventToState(MgovSignEvent event) async* {
//     if (event is MgovSignLaunchEvent) {
//       yield MgovSignLoading();
//
//       try {
//         final List<MgovSign> result = await globalRepository.getOrderDocuments(
//           orderId: event.orderId,
//           userId: event.userId,
//         );
//
//         // Дополнительная логика обработки, если необходимо
//
//         yield MgovSignSuccess();
//       } catch (e) {
//         yield MgovSignFailure(e.toString());
//       }
//     }
//   }
// }