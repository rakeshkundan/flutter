import 'package:flutter/cupertino.dart';
import 'package:movie/services/networking.dart';
import 'package:movie/utilities/category_list.dart';

class CategoryData extends ChangeNotifier {
  List<Future> data = [];

  void fetchCategoryData() async {
    for (var category in CategoryList().category) {
      var fetchedData = await NetworkHelper(
              url:
                  'https://api.themoviedb.org/3/movie/${category.searchId}?api_key=b195f787962173c1ee91ddc986379adc&region=IN&page=1')
          .getData();
      data.add(fetchedData);
    }
  }
}
