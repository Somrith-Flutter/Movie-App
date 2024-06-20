import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/home/widgets/home_movie_detail.dart';
import 'package:legend_cinema/modules/home/widgets/movie_item.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<Movies> displayList = [];
  List<Movies> allMovies = [];
  bool isLoading = false;
  bool hasSearched = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    allMovies = [
      ...movie1,
      ...movie2,
      ...movie3,
      ...movie4,
      ...movie5,
      ...movie6,
      ...movie7,
      ...movie8,
    ];

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _focusNode.hasPrimaryFocus) {
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void updateList(String value) async {
    setState(() {
      isLoading = true;
      hasSearched = value.isNotEmpty;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      if (value.isEmpty) {
        displayList = [];
      } else {
        displayList = allMovies
            .where((movie) =>
                movie.title!.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(
          S.of(context).search,
          size: 22,
          bold: true,
        ),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: Colors.black,
      body: FocusScope(
        node: FocusScopeNode(),
        child: Column(
          children: [
            _buildBody(),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? _buildLoadingIndicator()
                  : (displayList.isEmpty
                      ? _showImages(hasSearched)
                      : _buildList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: S.of(context).search_cinema,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(0.8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: TextStyle(color: Colors.white.withOpacity(0.8)),
        onChanged: updateList,
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  AppRoute.route.push(context, HomeMovieDetail(list: displayList[index],));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(displayList[index].image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            displayList[index].title,
                            size: 16,
                            color: Colors.white,
                          ),
                          TextWidget(
                            displayList[index].release,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 40,
                thickness: 0.5,
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _showImages(bool hasSearched) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(AssetPath.searchIcon),
          ),
          const SizedBox(height: 20),
          TextWidget(
            hasSearched
                ? S.of(context).no_movie
                : S.of(context).search_cinema,
            size: 22,
            bold: true,
            color: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}