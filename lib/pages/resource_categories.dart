import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class ResourceCategory {
  ResourceCategory({required this.name, required this.id, required this.icon});

  final String id;
  final String name;
  final IconData icon;

  ResourceCategory copyWith({String? id, String? name, IconData? icon}) {
    return ResourceCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }
}

class ResourceCategoryList extends Notifier<List<ResourceCategory>> {
  @override
  List<ResourceCategory> build() => [
        // ResourceCategory(id: '0', name: 'clothes' icon),
        // ResourceCategory(id: '1', name: 'medicine'),
        // ResourceCategory(id: '2', name: 'rice'),
      ];

  void add(String name, IconData icon) {
    state = [
      ...state,
      ResourceCategory(
          id: _uuid.v4(),
          name: name,
          icon: icon),
    ];
  }

  void edit({required String id, String? name, IconData? icon}) {
    state = [
      for (final resourceCategory in state)
        if (resourceCategory.id == id)
          resourceCategory.copyWith(name: name, icon: icon)
        else
          resourceCategory,
    ];
  }

  void remove(ResourceCategory target) {
    state = state
        .where((resourceCategory) => resourceCategory.id != target.id)
        .toList();
  }
}
