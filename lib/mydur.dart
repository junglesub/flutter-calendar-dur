import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class WheelDur extends StatefulWidget {
  const WheelDur({super.key});

  @override
  State<WheelDur> createState() => _WheelDurState();
}

class _WheelDurState extends State<WheelDur> {
  final now = TimeOfDay.now();
  late final _hoursWheel = WheelPickerController(
    itemCount: 4,
    initialIndex: 1,
  );
  late final _minutesWheel = WheelPickerController(
    itemCount: 4,
    initialIndex: 0,
    mounts: [_hoursWheel],
  );

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26.0, height: 1.5);
    final wheelStyle = WheelPickerStyle(
      itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
      squeeze: 1.25,
      diameterRatio: .8,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget itemBuilder(BuildContext context, int index) {
      return Text("$index".padLeft(2, '0'), style: textStyle);
    }

    Widget minuteBuilder(BuildContext context, int index) {
      return Text(["00", "15", "30", "45"][index % 4], style: textStyle);
    }

    final timeWheels = <Widget>[
      Expanded(
        child: WheelPicker(
          builder: itemBuilder,
          controller: _hoursWheel,
          looping: false,
          style: wheelStyle,
          selectedIndexColor: Colors.redAccent,
        ),
      ),
      Expanded(
        child: WheelPicker(
          builder: minuteBuilder,
          controller: _minutesWheel,
          looping: true,
          style: wheelStyle,
          selectedIndexColor: Colors.redAccent,
        ),
      ),
    ];
    timeWheels.insert(1, const Text("시간", style: textStyle));

    final amPmWheel = Expanded(
      child: WheelPicker(
        itemCount: 2,
        builder: (context, index) {
          return Text(["AM", "PM"][index], style: textStyle);
        },
        initialIndex: (now.period == DayPeriod.am) ? 0 : 1,
        looping: false,
        style: wheelStyle.copyWith(
          shiftAnimationStyle: const WheelShiftAnimationStyle(
            duration: Duration(seconds: 1),
            curve: Curves.bounceOut,
          ),
        ),
      ),
    );

    return Center(
      child: SizedBox(
        width: 200.0,
        height: 200.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _centerBar(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  ...timeWheels,
                  const SizedBox(width: 6.0),
                  const Text("분", style: textStyle)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Don't forget to dispose the controllers at the end.
    _hoursWheel.dispose();
    _minutesWheel.dispose();
    super.dispose();
  }

  Widget _centerBar(BuildContext context) {
    return Center(
      child: Container(
        height: 38.0,
        decoration: BoxDecoration(
          color: const Color(0xFFC3C9FA).withAlpha(26),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
