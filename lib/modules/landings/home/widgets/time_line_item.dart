import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/modules/landings/home/widgets/movie_item.dart';
import '../../../../widgets/text_widget.dart';

class BuildTimeLineItems extends StatelessWidget {
  const BuildTimeLineItems({super.key ,this.movies});
  final List<Movies>? movies;
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    item!.image!,
                    width: 200,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(10),
                Row(
                  children: [
                    TextWidget(
                      item.date,
                      size: 12,
                    ),
                    const Gap(5),
                    Stack(
                      children: [
                        Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                          ),
                        ),
                        Positioned(
                          top: 1,
                          left: 10,
                          child: TextWidget(
                            item.type, 
                            size: 12, 
                            bold: true, 
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    item.title,
                    bold: true,
                    size: 14,
                  ),
                ),
            
              ],
            );
          },
        ),
      );
  }
}
