class Destination {
  const Destination({
    required this.city,
    required this.country,
    required this.imageUrl,
    required this.distance,
    required this.available,
    required this.price,
    this.description = '',
  });

  final String city;
  final String country;
  final String imageUrl;
  final String distance;
  final String available;
  final String price;
  final String description;

  String get title => '$city, $country';
}

const destinations = [
  Destination(
    city: 'Toronto',
    country: 'Canada',
    imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=1000',
    distance: '150KM',
    available: 'OCT 24–25',
    price: '\$50.00',
    description: 'Experience a comfortable and memorable stay at our hotel, where modern amenities, warm hospitality, and convenient surroundings come together. Designed for both business and leisure travelers, the hotel offers well-appointed rooms, quality facilities, and attentive service to make every stay relaxing and enjoyable.',
  ),
  Destination(
    city: 'Bali',
    country: 'Indonesia',
    imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=1000',
    distance: '2,300KM',
    available: 'NOV 12–16',
    price: '\$80.00',
  ),
];
