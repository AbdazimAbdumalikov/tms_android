part of 'deviation_report_bloc.dart';

abstract class DeviationReportEvent {}

class ReportDeviation extends DeviationReportEvent {
  final String message;

  ReportDeviation({required this.message});
}
