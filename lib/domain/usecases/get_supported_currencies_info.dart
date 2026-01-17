import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/entities/currency_info_entity.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class GetSupportedCurrencies
    extends UseCase<Result<List<CurrencyInfoEntity>>, NoParams> {
  final CurrencyRepository repository;

  GetSupportedCurrencies(this.repository);

  @override
  Future<Result<List<CurrencyInfoEntity>>> call(NoParams params) async {
    return repository.getSupportedCurrencyInfo();
  }
}
