import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.placeForm);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('No locations added.'),
                ),
                builder: (context, places, child) => places.itemsCount == 0
                    ? child!
                    : ListView.builder(
                        itemCount: places.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.getItem(i).image),
                          ),
                          title: Text(places.getItem(i).title),
                          subtitle: Text(places.getItem(i).location.address!),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.placeDetail,
                              arguments: places.getItem(i),
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
