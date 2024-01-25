part of 'file_signing_bloc.dart';

@immutable
abstract class FileSigningEvent {}

class OrderDocumentsInitialEvent extends FileSigningEvent {}

class OrderDocumentsReadFileEvent extends FileSigningEvent {
  final String url;
  OrderDocumentsReadFileEvent({required this.url});
}

class OrderDocumentsSignEvent extends FileSigningEvent {
  final String url;
  OrderDocumentsSignEvent({required this.url});
}