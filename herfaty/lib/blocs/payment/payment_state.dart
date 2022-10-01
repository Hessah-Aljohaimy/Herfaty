part of 'payment_bloc.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState extends Equatable {
  PaymentStatus status;
  final CardFieldInputDetails cardFieldInputDetails;

  PaymentState({
    this.status = PaymentStatus.initial,
    this.cardFieldInputDetails = const CardFieldInputDetails(complete: false),
  });

  PaymentState copyWith({
    PaymentStatus? status,
    CardFieldInputDetails? cardFieldInputDetails,
  }) {
    return PaymentState(
      status: status ?? this.status,
      cardFieldInputDetails:
          cardFieldInputDetails ?? this.cardFieldInputDetails,
    );
  }

  @override
  List<Object> get props => [status, cardFieldInputDetails];
}
