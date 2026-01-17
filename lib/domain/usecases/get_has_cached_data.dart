import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class GetHasCachedData extends UseCase<bool, NoParams> {
  final CurrencyRepository repository;

  GetHasCachedData(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return repository.hasCachedData();
  }
}
