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
            // Add me later
          },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined, color: Colors.black54, size: 28),
          onPressed: () {
            // Add me later
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

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

  Widget _buildCategoryGrid(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'name': 'Biryani', 'image': 'https://img.freepik.com/free-photo/gourmet-chicken-biryani-with-steamed-basmati-rice-generated-by-ai_188544-13480.jpg'},
      {'name': 'Pizza', 'image': 'https://img.freepik.com/free-photo/top-view-pepperoni-pizza-with-mushroom-sausages-bell-pepper-olive-corn-black-wooden_141793-2158.jpg'},
      {'name': 'Dosa', 'image': 'https://www.shutterstock.com/image-photo/side-view-isometric-angle-crispy-600nw-2600398075.jpg'},
      {'name': 'Burger', 'image': 'https://img.freepik.com/free-photo/delicious-burger-with-many-ingredients-isolated-white-background-tasty-fast-food-hamburger_90220-1063.jpg'},
      {'name': 'Rolls', 'image': 'https://www.elmundoeats.com/wp-content/uploads/2024/02/Crispy-spring-rolls.jpg'},
      {'name': 'Cake', 'image': 'https://img.freepik.com/free-photo/slice-delicious-chocolate-cake_144627-8998.jpg'},
      {'name': 'Thali', 'image': 'https://media.istockphoto.com/id/1158578874/photo/indian-hindu-veg-thali-food-platter-selective-focus.jpg?s=612x612&w=0&k=20&c=ZHAsJ9sJJoeAmwD3iU1Oo2YSKn_BG6JoE7zuG1frxwg='},
      {'name': 'More', 'image': 'https://img.freepik.com/free-photo/top-view-table-full-delicious-food-composition_23-2149141352.jpg'},
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
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100.0, 
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.8, 
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

  Widget _buildRestaurantSectionHeader(BuildContext context) {
    return Text(
      'Restaurants to explore',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
    );
  }

  Widget _buildRestaurantList() {
    final restaurants = [
      {
        'name': "Anna's Kitchen",
        'cuisine': 'South Indian, Biryani',
        'rating': '4.3',
        'time': '25-30 MINS',
        'offer': '30% OFF',
        'image': 'https://b.zmtcdn.com/data/pictures/chains/1/20930131/0d2b6fceea27ddcb03770e4a027012b9.jpg'
      },
      {
        'name': 'Burger Junction',
        'cuisine': 'Burgers, Fast Food',
        'rating': '4.5',
        'time': '20-25 MINS',
        'offer': '50% OFF UPTO ₹100',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT21ACHG22iljXqrmycPCa30zZUxmJikcW_Xt-BCTcw9ExSrLdh7udW_NmpH-xTGe5d9yY&usqp=CAU'
      },
      {
        'name': 'The Pizza House',
        'cuisine': 'Pizza, Italian',
        'rating': '4.1',
        'time': '35-40 MINS',
        'offer': 'Buy 1 Get 1 Free',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2i6QWP5XIngk8aZaI-MDaiqqqb6UNzOSLFg&s'
      },
        {
      "name": "Sweet Tooth Bakery",
      "cuisine": "Bakery, Desserts",
      "rating": "4.7",
      "time": "15-20 MINS",
      "offer": "20% OFF on orders above ₹500",
      "image": "https://b.zmtcdn.com/data/dish_photos/39f/af99d0936e292017c3f80f6799a6d39f.jpg"
    },
    {
      "name": "Healthy Eats",
      "cuisine": "Salads, Juices",
      "rating": "4.6",
      "time": "30-35 MINS",
      "offer": "10% OFF on first order",
      "image": "https://images.unsplash.com/photo-1584270354949-1b5d82d71a6b"
    },
    {
      "name": "Tandoori Nights",
      "cuisine": "North Indian, Tandoor",
      "rating": "4.2",
      "time": "40-45 MINS",
      "offer": "Free Delivery on orders above ₹300",
      "image": "https://b.zmtcdn.com/data/dish_photos/07b/bcd87001bc81f80d3b5a194acb6a607b.jpg"
    },
    {
      "name": "Sushi World",
      "cuisine": "Japanese, Sushi",
      "rating": "4.8",
      "time": "30-35 MINS",
      "offer": "15% OFF on first order",
      "image": "https://images.unsplash.com/photo-1553621042-f6e147245754"
    },
    {
      "name": "Pasta Palace",
      "cuisine": "Italian, Pasta",
      "rating": "4.4",
      "time": "25-30 MINS",
      "offer": "20% OFF on orders above ₹400",
      "image": "https://images.unsplash.com/photo-1603133872878-684f208fb84e"
    }
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
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
          childCount: restaurants.length,
        ),
      ),
    );
  }
}

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