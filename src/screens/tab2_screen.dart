import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/theme/my_theme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const _CategoryList(),
          Expanded(
            child: NewsList(
              newsList: service.categoryArticles[service.selectedCategory]!,
            ),
          )
        ]),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var name = categories[index].name;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              _CategoryButton(category: categories[index]),
              const SizedBox(
                height: 5,
              ),
              Text('${name[0].toUpperCase()}${name.substring(1)}')
            ]),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final service = Provider.of<NewsService>(context, listen: false);
        service.selectedCategory = category.name;
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            category.icon,
            color: service.selectedCategory == category.name ? myTheme.colorScheme.secondary : Colors.black54,
          )),
    );
  }
}
