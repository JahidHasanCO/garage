import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/shared/repo/auth_repo.dart';
import 'package:garage/shared/repo/home_repo.dart';
import 'package:garage/shared/repo/service_package_repo.dart';
import 'package:garage/shared/repo/service_repo.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo());
final homeRepoProvider = Provider<HomeRepo>((ref) => HomeRepo());
final serviceRepoProvider = Provider<ServiceRepo>((ref) => ServiceRepo());
final servicePackageRepoProvider = Provider<ServicePackageRepo>((ref) => ServicePackageRepo());
