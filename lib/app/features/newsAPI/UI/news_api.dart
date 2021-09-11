import 'package:codelabs/app/core/data/model/news_api_response_mode.dart';
import 'package:codelabs/app/core/utils/constants.dart';
import 'package:codelabs/app/core/widget/elv_button.dart';
import 'package:codelabs/app/features/newsAPI/controller/getx_news_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsApiScreen extends StatefulWidget {
  NewsApiScreen({Key? key}) : super(key: key);

  @override
  _NewsApiScreenState createState() => _NewsApiScreenState();
}

class _NewsApiScreenState extends State<NewsApiScreen> {
  final String _TAG = "NewsApiScreen";

  final GetX_New_Api_Controller _getX_NewsApi_Controller =
      Get.put(GetX_New_Api_Controller());

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _getX_NewsApi_Controller.fetchNewsDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    print("BMC- $_TAG: rebuilt");
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News'),
        ),
        backgroundColor: KColor.background,
        body: RefreshIndicator(
          onRefresh: () => _getX_NewsApi_Controller.fetchNewsDataFromApi(),
          child: Column(
            children: [
              Obx(() {
                return getSearchBarUI();
              }),
              Obx(() {
                return _body();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
      child: SizedBox(
        width: Get.width,
        height: 64,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Container(
            decoration: const BoxDecoration(
              color: KColor.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: _onSearchTextChanged,
                      style: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: KColor.kPrimaryLightColor,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: InputBorder.none,
                        helperStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: KColor.kPrimaryColor,
                        ),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          height: 0.8,
                          color: KColor.kPrimaryLightColor,
                        ),
                      ),
                      onEditingComplete: () {},
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: _getX_NewsApi_Controller.searchNewsList.length != 0 ||
                          _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.red),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchTextChanged("");
                          },
                        )
                      : const Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    if (_getX_NewsApi_Controller.isLoading.value) {
      return const Expanded(
        child: Center(
          child: SpinKitCircle(
            color: KColor.kPrimaryColor,
            size: 50.0,
          ),
        ),
      );
    } else {
      if (_getX_NewsApi_Controller.newsList.isNotEmpty) {
        return _getX_NewsApi_Controller.searchNewsList.length != 0 ||
                _searchController.text.isNotEmpty
            ? buildListViewBuilder(_getX_NewsApi_Controller.searchNewsList)
            : buildListViewBuilder(_getX_NewsApi_Controller.newsList);
      } else {
        return Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Elv_Button(
                      labelText: "Try Again",
                      callback: () {
                        _getX_NewsApi_Controller.fetchNewsDataFromApi();
                      })
                ],
              ),
            ),
          ),
        );
      }
    }
  }

  Widget _singleCard(NewsApiResponseModel newsListModel) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: KColor.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey, offset: Offset(1.1, 1.1), blurRadius: 10.0),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        maintainState: true,
        trailing: Icon(Icons.keyboard_arrow_down, size: 30.0),
        title: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 16.0, bottom: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'ID',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: KColor.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.1,
                    color: KColor.darkText),
              ),
              Text(
                newsListModel.id.toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: KColor.fontName,
                  fontSize: 16,
                  color: KColor.kPrimaryLightColor,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Title',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: KColor.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.1,
                    color: KColor.darkText),
              ),
              const SizedBox(height: 5),
              Text(
                newsListModel.title.toString(),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: KColor.fontName,
                  fontSize: 16,
                  color: KColor.kPrimaryLightColor,
                ),
              )
            ],
          ),
        ),
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
            child: Container(
              height: 2,
              decoration: const BoxDecoration(
                color: KColor.background,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: newsListModel.summary == null
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Summary',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: KColor.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: KColor.darkText),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              newsListModel.summary.toString(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontFamily: KColor.fontName,
                                fontSize: 16,
                                color: KColor.kPrimaryLightColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                ),
                const Text(
                  'Link',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: KColor.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.1,
                      color: KColor.darkText),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => _launchURL(newsListModel.link.toString()),
                  child: Text(
                    newsListModel.link.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: KColor.fontName,
                      fontSize: 16,
                      color: KColor.lightText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: newsListModel.image == null
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(newsListModel.image.toString()),
                        ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Published',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: KColor.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.1,
                      color: KColor.darkText),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: KColor.grey.withOpacity(0.5),
                      size: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        newsListModel.published.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: KColor.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: KColor.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBoxUI() {
    return Container(
      decoration: BoxDecoration(
        color: KColor.kPrimaryLightColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.edit,
          color: KColor.kPrimaryLightColor,
          size: 22,
        ),
      ),
    );
  }

  Widget buildListViewBuilder(List<NewsApiResponseModel> _list) {
    return Expanded(
      child: AnimationLimiter(
        child: ListView.builder(
            //shrinkWrap: true,
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: _list.length,
            // itemBuilder: (context, index) => _singleCard(_list[index]),
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 100.0,
                  child: FadeInAnimation(
                    child: _singleCard(_list[index]),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _onSearchTextChanged(String text) async {
    _getX_NewsApi_Controller.clearSearchResult();
    if (text.isEmpty) {
      return;
    }
    if (_getX_NewsApi_Controller.newsList.isNotEmpty) {
      _getX_NewsApi_Controller.newsList.forEach((userDetail) {
        if (userDetail.title!.toLowerCase().contains(text.toLowerCase())) {
          _getX_NewsApi_Controller.addIntoSearchResult(userDetail);
        }
      });
    }
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
