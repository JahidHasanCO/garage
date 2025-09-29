import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garage/core/provider/provider.dart';
import 'package:garage/shared/widgets/provider_selector.dart';
import 'package:garage/utils/extension/ref.dart';
import 'package:garage/utils/extension/string.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.select(appProvider, (app) => app.user);

    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      title: Row(
        children: [
          // Circle Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
            child: (user != null && user.name.isNotEmpty)
                ? Text(
                    user.name[0].toUpperCase(),
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: theme.primaryColor,
                    size: 24,
                  ),
          ),
          const SizedBox(width: 12),
          // User info column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User name
                Text(
                  user?.name ?? 'Guest',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                // User address
                Builder(
                  builder: (context) {
                    final hasLocation = ref.select(
                      homeProvider,
                      (home) => home.hasLocation,
                    );
                    final displayLocation = ref.select(
                      homeProvider,
                      (home) => home.displayLocation,
                    );
                    final isLocationFromCache = ref.select(
                      homeProvider,
                      (home) => home.isLocationFromCache,
                    );
                    return Text(
                      hasLocation
                          ? displayLocation.shortLocationText
                          : 'Location not available',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: hasLocation
                            ? (isLocationFromCache
                                  ? Colors.orange[700]
                                  : Colors.green[700])
                            : Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Location refresh button
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: ProviderSelector(
            provider: homeProvider,
            selector: (home) => home.status,
            builder: (context, status) {
              return IconButton(
                onPressed: status.isLoading
                    ? null
                    : () => ref.read(homeProvider.notifier).refreshLocation(),
                icon: status.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : Builder(
                        builder: (context) {
                          final hasLocation = ref.select(
                            homeProvider,
                            (home) => home.hasLocation,
                          );
                          final isLocationFromCache = ref.select(
                            homeProvider,
                            (home) => home.isLocationFromCache,
                          );
                          return Icon(
                            Icons.location_on,
                            color: hasLocation
                                ? (isLocationFromCache
                                      ? Colors.orange[700]
                                      : Colors.green[700])
                                : Colors.grey[600],
                          );
                        },
                      ),
                tooltip: status.isLoading
                    ? 'Getting location...'
                    : 'Refresh location',
              );
            },
          ),
        ),
      ],
    );
  }


}
