part of 'emergency_cubit.dart';

@immutable
sealed class EmergencyState {}

class Loading extends EmergencyState {}

final class EmergencyInitial extends EmergencyState {}

class EmergencyAddedSuccessfully extends EmergencyState {}

class EmergencyAddedError extends EmergencyState {}

class AcceptEmergencySuccessfully extends EmergencyState {}

class AcceptEmergencyError extends EmergencyState {}

class RejectEmergencySuccessfully extends EmergencyState {}

class RejectEmergencyError extends EmergencyState {}

class GetAllEmergenciesSuccessfully extends EmergencyState {}

class GetAllEmergenciesError extends EmergencyState {}

class UpdateEmergencyStatusSuccessfully extends EmergencyState {}

class UpdateEmergencyStatusError extends EmergencyState {}

class DeleteEmergencySuccessfully extends EmergencyState {}

class DeleteEmergencyError extends EmergencyState {}
