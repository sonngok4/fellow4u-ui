// lib/features/trips/presentation/widgets/trip_card.dart
import 'package:flutter/material.dart';
import '../../../domain/entities/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onTap;
  final double width;

  const TripCard({
    super.key,
    required this.trip,
    this.onTap,
    this.width = 300, // Default width, can be customized
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    trip.coverPhoto,
                    width: width,
                    height: width * 0.5,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: width,
                      height: width * 0.5,
                      color: Colors.grey[300],
                      child:
                          const Center(child: Icon(Icons.image_not_supported)),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.02,
                  child: IconButton(
                    icon: Icon(
                      Icons.bookmark_outline_rounded,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.08,
                    ),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: index < trip.rating.round()
                              ? Colors.yellow
                              : Colors.white54,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text(
                        '${trip.rating}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        Text(
                          trip.startDate.toString().split('-')[0],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                        Text(
                          '${trip.duration} days',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: const Color(0xFF00CEA6),
                        size: MediaQuery.of(context).size.width * 0.06,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005),
                      Text(
                        '\$${trip.adultPrice}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00CEA6),
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
