import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold();
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
