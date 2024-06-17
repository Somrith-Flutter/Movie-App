
import 'package:legend_cinema/constants/asset_path.dart';

final List<Movies> movie1 = [
  Movies(
    image: AssetPath.story1,
    title: 'Testing 01',
    type: 'SBT',
    date: 'date": "14 june, 2024'
  ),
  Movies(
    image: AssetPath.story6,
    title: 'Testing 05',
    type: 'SBT',
    date: 'date": "14 june, 2024'
  ),
];

final List<Movies> movie2 = [
  Movies(
    image: AssetPath.story2,
    title: 'Testing 02',
    type: 'SRF',
    date: 'date": "14 june, 2024'
  ),
  Movies(
    image: AssetPath.story7,
    title: 'Testing 06',
    type: 'SBT',
    date: 'date": "14 june, 2024'
  ),
];

final List<Movies> movie3 = [
  Movies(
    image: AssetPath.story3,
    title: 'Testing 03',
    type: 'SDF',
    date: 'date": "14 june, 2024'
  ),
  Movies(
    image: AssetPath.story8,
    title: 'Testing 08',
    type: 'SBT',
    date: 'date": "14 june, 2024'
  ),
];

final List<Movies> movie4 = [
  Movies(
    image: AssetPath.story4,
    title: 'Testing 04',
    type: 'PPV',
    date: 'date": "14 june, 2024'
  ),
  Movies(
    image: AssetPath.story9,
    title: 'Testing 09',
    type: 'SBT',
    date: 'date": "14 june, 2024'
  ),
];

final List<Movies> movie5 = [
  Movies(
    image: AssetPath.story5,
    title: 'Testing 05',
    type: 'TTT',
    date: 'date": "14 june, 2024'
  ),
  Movies(
    image: AssetPath.story10,
    title: 'Testing 10',
    type: 'SBT',
    date: 'date": "14 june, 2024'
  ),
];


class Movies{
  Movies({
    this.image,
    this.title,
    this.type,
    this.date,
  });

  final String? image;
  final String? title;
  final String? type;
  final String? date; 
}

List<String> images = [
  AssetPath.story1,
  AssetPath.story2,
  AssetPath.story3,
  AssetPath.story4,
  AssetPath.story5,
  AssetPath.story6,
  AssetPath.story7,
  AssetPath.story8,
  AssetPath.story9,
  AssetPath.story10,
];