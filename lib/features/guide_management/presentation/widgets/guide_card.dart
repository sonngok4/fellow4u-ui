import 'package:flutter/material.dart';

import '../../domain/entities/guide.dart';
import '../pages/guide_profile_page.dart';

class GuideCard extends StatelessWidget {
  final Guide guide;
  final double width;

  const GuideCard({
    super.key,
    required this.guide,
    this.width = 250, // Thêm kích thước mặc định
  });

  // Helper method to get full name
  String get fullName => '${guide.firstName} ${guide.lastName}';

  // Helper method to get location
  String get location => '${guide.city}, ${guide.country}';

  // Helper method to generate a default image path (you might want to modify this)
  String get imagePath => 'assets/images/default_guide_avatar.png';

  // Helper method to calculate rating (you'll need to implement actual rating logic)
  int get rating {
    // Placeholder rating calculation
    // You might want to add a rating field to the Guide entity or
    // calculate it based on reviews or other criteria
    return 4; // Default to 4-star rating
  }

  // Helper method to get number of reviews (similar to rating)
  int get reviews {
    // Placeholder reviews count
    // You'll need to implement actual review counting logic
    return 25;
  }

@override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuideProfilePage(guideId: guide.id),
          ),
        );
      },
      child: SizedBox(
        width: width,
        child: Card(
          color: Colors.white,
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Quan trọng: giới hạn kích thước theo nội dung
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                // Thay thế Expanded
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.teal,
                            size: MediaQuery.of(context).size.width * 0.035),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.03,
                              color: Colors.teal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    // Optional: Display languages
                    if (guide.languages.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Languages: ${guide.languages.join(", ")}',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
