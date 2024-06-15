class OtherUtils {
  static String sortAndJoin(List<int> list){
    list.sort();
    String joinedString = '';
 
    for (int i = 0; i < list.length; i++) {
      joinedString += list[i].toString();
      if ((i + 1) % 3 == 0 && i != list.length - 1) {
        joinedString += '\n';
      } else {
        joinedString += ' ';
      }
    }
    return joinedString;
  }
 
  static String getFormattedTime(int elapsedSeconds) {
    final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
