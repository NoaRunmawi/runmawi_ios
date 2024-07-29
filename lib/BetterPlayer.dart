import 'dart:async';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:runmawi/AppUtils/AppImages.dart';
import 'package:runmawi/AppUtils/Colors.dart';
import 'package:runmawi/AppUtils/DefaultButton.dart';
import 'package:runmawi/AppUtils/MethodUtils.dart';
import 'package:runmawi/AppUtils/prefs.dart';
import 'package:runmawi/AppUtils/textstyle.dart';
import 'package:runmawi/Model/VedioDetails.dart';
import 'package:runmawi/Ratings.dart';
import 'package:runmawi/Repositery/Homepage.dart';
import 'package:runmawi/Repositery/RazorPay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:runmawi/Webviewplay.dart';

class DrmPage extends StatefulWidget {

  String? vedioId;

  String? image;

  DrmPage(this.image, {this.vedioId});

  @override
  _DrmPageState createState() => _DrmPageState();
}

class _DrmPageState extends State<DrmPage> {
  late BetterPlayerController _widevineController;
  late BetterPlayerConfiguration betterPlayerConfiguration;
  MovieModel? movieModel;
  late BetterPlayerDataSource _betterPlayerDataSource;

  final StreamController<bool> _playController = StreamController.broadcast();
  final StreamController<bool> _controller = StreamController.broadcast();
  final StreamController<bool> _placeholderStreamController = StreamController.broadcast();
  bool _showPlaceholder = true;
  bool isLoading = true;

