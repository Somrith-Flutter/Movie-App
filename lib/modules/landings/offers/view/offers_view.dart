import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_cinema/constants/asset_path.dart';

List<String> image =[
  AssetPath.Cinema2,
  AssetPath.Cinema6,
  AssetPath.Cinema4,
  AssetPath.Cinema5,
  AssetPath.Cinema7,
];
List<String> imageCard =[
  AssetPath.CinemaCard1,
  AssetPath.Cinema6,
  AssetPath.Cinema7,
];
class OffersView extends StatelessWidget {
  const OffersView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Offers"),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 220,
                child: Image.asset('assets/images/cinema1.jpeg',
                  fit: BoxFit.fill,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'What we offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: image.length, // Number of items in the list
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){},
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.white70, // Border color
                                width: 1,
                              ),
                            ),
                            child: SizedBox(
                                height: 260,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                          child: Image.asset(image[index],
                                            fit: BoxFit.fill,
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: ListTile(
                                        title: Text(
                                          'Title of content ${index + 1}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Premium Benefits",
                style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageCard.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Card(
                            child: SizedBox(
                                width: 280,
                                child: Image.asset(imageCard[index],
                                fit: BoxFit.fill,)
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}