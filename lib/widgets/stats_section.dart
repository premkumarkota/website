import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({Key? key}) : super(key: key);

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  bool isVisible = false;

  final List<Map<String, dynamic>> stats = [
    {'value': 20, 'suffix': '+', 'label': 'HAPPY CLIENTS'},
    {'value': 8000, 'suffix': '+', 'label': 'ACTIVE USERS'},
    {'value': 99, 'suffix': '%', 'label': 'UPTIME'},
  ];

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('stats-pop-vibrant'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !isVisible) {
          if (mounted) setState(() => isVisible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 60,
          runSpacing: 40,
          children: stats.asMap().entries.map((entry) {
            final index = entry.key;
            final stat = entry.value;

            return Column(
                  children: [
                    TweenAnimationBuilder<int>(
                      tween: IntTween(
                        begin: 0,
                        end: isVisible ? stat['value'] as int : 0,
                      ),
                      duration: 2000.ms,
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              value.toString(),
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                stat['suffix'] as String,
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFEC4899),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      stat['label'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF7C3AED), // Vibrant purple
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                )
                .animate(target: isVisible ? 1 : 0)
                .fadeIn(duration: 400.ms, delay: (index * 200).ms)
                .scale(
                  begin: const Offset(0.5, 0.5),
                  curve: Curves.easeOutBack,
                  delay: (index * 200).ms,
                );
          }).toList(),
        ),
      ),
    );
  }
}
