import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _fontFamily = 'Lato';
final ThemeData theme = ThemeData();

/// main text [Color] (posts, replies, menu items etc.)
const _primaryColor = Color(0xFF18191B);

/// secondary text [Color] (subtitles, timestamps etc.)
const _secondaryTextColor = Color(0xFF676B78);

/// accent [Color] (accented UI elements like check marks)
const _secondaryColor = Colors.deepOrange;

/// darker accent [Color] (splash on accent buttons)
const _secondaryDark = Colors.deepOrangeAccent;

/// error [Color] (warnings, destructive actions)
const _errorColor = Color(0xFFD0021B);

/// disabled elements like disabled button borders or links
const _disabledColor = Color(0xFFB2B6C2);

/// background color for certain UI elements
const _canvasColor = Color(0xFFf1f2f5);

/// [Color] used for borders in gallery and background of
/// paragraph elements
const _cardColor = Color(0xFFf7f8ff);

/// [Color] used for the background of every page of the app
const _scaffoldColor = Color(0xFFFFFFFF);

/// [Color] used in certain smaller widgets for bright background
const _backgroundColor = Color(0xFFF1F2F5);

/// [Color] that
const _dividerColor = Color(0xFFD4D6DE);

/// [Color] used for unchecked activity centre messages
const _uncheckedColor = Color(0xFFEBF4FF);

const _bold = FontWeight.w700;
const _regular = FontWeight.w400;

const _primaryTextTheme = TextTheme(
  headline1: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 28, fontWeight: _bold),
  headline2: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 22, fontWeight: _bold),
  headline3: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 18, fontWeight: _bold),
  headline4: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 16, fontWeight: _bold),
  headline5: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 14, fontWeight: _bold),
  headline6: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 12, fontWeight: _bold),
  bodyText1: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 16, fontWeight: _regular),
  bodyText2: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 14, fontWeight: _regular),
  subtitle1: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 18, fontWeight: _regular),
  subtitle2: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 14, fontWeight: _bold),
  overline: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 14, fontWeight: _regular),
  caption: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 12, fontWeight: _regular),
  button: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 16, fontWeight: _bold),
);

const _secondaryTextTheme = TextTheme(
  headline1: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 28, fontWeight: _bold),
  headline2: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 22, fontWeight: _bold),
  headline3: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 18, fontWeight: _bold),
  headline4: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 16, fontWeight: _bold),
  headline5: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 14, fontWeight: _bold),
  headline6: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 12, fontWeight: _bold),
  bodyText1: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 16, fontWeight: _regular),
  bodyText2: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 14, fontWeight: _regular),
  subtitle1: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 18, fontWeight: _regular),
  subtitle2: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 14, fontWeight: _bold),
  overline: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 14, fontWeight: _regular),
  caption: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 12, fontWeight: _regular),
  button: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 16, fontWeight: _bold),
);

const _inputDecorationTheme = InputDecorationTheme(
  errorStyle: TextStyle(fontFamily: _fontFamily, color: _errorColor, fontSize: 16, fontWeight: _regular),
  hintStyle: TextStyle(fontFamily: _fontFamily, color: _secondaryTextColor, fontSize: 16, fontWeight: _regular),
  labelStyle: TextStyle(color: _secondaryColor),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: _secondaryColor, width: 2),
  ),
);

const _snackBarTheme = SnackBarThemeData(
  backgroundColor: _primaryColor,
  contentTextStyle: TextStyle(fontFamily: _fontFamily, fontSize: 14, color: Colors.white, fontWeight: _regular),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);

/// specifies the general appearance of [Icon]s
const _iconTheme = IconThemeData(color: _primaryColor);

/// specifies the general appearance of app bars
const _appBarTheme = AppBarTheme(
  color: _scaffoldColor,
  toolbarTextStyle: TextStyle(fontFamily: _fontFamily, color: _primaryColor, fontSize: 18, fontWeight: _bold),
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
  ),
);

const _tabTheme = TabBarTheme(
  indicatorSize: TabBarIndicatorSize.tab,
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(color: _secondaryColor, width: 2),
  ),
  labelStyle: TextStyle(
    fontFamily: _fontFamily,
    color: _primaryColor,
    fontSize: 16,
    fontWeight: _bold,
  ),
  unselectedLabelStyle: TextStyle(
    fontFamily: _fontFamily,
    color: _secondaryTextColor,
    fontSize: 16,
    fontWeight: _regular,
  ),
  labelColor: _primaryColor,
  unselectedLabelColor: _secondaryTextColor,
);

final lightThemeData = ThemeData(
  unselectedWidgetColor: _uncheckedColor,
  backgroundColor: _backgroundColor,
  disabledColor: _disabledColor,
  dividerColor: _dividerColor,
  indicatorColor: _secondaryColor,
  inputDecorationTheme: _inputDecorationTheme,
  errorColor: _errorColor,
  fontFamily: _fontFamily,
  scaffoldBackgroundColor: _scaffoldColor,
  iconTheme: _iconTheme,
  primaryIconTheme: _iconTheme,
  primaryTextTheme: _primaryTextTheme,
  textTheme: _secondaryTextTheme,
  snackBarTheme: _snackBarTheme,
  appBarTheme: _appBarTheme,
  tabBarTheme: _tabTheme,
  primaryColor: _primaryColor,
  secondaryHeaderColor: _secondaryTextColor,
  canvasColor: _canvasColor,
  cardColor: _cardColor,
  colorScheme: theme.colorScheme.copyWith(
    secondary: _secondaryColor,
    secondaryContainer: _secondaryDark,
    onSecondary: Colors.white,
  ),
);
