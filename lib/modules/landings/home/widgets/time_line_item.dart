import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/modules/landings/home/widgets/home_movie_detail.dart';
import 'package:legend_cinema/modules/landings/home/widgets/movie_item.dart';
import '../../../../widgets/text_widget.dart';

class BuildTimeLineItems extends StatelessWidget {
  const BuildTimeLineItems({super.key, this.movies});

  final List<Movies>? movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 15),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 2 / 3,
        ),
        itemCount: movies?.length ?? 0,
        itemBuilder: (context, index) {
          var item = movies?[index];
          if (item == null) return const SizedBox.shrink();
          return GestureDetector(
            onTap: () {
              AppRoute.route.push(
                context,
                HomeMovieDetail(
                  list: item,
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item.image!,
                    width: double.infinity,
                    height: 235,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(10),
                Row(
                  children: [
                    TextWidget(
                      item.release,
                      size: 12,
                      bold: true,
                      color: Colors.grey,
                    ),
                    const Gap(5),
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: TextWidget(
                          item.classification,
                          size: 12,
                          bold: true,
                          textAlign: TextAlign.center,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Flexible(
                  child: TextWidget(
                    item.title,
                    bold: true,
                    size: 12,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
