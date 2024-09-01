import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:disaster_hackathon_app/components/bottom_nav_bar.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:gap/gap.dart';
import 'resource_categories.dart';

/// Some keys used for testing
final addResourceCategoryKey = UniqueKey();
final resourceCategoryListProvider =
    NotifierProvider<ResourceCategoryList, List<ResourceCategory>>(
        ResourceCategoryList.new);

class ResourceCategoriesPage extends ConsumerStatefulWidget {
  ResourceCategoriesPage({super.key});

  @override
  _ResourceCategoriesPageState createState() =>
      _ResourceCategoriesPageState(); // Provide the createState method
}

class _ResourceCategoriesPageState
    extends ConsumerState<ResourceCategoriesPage> {
  late TextEditingController newResourceCategoryController;
  Icon? _selectedIcon;
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    newResourceCategoryController = TextEditingController();
  }

  @override
  void dispose() {
    newResourceCategoryController.dispose();
    super.dispose();
  }

  _pickIcon() async {
    IconPickerIcon? icon = await showIconPicker(context,
        iconPackModes: [IconPack.fontAwesomeIcons]);

    _selectedIcon = Icon(icon?.data);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  @override
  Widget build(BuildContext context) {
    final resourceCategories = ref.watch(resourceCategoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Categories'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.blue.shade800,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'New Resource Category:',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            key: addResourceCategoryKey,
                            controller: newResourceCategoryController,
                            decoration: const InputDecoration(
                              labelText: 'Enter category',
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickIcon,
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blue.shade800),
                          ),
                          child: _selectedIcon == null
                              ? const Text(
                                  'Icon',
                                  style: TextStyle(color: Colors.white),
                                )
                              : Icon(
                                  _selectedIcon!.icon, // Use the icon data
                                  color: Colors
                                      .white, // Set the icon color to white
                                ),
                        ),
                        const Gap(5),
                        ElevatedButton(
                          onPressed: () {
                            if (newResourceCategoryController
                                    .text.isNotEmpty &&
                                _selectedIcon != null) {
                              ref
                                  .read(resourceCategoryListProvider.notifier)
                                  .add(
                                    newResourceCategoryController.text,
                                    _selectedIcon!.icon!,
                                  );
                              newResourceCategoryController.clear();
                              setState(() {
                                _selectedIcon = null;
                              });
                            }
                          },
                          child: const Icon(Icons.check, color: Colors.white),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.blue.shade800),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(42),
            Expanded(
              child: ListView.separated(
                itemCount: resourceCategories.length,
                separatorBuilder: (context, index) =>
                    const Gap(16),
                itemBuilder: (context, index) {
                  final resourceCategory = resourceCategories[index];
                  return ProviderScope(
                    overrides: [
                      _currentResourceCategory
                          .overrideWithValue(resourceCategory),
                    ],
                    child: const ResourceCategoryItem(),
                  );
                },
              ),
            )
            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onTabTapped: _onTabTapped,
        currentIndex: _currentIndex,
      ),
    );
  }
}

final _currentResourceCategory =
    Provider<ResourceCategory>((ref) => throw UnimplementedError());

/// The widget that displays the components of an individual Todo Item
class ResourceCategoryItem extends ConsumerStatefulWidget {
  const ResourceCategoryItem({super.key});

  @override
  _ResourceCategoryItemState createState() => _ResourceCategoryItemState();
}

class _ResourceCategoryItemState extends ConsumerState<ResourceCategoryItem> {
  // Function to edit the icon of the resource category
  

  // Function to edit the name of the resource category with confirmation
  void _editCategory(ResourceCategory resourceCategory) async {
    TextEditingController nameController =
        TextEditingController(text: resourceCategory.name);

    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${resourceCategory.name}'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'New Category:'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && nameController.text.isNotEmpty) {
      ref.read(resourceCategoryListProvider.notifier).edit(
            id: resourceCategory.id,
            name: nameController.text,
          );
    }
  }

  // Function to delete the resource category with confirmation
  void _deleteCategory(ResourceCategory resourceCategory) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${resourceCategory.name}?'),
          content: Text('Are you sure you want to delete this category?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      ref.read(resourceCategoryListProvider.notifier).remove(resourceCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resourceCategory = ref.watch(_currentResourceCategory);

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
             Icon(resourceCategory.icon, color: Colors.blue, size: 40),
              
            Gap(30),
            Expanded(
              child: Text(
                resourceCategory.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue.shade800, size: 30),
              onPressed: () =>
                  _editCategory(resourceCategory), // Name edit function
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red.shade300, size: 30),
              onPressed: () =>
                  _deleteCategory(resourceCategory), // Delete function
            ),
          ],
        ),
      ),
    );
  }
}
