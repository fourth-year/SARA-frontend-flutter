abstract class UserSates{}
class UserInitialState extends UserSates{}

class WalletLoadingState extends UserSates{}
class WalletSuccessState extends UserSates{}
class WalletErrorState extends UserSates{}

class DonationLoadingState extends UserSates{}
class DonationSuccessState extends UserSates{}
class DonationErrorState extends UserSates{}