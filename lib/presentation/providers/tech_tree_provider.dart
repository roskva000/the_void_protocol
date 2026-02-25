import 'package:flutter_riverpod/flutter_riverpod.dart';

class TechTreeNode {
  final String id;
  final String titleKey;
  final String descKey;
  final double cost;
  final bool unlocked;
  final List<String> prerequisites;

  TechTreeNode({
    required this.id,
    required this.titleKey,
    required this.descKey,
    required this.cost,
    required this.unlocked,
    required this.prerequisites,
  });
}

class TechTreeNotifier extends Notifier<List<TechTreeNode>> {
  @override
  List<TechTreeNode> build() {
    return [
      TechTreeNode(
        id: 'auto_clicker',
        titleKey: 'techAutoClicker',
        descKey: 'techAutoClickerDesc',
        cost: 10,
        unlocked: false,
        prerequisites: [],
      ),
      TechTreeNode(
        id: 'active_cooling',
        titleKey: 'techActiveCooling',
        descKey: 'techActiveCoolingDesc',
        cost: 50,
        unlocked: false,
        prerequisites: ['auto_clicker'],
      ),
    ];
  }

  void unlock(String nodeId) {
    state = [
      for (final node in state)
        if (node.id == nodeId)
          TechTreeNode(
            id: node.id,
            titleKey: node.titleKey,
            descKey: node.descKey,
            cost: node.cost,
            unlocked: true,
            prerequisites: node.prerequisites,
          )
        else
          node,
    ];
  }
}

final techTreeProvider =
    NotifierProvider<TechTreeNotifier, List<TechTreeNode>>(() {
  return TechTreeNotifier();
});
