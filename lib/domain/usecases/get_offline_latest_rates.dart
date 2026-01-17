import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/entities/entities.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class GetOfflineLatestRates
    extends UseCase<Result<List<CurrencyRateEntity>>, NoParams> {
  final CurrencyRepository repository;

  GetOfflineLatestRates(this.repository);

  @override
  Future<Result<List<CurrencyRateEntity>>> call(NoParams params) async {
    return repository.getOfflineLatestRates();
  }
}
