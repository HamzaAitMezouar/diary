import 'package:diary/core/constants/dimensions.dart';
import 'package:diary/core/exports.dart';
import 'package:diary/core/extensions/conntext_extension.dart';
import 'package:diary/core/routes/routes_names.dart';
import 'package:diary/presentation/home/controller/home_provider.dart';
import 'package:diary/presentation/home/controller/home_state.dart';
import 'package:diary/widgets/custom_long_button.dart';
import 'package:diary/widgets/loading_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
                body: CustomScrollView(
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
                                          context.translate.noReminders,
                                          style: TextStyles.robotoBold13,
                                        ),
                                        Text(
                                          context.translate.stayHealthy,
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
                                          borderRadius: Borders.b10,
                                          color: AppColors.borderColor,
                                          boxShadow: [
                                            const BoxShadow(
                                              color: AppColors.grey,
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(1, 1),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Card(
                                              color: AppColors.sofGrey,
                                              surfaceTintColor: AppColors.transparent,
                                              child: Padding(
                                                padding: Paddings.allXxxxs,
                                                child: Image.asset(
                                                  reminder.icon,
                                                  height: D.xl,
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
                              color: AppColors.superDark,
                            ),
                            height: D.xxl,
                            onTap: () {
                              context.goNamed(RoutesNames.addReminderPage);
                            },
                            backgorundColor: AppColors.turquoise,
                            title: "Add Medicine",
                            style: TextStyles.robotoBold13,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Text("Error");
  }
}

// class ArticleCard extends StatelessWidget {
//   const ArticleCard({
//     super.key,
//     required this.article,
//   });

//   final ArticleModel article;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: D.xs, vertical: D.xxxxs),
//       decoration: BoxDecoration(
//         borderRadius: Borders.b12,
//         color: AppColors.borderColor,
//         boxShadow: [
//           BoxShadow(color: AppColors.grey, spreadRadius: 1, blurRadius: 2, offset: Offset(1, 1)),
//         ],
//       ),
//       padding: Paddings.allXxxxs,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ArticleImageWidget(article: article),
//           xsSpacer(),
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 xsSpacer(),
//                 Text(
//                   article.author ?? "",
//                   maxLines: 1,
//                   style: TextStyles.roboto13.copyWith(fontSize: 10),
//                 ),
//                 Text(article.title ?? "",
//                     overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyles.montserratBold13),
//                 xxxsSpacer(),
//                 Text(
//                   article.description ?? "",
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 3,
//                   style: TextStyles.roboto13.copyWith(fontSize: 10),
//                 ),
//                 xxsSpacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       article.source?.name ?? "",
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.end,
//                       maxLines: 3,
//                       style: TextStyles.robotoBold13.copyWith(color: AppColors.black),
//                     ),
//                     xxxsSpacer(),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ArticleImageWidget extends StatelessWidget {
//   const ArticleImageWidget({
//     super.key,
//     required this.article,
//   });

//   final ArticleModel article;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: Borders.b12,
//       child: Image.network(
//         article.urlToImage ?? "",
//         height: D.xxxxxl * 1.8,
//         width: D.xxxxxl * 1.8,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           return loadingProgress == null
//               ? child
//               : SizedBox(
//                   height: D.xxxxxl * 1.8,
//                   width: D.xxxxxl * 1.8,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return Container(
//             height: D.xxxxxl * 1.8,
//             width: D.xxxxxl * 1.8,
//             decoration: BoxDecoration(
//               image: DecorationImage(image: AssetImage(Assets.placeholder), fit: BoxFit.cover),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
