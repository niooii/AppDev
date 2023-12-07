import 'package:flutter/material.dart';
// import 'App0802.dart'; 
void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieTitlePage(),
    );
  }
}
class MovieTitlePage extends StatefulWidget {
  @override
  MovieTitlePageState createState() => MovieTitlePageState();
}
class MovieTitlePageState extends State<MovieTitlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Title',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: buildTitlePageCore(),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final overview = '(From themoviedb.com) One day at work, unsuccessful '
      'puppeteer Craig finds a portal into the head of actor John '
      'Malkovich. The portal soon becomes a passion for anybody who '
      'enters its mad and controlling world of overtaking another human '
      'body.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: buildDetailPageCore(context),
        ),
      ),
    );
  }
}


extension MoreMovieTitlePage on MovieTitlePageState {
  goToDetailPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(),
      ),
    );
  }

    Widget buildTitlePageCore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Being John Malkovich',textScaleFactor: 1.5,),
        SizedBox(height: 16.0),
        ElevatedButton.icon(
          icon: Icon(Icons.arrow_forward),
          label: Text('Details'), onPressed: goToDetailPage,
        ),
      ],
    );
  }
}
extension MoreDetailPage on DetailPage {
  Widget buildDetailPageCore(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(overview,),
      ],
    );
  }
}
