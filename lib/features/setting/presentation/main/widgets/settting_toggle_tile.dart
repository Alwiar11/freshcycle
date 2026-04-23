import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingToggleTile extends StatefulWidget {
  const SettingToggleTile({
    super.key,
    required this.icon,
    required this.title,
    this.initialValue = true,
  });

  final IconData icon;
  final String title;
  final bool initialValue;

  @override
  State<SettingToggleTile> createState() => _SettingToggleTileState();
}

class _SettingToggleTileState extends State<SettingToggleTile> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              widget.icon,
              color: Theme.of(context).colorScheme.primary,
              size: 20.r,
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Text(
              widget.title,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(fontSize: 14.sp),
            ),
          ),
          Switch(
            value: _isOn,
            onChanged: (val) => setState(() => _isOn = val),
            activeThumbColor: Colors.white,
            activeTrackColor: Theme.of(context).colorScheme.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
        ],
      ),
    );
  }
}
