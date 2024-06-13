import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/more/widgets/learn_more_details_widget.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class LearnMoreWidget extends StatelessWidget {
  const LearnMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        centerTitle: true,
        title: const TextWidget('Legend Member', size: 26, bold: true,),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: TextWidget(
              'Member Benifits',
              size: 24,
              bold: true,
            )),
          const Align(
            alignment: Alignment.topLeft,
            child: TextWidget(
              'Getting many benifit from our membership card. Take one now at your nearby Legend Cinema!',
              size: 14,
              color: Colors.grey,
            )
          ),
          const Gap(24),
          _buildBnifit()
        ],
      ),
    );
  }

  Widget _buildBnifit(){
     List<Benifit> images =[
      Benifit(
        thumbnails: AssetPath.dis0,
        titles: '5% Bonus on top up',
        images: AssetPath.dis5,
        contents: 'test'
      ),
      Benifit(
        thumbnails: AssetPath.dis0,
        titles: 'Discount 10% Ticked &\nConcession',
        images: AssetPath.dis10,
        contents: 'test'
      ),
    ];
    return Expanded(
      child: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index){
          var items = images[index];
          return GestureDetector(
            onTap: () => AppRoute().push(context, LernMoreDetailsWidget(
              thumbnail: items.thumbnails,
              title: items.titles,
              content: items.contents,
            )),
            child: Stack(
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade900,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: double.maxFinite,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10), 
                              bottomLeft: Radius.circular(10))
                          ),
                          child: Image.asset(items.images!, fit: BoxFit.contain,),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 170,
                  child: TextWidget(
                    items.titles,
                    maxLines: 2,
                    size: 16,
                    bold: true,
                  )),
                
                const Positioned(
                  right: 30,
                  bottom: 40,
                  child: Icon(Icons.arrow_forward_sharp),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Benifit{
  Benifit({
    this.titles,
    this.images,
    this.thumbnails,
    this.contents,
  });

  final String? titles;
  final String? images;
  final String? thumbnails;
  final String? contents;
}