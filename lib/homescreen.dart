import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeAndSearch(context),
                  const SizedBox(height: 24),
                  _buildOfferCarousel(),
                  const SizedBox(height: 24),
                  _buildCategoryGrid(context),
                  const SizedBox(height: 24),
                  _buildRestaurantSectionHeader(context),
                ],
              ),
            ),
          ),
          _buildRestaurantList(),
        ],
      ),
    );
  }

  // Builds the top sticky app bar
  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      floating: true,
      elevation: 1.0,
      title: const Text(
        'Sara!',
        style: TextStyle(
          color: Colors.pink,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey[200],
          height: 1.0,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black54, size: 26),
          onPressed: () {
            // Handle search action
          },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined, color: Colors.black54, size: 28),
          onPressed: () {
            // Handle profile action
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // Builds the welcome message and search bar section
  Widget _buildWelcomeAndSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello Sanjay!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Search for restaurants and food',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  // Builds the horizontally scrolling offer cards
  Widget _buildOfferCarousel() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          OfferCard(
            title: '50% OFF',
            subtitle: 'Up to ₹100 on your first order',
            buttonText: 'ORDER NOW',
            gradient: LinearGradient(
              colors: [Color(0xFFFBBF24), Color(0xFFF97316)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          SizedBox(width: 16),
          OfferCard(
            title: 'Free Delivery',
            subtitle: 'On all orders above ₹199',
            buttonText: 'EXPLORE',
            gradient: LinearGradient(
              colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          SizedBox(width: 16),
          OfferCard(
            title: 'Try Healthy',
            subtitle: 'Get salads & juices at 20% off',
            buttonText: 'SEE MORE',
            gradient: LinearGradient(
              colors: [Color(0xFF34D399), Color(0xFF3B82F6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }

  // Builds the "What's on your mind?" category section
  Widget _buildCategoryGrid(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'name': 'Biryani', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=Biryani'},
      {'name': 'Pizza', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=Pizza'},
      {'name': 'Dosa', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=Dosa'},
      {'name': 'Burger', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=Burger'},
      {'name': 'Rolls', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=Rolls'},
      {'name': 'Cake', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=Cake'},
      {'name': 'Thali', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=Thali'},
      {'name': 'More', 'image': 'https://placehold.co/100x100/FFF0F5/DB2777?text=More'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's on your mind?",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryItem(
              name: categories[index]['name']!,
              imageUrl: categories[index]['image']!,
            );
          },
        ),
      ],
    );
  }

  // Builds the header for the restaurant list
  Widget _buildRestaurantSectionHeader(BuildContext context) {
    return Text(
      'Restaurants to explore',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
    );
  }

  // Builds the list of restaurant cards
  Widget _buildRestaurantList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            // In a real app, this data would come from an API
            final restaurants = [
              {
                'name': "Anna's Kitchen",
                'cuisine': 'South Indian, Biryani',
                'rating': '4.3',
                'time': '25-30 MINS',
                'offer': '30% OFF',
                'image': 'https://placehold.co/600x400/FEF2F2/DC2626?text=Annas+Kitchen'
              },
              {
                'name': 'Burger Junction',
                'cuisine': 'Burgers, Fast Food',
                'rating': '4.5',
                'time': '20-25 MINS',
                'offer': '50% OFF UPTO ₹100',
                'image': 'https://placehold.co/600x400/F3E8FF/8B5CF6?text=Burger+Junction'
              },
              {
                'name': 'The Pizza House',
                'cuisine': 'Pizza, Italian',
                'rating': '4.1',
                'time': '35-40 MINS',
                'offer': 'Buy 1 Get 1 Free',
                'image': 'https://placehold.co/600x400/E0F2FE/0EA5E9?text=Pizza+House'
              },
            ];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RestaurantCard(
                name: restaurants[index]['name']!,
                cuisine: restaurants[index]['cuisine']!,
                rating: restaurants[index]['rating']!,
                deliveryTime: restaurants[index]['time']!,
                offer: restaurants[index]['offer']!,
                imageUrl: restaurants[index]['image']!,
              ),
            );
          },
          childCount: 3, // Number of restaurants
        ),
      ),
    );
  }
}

// Reusable widget for offer cards
class OfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final Gradient gradient;

  const OfferCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: (gradient.colors.last).withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable widget for category items
class CategoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CategoryItem({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.pink[50],
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Reusable widget for restaurant cards
class RestaurantCard extends StatelessWidget {
  final String name;
  final String cuisine;
  final String rating;
  final String deliveryTime;
  final String offer;
  final String imageUrl;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.offer,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.restaurant, color: Colors.grey)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Text(
                            rating,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, color: Colors.white, size: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  cuisine,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    Icon(Icons.motorcycle, color: Colors.pink[400], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      deliveryTime,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    const Spacer(),
                    Icon(Icons.local_offer, color: Colors.pink[400], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      offer,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.pink[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}