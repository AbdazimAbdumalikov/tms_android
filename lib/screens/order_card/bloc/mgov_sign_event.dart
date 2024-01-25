import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// События
abstract class MgovSignEvent extends Equatable {
  const MgovSignEvent();
}

class MgovSignLaunchEvent extends MgovSignEvent {
  final int orderId;
  final int userId;

  const MgovSignLaunchEvent({
    required this.orderId,
    required this.userId,
  });

  @override
  List<Object?> get props => [orderId, userId];
}