// lib/features/trips/presentation/pages/trips_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_trips_provider.dart';
import '../widgets/trip_card.dart';

class TripsListPage extends StatefulWidget {
  const TripsListPage({super.key});

  @override
  State<TripsListPage> createState() => _TripsListPageState();
}

class _TripsListPageState extends State<TripsListPage> {
  @override
  void initState() {
    super.initState();
    // Fetch trips when page loads
    context.read<TripsProvider>().fetchTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tours'),
      ),
      body: Consumer<TripsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  ElevatedButton(
                    onPressed: () => provider.fetchTrips(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.trips.isEmpty) {
            return const Center(child: Text('No trips available'));
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchTrips(),
            child: ListView.builder(
              itemCount: provider.trips.length,
              itemBuilder: (context, index) {
                final trip = provider.trips[index];
                return TripCard(
                  trip: trip,
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/trip-details',
                    arguments: trip.id,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
