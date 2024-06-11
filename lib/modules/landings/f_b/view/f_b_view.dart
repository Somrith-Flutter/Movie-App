import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/f_b/widgets/f_b_combo.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'dart:ui';
import 'package:legend_cinema/widgets/text_widget.dart';

class FBView extends StatelessWidget {
  const FBView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> cinemaList = [
      {"title": "Legend Eden Garden"},
      {"title": "Legend Toul Kork"},
      {"title": "Legend Premium Exchange Square"},
      {"title": "Legend Olympia"},
      {"title": "Legend SenSok"},
      {"title": "Legend Noro Mall"},
      {"title": "Legend Midtown Mall"},
      {"title": "Legend Meanchey"},
      {"title": "Legend Cinema 271 Mega Mall"},
      {"title": "Legend K Mall"},
      {"title": "Legend Cinema Sihanoukville"},
      {"title": "Legend Siem Reap"},
    ];
    return Stack(
      children: [
        Image.asset(AssetPath.fbhero,width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.black.withOpacity(0.5), 
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, 
          appBar: AppBar(
            title: TextWidget(S.of(context).fb, size: 20, bold: true),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Image.asset(AssetPath.fbhero),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 12, left: 12),
                child: TextWidget(
                  S.of(context).choose_cinema,
                  size: 20,
                  bold: true,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cinemaList.length,
                itemBuilder: (context, index) {
                  var data = cinemaList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: SizedBox(
                      height: 80,
                      child: GestureDetector(
                        onTap: (){
                          AppRoute.route.push(context, const FAndBCombo());
                        },
                        child: Card(
                          color: Colors.white70.withOpacity(0.1),
                          elevation: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.8)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 60,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              AssetPath.cinema1,
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextWidget(data["title"],
                                        size: 16, bold: true,overflow: TextOverflow.ellipsis,),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
