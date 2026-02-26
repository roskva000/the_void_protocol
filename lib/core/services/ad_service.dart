// Placeholder for AdMob
class AdService {
  Future<void> init() async {
    // MobileAds.instance.initialize();
  }

  Future<void> showRewardedAd(Function onReward) async {
    // RewardedAd.load(...);
    await Future.delayed(const Duration(seconds: 1));
    onReward();
  }
}
