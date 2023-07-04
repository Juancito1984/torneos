import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:torneos/app/modules/initial_module/initial_controller.dart';
import 'package:torneos/app/modules/initial_module/widgets/item_tab.dart';

import '../../../theme/app_colors.dart';
import '../../../utils/strings.dart';

class OptionNavigatorBar extends GetView<InitialController> {
  const OptionNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: accentColor,
      ),
      child: TabBar(
        indicatorColor: primaryColor,
        unselectedLabelColor: Colors.grey.withOpacity(0.6),
        controller: controller.tabController,
        tabs: [
          ItemTab(icon: FontAwesomeIcons.calendarAlt, title: fechas),
          ItemTab(icon: FontAwesomeIcons.listOl, title: posiciones),
          ItemTab(icon: FontAwesomeIcons.userTie, title: estadisticas),
        ],
      ),
    );
  }
}
