class Utils {
  static int currentTimeSeconds() {
    return (DateTime.now().millisecondsSinceEpoch ~/ 1000);
  }

  static String getFileSize(int fileSize) {
    String str = '';

    if (fileSize < 1024) {
      str = '${fileSize} B';
    } else if (1024 <= fileSize && fileSize < 1048576) {
      str = '${(fileSize / 1024).toStringAsFixed(2)} K';
    } else if (1048576 <= fileSize && fileSize < 1073741824) {
      str = '${(fileSize / 1048576).toStringAsFixed(2)} M';
    } else if (1073741824 <= fileSize && fileSize < 1099511627776) {
      str = '${(fileSize / 1073741824).toStringAsFixed(2)} G';
    }

    return str;
  }

  static String getDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  static String getCurrPathFileName(String path) {
    if ('/'.compareTo(path) == 0) return '根目录';
    int startIndex = path.lastIndexOf('/');

    if (startIndex == -1) return '';
    return path.substring(startIndex + 1);
  }

  static String getParentPath(String path) {
    if ('/'.compareTo(path) == 0) return '/';

    int startIndex = path.lastIndexOf('/');

    if (startIndex <= 0) return '/';
    return path.substring(0, startIndex);
  }
}
