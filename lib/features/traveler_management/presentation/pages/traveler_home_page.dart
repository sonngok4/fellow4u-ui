import 'package:flutter/material.dart';

import '../../../core/presentation/widgets/layouts/main_scaffold.dart';
import '../../../guide_management/domain/entities/guide.dart';
import '../../../guide_management/domain/repositories/guide_repository.dart';
import '../../../guide_management/domain/usescases/get_guide.dart';
import '../../../guide_management/presentation/widgets/guide_card.dart';
import '../../../trips/domain/entities/trip.dart';
import '../../../trips/domain/repositories/trip_repository.dart';
import '../../../trips/domain/usescases/get_trip.dart';
import '../../../trips/presentation/provider/widgets/trip_card.dart';

class TravelerHomePage extends StatefulWidget {
  final GuideRepository guideRepository;
  final TripRepository tripRepository;

  const TravelerHomePage(
      {super.key, required this.guideRepository, required this.tripRepository});

  @override
  State<TravelerHomePage> createState() => _TravelerHomePageState();
}

class _TravelerHomePageState extends State<TravelerHomePage> {
  List<Guide> guides = [];
  List<Trip> trips = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Fetch guide and trip data
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      // Use the repositories passed from the constructor
      final guideUseCase = GetGuide(widget.guideRepository);
      final tripUseCase = GetTrip(widget.tripRepository);

      // Fetch guides and trips concurrently
      final results = await Future.wait([
        guideUseCase.callAll(),
        tripUseCase.callAll(),
      ]);

      // Update state with fetched data
      if (mounted) {
        setState(() {
          guides = results[0] as List<Guide>;
          trips = results[1] as List<Trip>;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle potential errors (e.g., network issues)
      print('Error fetching data: $e');

      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
    print('Trips length: ${trips.length}');
    trips.forEach((trip) {
      print('Trip: ${trip.id}, ${trip.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Explore',
      headerBackground: Image.asset(
        'assets/images/header_background.png',
        fit: BoxFit.cover,
      ),
      showSearch: true,
      currentIndex: 0,
      onNavigationChanged: (index) {
        // Handle navigation
      },
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $_errorMessage'),
                      ElevatedButton(
                        onPressed: _fetchData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: [
                    // Guide Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Explore Guides',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('${guides.length} guides available'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: guides
                                  .map((guide) => GuideCard(guide: guide, width: 250,))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Trips Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Explore Trips',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('${trips.length} trips available'),
                          if (trips.isEmpty)
                            const Center(child: Text('No trips available'))
                          else
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: trips
                                    .map((trip) => TripCard(trip: trip, width: 300,))
                                    .toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
