import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tvs.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTvs getPopularTvs;

  PopularTvNotifier(this.getPopularTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();

    result.fold(
      (failure)  {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      }, 
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      }
    );
  }
}
