import 'package:flutter/material.dart';

class CustomThemes {
  // Flutter Theming Tool 1.0.0+10, developed by Tamata Soft
  static get mainTheme {
    // Initialize ThemeData.
    var theme = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    );

// ElevatedButton Setting.
    theme = theme.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.disabled)) {
              return Colors.blue;
            }
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.disabled)) {
              return const Color(0xff64b5f6);
            }
          }),
          elevation: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.disabled)) {
              return 3.0;
            }
          }),
          side: MaterialStateProperty.resolveWith(
            (states) {
              var isDisabled = states.contains(MaterialState.disabled);
              return BorderSide(
                color: (isDisabled)
                    ? const Color(0xff1e88e5).withOpacity(.15)
                    : const Color(0xff1e88e5),
              );
            },
          ),
          shape: MaterialStateProperty.all(
            const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );

// OutlinedButton Setting.
    theme = theme.copyWith(
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (!states.contains(MaterialState.disabled)) {
                return Colors.blue;
              }
            },
          ),
          overlayColor: MaterialStateProperty.all(Colors.blue.withOpacity(.15)),
          side: MaterialStateProperty.resolveWith(
            (states) {
              var isDisabled = states.contains(MaterialState.disabled);
              return BorderSide(
                color: (isDisabled)
                    ? const Color(0xff4fc3f7).withOpacity(.15)
                    : const Color(0xff4fc3f7),
                width: 0.0,
              );
            },
          ),
          shape: MaterialStateProperty.all(
            const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );

// TextButton Setting.
    theme = theme.copyWith(
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.disabled)) {
              return Colors.blue;
            }
          }),
          overlayColor: MaterialStateProperty.all(Colors.blue.withOpacity(.15)),
        ),
      ),
    );

// CheckBox Setting.
    theme = theme.copyWith(
      checkboxTheme: theme.checkboxTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );

// Card Setting.
    theme = theme.copyWith(
      cardTheme: theme.cardTheme.copyWith(
        shadowColor: const Color(0xffe3f2fd),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1.0),
            bottomLeft: Radius.circular(1.0),
            topRight: Radius.circular(1.0),
            bottomRight: Radius.circular(1.0),
          ),
          side: BorderSide(
            color: Color(0xffeeeeee),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        margin: const EdgeInsets.only(
          top: 10.0,
          left: 5.0,
          right: 5.0,
          bottom: 10.0,
        ),
      ),
    );

// Text Setting.
    theme = theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        caption: (theme.textTheme.caption ?? const TextStyle()).copyWith(
          shadows: [
            const Shadow(
              blurRadius: 0.0,
            )
          ],
        ),
      ),
    );

// Appbar Setting.
    theme = theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        iconTheme: (theme.appBarTheme.iconTheme ?? theme.iconTheme)
            .copyWith(color: const Color(0xffffffff)),
        elevation: 0.0,
        color: Colors.blue,
        textTheme: (theme.appBarTheme.textTheme ?? const TextTheme()).copyWith(
          headline6:
              (theme.appBarTheme.textTheme?.headline6 ?? const TextStyle())
                  .copyWith(
            fontSize: 20.0,
            shadows: [
              const Shadow(
                blurRadius: 0.0,
              )
            ],
          ),
        ),
      ),
    );
    return theme;
  }
}
