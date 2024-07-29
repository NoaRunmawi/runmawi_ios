import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/BetterPlayer.dart';
import 'package:runmawi/TvShows.dart';

class MovieAdapter extends StatefulWidget {
  double? height;

  double? width;
  String? id;

  String? url;
  String? image;

  MovieAdapter(
      {Key? key, this.height, this.width, this.image, this.url, this.id})
      : super(key: key);

  @override
  State<MovieAdapter> createState() => _MovieAdapterState();
}

class _MovieAdapterState extends State<MovieAdapter> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.image.toString(),
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: () {
          if (widget.url.toString().contains("tvshow")) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TVShows(
                          VedioId: widget.id.toString(),
                        )));
          } else {
            print("going to drm");
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>HlsSubtitlesPage()));

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DrmPage(
                          widget.image.toString(),
                          vedioId: widget.id.toString(),
                        )));
          }
        },
        child: AspectRatio(
          aspectRatio: 16 / 11,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(),
      errorWidget: (context, url, error) => Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
                image: AssetImage(AppImages.demoMovieImage),
                fit: BoxFit.cover)),
      ),
    );
  }
}
