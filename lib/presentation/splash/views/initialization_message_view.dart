import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitializationStatusMessageView extends StatelessWidget {
  const InitializationStatusMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SplashCubit, SplashState, String>(
      selector: (state) => state.initProcessMessage,
      builder: (context, message) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Dimens.space24),
            child: Text(
              message,
              style: context.textStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
