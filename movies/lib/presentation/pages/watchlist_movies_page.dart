import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/common/utils.dart';
import 'package:movies/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    print("Init State MOVIE PAGE");
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //         .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    print("Change Dependency MOVIE PAGE");
    super.didChangeDependencies();
    // routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // @override
  // void didPopNext() {
  //   Provider.of<WatchlistMovieNotifier>(context, listen: false)
  //       .fetchWatchlistMovies();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistMovieNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: data.watchlistMovies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("UNSUBSCRIbe MOVIE PAGE");
    // routeObserver.unsubscribe(this);
    super.dispose();
  }
}
