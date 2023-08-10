import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable  {

  final String message ;
 const Failure({
    required this.message
} );
@override
  // TODO: implement props
  List<Object?> get props => [
    message
];

}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

}
class DatabaseFailure extends Failure  {
  const DatabaseFailure({required super.message});

}