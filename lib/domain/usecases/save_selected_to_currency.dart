import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/params/save_currency_params.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class SaveSelectedToCurrency extends UseCase<Result<void>, SaveCurrencyParams> {
  final CurrencyRepository repository;

  SaveSelectedToCurrency(this.repository);

  @override
  Future<Result<void>> call(SaveCurrencyParams params) async {
    return repository.saveSelectedToCurrency(params.currencyCode);
  }
}
