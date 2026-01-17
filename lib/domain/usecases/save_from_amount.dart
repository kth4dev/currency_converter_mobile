import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class SaveFromAmountParams extends Params {
  final double amount;

  const SaveFromAmountParams(this.amount);

  @override
  List<Object> get props => [amount];
}

class SaveFromAmount extends UseCase<Result<void>, SaveFromAmountParams> {
  final CurrencyRepository repository;

  SaveFromAmount(this.repository);

  @override
  Future<Result<void>> call(SaveFromAmountParams params) async {
    return repository.saveFromAmount(params.amount);
  }
}
