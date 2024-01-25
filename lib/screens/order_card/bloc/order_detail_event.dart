part of 'order_detail_bloc.dart';

@immutable
abstract class OrderDetailEvent {}

class OrderDetailEventInitial extends OrderDetailEvent {
  final int orderId;

  OrderDetailEventInitial(this.orderId);
}

class OrderDetailEventStop extends OrderDetailEvent {
  final String cause;
  final int pointId;
  final UserDTO? emptyDriver;

  OrderDetailEventStop({required this.pointId, required this.cause, this.emptyDriver});
}

class OrderDetailEventAccident extends OrderDetailEvent {
  final String message;

  OrderDetailEventAccident({required this.message});
}

class OrderDetailEventDeviation extends OrderDetailEvent {
  final int orderId;
  final int pointId;
  // final String message;
  final double lat;
  final double lng;

  OrderDetailEventDeviation({
    required this.orderId,
    required this.pointId,
    // required this.message,
    required this.lat,
    required this.lng,
  });
}

class OrderDetailEventStart extends OrderDetailEvent {}

class OrderDetailEventResume extends OrderDetailEvent {}

class OrderDetailRefreshEvent extends OrderDetailEvent {
  final int orderId;

  OrderDetailRefreshEvent({
    required this.orderId,
  });
}

class OrderDetailEventReset extends OrderDetailEvent {}

class OrderDetailEventOrderDecline extends OrderDetailEvent {
  final int orderId;

  OrderDetailEventOrderDecline({
    required this.orderId,
  });
}

class OrderDetailEventFinishOrder extends OrderDetailEvent {
  final int orderId;

  OrderDetailEventFinishOrder({
    required this.orderId,
  });
}