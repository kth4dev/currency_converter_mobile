import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class GetFromAmount extends UseCase<Result<double>, NoParams> {
  final CurrencyRepository repository;

  GetFromAmount(this.repository);

  @override
  Future<Result<double>> call(NoParams params) async {
    return repository.getFromAmount();
  }
}
