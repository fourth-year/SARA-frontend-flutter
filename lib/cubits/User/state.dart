abstract class UserSates{}
class UserInitialState extends UserSates{}

class WalletLoadingState extends UserSates{}
class WalletSuccessState extends UserSates{}
class WalletErrorState extends UserSates{}

class DonationLoadingState extends UserSates{}
class DonationSuccessState extends UserSates{}
class DonationErrorState extends UserSates{
String mes;
  DonationErrorState({required this.mes});
}

class adoptionLoadingState extends UserSates{}
class adoptionSuccessState extends UserSates{}
class adoptionErrorState extends UserSates{}


class sponcershipsLoadingState extends UserSates{}
class sponcershipsSuccessState extends UserSates{}
class sponcershipsErrorState extends UserSates{}

class sessionLoadingState extends UserSates{}
class sessionSuccessState extends UserSates{}
class sessionErrorState extends UserSates{}

class session_PSuccessState extends UserSates{}
class session_PErrorState extends UserSates{}

class session_UserSuccessState extends UserSates{}
class session_UserErrorState extends UserSates{}

class Changeselect extends UserSates{}