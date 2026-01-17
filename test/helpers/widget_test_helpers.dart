import 'dart:async';

import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:currency_converter/presentation/home/views/converter/currency_converter_view.dart';
import 'package:currency_converter/presentation/home/views/status_header/status_header_view.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyBloc extends Mock implements CurrencyBloc {
  final _controller = StreamController<CurrencyState>.broadcast();
  CurrencyState _state = const CurrencyState();

  @override
  CurrencyState get state => _state;

  set state(CurrencyState value) {
    _state = value;
    _controller.add(value);
  }

  @override
  Stream<CurrencyState> get stream => _controller.stream;

  @override
  Future<void> close() async {
    await _controller.close();
  }
}

class MockSplashCubit extends Mock implements SplashCubit {
  final _controller = StreamController<SplashState>.broadcast();
  SplashState _state = const SplashState();

  @override
  SplashState get state => _state;

  set state(SplashState value) {
    _state = value;
    _controller.add(value);
  }

  @override
  Stream<SplashState> get stream => _controller.stream;

  @override
  Future<void> close() async {
    await _controller.close();
  }
}

class WidgetTestWrapper extends StatelessWidget {
  final Widget child;
  final CurrencyBloc? currencyBloc;
  final SplashCubit? splashCubit;
  final ThemeData? theme;

  const WidgetTestWrapper({
    super.key,
    required this.child,
    this.currencyBloc,
    this.splashCubit,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = MaterialApp(
      theme: theme ?? ThemeData.light(),
      home: Scaffold(body: child),
    );

    if (currencyBloc != null) {
      result = BlocProvider<CurrencyBloc>.value(
        value: currencyBloc!,
        child: result,
      );
    }

    if (splashCubit != null) {
      result = BlocProvider<SplashCubit>.value(
        value: splashCubit!,
        child: result,
      );
    }

    return result;
  }
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpApp(Widget widget, {ThemeData? theme}) async {
    await pumpWidget(
      MaterialApp(
        theme: theme ?? ThemeData.light(),
        home: Scaffold(body: widget),
      ),
    );
  }

  Future<void> pumpWithCurrencyBloc(
    Widget widget,
    CurrencyBloc bloc, {
    ThemeData? theme,
  }) async {
    await pumpWidget(
      WidgetTestWrapper(
        currencyBloc: bloc,
        theme: theme,
        child: widget,
      ),
    );
  }

  Future<void> pumpWithSplashCubit(
    Widget widget,
    SplashCubit cubit, {
    ThemeData? theme,
  }) async {
    await pumpWidget(
      WidgetTestWrapper(
        splashCubit: cubit,
        theme: theme,
        child: widget,
      ),
    );
  }
}

MockCurrencyBloc createMockCurrencyBloc([CurrencyState? initialState]) {
  final bloc = MockCurrencyBloc();
  if (initialState != null) {
    bloc.state = initialState;
  }
  return bloc;
}

MockSplashCubit createMockSplashCubit([SplashState? initialState]) {
  final cubit = MockSplashCubit();
  if (initialState != null) {
    cubit.state = initialState;
  }
  when(cubit.initialize).thenAnswer((_) async {});
  return cubit;
}


extension CurrencyConverterTestExtension on WidgetTester {
  Future<void> pumpConverterView(
    MockCurrencyBloc bloc,
    CurrencyState state, {
    ThemeData? theme,
  }) async {
    bloc.state = state;
    when(() => bloc.add(any())).thenReturn(null);

    await pumpWidget(
      MaterialApp(
        theme: theme ?? ThemeData.light(),
        home: BlocProvider<CurrencyBloc>.value(
          value: bloc,
          child: const Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  StatusHeaderView(),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: CurrencyConverterView(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
