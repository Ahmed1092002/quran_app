part of 'elquran_cubit.dart';

@immutable
abstract class ElquranState {}

class ElquranInitial extends ElquranState {}
class ElquranGetJusSuccessState extends ElquranState {}
class ElquranGetJusErrorState extends ElquranState {}
class ElquranGetJusLoadingState extends ElquranState {}
class ElquranGetAudioSurahSuccessState extends ElquranState {}
class ElquranGetAudioSurahErrorState extends ElquranState {}
class ElquranGetAudioSurahLoadingState extends ElquranState {}
