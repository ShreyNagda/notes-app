import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/signin_page.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

FirebaseAuth auth = FirebaseAuth.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return DynamicColorTheme(
        themedWidgetBuilder: (context, data) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => NoteProvider())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Notes App',
              theme: data,
              home: auth.currentUser != null
                  ? const HomePage()
                  : const SigninPage(),
            ),
          );
        },
        data: (Color color, bool isDark) {
          return buildTheme(color, isDark);
        },
        defaultColor: Colors.primaries.first.shade400,
        defaultIsDark: true,
      );
    });
  }

  ThemeData buildTheme(Color color, bool isDark) {
    ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
    Color backgroundColor =
        isDark ? const Color.fromARGB(115, 82, 82, 82) : Colors.white;
    Color accentColor = !isDark ? Colors.black87 : Colors.white;
    return base.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: color,
      textTheme: _buildTextTheme(base.textTheme, accentColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: color,
        foregroundColor: backgroundColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: color,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(color: color),
      iconTheme: IconThemeData(color: accentColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: backgroundColor,
      ),
      useMaterial3: true
    );
  }

  TextTheme _buildTextTheme(TextTheme base, Color color) {
    var fontFamily = GoogleFonts.aBeeZee().fontFamily;
    return base.copyWith(
      bodyMedium: base.bodyMedium!
          .copyWith(fontSize: 12.sp, color: color, fontFamily: fontFamily),
      bodyLarge: base.bodyLarge!.copyWith(
        color: color,
        fontSize: 14.sp,
        fontFamily: fontFamily,
      ),
      bodySmall: base.bodySmall!.copyWith(
        color: color,
        fontSize: 10.sp,
        fontFamily: fontFamily,
      ),
      titleSmall: base.titleSmall!.copyWith(
        color: color,
        fontSize: 18.sp,
        fontFamily: fontFamily,
      ),
      titleMedium: base.titleMedium!.copyWith(
        color: color,
        fontSize: 20.sp,
        fontFamily: fontFamily,
      ),
      titleLarge: base.titleLarge!.copyWith(
        color: color,
        fontSize: 22.sp,
        letterSpacing: 5,
        fontFamily: fontFamily,
      ),
    );
  }
}
