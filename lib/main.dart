import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:x_wet/models/day/day.dart';
import 'package:x_wet/models/days_month/days_month.dart';
import 'package:x_wet/models/month_data/year_data.dart';
import 'package:x_wet/models/user_data/user.dart';
import 'package:x_wet/ui/fill_data/ui/fill_data.dart';
import 'package:x_wet/ui/home/ui/home_screen.dart';
import 'package:x_wet/ui/onboarding/ui/onboarding.dart';
import 'package:x_wet/utils/color_palette/colors.dart';
import 'package:traffic_router/traffic_router.dart' as tr;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:apphud/apphud.dart';
import 'package:app_review/app_review.dart';
import 'dart:async';

final api = 'app_hDn2d5FAdFsDCRYcQ4sGNaEAUWqarc';
final productID = 'premium_water_drink';

final termsOfUse = 'https://docs.google.com/document/d/1LTFmlvf5qyutj3M47ABlnDZYcFx1mdjBRRXPbw_Ys1I/edit?usp=sharing';
final privacyPolicy = 'https://docs.google.com/document/d/1N83yGiqEasm5NB23R-dvljjTAC-tuSTqaLKPe687CuA/edit?usp=sharing';
final support = 'https://docs.google.com/forms/d/e/1FAIpQLSfIfWFbl34TesmZBTeNE3gSSugZMQDC3vjWLLilxVwyOkINmA/viewform?usp=sf_link';

// Этот контроллер подписки может использоваться в StreamBuilder
final StreamController<bool> subscribedController = StreamController.broadcast();
// Через эту переменную можно смотреть состояние подписки юзера
bool subscribed = false;
late Stream<bool> subscribedStream;
late StreamSubscription<bool> subT;

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> purchase() async {
    final res = await Apphud.purchase(productId: productID);
    if ((res.nonRenewingPurchase?.isActive ?? false) || kDebugMode) {
        subscribedController.add(true);
        return true;
    }
    return false;
}

// Закинуть на экран с покупкой, если вернул true, то закрыть экран покупки
// В дебаге этот метод вернет true
Future<bool> restore() async {
    final res = await Apphud.restorePurchases();
    if (res.purchases.isNotEmpty || kDebugMode) {
        subscribedController.add(true);
        return true;
    }
    return false;
}

// Эти 3 метода нужны для показа вебвью с пользовательским соглашением, саппортом. Оставить в этом файле (main.dart), вызывать из экрана покупки, настроек
openTermsOfUse() {
    launch(termsOfUse);
}
openPrivacyPolicy() {
    launch(privacyPolicy);
}
openSupport() {
    launch(support);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final trafficRouter = await tr.TrafficRouter.initialize(
    settings: tr.Settings(paramNames: tr.ParamNames(
      databaseRoot: 'json_wtrdrnk',
      baseUrl1: 'dimme',
      baseUrl2: 'yikke',
      url11key: 'fidra',
      url12key: 'quqar',
      url21key: 'kudur',
      url22key: 'pedro',
    ))
  );

  if (trafficRouter.url.isEmpty) {
    await Apphud.start(apiKey: api);
    subscribedStream = subscribedController.stream;
    subT = subscribedStream.listen((event) {
      subscribed = event;
    });
    if (await Apphud.isNonRenewingPurchaseActive(productID)) {
      subscribedController.add(true);
    }
    startMain();
  } else {
    AppReview.requestReview;
    if (trafficRouter.override) {
      await _launchInBrowser(trafficRouter.url);
    } else {
      runApp(MaterialApp(
        home: WebViewPage(
          url: trafficRouter.url,
        ),
      ));
    }
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webController;
  late String webviewUrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _enableRotation();
    webviewUrl = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if ((await _webController?.canGoBack()) ?? false) {
          await _webController?.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            gestureNavigationEnabled: true,
            initialUrl: webviewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (con) {
              print('complete');
              _webController = con;
            },
          ),
        ),
      ),
    );
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}


void startMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  Directory directory = Directory.current;
  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  Hive.init(directory.path);
  Hive..registerAdapter<UserData>(UserDataAdapter())
      ..registerAdapter<DayData>(DayDataAdapter())
      ..registerAdapter<MonthData>(MonthDataAdapter())
      ..registerAdapter<YearData>(YearDataAdapter());
  await Hive.openBox<YearData>('year');
  await Hive.openBox<UserData>('user');
  await purchase().then((value) => subscribed=value);
  // await Hive.box<YearData>('year').clear();
  // await Hive.deleteFromDisk();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_,column) => MaterialApp(
        darkTheme: ThemeData(
          selectedRowColor: AppColors.aquaBlue,
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
              button: TextStyle(
                fontSize: 45.sp,
              ),),
          splashColor: AppColors.white
        ),
        home: subscribed==true ? Hive.box<UserData>('user').isNotEmpty ? HomeScreen() : FillDataScreen() : OnBoardingScreen(),
      ),
    );
  }
}