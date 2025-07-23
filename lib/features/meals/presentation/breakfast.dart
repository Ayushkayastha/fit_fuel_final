import 'package:fit_fuel_final/core/route/path.dart';
import 'package:fit_fuel_final/features/meals/presentation/provider/food_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/storage/secure_storage_providers.dart';
import '../data/breakfast_provider.dart';
import '../domain/food_detail_args.dart';

class Breakfast extends ConsumerStatefulWidget {
  const Breakfast({super.key});

  @override
  ConsumerState<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends ConsumerState<Breakfast> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  String? userId;


  @override
  void initState() {

    super.initState();

    Future.microtask(() => ref.refresh(breakfastProvider));
    _loadUserId();
    _focusNode.addListener(() {
      setState(() {
        _isSearching = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(foodSearchProvider.notifier).search('');
    _focusNode.unfocus(); // Hide keyboard
    setState(() {
      _isSearching = false;
    });
  }


  Future<void> _loadUserId() async {
    final id = await ref.read(userIdProvider.future);
    setState(() {
      userId = id;
    });
    print('User ID loaded: $userId');
  }

  @override
  Widget build(BuildContext context) {
    final foods = ref.watch(foodSearchProvider);
    final breakfastAsync = ref.watch(breakfastProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Breakfast'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Search foods...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _isSearching
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearSearch,
                )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (query) {
                ref.read(foodSearchProvider.notifier).search(query);
              },
            ),
          ),
          if (_isSearching)
            Expanded(
              child: ListView.builder(
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  return ListTile(
                    title: Text(food),
                    onTap: () {
                      context.pushNamed(
                        PathName.fooddetailpageRoute.routeName,
                        extra: FoodDetailArgs(food: food, mealType: 'breakfast'),
                      );
                    },
                  );
                },
              ),
            )
          else
             Expanded(
              child: Center(
                child: breakfastAsync.when(
                  data: (entries) {
                    if (entries.isEmpty) return const Center(child: Text("No breakfast items"));
                    return ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        final item = entries[index];
                        return ListTile(
                          title: Text(item['foodItem']),
                          subtitle: Text('${item['calories']} kcal'),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error happned: $e')),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
