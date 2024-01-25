part of 'file_signing_bloc.dart';

@immutable
abstract class FileSigningState {}

class OrderDocumentsInitial extends FileSigningState {}

class OrderDocumentsIsLoadingState extends FileSigningState {}

class OrderDocumentsIsLoadedState extends FileSigningState {
  final List<OrderDocumentSign?> documents;

  OrderDocumentsIsLoadedState({required this.documents});
}

class OrderDocumentsIsLoadedSignState extends FileSigningState {
  final List<OrderDocumentSign?> document;

  OrderDocumentsIsLoadedSignState({required this.document});
}

class OrderDocumentsLoadingErrorState extends FileSigningState {
  final AppError error;

  OrderDocumentsLoadingErrorState({
    required this.error,
  });
}
