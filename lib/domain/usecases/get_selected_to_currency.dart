import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class GetSelectedToCurrency extends UseCase<Result<String>, NoParams> {
  final CurrencyRepository repository;

  GetSelectedToCurrency(this.repository);

  @override
  Future<Result<String>> call(NoParams params) async {
    return repository.getSelectedToCurrency();
  }
}
