import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery/Pages/HomeScreen/hom_screen.dart';
import 'package:fooddelivery/Provider/cart_provider.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/cart_item.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late Razorpay _razorpay;
  double grandTotal = 0.0;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': grandTotal.ceil() * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    var subTotal = cartProvider.subTotal();
    var discount = 7;
    var shipping = 5;
    var discountValue = (subTotal * discount) / 100;
    var priceAfterDiscount = subTotal - discountValue;
    grandTotal = priceAfterDiscount + shipping;
    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        grandTotal = 0.0;
      });
    }

    print(subTotal);
    return Scaffold(
      bottomNavigationBar: cartProvider.getCartList.isEmpty
          ? Text("")
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MyButton(
                  onpressed: () {
                    //razorpay

                    openCheckout().whenComplete(() {
                      cartProvider.deleteCart();
                      RoutingPage.pushReplacement(
                          context: context, page: HomeScreen());
                    });
                  },
                  text: "Proceed"),
            ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              RoutingPage.pop(context: context);
            },
          ),
        ),
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: List.generate(
                cartProvider.getCartList.length,
                (index) {
                  var data = cartProvider.cartList[index];
                  return CartItem(
                    productId: data.productId,
                    productImage: data.productImage,
                    productName: data.productName,
                    productPrice: data.productPrice,
                    productQunatity: data.productQunatity,
                    productCategory: data.productCategory,
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              ListTile(
                leading: Text("SubTotal"),
                trailing: Text("Rs ${subTotal.toStringAsFixed(2)}"),
              ),
              ListTile(
                leading: Text("Discount"),
                trailing: Text("$discount %"),
              ),
              ListTile(
                leading: Text("Shipping"),
                trailing: Text("Rs $shipping"),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Text(
                  "Grand Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                trailing: Text(
                  "Rs ${grandTotal.toStringAsFixed(2)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
