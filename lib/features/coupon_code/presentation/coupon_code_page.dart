import 'package:flutter/material.dart';
import 'package:nai_hub/utils/theme/colors.dart';

class EnterCouponCodePage extends StatefulWidget {
  @override
  _EnterCouponCodePageState createState() => _EnterCouponCodePageState();
}

class _EnterCouponCodePageState extends State<EnterCouponCodePage> {
  final _couponController = TextEditingController();
  final _couponFocusNode = FocusNode();
  String? _errorText;
  bool _canApplyCoupon = false;

  @override
  void initState() {
    super.initState();
    // Add a listener to the controller to react to text changes.
    // This is more efficient than checking the text length in the build method.
    _couponController.addListener(_updateCanApplyState);
  }

  @override
  void dispose() {
    // It's crucial to remove listeners and dispose of all controllers and focus nodes
    // to prevent memory leaks.
    _couponController.removeListener(_updateCanApplyState);
    _couponController.dispose();
    _couponFocusNode.dispose();
    super.dispose();
  }

  void _updateCanApplyState() {
    // Use setState to rebuild the widget only when the text's empty status changes.
    final isTextEmpty = _couponController.text.trim().isEmpty;
    if (_canApplyCoupon == isTextEmpty) {
      setState(() {
        _canApplyCoupon = !isTextEmpty;
        // Also, clear the error text when the user starts typing again.
        if (_errorText != null) {
          _errorText = null;
        }
      });
    }
  }

  void _applyCoupon() {
    // Hides the keyboard when the button is pressed.
    _couponFocusNode.unfocus();

    final code = _couponController.text.trim();
    if (code.isEmpty)
      return; // Should not happen if button is disabled, but good for safety.

    setState(() {
      // Dummy validation logic. Replace with your actual validation.
      if (code == 'SAVE20' || code == 'FLUTTER') {
        _errorText = null;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Coupon "$code" applied successfully!'),
              backgroundColor: Colors.green,
            ),
          );
      } else {
        _errorText = 'This coupon code is not valid.';
      }
    });
  }

  void _clearCoupon() {
    _couponController.clear();
    setState(() {
      _errorText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildApplyButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: white),
        // Explicitly pop the current route.
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const Text(
        'Enter Coupon Code',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'inter_bold',
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Got a coupon?',
            style: TextStyle(fontFamily: 'inter_bold', fontSize: 26),
          ),
          const SizedBox(height: 4),
          const Text(
            'Enter your coupon code below to get a discount.',
            style: TextStyle(
              fontFamily: 'inter_medium',
              fontSize: 13,
              color: grey_676763,
            ),
          ),
          const SizedBox(height: 24),
          _buildCouponTextField(),
        ],
      ),
    );
  }

  Widget _buildCouponTextField() {
    final theme = Theme.of(context);
    return TextField(
      controller: _couponController,
      focusNode: _couponFocusNode,
      textCapitalization: TextCapitalization.characters,
      cursorColor: mainColor,
      decoration: InputDecoration(
        labelText: 'Coupon Code',
        // Let the theme handle the label color on focus change.
        labelStyle: TextStyle(
          color: _couponFocusNode.hasFocus ? mainColor : Colors.black54,
        ),
        hintText: 'e.g. SAVE20',
        errorText: _errorText,
        // Only show the clear button if there is text.
        suffixIcon:
            _canApplyCoupon
                ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _clearCoupon,
                )
                : null,
        // Using theme colors for consistency
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: mainColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          // Disable the button when no code is entered.
          // The `onPressed` property being null disables the button automatically.
          onPressed: _canApplyCoupon ? _applyCoupon : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            // Style the button differently when it's disabled.
            disabledBackgroundColor: mainColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Apply Coupon',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'inter_bold',
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
