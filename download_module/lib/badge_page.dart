import 'package:badge_app_example/provider/calculate_provider.dart';
import 'package:badge_app_example/provider/download_provider_notifier.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BadgePageExample extends StatelessWidget {
  const BadgePageExample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final downloadProgress =
        context.select((DownloadProvider p) => p.downloadProgress);
    int numberOfClick = context.select((Calculate counter) => counter.value);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              badgeContent: downloadProgress == 100
                  ? const Icon(Icons.check_circle, size: 12)
                  : const Icon(Icons.error, size: 12),
              badgeColor: downloadProgress == 100 ? Colors.green : Colors.red,
              showBadge: downloadProgress > 1 ? true : false,
              child: IconButton(
                onPressed: () {
                  context.read<DownloadProvider>().createEnqueue();
                  context.read<DownloadProvider>().registerIsolate();
                },
                icon: const Icon(Icons.download_for_offline),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //context.read<DownloadProvider>().reset();
                context.read<Calculate>().click = numberOfClick++;
                context.read<Calculate>().calculate();
                },
              child: const Text('Reset'),
            ),
            Text(
              '$numberOfClick',
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
