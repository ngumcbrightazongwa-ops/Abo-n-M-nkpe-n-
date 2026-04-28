class AppStrings {
  static const appName = 'Nkwen Language';
  static const welcomeTitle = 'Learn Nkwen';
  static const welcomeSubtitle = 'Start with simple greetings, then build up.';
  static const chooseTrackTitle = 'Choose your learning track';
  static const continueLabel = 'Continue';
  static const homeLabel = 'Home';
  static const learnLabel = 'Learn';
  static const practiceLabel = 'Practice';
  static const profileLabel = 'Profile';
  static const lessonLoadingLabel = 'Loading lesson...';
  static const lessonNotFoundLabel = 'Lesson not found';
  static const noVocabularyFoundLabel = 'No vocabulary found for this lesson.';
  static const audioComingSoonLabel = 'Audio pronunciation will be added soon.';
  static const savedForPracticeLabel = 'Saved for practice.';
  static const recordingStoppedLabel = 'Recording stopped';
  static const savedRecordingLabel = 'Saved recording';
  static const microphonePermissionRequiredLabel = 'Microphone permission required';
  static const recordingLabel = 'Recording...';
  static const listenAndRepeatTitle = 'Listen and repeat';
  static const slowLabel = 'Slow';
  static const yourTurnTitle = 'Your turn';
  static const tapMicInstruction = 'Tap the microphone and say it out loud';
  static const meaningBreakdownTitle = 'Meaning breakdown';
  static const letsPracticeTitle = "Let's practice!";

  static String lessonOfLabel(int lessonNumber, int totalLessons) =>
      'Lesson $lessonNumber of $totalLessons';

  static String meaningBreakdownText(String word) => '$word is a common way to greet someone in Nkwen.';
}
