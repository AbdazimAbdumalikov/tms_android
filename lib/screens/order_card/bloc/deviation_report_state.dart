part of 'deviation_report_bloc.dart';

abstract class DeviationReportState {}

class DeviationReportInitial extends DeviationReportState {}

class DeviationReportLoading extends DeviationReportState {}

class DeviationReportSuccess extends DeviationReportState {}

class DeviationReportFailure extends DeviationReportState {
  final AppError error;

  DeviationReportFailure({required this.error});
}
