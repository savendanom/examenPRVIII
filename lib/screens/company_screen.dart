import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:project_movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CompanyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic company = ModalRoute.of(context)!.settings.arguments;

    print('dataInfo: ${company}');

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _MyAppBar(company: company),
          SliverList(
              delegate: SliverChildListDelegate([
            _CartelCompay(id: company['id']),
            _TituloSection(title: 'Logos'),
            LogosCompaniesCarrusel(idCompany: company['id']),
          ]))
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  final company;

  const _MyAppBar({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
          color: Colors.black12,
          child: Text(
            company['title'],
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/count-loading.gif'),
          image: NetworkImage(company['image']),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _CartelCompay extends StatelessWidget {
  final id;

  const _CartelCompay({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    final TextTheme customTextTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: moviesProvider.getInfoCompany(id),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('companie.name',
                        style: customTextTheme.headline5,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start),
                    Text('companie.name',
                        style: customTextTheme.subtitle1,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start)
                  ],
                )
              ],
            ),
          );
        }

        final CompanyResponse data = snapshot.data;

        return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name,
                      style: customTextTheme.headline5,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start),
                  Text(data.headquarters,
                      style: customTextTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start)
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _TituloSection extends StatelessWidget {
  final String title;

  const _TituloSection({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
