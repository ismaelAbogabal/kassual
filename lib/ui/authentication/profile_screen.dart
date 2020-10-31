import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/ui/authentication/address_adder_screen.dart';
import 'package:kassual/ui/cart/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ShopifyUser user;

  ProfileScreen({Key key, @required this.user})
      : assert(user != null),
        super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  var controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: TabBarView(
        controller: controller,
        children: [
          detailsTab(),
          addressScreen(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.user.displayName),
      bottom: TabBar(
        isScrollable: true,
        controller: controller,
        tabs: [
          Tab(text: "Details"),
          Tab(text: "Addresses"),
        ],
      ),
    );
  }

  Widget detailsTab() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: widget.user.tags
                .map((e) => Chip(
                      label: Text(e),
                      elevation: 0,
                      backgroundColor: Colors.black45,
                      labelStyle: TextStyle(color: Colors.white),
                    ))
                .toList(),
          ),
        ),
        ListTile(
          title: Text("Name"),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(widget.user.displayName),
          ),
        ),
        Divider(),
        ListTile(
          title: Text("Email"),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(widget.user.email),
          ),
        ),
        Divider(),
        ListTile(
          title: Text("Phone"),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(widget.user.phone ?? "none"),
          ),
        ),
        Divider(),
        ListTile(
          title: Text("Orders"),
          onTap: openOrdersScreen,
        ),
        Divider(),
        ListTile(
          title: Text("Logout", style: TextStyle(color: Colors.redAccent)),
          trailing: Icon(Icons.logout, color: Colors.redAccent),
          onTap: () {
            BlocProvider.of<UserBloc>(context).add(UESignOut());
          },
        ),
        Divider(),
      ],
    );
  }

  String formattedAddress(Address address) {
    String formattedAddress = '';

    if (address == null) return formattedAddress;

    if (address.country != null) {
      formattedAddress += address.country + ",";
    }

    if (address.province != null) {
      formattedAddress += address.province + ",";
    }

    if (address.city != null) {
      formattedAddress += address.city + ",";
    }

    if (address.formattedArea != null) {
      formattedAddress += address.formattedArea + ",";
    }

    return formattedAddress;
  }

  Widget addressScreen() {
    return ListView(
      children: [
        ...widget.user.address.addressList.map((e) => addressData(e)).toList(),
        ListTile(
          selected: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddressAdderScreen()),
            );
          },
          title: Text("Add Address"),
          trailing: Icon(Icons.add),
        ),
      ],
    );
  }

  addressData(Address address) {
    return ExpansionTile(
      trailing: addressPopupMenuButton(address),
      title: Text(
          "Address: ${address.address1 ?? address.address2 ?? address.city}"),
      children: [
        if (address.firstName != null && address.firstName.isNotEmpty)
          listTileItem("FirstName", address.firstName),
        if (address.lastName != null && address.lastName.isNotEmpty)
          listTileItem("Last Name", address.lastName),
        if (address.country != null && address.country.isNotEmpty)
          listTileItem("Country", address.country),
        if (address.address1 != null && address.address1.isNotEmpty)
          listTileItem("Address 1", address.address1),
        if (address.address2 != null && address.address2.isNotEmpty)
          listTileItem("Address 2", address.address2),
        if (address.city != null && address.city.isNotEmpty)
          listTileItem("City", address.city),
        if (address.province != null && address.province.isNotEmpty)
          listTileItem("Province", address.province),
        if (address.zip != null && address.zip.isNotEmpty)
          listTileItem("Zip code", address.zip),
        if (address.phone != null && address.phone.isNotEmpty)
          listTileItem("phone", address.phone),
      ],
    );
  }

  PopupMenuButton addressPopupMenuButton(Address address) {
    return PopupMenuButton<Function(Address)>(
      onSelected: (value) => value?.call(address),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("Modify"),
          value: modifyAddress,
        ),
        PopupMenuItem(
          child: Text("Delete"),
          value: deleteAddress,
        ),
      ],
    );
  }

  ListTile listTileItem(String title, String trailing) {
    return ListTile(
      leading: Text(title),
      trailing: Text(trailing),
      onTap: () {},
    );
  }

  deleteAddress(Address address) {
    UserBloc.of(context).add(UERemoveAddress(address));
  }

  modifyAddress(Address address) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressAdderScreen(address: address),
      ),
    );
  }

  void openOrdersScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersScreen(),
      ),
    );
  }
}
