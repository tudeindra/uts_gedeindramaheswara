import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyAppState extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final MyAppState appState = MyAppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Contoh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/product_detail': (context) => ShopPage(appState),
        '/cart': (context) => CartPage(appState),
        '/payment': (context) => PaymentPage(appState),
        '/thank_you': (context) => ThankYouPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sneaker Shop'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/nike.jpg',
                    height: MediaQuery.of(context).size.height *
                        0.3, // responsive height
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Just Do It',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Brand new sneakers and custom kicks made with premium quality',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/product_detail');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          0.4, // responsive width
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Shop Now',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShopPage extends StatelessWidget {
  final MyAppState appState;

  ShopPage(this.appState);

  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/images/nike1.jpg',
      'name': 'Nike Air Max',
      'price': '\$150',
    },
    {
      'image': 'assets/images/nike2.jpg',
      'name': 'Nike Air Force 1',
      'price': '\$120',
    },
    {
      'image': 'assets/images/nike3.jpg',
      'name': 'Nike Zoom',
      'price': '\$180',
    },
    {
      'image': 'assets/images/nike4.jpg',
      'name': 'Nike React',
      'price': '\$200',
    },
    {
      'image': 'assets/images/nike5.jpg',
      'name': 'Nike VaporMax',
      'price': '\$220',
    },
    {
      'image': 'assets/images/nike6.jpg',
      'name': 'Nike Dunk',
      'price': '\$170',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sneaker Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchBar(),
            SizedBox(height: 10),
            _buildHotPicksSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildHotPicksSection(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          ClampingScrollPhysics(), // changed physics to ClampingScrollPhysics
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? 2
                : 4, // adaptive cross axis count
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductItem(context, products[index]);
      },
    );
  }

  Widget _buildProductItem(BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product_detail');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(
                product['image'],
                fit: BoxFit.cover,
                height:
                    MediaQuery.of(context).size.width / 3, // responsive height
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    product['price'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(), // Spacer added to push shopping cart icon to the bottom
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                _addToCart(context, product);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Item added to cart'),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, Map<String, dynamic> product) {
    appState.addToCart(product);
  }
}

class CartPage extends StatelessWidget {
  final MyAppState appState;

  CartPage(this.appState);

  @override
  Widget build(BuildContext context) {
    final cartItems = appState.cartItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cartItems[index]['name']),
                  subtitle: Text(cartItems[index]['price']),
                  leading: Image.asset(
                    cartItems[index]['image'],
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeFromCart(context, index);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: cartItems.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                _proceedToPayment(
                    context); // Ubah onPressed untuk navigasi ke halaman pembayaran
              },
              label: Text('Proceed to Payment'),
              icon: Icon(Icons.payment),
            ),
    );
  }

  void _removeFromCart(BuildContext context, int index) {
    appState.cartItems.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item removed from cart'),
      ),
    );
    appState.notifyListeners();
  }

  void _proceedToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage(appState)),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final MyAppState appState;

  PaymentPage(this.appState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Amount: \$${_calculateTotalAmount(appState.cartItems)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _makePayment(context);
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotalAmount(List<Map<String, dynamic>> cartItems) {
    double totalAmount = 0;
    for (var item in cartItems) {
      totalAmount += double.parse(item['price'].replaceAll('\$', ''));
    }
    return totalAmount;
  }

  void _makePayment(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/thank_you');
  }
}

class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thank you for your purchase!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/product_detail');
              },
              child: Text('Shop Again'),
            ),
          ],
        ),
      ),
    );
  }
}
