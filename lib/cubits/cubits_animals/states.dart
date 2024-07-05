// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AnimalStates {}

class AnimalInitialState extends AnimalStates {}

class AnimalLoadingState extends AnimalStates {}

class GetAnimalSuccessState extends AnimalStates {}
class GetAnimalErrorState extends AnimalStates {}

class GetCatsSuccessState extends AnimalStates {}
class GetCatsErrorState extends AnimalStates {}

class AddAnimalSuccessState extends AnimalStates {}
class AddAnimalErrorState extends AnimalStates {}

class DeleteAnimalSuccessState extends AnimalStates {}
class DeleteAnimalErrorState extends AnimalStates {}

class GetAnimalByIdSuccessState extends AnimalStates {}
class GetAnimalByIdErrorState extends AnimalStates {}

class TypeAnimalState extends AnimalStates {}
class DepAnimalState extends AnimalStates {}
class DateAnimalState extends AnimalStates {}
class HealthAnimalState extends AnimalStates {}

class UpdateAnimalSuccessState extends AnimalStates {}
class UpdateAnimalErrorState extends AnimalStates {}



class FeedingSuccessState extends AnimalStates {}
class  FeedingErrorState extends AnimalStates {}

class CanFeedingSuccessState extends AnimalStates {}
class  CanFeedingErrorState extends AnimalStates {}


class vaccinationSuccessState extends AnimalStates {}
class  vaccinationErrorState extends AnimalStates {}

class CanvaccinationSuccessState extends AnimalStates {}
class  CanvaccinationErrorState extends AnimalStates {}

class CheckState extends AnimalStates {}


class adoptionsLoadingState extends AnimalStates {}
class adoptionsSuccessState extends AnimalStates {}
class adoptionsErrorState extends AnimalStates {}


class sponcershipLoadingState extends AnimalStates {}
class sponcershipSuccessState extends AnimalStates {}
class sponcershipErrorState extends AnimalStates {
  late dynamic error;
  sponcershipErrorState(this.error);

}