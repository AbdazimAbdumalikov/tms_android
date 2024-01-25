import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/order_dto.dart';
import 'package:europharm_flutter/network/models/point_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'deviation_report_event.dart';
part 'deviation_report_state.dart';

class DeviationReportBloc extends Bloc<DeviationReportEvent, DeviationReportState> {
  DeviationReportBloc(this.repository) : super(DeviationReportInitial()) {
    on<DeviationReportEvent>(_sendDeviationReport);
  }

  final GlobalRepository repository;
  late OrderDTO currentOrder;
  late PointDTO point;
  int? orderId;
  int? pointId;

  @override
  Future<void> _sendDeviationReport(
      DeviationReportEvent event,
      Emitter<DeviationReportState> emit,
      ) async {
    emit(DeviationReportLoading());

    try {
      final currentPosition = await Geolocator.getCurrentPosition();
      final lat = currentPosition.latitude;
      final lng = currentPosition.longitude;

      // Замените OrderRepository на ваш репозиторий для работы с заказами
      final response = await repository.reportDeviation(
        orderId: orderId!,
        pointId: point.id!,
        // message: (event as ReportDeviation).message,
        lat: lat,
        lng: lng,
      );

      print('Данные отправлены на сервер:');
      print('Номер заказа: ${orderId}');
      print('Номер точки: ${point.id}');
      // print('Сообщение: ${event.message}');
      print('Координаты (lat, lng): ($lat, $lng)');
      print('Статус кода ответа: ${response.statusCode}');

      // Проверьте успешность отправки отчета
      if (response.statusCode == 200) {
        emit(DeviationReportSuccess()); // Отправьте соответствующее состояние при успехе
      } else {
        emit(
          DeviationReportFailure(
            error: AppError(message: "Ошибка при отправке отчета о ДТП"),
          ),
        ); // Отправьте состояние ошибки в случае неудачи
      }
    } catch (e) {
      emit(
        DeviationReportFailure(
          error: AppError(message: "Ошибка при отправке отчета о ДТП"),
        ),
      ); // Обработайте ошибку и отправьте соответствующее состояние
    }
  }
}
