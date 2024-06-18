
import 'package:legend_cinema/constants/asset_path.dart';

final List<Movies> movie1 = [
  Movies(
    image: AssetPath.boyKill,
    title: "Boy Kills World",
    genre: "Action",
    duration: "1h 50mins",
    release: "14 Jun 2024",
    classification: "R18",
  ),
  Movies(
    image: AssetPath.darkMother,
    title: "Dark Mother (Extended Version),The",
    genre: "Horror",
    duration: "1h 50mins",
    release: "06 June 2024",
    classification: "NC15",
  ),
];

final List<Movies> movie2 = [
  Movies(
    image: AssetPath.motherGhost,
    title: "Dear Mother Ghost",
    genre: "Horror",
    duration: "1h 50mins",
    release: "13 June 2024",
    classification: "NC15",
  ),
  Movies(
    image: AssetPath.police,
    title: "Formed Police Unit",
    genre: "Action",
    duration: "1h 40mins",
    release: "14 Jun 2024",
    classification: "TBC",
  ),
];

final List<Movies> movie3 = [
  Movies(
    image: AssetPath.saga,
    title: "Furiosa: A Mad Max Saga",
    genre: "Action",
    duration: "2h 29mins",
    release: "23 May 2024",
    classification: "R18",
  ),
  Movies(
    image:  AssetPath.inside,
    title: "Inside Out 2",
    genre: "Animation",
    duration: "1h 36mins",
    release: "13 June 2024",
    classification: "G",
  ),
];

final List<Movies> movie4 = [
  Movies(
    image: AssetPath.roundUp,
    title: "Roundub : Punishment, The",
    genre: "Action",
    duration: "1h 49mins",
    release: "14 June 2024",
    classification: "R18",
  )
  ,Movies(
    image: AssetPath.sinden,
    title: "Sinden Gaib",
    genre: "Horror",
    duration: "1h 35mins",
    release: "07 Jun 2024",
    classification: "R18",
  ),
];

final List<Movies> movie5 = [
  Movies(
    image: AssetPath.under,
    title: "Under Parallel Skies",
    genre: "romance",
    duration: "1h 50mins",
    release: "12 Jun 2024",
    classification: "G",
  ),
  Movies(
    image: AssetPath.watcher,
    title: "Watcher, The",
    genre: "Horror",
    duration: "1h 41mins",
    release: "06 June 2024",
    classification: "NC15",
  )
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
    date: '12, 1, 24,',
    type: 'DGE',
  ),
  Movies(
    image: AssetPath.story2,
    title: 'title 2',
    date: '12, 1, 24,',
    type: 'IGE',
  ),
  Movies(
    image: AssetPath.story3,
    title: 'title 3',
    date: '12, 1, 24,',
    type: 'LGE',
  ),
  Movies(
    image: AssetPath.story4,
    title: 'title 4',
    date: '12, 1, 24,',
    type: 'HGE',
  ),
  Movies(
    image: AssetPath.story5,
    title: 'title 5',
    date: '12, 1, 24,',
    type: 'XGE',
  ),
  Movies(
    image: AssetPath.story6,
    title: 'title 6',
    date: '12, 1, 24,',
    type: 'BGE',
  ),
  Movies(
    image: AssetPath.story7,
    title: 'title 7',
    date: '12, 1, 24,',
    type: 'SGE',
  ),
  Movies(
    image: AssetPath.story8,
    title: 'title 8',
    date: '12, 1, 24,',
    type: 'FGE',
  ),
  Movies(
    image: AssetPath.story9,
    title: 'title 9',
    date: '12, 1, 24,',
    type: 'DAE',
  ),
  Movies(
    image: AssetPath.story10,
    title: 'title 10',
    date: '12, 1, 24,',
    type: 'DDE',
  ),
];