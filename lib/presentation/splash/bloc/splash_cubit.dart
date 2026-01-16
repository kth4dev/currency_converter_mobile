import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetHasCachedData hasCachedData;
  final GetLatestRates getLatestRates;
  final GetSupportedCurrencies getCurrenciesInfo;

  SplashCubit(this.hasCachedData, this.getLatestRates, this.getCurrenciesInfo)
    : super(const SplashState());

  Future<void> initialize() async {
    const noParams = NoParams();
    emit(state.copyWith(initState: const Initial()));

    // final hasCached = await hasCachedData(noParams);
    // if (hasCached) {
    //   await Future.delayed(const Duration(seconds: 2));
    //   emit(state.copyWith(initState: const Success()));
    //   return;
    // }

    emit(state.copyWith(initProcessMessage: 'Getting available currencies...'));
    final infoResult = await getCurrenciesInfo(noParams);
    if (infoResult is Fail<List<CurrencyInfoEntity>>) {
      emit(
        state.copyWith(
          initState: Failure(
            message: infoResult.errorMessage,
            type: infoResult.errorType,
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(initProcessMessage: 'Updating exchange rates...'));
    final ratesResult = await getLatestRates(noParams);
    if (ratesResult is Fail<List<CurrencyRateEntity>>) {
      emit(
        state.copyWith(
          initState: Failure(
            message: ratesResult.errorMessage,
            type: ratesResult.errorType,
          ),
        ),
      );
      return;
    }
    emit(state.copyWith(initProcessMessage: 'Setup complete!'));
    emit(state.copyWith(initState: const Success()));
  }
}
