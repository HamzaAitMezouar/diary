import 'package:diary/core/exports.dart';
import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/presentation/home/controller/home_provider.dart';
import 'package:diary/presentation/home/controller/home_state.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:diary/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/DI/socket_provider.dart';
import '../widgets/week_days_history.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final home = ref.watch(homeProvider);
    return home is HomeLoading
        ? const CustomLoading()
        : home is HomeLoaded
            ? Scaffold(
                body: RefreshIndicator(
                  onRefresh: () => ref.read(homeProvider.notifier).loadReminders(),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            xxlSpacer(),
                            home.reminders.isEmpty
                                ? Card(
                                    margin: Paddings.allXs,
                                    shape: RoundedRectangleBorder(borderRadius: Borders.b10),
                                    child: Padding(
                                      padding: Paddings.allXs,
                                      child: Column(
                                        children: [
                                          Text(
                                            " context.translate.noReminders",
                                            style: TextStyles.robotoBold13,
                                          ),
                                          Text(
                                            "context.translate.stayHealthy",
                                            style: TextStyles.roboto13,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      ...home.reminders.map(
                                        (reminder) => Container(
                                          margin: const EdgeInsets.symmetric(horizontal: D.xs, vertical: D.xxxs),
                                          padding: Paddings.allXxxxs,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: Borders.b10,
                                          ),
                                          child: Row(
                                            children: [
                                              Card(
                                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                child: Padding(
                                                  padding: Paddings.allXxxxs,
                                                  child: Image.asset(
                                                    reminder.icon,
                                                    height: D.xl,
                                                    color: Theme.of(context).textTheme.displayLarge?.color,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Image.asset(
                                                        Assets.pill,
                                                        height: D.xl,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              xxxsSpacer(),
                                              Text(
                                                reminder.medicineName.toString(),
                                                style: TextStyles.robotoBold10.copyWith(fontSize: 12),
                                              ),
                                              const Spacer(),
                                              const WeekDaysHistory()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            xxlSpacer(),
                            CustomButton(
                              icon: Image.asset(
                                Assets.drugs,
                                height: D.xlg,
                              ),
                              height: D.xxl,
                              onTap: () {
                                // context.goNamed(RoutesNames.addReminderPage);
                              },
                              title: "Add Medicine",
                              style: TextStyles.robotoBold13,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Text("Error");
  }
}
