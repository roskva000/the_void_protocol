import 'dart:math';

class CostCalculator {
  /// Base growth rate for Noise Generators
  static const double generatorGrowthRate = 1.07;

  /// Base growth rate for Filters
  static const double filterGrowthRate = 1.15;

  /// Calculate the cost of the nth item (0-indexed for the 'first' purchase)
  static double getCost(double baseCost, double rate, int currentLevel) {
    return baseCost * pow(rate, currentLevel);
  }

  /// O(1) calculation for the total cost of buying 'count' items starting from 'currentLevel'.
  /// Sum of geometric series: a * ((1 - r^n) / (1 - r))
  /// where a is the cost of the *next* item.
  static double getBulkBuyCost(
    double baseCost,
    double rate,
    int currentLevel,
    int count,
  ) {
    if (count <= 0) return 0.0;
    if (rate == 1.0) {
      return baseCost * count;
    }
    double firstItemCost = getCost(baseCost, rate, currentLevel);
    return firstItemCost * ((1 - pow(rate, count)) / (1 - rate));
  }

  /// O(1) calculation for the maximum number of items that can be bought with 'balance'.
  /// From: a * ((1 - r^n) / (1 - r)) <= balance
  /// solve for n: r^n >= 1 - (balance * (1 - r) / a)
  /// n = floor( log(1 - balance * (1 - r) / a) / log(r) )
  /// Note: The math differs slightly for rate > 1. Let's use the standard formula carefully.
  /// Sum = a * (r^n - 1) / (r - 1)
  /// Sum * (r - 1) / a = r^n - 1
  /// r^n = 1 + Sum * (r - 1) / a
  /// n = log(1 + Sum * (r - 1) / a) / log(r)
  static int getMaxAffordableCount(
    double baseCost,
    double rate,
    int currentLevel,
    double balance,
  ) {
    if (balance <= 0) return 0;

    double firstItemCost = getCost(baseCost, rate, currentLevel);
    if (balance < firstItemCost) return 0;

    if (rate == 1.0) {
      return (balance / firstItemCost).floor();
    }

    double maxN = log(1 + (balance * (rate - 1) / firstItemCost)) / log(rate);
    return maxN.floor();
  }
}
