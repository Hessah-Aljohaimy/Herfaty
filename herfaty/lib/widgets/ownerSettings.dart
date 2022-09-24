import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OwnerSettings extends StatefulWidget {
  const OwnerSettings({super.key});

  @override
  State<OwnerSettings> createState() => _OwnerSettingsState();
}

class _OwnerSettingsState extends State<OwnerSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Owner settings page')));
  }
}