  ValueNotifier<String> saveMovie = ValueNotifier("0");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _placeholderStreamController.close();
  }

  @override
  void initState() {

    betterPlayerConfiguration =
    const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      // controlsConfiguration:
      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
        // backgroundColor: Colors.green,
        leftPadding: 5,
        rightPadding: 5,
        fontColor: Colors.white,
        outlineColor: Colors.black,
        fontSize: 15,
      ),
    );


    // _setupDataSource();

    _callData();

    super.initState();
  }


  Future<void> _callData() async {

   // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);


    var userId =
    await AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id);

    try {
      var response = await HomeRepository().homeApi({
        "type": "video_detail",
        "video_id": widget.vedioId.toString(),
        "user_id": userId,
        "build_type": "2"
      });

      isLoading = true;
      setState(() {});

      movieModel = MovieModel.fromJson(response.value);

      if (movieModel!.status == true) {
        _widevineController = BetterPlayerController(betterPlayerConfiguration);
        saveMovie.value = movieModel!.data![0].user_save_movie.toString();

        var subtitle = movieModel?.data?[0].direct_url;
        var subtitle1 = await Utils.getFileUrl(Constants.fileExampleSubtitlesUrl);
        print("subtitle====$subtitle");
        print("subtitle1====$subtitle1");

        var streamApiHostName="https://video.bunnycdn.com";
        var libraryId="270162";
        var videoId=""+movieModel!.data![0].bunny_video_id.toString();
        var storageZoneId="vz-408b4d55-9c6";
        var storageDomain="b-cdn.net";

        String video_id=""+movieModel!.data![0].bunny_video_id.toString();

        //  int buffer="${movieModel!.data![0].quality.toString()}" as int;

        String a=movieModel!.data![0].quality.toString();

        int buffer = int.parse(a);

        //  int buffer =100000;



        String auth_token=movieModel!.data![0].auth_token.toString();
        String expiration_timestamp=movieModel!.data![0].expiration_timestamp.toString();


        var wvLicenseUri=streamApiHostName+"/WidevineLicense/"+libraryId+"/"+videoId+"?token="+auth_token+"&expires="+expiration_timestamp;
        //var fpCertificateUri=streamApiHostName+"/FairPlay/"+libraryId+"/certificate";

        BetterPlayerDataSource dataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          "https://"+storageZoneId+"."+storageDomain+"/"+videoId+"/playlist.m3u8",

          // notificationConfiguration: BetterPlayerNotificationConfiguration(
          //   showNotification: true,
          //   title: ""+movieModel!.data![0].title.toString(),
          //   author: "Director : "+movieModel!.data![0].director.toString(),
          //   imageUrl: ""+movieModel!.data![0].img.toString(),
          //   activityName: "MainActivity",
          // ),

          drmConfiguration: BetterPlayerDrmConfiguration(
            drmType: BetterPlayerDrmType.widevine,
            licenseUrl: wvLicenseUri,
            headers: {"Referer": "https://runmawi.in" },

          ),

          bufferingConfiguration: BetterPlayerBufferingConfiguration(
            maxBufferMs: buffer,
            bufferForPlaybackMs: 2500,
            bufferForPlaybackAfterRebufferMs: 5000,
          ),



          //  placeholder: BetterPlayerController(betterPlayerConfiguration),

          cacheConfiguration: BetterPlayerCacheConfiguration(
            useCache: true,
            maxCacheFileSize:  10 * 1024 * 1024,
            maxCacheSize:  10 * 1024 * 1024,
            preCacheSize:  2 * 1024 * 1024,
            key: video_id,

          ),


          subtitles: BetterPlayerSubtitlesSource.single(

            type: BetterPlayerSubtitlesSourceType.file,
            // url: await Utils.getFileUrl(Constants.fileExampleSubtitlesUrl),
            url: subtitle1,
            name: "SubTitle",
            selectedByDefault: false,

            // content: "this content of Subtitle is demo ghjghghjb n ygvgh vhgvytgfyhgnb  hgcyhg nhcvychb  hygh vhbn  nb h nb n hg hnb nb nh n kbjhbjhbjhbjhbjhbjhbjhbjbjbjbjbjbjbhhvbhvbhh uhguhgug uygug yuguihiuhi iuhiuhiuhj ui huihj uihiu h kj ij ui h "
          ),
        );

        _widevineController.addEventsListener((event) {
          if (event.betterPlayerEventType == BetterPlayerEventType.play) {
            _setPlaceholderVisibleState(false);
          }
          if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
            print("Current subtitle line: " +
                _widevineController.renderedSubtitle.toString());
          }
        });


        isLoading = false;
        setState(() {});

        _widevineController.setupDataSource(dataSource);
        setState(() {});


        // _widevineController.setControlsEnabled(f)

        // BetterPlayerConfiguration controller=BetterPlayerConfiguration( );


      } else {
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool checkValidity(String? validTill) {
    print("till Date$validTill");
    // If validTill is null, return false
    if (validTill == null || validTill.toString().isEmpty) {
      return false;
    }

    // Parse the validTill date and time
    DateTime validTillDateTime;
    try {
      validTillDateTime = DateFormat('dd-MMM-yy hh:mm a').parse(validTill);
    } catch (e) {
      print("euuuuu$e");
      // If parsing fails, return false
      return false;
    }
    // Get the current date and time
    DateTime currentDateTime = DateTime.now();

    // Check if the validTill date and time is in the future
    return validTillDateTime.isAfter(currentDateTime);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.commonBackgroundPath),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: isLoading && movieModel == null
                ? Padding(
                padding: EdgeInsets.only(top: height / 2.3),
                child: const Center(child: CircularProgressIndicator()))
                : Column(
              children: [


                _buildAppBarRow(""+movieModel!.data![0].title.toString()),

                // _buildOverlay(),

                //
                // movieModel!.data![0].type.toString()=="Free"||(movieModel!.data![0].validTill.toString().isNotEmpty&&movieModel!.data![0].validTill!=null)  ?



                //     movieModel!.data![0].super_user.toString()=="1"? //super user check na
                // Stack(
                //   children: [
                //     Positioned(
                //
                //       child: AspectRatio(aspectRatio: 16 / 9,
                //              child: BetterPlayer(controller: _widevineController,  ),
                //       )
                //     ),
                //     Positioned(
                //       top: 10,
                //       right: 10,
                //       child: Image.asset(
                //         'assets/Images/superuser.gif',
                //         fit: BoxFit.cover,
                //         width: 40,
                //         height: 40,
                //       ),
                //     ),
                //
                //   ],
                // ) :


                FadeInImage.assetNetwork(
                    placeholder: 'assets/Images/placeholder.jpg',
                    image:"${movieModel!.data![0].img.toString()}"
                ),

                movieModel!.data![0].super_user.toString()=="1"? //super user check na  (if)

                DefaultButton(
                  text:
                  "Watch Now ",
                  onpress: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPlay(""+movieModel!.data![0].title.toString(), movieModel!.data![0].embed_auth_url.toString())));
                  },

                  margin: const EdgeInsets.only(
                      top: 10, left: 16, right: 16),
                  height: 40,
                  borderRadius: 16,
                  color: Colors.blue.withOpacity(0.8),
                  bordercolor: AppColor.secondaryBlackColor,
                  style: Styles.style_White(
                      fontWeight: FontWeight.w400, fontsize: 16),
                ) :


                Container(),


                checkValidity(movieModel!.data![0].validTill.toString()) ? // lei leh lei loh check na  ( if )
                DefaultButton(
                  text:
                  "Watch Now ",
                  onpress: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPlay(""+movieModel!.data![0].title.toString(), movieModel!.data![0].embed_auth_url.toString())));
                  },

                  margin: const EdgeInsets.only(
                      top: 10, left: 16, right: 16),
                  height: 40,
                  borderRadius: 16,
                  color: Colors.blue.withOpacity(0.8),
                  bordercolor: AppColor.secondaryBlackColor,
                  style: Styles.style_White(
                      fontWeight: FontWeight.w400, fontsize: 16),
                ) :  // (else)
                // Image.network("${movieModel!.data![0].img.toString()}"),




                checkValidity(movieModel!.data![0].validTill.toString()) ?// lei leh lei loh check na  (if)
                Container( ) :
                DefaultButton(
                  text:
                  "₹ Rent This Movie",
                  onpress: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(

                          title: Text("${movieModel!.data![0].title.toString()}"),
                          content: Text("After payment is successful, you can watch the movie for 3 days.\n\nPlease select movie quality :\n(Inclusive all GST 18%)"),
                          actions: <Widget>[


                            movieModel!.data![0].ppvCost_three.toString()=="0.00"?
                            Container( ) :
                            TextButton(
                              child: Text("Low  quality ₹ ${movieModel!.data![0].ppvCost_three.toString()}"),
                              onPressed:() async {

                                MethodUtils.showToast("Lo nghak lawk...");
                                String userId = await AppPrefrence.getString(
                                    AppConstants.SHARED_PREFERENCE_USER_Id);
                                RazorPayPaymentIntegration razorPay =
                                RazorPayPaymentIntegration(
                                    callback: _callData);
                                // razorPay.amount = 1.00;
                                razorPay.amount = num.parse(movieModel!.data![0].ppvCost_three);
                                razorPay.userName =
                                await AppPrefrence.getString(AppConstants
                                    .SHARED_PREFERENCE_USER_name);
                                razorPay.contactNumber =
                                await AppPrefrence.getString(AppConstants
                                    .SHARED_PREFERENCE_USERMOBILE);
                                razorPay.categoryId =
                                    movieModel!.data![0].category.toString();
                                razorPay.videoId = widget.vedioId.toString();
                                razorPay.userId = userId;
                                razorPay.quality = "low";
                                razorPay.context = context;
                                await razorPay.initiliazation();
                                Navigator.of(context).pop();
                              },
                            ),

                            movieModel!.data![0].ppvCost_two.toString()=="0.00"?
                            Container( ) :
                            TextButton(
                              child: Text("Medium  quality ₹ ${movieModel!.data![0].ppvCost_two.toString()}"),
                              onPressed:() async {
                                MethodUtils.showToast("Lo nghak lawk...");
                                String userId = await AppPrefrence.getString(
                                    AppConstants.SHARED_PREFERENCE_USER_Id);
                                RazorPayPaymentIntegration razorPay =
                                RazorPayPaymentIntegration(
                                    callback: _callData);
                                // razorPay.amount = 1.00;
                                razorPay.amount = num.parse(movieModel!.data![0].ppvCost_two);
                                razorPay.userName =
                                await AppPrefrence.getString(AppConstants
                                    .SHARED_PREFERENCE_USER_name);
                                razorPay.contactNumber =
                                await AppPrefrence.getString(AppConstants
                                    .SHARED_PREFERENCE_USERMOBILE);
                                razorPay.categoryId =
                                    movieModel!.data![0].category.toString();
                                razorPay.videoId = widget.vedioId.toString();
                                razorPay.userId = userId;
                                razorPay.quality = "mid";
                                razorPay.context = context;
                                await razorPay.initiliazation();
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text("High  quality ₹ ${movieModel!.data![0].ppvCost.toString()}"),
                              onPressed:() async {

                                MethodUtils.showToast("Lo nghak lawk...");
                                String userId = await AppPrefrence.getString(
                                    AppConstants.SHARED_PREFERENCE_USER_Id);
                                RazorPayPaymentIntegration razorPay =
                                RazorPayPaymentIntegration(
                                    callback: _callData);
                                // razorPay.amount = 1.00;
                                razorPay.amount = num.parse(movieModel!.data![0].ppvCost);
                                razorPay.userName =
                                await AppPrefrence.getString(AppConstants
                                    .SHARED_PREFERENCE_USER_name);
                                razorPay.contactNumber =
                                await AppPrefrence.getString(AppConstants
                                    .SHARED_PREFERENCE_USERMOBILE);
                                razorPay.categoryId ="1";
                                razorPay.videoId = widget.vedioId.toString();
                                razorPay.userId = userId;
                                razorPay.quality = "high";
                                razorPay.context = context;
                                await razorPay.initiliazation();
                                Navigator.of(context).pop();
                              },
                            ),

                          ],
                        );
                      },
                    );

                  },
                  // onpress: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification())),
                  //  gradient: MethodUtils.gradients(),
                  margin: const EdgeInsets.only(
                      top: 10, left: 16, right: 16),
                  height: 40,
                  borderRadius: 16,
                  color: Colors.blue.withOpacity(0.8),
                  bordercolor: AppColor.secondaryBlackColor,
                  style: Styles.style_White(
                      fontWeight: FontWeight.w400, fontsize: 16),
                ),



                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: Row(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: saveMovie,
                          builder: (context, isSave, Widget) {
                            return _buildRow(
                                isSave.toString() == "0"
                                    ? "assets/Images/ic_save.png"
                                    : "assets/Images/ic_savedMovie.png",
                                "Save for Later", () async {
                              //       MethodUtils.showLoader(context);
                              var userId = await AppPrefrence.getString(
                                  AppConstants.SHARED_PREFERENCE_USER_Id);
                              HomeRepository().homeApi({
                                "type": "save_video",
                                "user_id": userId.toString(),
                                "video_id": widget.vedioId,
                                "status":
                                isSave.toString() == "0" ? "1" : "0"
                              }).then((value) {
                                if (value.value['status'] == true) {
                                  isSave.toString() == "0"
                                      ? saveMovie.value = "1"
                                      : saveMovie.value = "0";
                                  //    Navigator.pop(context);
                                  //   MethodUtils.hideLoader(context);
                                  //  saveMovie.value = "1";
                                  MethodUtils.showToast(
                                      value.value['message']);
                                } else {
                                  saveMovie.value = "0";
                                  //    MethodUtils.hideLoader(context);
                                  MethodUtils.showToast(
                                      value.value['message']);
                                }
                              }).catchError((e) {
                                //   MethodUtils.hideLoader(context);
                                MethodUtils.showToast(e.toString());
                              });
                            });
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      movieModel!.data![0].user_rating.toString() == "0"
                          ? _buildRow(
                          "assets/Images/ic_like.png", "Rating", () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShareRating(
                                  vedioId: movieModel!
                                      .data![0].id
                                      .toString(),
                                  callback: _callData,
                                )));
                      })
                          : Expanded(child: Container()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                            movieModel!.data![0].title.toString(),
                            style: Styles.style_White(
                                fontsize: 24, fontWeight: FontWeight.w600),
                          )),
                      movieModel!.data![0].average_rating.toString() ==
                          "0"
                          ? Container()
                          : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xffF6C700),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            movieModel!.data![0].average_rating
                                .toString(),
                            style: Styles.style_White(
                                fontsize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                    padding:
                    const EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Html(
                      data: movieModel!.data![0].html.toString(),
                      style: {},
                    )),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildAppBarRow( String title) {
    return Row(

      children: [
        GestureDetector(
          onTap: ()
          {
            Navigator.pop(context);
          },

          child: Image.asset(
            AppImages.barBackImage,
            scale: 2,

          ),
        ),
        SizedBox(
          width: 10,
        ),

      ],
    );
  }


  Widget _buildRow(String image, String text, void Function() ontap) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                scale: 2,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: Styles.style_White(
                    fontsize: 14, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return StreamBuilder<bool>(
      stream: _placeholderStreamController.stream,
      builder: (context, snapshot) {
        return _showPlaceholder
            ? Image.network(
          widget.image.toString(),
          fit: BoxFit.fill,
        )
            : const SizedBox();
      },
    );
  }

  void _setPlaceholderVisibleState(bool hidden) {
    _placeholderStreamController.add(hidden);
    _showPlaceholder = hidden;
  }

  Widget _buildPlaceholder() {
    return StreamBuilder<bool>(
      stream: _playController.stream,
      builder: (context, snapshot) {
        bool showPlaceholder = snapshot.data ?? true;

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: showPlaceholder ? 1.0 : 0.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: showPlaceholder
                ? Image.network(
              widget.image.toString(),
              fit: BoxFit.fill,
            )
                : Container(),
          ),
        );
      },
    );
  }

  Widget _buildOverlay() {
    return StreamBuilder<bool>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        bool showOverlay = snapshot.data ?? false;

        return showOverlay
            ? const Center(
          child: Text(
            "Rishi Sir",
            style: TextStyle(color: Colors.red),
          ),
        )
            : Container();
      },
    );
  }
}

