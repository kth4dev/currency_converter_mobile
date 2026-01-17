import 'package:currency_converter/core/usecase/usecase.dart';

class SaveCurrencyParams extends Params {
  final String currencyCode;

  const SaveCurrencyParams(this.currencyCode);

  @override
  List<Object> get props => [currencyCode];
}
