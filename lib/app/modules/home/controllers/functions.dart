String categorizeCreditScore(int creditScore) {
  if (creditScore >= 750) {
    return "Excellent";
  } else if (creditScore >= 700) {
    return "Good";
  } else if (creditScore >= 650) {
    return "Fair";
  } else if (creditScore >= 600) {
    return "Poor";
  } else {
    return "Very Poor";
  }
}

List<List<T>> divideList<T>(List<T> originalList, int groupSize) {
  List<List<T>> listOfLists = [];
  int totalLength = originalList.length;

  for (int i = 0; i < totalLength; i += groupSize) {
    // Determine the end index for the current sublist.
    // It's either the current start index plus the group size,
    // or the total length of the list, whichever is smaller.
    int endIndex = (i + groupSize < totalLength) ? i + groupSize : totalLength;

    // Use the sublist method to get the segment and add it to the result.
    listOfLists.add(originalList.sublist(i, endIndex));
  }

  return listOfLists;
}
