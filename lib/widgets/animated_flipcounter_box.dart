import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class MyAnimatedFlipCounter extends StatelessWidget {
  final num value;
  final Duration duration;
  final Duration negativeSignDuration;
  final Curve curve;
  final TextStyle? textStyle;
  final String? prefix;
  final String? infix;
  final String? suffix;
  final int fractionDigits;
  final int wholeDigits;
  final bool hideLeadingZeroes;
  final String? thousandSeparator;
  final String decimalSeparator;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets padding;

  const MyAnimatedFlipCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 300),
    this.negativeSignDuration = const Duration(milliseconds: 150),
    this.curve = Curves.linear,
    this.textStyle,
    this.prefix,
    this.infix,
    this.suffix,
    this.fractionDigits = 2,
    this.wholeDigits = 1,
    this.hideLeadingZeroes = false,
    this.thousandSeparator,
    this.decimalSeparator = '.',
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding = EdgeInsets.zero,
  })  : assert(fractionDigits >= 0, 'fractionDigits must be non-negative'),
        assert(wholeDigits >= 0, 'wholeDigits must be non-negative');

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context)
        .style
        .merge(textStyle)
        .merge(const TextStyle(fontFeatures: [FontFeature.tabularFigures()]));

    final prototypeDigit = TextPainter(
      text: TextSpan(text: '0', style: style),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout();

    final Color color = style.color ?? const Color(0xffff0000);

    final int intValue = (value * math.pow(10, fractionDigits)).round();
    final String formattedValue = intValue.toString().padLeft(wholeDigits + fractionDigits, '0');
    final List<int> digits = formattedValue.split('').map((e) => int.parse(e)).toList();

    final integerWidgets = <Widget>[];
    for (int i = 0; i < digits.length - fractionDigits; i++) {
      final digit = _SingleDigitFlipCounter(
        key: ValueKey('int-$i'),
        value: digits[i].toDouble(),
        duration: duration,
        curve: curve,
        size: prototypeDigit.size,
        color: color,
        padding: padding,
        visible: hideLeadingZeroes
            ? digits[i] != 0 || i == digits.length - fractionDigits - 1
            : true,
      );
      integerWidgets.add(digit);
    }

    if (thousandSeparator != null) {
      int firstVisibleDigitIndex = 0;
      if (hideLeadingZeroes) {
        firstVisibleDigitIndex = digits.indexWhere((d) => d != 0);
        if (firstVisibleDigitIndex == -1) {
          firstVisibleDigitIndex = digits.length - 1;
        }
      }
      int counter = 0;
      for (int i = integerWidgets.length; i > firstVisibleDigitIndex; i--) {
        if (counter > 0 && counter % 3 == 0) {
          integerWidgets.insert(i, Text(thousandSeparator!));
        }
        counter++;
      }
    }

    final fractionWidgets = <Widget>[];
    for (int i = digits.length - fractionDigits; i < digits.length; i++) {
      final digit = _SingleDigitFlipCounter(
        key: ValueKey('frac-$i'),
        value: digits[i].toDouble(),
        duration: duration,
        curve: curve,
        size: prototypeDigit.size,
        color: color,
        padding: padding,
      );
      fractionWidgets.add(digit);
    }

    return DefaultTextStyle.merge(
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment,
        textDirection: TextDirection.ltr,
        children: [
          if (prefix != null) Text(prefix!),
          ClipRect(
            child: TweenAnimationBuilder(
              duration: negativeSignDuration,
              tween: Tween(end: value < 0 ? 1.0 : 0.0),
              builder: (_, double v, __) => Center(
                widthFactor: v,
                child: Opacity(opacity: v, child: const Text('-')),
              ),
            ),
          ),
          if (infix != null) Text(infix!),
          ...integerWidgets,
          if (fractionDigits != 0) Text(decimalSeparator),
          ...fractionWidgets,
          if (suffix != null) Text(suffix!),
        ],
      ),
    );
  }
}

class _SingleDigitFlipCounter extends StatelessWidget {
  final double value;
  final Duration duration;
  final Curve curve;
  final Size size;
  final Color color;
  final EdgeInsets padding;
  final bool visible;

  const _SingleDigitFlipCounter({
    super.key,
    required this.value,
    required this.duration,
    required this.curve,
    required this.size,
    required this.color,
    required this.padding,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(end: value),
      duration: duration,
      curve: curve,
      builder: (_, double value, __) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        final w = size.width + padding.horizontal;
        final h = size.height + padding.vertical;

        return SizedBox(
          width: visible ? w : 0,
          height: h,
          child: Stack(
            children: <Widget>[
              _buildSingleDigit(
                digit: whole % 10,
                offset: h * decimal,
                opacity: 1 - decimal,
              ),
              _buildSingleDigit(
                digit: (whole + 1) % 10,
                offset: h * decimal - h,
                opacity: decimal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigit({
    required int digit,
    required double offset,
    required double opacity,
  }) {
    final Widget child;
    if (color.opacity == 1) {
      child = Text(
        '$digit',
        textAlign: TextAlign.center,
        style: TextStyle(color: color.withOpacity(opacity.clamp(0, 1))),
      );
    } else {
      child = Opacity(
        opacity: opacity.clamp(0, 1),
        child: Text(
          '$digit',
          textAlign: TextAlign.center,
        ),
      );
    }
    return Positioned(
      left: 0,
      right: 0,
      bottom: offset + padding.bottom,
      child: child,
    );
  }
}
