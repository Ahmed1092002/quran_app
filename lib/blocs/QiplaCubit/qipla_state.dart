part of 'qipla_cubit.dart';

@immutable
abstract class QiplaState {}

class QiplaInitial extends QiplaState {}

class QiplaLoading extends QiplaState {}
class QiplaSuccess extends QiplaState {
  final double qiblaDirection;
  QiplaSuccess(this.qiblaDirection);
}
