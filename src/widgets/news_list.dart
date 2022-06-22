import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_response.dart';
import 'package:news_app/src/theme/my_theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> newsList;
  const NewsList({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return _Header(article: newsList[index], idex: index);
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.article, required this.idex}) : super(key: key);
  final Article article;
  final int idex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          _CardTopBar(article: article, idex: idex),
          _TitleCard(article: article, idex: idex),
          _ImageCard(article: article),
          _CardBody(article: article),
          const SizedBox(height: 10),
          const Divider(thickness: 2, indent: 50, endIndent: 50),
          const _ButtonsCard()
        ],
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  const _CardTopBar({Key? key, required this.article, required this.idex}) : super(key: key);
  final Article article;
  final int idex;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text("${idex + 1}.", style: TextStyle(color: myTheme.colorScheme.secondary)),
        Text("${article.source?.name}.", style: TextStyle(color: myTheme.colorScheme.secondary))
      ]),
    );
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard({
    Key? key,
    required this.article,
    required this.idex,
  }) : super(key: key);
  final Article article;
  final int idex;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        article.title!,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: SizedBox(
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),

            child: article.urlToImage == null
                ? const Image(
                    height: 200,
                    width: double.infinity,
                    image: AssetImage('assets/no-image.jpg'),
                    fit: BoxFit.cover,
                  )
                : FadeInImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(article.urlToImage!),
                    placeholder: const AssetImage('assets/jar-loading.gif'),
                  )),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Text((article.description != null) ? article.description! : ''),
      ),
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  const _ButtonsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.colorScheme.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.star_border_outlined),
        ),
        const SizedBox(width: 10),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.more),
        )
      ]),
    );
  }
}
