import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../_services/logger_services/c_logger_controller.dart';
import '../../_services/logger_services/m_logger_model.dart';
import '../../_services/theme_services/c_theme_controller.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void saveLogFromException(e1, e2) {
  Get.find<LoggerController>().insertNewLog(
      log: LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
}

double getScreenScaleFactor({Size sampleUiSize = const Size(430, 932)}) {
  try {
    return ((Get.width / sampleUiSize.width) +
            (Get.height / sampleUiSize.height)) /
        2;
  } catch (e1, e2) {
    saveLogFromException(e1, e2);
    return 1;
  }
}

void vibrateNow() {
  try {
    HapticFeedback.selectionClick();
  } catch (e1, e2) {
    saveLogFromException(e1, e2);
    null;
  }
}

void superPrint(var content, {var title = 'Super Print'}) {
  String callerFrame = '';

  if (kDebugMode) {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split("\n");
      callerFrame = frames[1];
    } catch (e1, e2) {
      debugPrint(e1.toString(), wrapWidth: 1024);
      saveLogFromException(e1, e2);
    }

    DateTime dateTime = DateTime.now();
    String dateTimeString =
        '${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}.${dateTime.millisecond}';
    debugPrint('', wrapWidth: 1024);
    debugPrint(
        '- ${title.toString()} - ${callerFrame.split('(').last.replaceAll(')', '')}',
        wrapWidth: 1024);
    debugPrint('____________________________');
    try {
      debugPrint(
          const JsonEncoder.withIndent('  ')
              .convert(const JsonDecoder().convert(content)),
          wrapWidth: 1024);
    } catch (e1, e2) {
      try {
        debugPrint(
            const JsonEncoder.withIndent('  ')
                .convert(const JsonDecoder().convert(jsonEncode(content))),
            wrapWidth: 1024);
      } catch (e1, e2) {
        debugPrint(content.toString());
        // saveLogFromException(e1,e2);;
      }
      // saveLogFromException(e1,e2);;
    }
    debugPrint('____________________________ $dateTimeString');
  }
}

String numberFormat(String numString) {
  return NumberFormat('#,##0').format(int.parse(numString));
}

class AppFunctions {
  // Future<XFile?> pickImage(
  //     {required ImageSource imageSource}) async {
  //   var image = await ImagePicker()
  //       .pickImage(source: imageSource, maxHeight: 720, maxWidth: 1080);
  //   if(image!= null){
  //     return image;
  //   }else{
  //     return null;
  //   }
  // }
  int calculateMaxPage(int productsLength, int size) {
    if (productsLength % size == 0) {
      return productsLength ~/ size;
    } else {
      return (productsLength ~/ size) + 1;
    }
  }

  static void pushTo(dynamic page, {Map<String, dynamic>? arg}) {
    Get.to(page, arguments: arg)!.then(
      (value) {
        Future.delayed(const Duration(milliseconds: 100)).then(
          (value) {
            ThemeController themeController = Get.find();
            themeController.update();
          },
        );
      },
    );
  }

