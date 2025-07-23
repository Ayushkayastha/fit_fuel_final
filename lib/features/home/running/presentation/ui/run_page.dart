// lib/features/home/running/presentation/ui/run_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/run_data.dart';
import '../providers/run_providers.dart';

class RunPage extends ConsumerWidget {
  const RunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final running = ref.watch(isRunningProvider);
    final runDataAsync = ref.watch(runDataStreamProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1) Main content area
        Padding(
          padding: const EdgeInsets.all(16),
          child: runDataAsync.when(
            data: (RunData data) => Column(
              mainAxisSize: MainAxisSize.min,        // ← shrink‐wrap vertically
              children: [
                _infoTile('Distance (m)', data.distanceMeters.toStringAsFixed(1)),
                _infoTile('Elapsed', _formatDuration(data.elapsed)),
                _infoTile('Speed (m/s)', data.currentSpeed.toStringAsFixed(1)),
                _infoTile('Avg Speed (m/s)', data.averageSpeed.toStringAsFixed(1)),
              ],
            ),
            loading: () => const Center(child: Text('Press Start to begin')),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),

        // 2) Start/Stop button at the bottom
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              final ctrl = ref.read(runControllerProvider);
              running ? ctrl.stop() : ctrl.start();
            },
            icon: Icon(running ? Icons.stop : Icons.play_arrow),
            label: Text(running ? 'Stop' : 'Start'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ),
      ],
    );

  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final two = (int n) => n.toString().padLeft(2, '0');
    return '${two(d.inHours)}:${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}';
  }
}
