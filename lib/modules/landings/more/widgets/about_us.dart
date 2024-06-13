import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/repository/more_repository.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({super.key});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  final MoreController controller = Get.put(MoreController(repository: MoreRepository()));

  @override
  void initState() {
    super.initState();
    controller.fetchAboutus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about_us),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage}'));
        } else if (controller.aboutus.isEmpty) {
          return const Center(child: Text('No data available.'));
        } else {
          final about = controller.aboutus.first;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    child: CachedNetworkImage(
                      imageUrl: about.image ?? '',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextWidget(
                      about.title ?? '',
                      size: 24,
                      bold: true,
                    ),
                  ),
                  if (about.subtitle != null && about.subtitle!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextWidget(
                        about.subtitle!,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  TextWidget(
                    about.description ?? '',
                    size: 16,
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}