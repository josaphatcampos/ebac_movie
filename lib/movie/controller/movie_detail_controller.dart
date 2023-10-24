import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pre_projeto/common/services/repositories/movie_repository.dart';
import 'package:share_plus/share_plus.dart';

import '../../common/model/movie_detail_model.dart';

class MovieDetailController {
  MovieRepository repository = MovieRepository();

  MovieDetail movie = MovieDetail.fromDetail();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  void dispose() {
    isLoading.dispose();
  }

  void getMovie(int id) async {
    isLoading.value = true;
    movie = await repository.getMovieDetail(id);
    isLoading.value = false;
  }

  Future<void> capturePng(GlobalKey globalKey) async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;

    final image = await boundary.toImage();

    final ByteData? byteData =
        await image.toByteData(format: ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final Directory temp = await getTemporaryDirectory();

    File tempImage = File("${temp.path}/movies_ebac.png");

    tempImage.writeAsBytesSync(pngBytes);

    if (kDebugMode) {
      print(tempImage.path);
    }

    Share.shareFiles([tempImage.path],
        text: "Olha o que encontrei no Ebac Movies do Josaphat : \n\n${movie.title} \n\nSinopse: ${movie.overview} \nVeja no IMDB https://www.imdb.com/title/${movie.imdbId}"
    );
  }
}
