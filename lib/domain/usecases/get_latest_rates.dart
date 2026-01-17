import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/entities/entities.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class GetLatestRates
    extends UseCase<Result<List<CurrencyRateEntity>>, NoParams> {
  final CurrencyRepository repository;

  GetLatestRates(this.repository);

  @override
  Future<Result<List<CurrencyRateEntity>>> call(NoParams params) async {
    return repository.getLatestRates();
  }
}
