import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../providers/theme_provider.dart';

class DetailScreen extends StatefulWidget {
  final Customer customer;

  const DetailScreen({Key? key, required this.customer}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildInfoCard(String title, List<Widget> children, {int index = 0}) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.1 : 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.white12 : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {int index = 0}) {
    return _buildInfoRowWithLabel(label, [Text(value)]);
  }

  Widget _buildInfoRowWithLabel(
    String label,
    List<Widget> children, {
    int index = 0,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(20 * (1 - _fadeAnimation.value), 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(
                    context,
                  ).textTheme.bodySmall?.color?.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    String type,
    String value, {
    required bool isPrimary,
    required IconData icon,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.white12 : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.blueGrey[800] : Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16,
              color: isDarkMode ? Colors.blue[200] : Colors.blue[600],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    if (isPrimary) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.green[900]
                              : Colors.green[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'PRIMARY',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colors.green[200]
                                : Colors.green[700],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRowWithAnimation(
    String title,
    List<Widget> children, {
    int index = 0,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animation = CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.1 + (index * 0.1),
            0.5 + (index * 0.1),
            curve: Curves.easeOut,
          ),
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Interval(
                      0.1 + (index * 0.1),
                      0.5 + (index * 0.1),
                      curve: Curves.easeOut,
                    ),
                  ),
                ),
            child: child,
          ),
        );
      },
      child: _buildInfoCard(title, children, index: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final primaryAddress = widget.customer.addresses.isNotEmpty
        ? widget.customer.addresses.first
        : null;
    final primaryPhone = widget.customer.phones.isNotEmpty
        ? widget.customer.phones.first
        : null;
    final primaryEmail = widget.customer.emails.isNotEmpty
        ? widget.customer.emails.first
        : null;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildMainContent(primaryAddress, primaryPhone, primaryEmail),
      ),
    );
  }

  Widget _buildMainContent(primaryAddress, primaryPhone, primaryEmail) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            'Customer Details',
            key: const ValueKey('detail_title'),
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                  bottom: BorderSide(
                    color: isDarkMode ? Colors.white12 : Colors.grey[200]!,
                    width: 1,
                  ),
                ),
                boxShadow: [
                  if (isDarkMode)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Row(
                children: [
                  // Profile Avatar
                  Hero(
                    tag: 'customer-${widget.customer.id}',
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.blueGrey[900]
                            : Colors.blue[50],
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.blueGrey[700]!
                              : Colors.blue[100]!,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDarkMode ? 0.2 : 0.1,
                            ),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: isDarkMode ? Colors.blue[100] : Colors.blue[700],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Customer Name and ID
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.customer.firstName} ${widget.customer.lastName}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).textTheme.titleLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: ${widget.customer.secureId}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Personal Information Card
            _buildInfoRowWithAnimation('Personal Information', [
              _buildInfoRow('First Name', widget.customer.firstName),
              _buildInfoRow('Last Name', widget.customer.lastName),
              _buildInfoRow('Date of Birth', widget.customer.dateOfBirth),
              _buildInfoRow('Marital Status', widget.customer.maritalStatus),
            ], index: 0),

            // Addresses Section
            if (widget.customer.addresses.isNotEmpty)
              _buildInfoRowWithAnimation('Addresses', [
                for (var address in widget.customer.addresses) ...[
                  _buildInfoRowWithLabel(
                    '${address.type[0].toUpperCase()}${address.type.substring(1)} Address',
                    [
                      Text(address.street),
                      Text(
                        '${address.city}, ${address.state} ${address.zipCode}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ], index: 1),

            // Phones Section
            if (widget.customer.phones.isNotEmpty)
              _buildInfoRowWithAnimation('Phone Numbers', [
                for (var phone in widget.customer.phones)
                  _buildContactItem(
                    '${phone.type[0].toUpperCase()}${phone.type.substring(1)}',
                    phone.number,
                    isPrimary: phone.isPrimary,
                    icon: Icons.phone,
                  ),
              ], index: 2),

            // Emails Section
            if (widget.customer.emails.isNotEmpty)
              _buildInfoRowWithAnimation('Email Addresses', [
                for (var email in widget.customer.emails)
                  _buildContactItem(
                    '${email.type[0].toUpperCase()}${email.type.substring(1)}',
                    email.address,
                    isPrimary: email.isPrimary,
                    icon: Icons.email,
                  ),
              ], index: 3),

            // Additional Information Card
            _buildInfoRowWithAnimation('Additional Information', [
              _buildInfoRow('Customer Since', '2023-01-15'),
              _buildInfoRow('Last Updated', '2023-10-30'),
            ], index: 2),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
