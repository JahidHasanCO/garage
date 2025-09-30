import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/app/app.dart';
import 'package:garage/modules/home/home.dart';
import 'package:garage/modules/login/providers/login_provider.dart';
import 'package:garage/modules/login/providers/login_state.dart';
import 'package:garage/modules/service_catalog/service_catalog.dart';
import 'package:garage/modules/service_package_details/service_package_details.dart';

final appProvider = NotifierProvider<AppProvider, AppState>(
  AppProvider.new,
);

final loginProvider = NotifierProvider<LoginProvider, LoginState>(
  LoginProvider.new,
);

final homeProvider = NotifierProvider<HomeProvider, HomeState>(
  HomeProvider.new,
);

final serviceCatalogProvider =
    NotifierProvider<ServiceCatalogProvider, ServiceCatalogState>(
      ServiceCatalogProvider.new,
    );

final servicePackageDetailsProvider =
    NotifierProvider<ServicePackageDetailsProvider, ServicePackageDetailsState>(
      ServicePackageDetailsProvider.new,
    );