  void addScrollEndListener(
      {required ScrollController scrollController,
      required Function() onReachBottom}) {
    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          bool isBottom = scrollController.position.pixels != 0;
          if (isBottom) {
            onReachBottom();
          }
        }
      },
    );
  }

  String hideMiddleCharacters(String input, int start) {
    if (input.length < 6) {
      // Not enough characters to hide
      return input;
    }

    // Replace characters in the middle with asterisks
    int startIndex = start;
    int endIndex = input.length - 4;
    String hiddenPart = '*' * (endIndex - startIndex + 1);
    String result = input.replaceRange(startIndex, endIndex + 1, hiddenPart);

    return result;
  }

  String convertMinutesToHoursAndMinutes(int minutes) {
    if (minutes < 0) {
      return "Invalid input";
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (hours == 0) {
      return "${remainingMinutes}min";
    } else if (remainingMinutes == 0) {
      return "${hours}hr";
    } else {
      return "${hours}hr ${remainingMinutes}min";
    }
  }

  dynamic parseEnum<T>({
    required List<Enum> values,
    required String query,
    required Enum defaultValue,
  }) {
    dynamic result = defaultValue;
    try {
      result = values.where((element) {
            return query.toUpperCase() == element.name.toUpperCase();
          }).firstOrNull ??
          defaultValue;
    } catch (e1, e2) {
      Get.find<LoggerController>().insertNewLog(
          log:
              LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
      null;
    }
    return result;
  }

  bool isSameDay({required DateTime dateTime1, required DateTime dateTime2}) {
    return dateTime1.toString().substring(0, 10) ==
        dateTime2.toString().substring(0, 10);
  }

  List<DateTime> getBetweenDates({required DateTimeRange dtr}) {
    List<DateTime> result = [];
    DateTime tempDate = dtr.start;
    do {
      result.add(tempDate);
      tempDate = tempDate.add(const Duration(days: 1));
    } while (!isSameDay(
        dateTime1: tempDate, dateTime2: dtr.end.add(const Duration(days: 1))));
    return result;
  }

  ///if xStartWithMonday is false, the result will be started in Sunday
  List<int?> getCalendarData(
      {required DateTime dateTime, bool xStartWithMonday = false}) {
    if (xStartWithMonday) {
      return _getCalendarDataWithMondayStart(dateTime: dateTime);
    } else {
      return _getCalendarDataWithSundayStart(dateTime: dateTime);
    }
  }

  List<int?> _getCalendarDataWithSundayStart({required DateTime dateTime}) {
    int startWeekDay = 7;

    //toIncreaseNextWeek
    int endWeekDay = {
      1: 7,
      2: 1,
      3: 2,
      4: 3,
      5: 4,
      6: 5,
      7: 6,
    }[startWeekDay]!;

    //1=Monday, 7=Sunday
    DateTimeRange dateTimeRange =
        AppFunctions().getCurrentMonth(dateTime: dateTime);
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    int currentDay = 1;
    int currentWeek = 1;
    List<int?> data = List.generate(42, (index) => null);
    do {
      DateTime thatDay = start.copyWith(day: currentDay);
      int weekday = (thatDay.weekday);
      int rowIndex = (startWeekDay + weekday) % 7;
      final currentWeekIndex = currentWeek - 1;
      int index = rowIndex + (currentWeekIndex * 7);

      data[index] = currentDay;
      currentDay++;
      if (weekday == endWeekDay) {
        //sunday
        currentWeek++;
      }
    } while (currentDay <= end.day);
    return data;
  }

  List<int?> _getCalendarDataWithMondayStart({required DateTime dateTime}) {
    //1=Monday, 7=Sunday
    DateTimeRange dateTimeRange =
        AppFunctions().getCurrentMonth(dateTime: dateTime);
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    int currentDay = 1;
    int currentWeek = 1;
    List<int?> data = List.generate(42, (index) => null);
    do {
      DateTime thatDay = start.copyWith(day: currentDay);
      int weekday = (thatDay.weekday);
      int index = (((currentWeek - 1) * 7) + weekday) - 1;
      data[index] = currentDay;
      currentDay++;
      if (weekday == 7) {
        //sunday
        currentWeek++;
      }
    } while (currentDay <= end.day);
    return data;
  }

  DateTimeRange getCurrentMonth({required DateTime dateTime}) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try {
      start = DateTime(dateTime.year, dateTime.month, 1, 0, 0);
      end = DateTime(start.year, start.month + 1, 1, 23, 59, 59, 999)
          .subtract(const Duration(days: 1));
    } catch (e1, e2) {
      Get.find<LoggerController>().insertNewLog(
          log:
              LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getNextMonth({required DateTime dateTime}) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try {
      start = DateTime(dateTime.year, dateTime.month + 1, 1, 0, 0);
      end = DateTime(start.year, start.month + 1, 1, 23, 59, 59, 999)
          .subtract(const Duration(days: 1));
    } catch (e1, e2) {
      Get.find<LoggerController>().insertNewLog(
          log:
              LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getPrevMonth({required DateTime dateTime}) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try {
      start = DateTime(dateTime.year, dateTime.month - 1, 1, 0, 0);
      end = DateTime(start.year, start.month + 1, 1, 23, 59, 59, 999)
          .subtract(const Duration(days: 1));
    } catch (e1, e2) {
      Get.find<LoggerController>().insertNewLog(
          log:
              LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getCurrentWeek({required DateTime focusedDate}) {
    int weekday = focusedDate.weekday;
    DateTime start = DateTime.now();

    if (weekday == 7) {
      start = focusedDate;
    } else {
      do {
        focusedDate = focusedDate.subtract(const Duration(days: 1));
        weekday = focusedDate.weekday;
      } while (weekday != 7);
      start = focusedDate;
    }
    return DateTimeRange(start: start, end: start.add(const Duration(days: 6)));
  }

  String getWeekdayString(int weekdayIndex) {
    Map<int, String> data = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      7: "Sunday",
    };

    return data[weekdayIndex] ?? "";
  }

  Future<File?> pickImage() async {
    File? result;
    try {
      final data = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (data != null) {
        result = File(data.path);
      }
    } catch (e1, e2) {
      Get.find<LoggerController>().insertNewLog(
          log:
              LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
      return result;
    }
    return result;
  }

  Future<List<File?>> pickMultiImage() async {
    List<File?> result = [];
    try {
      final data = await ImagePicker().pickMultiImage();
      if (data.isNotEmpty) {
        for (var image in data) {
          result.add(File(image.path));
        }
      }
      return result;
    } catch (e1, e2) {
      Get.find<LoggerController>().insertNewLog(
          log:
              LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
      return result;
    }
  }

  String getDateRangeString(
      {required DateTime firstDate, required DateTime lastDate}) {
    String dateString = "-";
    try {
      if (firstDate.year == lastDate.year) {
        //sameYear
        if (firstDate.month == lastDate.month) {
          //sameYearSameMonth
          if (firstDate.day == lastDate.day) {
            //sameYearSameMonthSameDay
            dateString = DateFormat("d MMM").format(lastDate);
          } else {
            //sameMonthButNotSameDay
            dateString =
                "${firstDate.day}-${DateFormat("d MMM").format(lastDate)}";
          }
        } else {
          //sameYearButNotSameMonth
          dateString =
              "${DateFormat("d MMM").format(firstDate)}-${DateFormat("d MMM").format(lastDate)}";
        }
      } else {
        //notSameYear
        dateString =
            "${DateFormat.yMMMd().format(firstDate)}-${DateFormat.yMMMd().format(lastDate)}";
      }
    } catch (e1, e2) {
      Get.find<LoggerController>().insertNewLog(
          log:
              LoggerModel.fromExceptions(title: e1.toString(), stackTrace: e2));
    }
    return dateString;
  }

  convertDate(String dateTimeString) {
    DateTime convertedDateTime = DateTime.parse(dateTimeString);
    var formattedDate = DateFormat('d MMM, yyyy').format(convertedDateTime);
    return formattedDate;
  }

  convertTime(String dateTimeString) {
    DateTime _convertedDateTime = DateTime.parse(dateTimeString)
        .add(const Duration(hours: 6, minutes: 30));
    var formattedTime = DateFormat('hh:mm a').format(_convertedDateTime);
    return formattedTime;
  }

  DateTime getStartOfWeek(DateTime date) {
    // Find Difference Of Days between GivenDay and Sunday
    // int difference = date.weekday - DateTime.sunday;
    print("Today ${date}");
    return date.subtract(Duration(days: date.weekday));
  }

  static Map<int, String> numbersMap = const {
    0: '၀',
    1: '၁',
    2: '၂',
    3: '၃',
    4: '၄',
    5: '၅',
    6: '၆',
    7: '၇',
    8: '၈',
    9: '၉',
  };

  static Map<int, String> monthsMap = const {
    1: 'ဇန်နဝရီ',
    2: 'ဖေဖော်ဝါရီ',
    3: 'မတ်',
    4: 'ဧပြီ',
    5: 'မေ',
    6: 'ဇွန်',
    7: 'ဇူလိုင်',
    8: 'သြဂုတ်',
    9: 'စက်တင်ဘာ',
    10: 'အောက်တိုဘာ',
    11: 'နိုဝင်ဘာ',
    12: 'ဒီဇင်ဘာ',
  };

  static String convertNumbersToLocalizedString(int numbers) {
    String result = '';
    String raw = numbers.toString();
    for (var element in raw.characters) {
      try {
        result = result + numbersMap[int.tryParse(element)].toString();
      } catch (e) {
        null;
      }
    }
    return result;
  }
}