class Constants {
  static const String bugBuckBunnyVideoUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  static const String forBiggerBlazesUrl =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
  static const String fileTestVideoUrl = "testvideo.mp4";
  static const String fileTestVideoEncryptUrl = "testvideo_encrypt.mp4";
  static const String networkTestVideoEncryptUrl =
      "https://github.com/tinusneethling/betterplayer/raw/ClearKeySupport/example/assets/testvideo_encrypt.mp4";
  static const String fileExampleSubtitlesUrl = "example_subtitles.srt";
  static const String hlsTestStreamUrl =
      "https://mtoczko.github.io/hls-test-streams/test-group/playlist.m3u8";
  static const String hlsPlaylistUrl =
      "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8";
  static const Map<String, String> exampleResolutionsUrls = {
    "LOW":
    "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
    "MEDIUM":
    "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4",
    "LARGE":
    "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4",
    "EXTRA_LARGE":
    "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4"
  };
  static const String phantomVideoUrl =
      "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8";
  static const String elephantDreamVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
  static const String forBiggerJoyridesVideoUrl =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4";
  static const String verticalVideoUrl =
      "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4";
  static String logo = "logo.png";
  static String placeholderUrl =
      "https://imgix.bustle.com/uploads/image/2020/8/5/23905b9c-6b8c-47fa-bc0f-434de1d7e9bf-avengers-5.jpg";
  static String elephantDreamStreamUrl =
      "http://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8";
  static String tokenEncodedHlsUrl =
      "https://amssamples.streaming.mediaservices.windows.net/830584f8-f0c8-4e41-968b-6538b9380aa5/TearsOfSteelTeaser.ism/manifest(format=m3u8-aapl)";
  static String tokenEncodedHlsToken =
      "Bearer=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1cm46bWljcm9zb2Z0OmF6dXJlOm1lZGlhc2VydmljZXM6Y29udGVudGtleWlkZW50aWZpZXIiOiI5ZGRhMGJjYy01NmZiLTQxNDMtOWQzMi0zYWI5Y2M2ZWE4MGIiLCJpc3MiOiJodHRwOi8vdGVzdGFjcy5jb20vIiwiYXVkIjoidXJuOnRlc3QiLCJleHAiOjE3MTA4MDczODl9.lJXm5hmkp5ArRIAHqVJGefW2bcTzd91iZphoKDwa6w8";
  static String widevineVideoUrl =
      "https://runmawioutput.sgp1.cdn.digitaloceanspaces.com/videos/dash/Gabriel/master.mpd";
  static String widevineLicenseUrl =
      "https://widevine-dash.ezdrm.com/widevine-php/widevine-foreignkey.php?pX=7CD245'";
  static String fairplayHlsUrl =
      "https://fps.ezdrm.com/demo/hls/BigBuckBunny_320x180.m3u8";
  static String fairplayCertificateUrl =
      "https://github.com/koldo92/betterplayer/raw/fairplay_ezdrm/example/assets/eleisure.cer";
  static String fairplayLicenseUrl = "https://fps.ezdrm.com/api/licenses/";
  static String catImageUrl =
      "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg";
  static String dashStreamUrl =
      "https://bitmovin-a.akamaihd.net/content/sintel/sintel.mpd";
  static String segmentedSubtitlesHlsUrl =
      "https://eng-demo.cablecast.tv/segmented-captions/vod.m3u8";
}

class Utils {
  static Future<String> getFileUrl(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }
}