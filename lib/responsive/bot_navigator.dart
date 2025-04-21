import 'package:flutter/material.dart';
import 'package:otop_front/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../providers/index_provider.dart';

class BotNavigator extends StatefulWidget {
  const BotNavigator({super.key});

  @override
  State<BotNavigator> createState() => _BotNavigatorState();
}

class _BotNavigatorState extends State<BotNavigator> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<SelectedIndexProvider>().selectedIndex;
    return const ResponsiveLayout(mobileBody: Column(), tabletBody: Column(), desktopBody: Column());
  }
}
