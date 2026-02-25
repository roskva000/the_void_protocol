import 'package:flutter_test/flutter_test.dart';
import 'package:the_void_protocol/domain/usecases/cost_calculator.dart';

void main() {
  group('CostCalculator', () {
    test('getCost calculates sequential cost correctly', () {
      // cost = 10 * (1.15)^0 = 10
      expect(CostCalculator.getCost(10, 1.15, 0), closeTo(10.0, 0.001));
      // cost = 10 * (1.15)^1 = 11.5
      expect(CostCalculator.getCost(10, 1.15, 1), closeTo(11.5, 0.001));
      // cost = 10 * (1.15)^2 = 13.225
      expect(CostCalculator.getCost(10, 1.15, 2), closeTo(13.225, 0.001));
    });

    test(
      'getBulkBuyCost calculates O(1) geometric series correctly vs sequential loop',
      () {
        double baseCost = 10.0;
        double rate = 1.15;
        int currentLevel = 5;
        int countToBuy = 10;

        // Sequential sum calculation (O(n))
        double sequentialSum = 0;
        for (int i = 0; i < countToBuy; i++) {
          sequentialSum += CostCalculator.getCost(
            baseCost,
            rate,
            currentLevel + i,
          );
        }

        // O(1) calculation
        double bulkCost = CostCalculator.getBulkBuyCost(
          baseCost,
          rate,
          currentLevel,
          countToBuy,
        );

        expect(bulkCost, closeTo(sequentialSum, 0.001));
      },
    );

    test('getMaxAffordableCount calculates correctly vs sequential buying', () {
      double baseCost = 10.0;
      double rate = 1.15;
      int currentLevel = 0;
      double balance = 100.0;

      // O(1) max calculation
      int maxAffordable = CostCalculator.getMaxAffordableCount(
        baseCost,
        rate,
        currentLevel,
        balance,
      );

      // Calculate how much that max amount actually costs
      double costForMax = CostCalculator.getBulkBuyCost(
        baseCost,
        rate,
        currentLevel,
        maxAffordable,
      );

      // Calculate how much one more would cost
      double costForMaxPlusOne = CostCalculator.getBulkBuyCost(
        baseCost,
        rate,
        currentLevel,
        maxAffordable + 1,
      );

      // Verify affordable
      expect(
        costForMax,
        lessThanOrEqualTo(balance),
        reason: 'Cost for max affordable should be <= balance',
      );

      // Verify max + 1 is unaffordable
      expect(
        costForMaxPlusOne,
        greaterThan(balance),
        reason: 'Cost for max + 1 should be > balance',
      );

      // Explicit scenario test
      // 10 + 11.5 + 13.225 + 15.208 = 49.93 (4 items)
      // 10 + ... + 17.49 (5th item) = 67.42 (5 items)
      // 10 + ... + 20.11 (6th item) = 87.53 (6 items)
      // 10 + ... + 23.13 (7th item) = 110.66 (7 items) -> Too expensive for balance 100!
      // So max should be 6.
      expect(maxAffordable, equals(6));
    });

    test('Edge case: rate = 1.0 (linear scaling)', () {
      expect(
        CostCalculator.getBulkBuyCost(10.0, 1.0, 0, 5),
        closeTo(50.0, 0.001),
      );
      expect(
        CostCalculator.getMaxAffordableCount(10.0, 1.0, 0, 55.0),
        equals(5),
      );
    });

    test('Edge case: insufficient balance returns 0', () {
      expect(
        CostCalculator.getMaxAffordableCount(10.0, 1.15, 0, 5.0),
        equals(0),
      );
    });
  });
}
