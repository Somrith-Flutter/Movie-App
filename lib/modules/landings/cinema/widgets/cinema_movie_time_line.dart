import 'package:flutter/material.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'cinema_movie_item.dart';

class CinemaMovieTimeLine extends StatelessWidget {
  const CinemaMovieTimeLine({super.key ,this.movies});
  final List<CinemaMovieItem>? movies;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 12),
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
        itemCount: movies!.length,
        itemBuilder: (context, index) {
          var item = movies?[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "${item!.image}",
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  TextWidget(
                    "${item.release}",
                    bold: true,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: TextWidget(
                        "${item.classification}",
                        color: Colors.black,
                        bold: true,
                      ),
                    ),
                  ),
                ],
              ),
              TextWidget(
                "${item.title}",
                color: Colors.white,
                size: 16,
                bold: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}