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
