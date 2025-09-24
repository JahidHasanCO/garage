import 'package:flutter/material.dart';
import 'package:garage/data/models/menu_item.dart';
import 'package:garage/modules/dashboard/dashboard.dart';
import 'package:garage/modules/service_catalog/service_catalog.dart';
import 'package:garage/theme/app_colors.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  int selectedIndex = 0;

  final List<MenuItem> menuItems = [
    const MenuItem(
      'Dashboard',
      'assets/icons/dashboard.svg',
      DashboardScreen(),
    ),
    const MenuItem(
      'Inventory',
      'assets/icons/inventory.svg',
      DashboardScreen(),
    ),
    const MenuItem(
      'Repair Tracker',
      'assets/icons/tool.svg',
      DashboardScreen(),
    ),
    const MenuItem(
      'Customers',
      'assets/icons/customers.svg',
      DashboardScreen(),
    ),
    const MenuItem('Bookings', 'assets/icons/calendar.svg', DashboardScreen()),
    const MenuItem(
      'Service Catalog',
      'assets/icons/lightbulb.svg',
      ServiceCatalogScreen(),
    ),
    const MenuItem(
      'Diagnostics',
      'assets/icons/lightbulb.svg',
      DashboardScreen(),
    ),
    const MenuItem(
      'Staff Management',
      'assets/icons/staff.svg',
      DashboardScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        children: [
          SideMenuWidget(
            selectedIndex: selectedIndex,
            items: menuItems,
            onItemSelected: (index) {
              setState(() => selectedIndex = index);
            },
          ),
          Expanded(
            child: Column(
              children: [
                CustomAppBar(title: menuItems[selectedIndex].title),
                Expanded(child: menuItems[selectedIndex].screen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
