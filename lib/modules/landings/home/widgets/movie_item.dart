
import 'package:get/get.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/utils/helpers/date_helper.dart';
final HomeController controller = Get.find();
final dateTime = DateInfo();
final List<Movies> movie1 = [
  Movies(
    image: AssetPath.boyKill,
    title: "Boy Kills World",
    genre: "Action",
    duration: "1h 50mins",
    release: controller.dateInfo.dateTime[0],
    classification: "R18",
  ),
  Movies(
    image: AssetPath.darkMother,
    title: "Dark Mother (Extended Version),The",
    genre: "Horror",
    duration: "1h 50mins",
    release: controller.dateInfo.dateTime[0],
    classification: "NC15",
  ),
   Movies(
    image: AssetPath.story8,
    title: "The GARFIELD Movie",
    genre: "Funny",
    duration: "1h 45mins",
    release: controller.dateInfo.dateTime[0],
    classification: "NC15",
  ),
   Movies(
    image: AssetPath.story10,
    title: "ទីក្រុងឧក្រិដ្ឋទណ្ឌកម្មក្តៅ",
    genre: "សើបអង្កេត",
    duration: "1h 50mins",
    release: controller.dateInfo.dateTime[0],
    classification: "NC15",
  ),
   Movies(
    image: AssetPath.story9,
    title: "FIRIOSA",
    genre: "Fightihng with the super power",
    duration: "1h 50mins",
    release: controller.dateInfo.dateTime[0],
    classification: "NC15",
  ),
   Movies(
    image: AssetPath.police,
    title: "The team of policman keep fighting",
    genre: "Horror",
    duration: "1h 50mins",
    release: controller.dateInfo.dateTime[0],
    classification: "NC15",
  ),
  Movies(
    image: AssetPath.under,
    title: "Under Parallel Skies",
    genre: "romance",
    duration: "1h 50mins",
    release: controller.dateInfo.dateTime[0],
    classification: "G",
  ),
   Movies(
    image: AssetPath.watcher,
    title: "Watcher, The",
    genre: "Horror",
    duration: "1h 41mins",
    release: controller.dateInfo.dateTime[0],
    classification: "NC15",
  )
];

final List<Movies> movie2 = [
  Movies(
    image: AssetPath.motherGhost,
    title: "Dear Mother Ghost",
    genre: "Horror",
    duration: "1h 50mins",
    release: controller.dateInfo.dateTime[1],
    classification: "NC15",
  ),
  Movies(
    image: AssetPath.police,
    title: "Formed Police Unit",
    genre: "Action",
    duration: "1h 40mins",
    release: controller.dateInfo.dateTime[1],
    classification: "TBC",
  ),
];

final List<Movies> movie3 = [
  Movies(
    image: AssetPath.saga,
    title: "Furiosa: A Mad Max Saga",
    genre: "Action",
    duration: "2h 29mins",
    release: controller.dateInfo.dateTime[2],
    classification: "R18",
  ),
  Movies(
    image:  AssetPath.inside,
    title: "Inside Out 2",
    genre: "Animation",
    duration: "1h 36mins",
    release: controller.dateInfo.dateTime[2],
    classification: "G",
  ),
];

final List<Movies> movie4 = [
  Movies(
    image: AssetPath.roundUp,
    title: "Roundub : Punishment, The",
    genre: "Action",
    duration: "1h 49mins",
    release: controller.dateInfo.dateTime[3],
    classification: "R18",
  )
  ,Movies(
    image: AssetPath.sinden,
    title: "Sinden Gaib",
    genre: "Horror",
    duration: "1h 35mins",
    release: controller.dateInfo.dateTime[3],
    classification: "R18",
  ),
];


class Movies{
  Movies({
    this.image,
    this.title,
    this.genre,
    this.duration,
    this.release,
    this.classification,
    this.type,
    this.date,
  });

  final String? image;
  final String? title;
  final String? genre;
  final String? duration;
  final String? release;
  final String? classification;
  final String? type;
  final String? date; 
}

List<Movies> pages = [
  Movies(
    image: AssetPath.story1,
    title: 'title 1',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "GHJ",
  ),
  Movies(
    image: AssetPath.story2,
    title: 'title 2',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "RSD",
  ),
  Movies(
    image: AssetPath.story3,
    title: 'title 3',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "R19",
  ),
  Movies(
    image: AssetPath.story4,
    title: 'title 4',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "R10",
  ),
  Movies(
    image: AssetPath.story5,
    title: 'title 5',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "R12",
  ),
  Movies(
    image: AssetPath.story6,
    title: 'title 6',
   genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "TRS",
  ),
  Movies(
    image: AssetPath.story7,
    title: 'title 7',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "CVB",
  ),
  Movies(
    image: AssetPath.story8,
    title: 'title 8',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "DDS",
  ),
  Movies(
    image: AssetPath.story9,
    title: 'title 9',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "TFD",
  ),
  Movies(
    image: AssetPath.story10,
    title: 'title 10',
    genre: "Horror",
    duration: "1h 35mins",
    release: dateTime.dateTime.first,
    classification: "R14",
  ),
];