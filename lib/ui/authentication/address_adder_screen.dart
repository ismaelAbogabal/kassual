import 'package:flutter/material.dart';
import 'package:flutter_simple_shopify/flutter_simple_shopify.dart';
import 'package:kassual/bloc/user_bloc/user_bloc.dart';
import 'package:kassual/ui/widgets/app_bar.dart';

class AddressAdderScreen extends StatefulWidget {
  final Address address;

  const AddressAdderScreen({Key key, this.address}) : super(key: key);

  @override
  _AddressAdderScreenState createState() => _AddressAdderScreenState();
}

class _AddressAdderScreenState extends State<AddressAdderScreen> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final company = TextEditingController();
  final address1 = TextEditingController();
  final address2 = TextEditingController();
  final country = TextEditingController();
  final province = TextEditingController();
  final city = TextEditingController();
  final zip = TextEditingController();
  final phone = TextEditingController();

  bool isDefault;

  bool modify;

  Address get shopifyAddress => Address(
        id: widget.address?.id,
        firstName: firstName.text,
        lastName: lastName.text,
        name: firstName.text,
        address1: address1.text,
        address2: address2.text,
        city: city.text,
        company: company.text,
        country: country.text,
        phone: phone.text,
        province: province.text,
        zip: zip.text,
      );

  @override
  void initState() {
    modify = widget.address != null;

    if (widget.address != null) {
      initData();
    }

    super.initState();
  }

  void initData() {
    Address address = widget.address;

    firstName.text = address.firstName;
    lastName.text = address.lastName;
    company.text = address.company;
    address1.text = address.address1;
    address2.text = address.address2;
    country.text = address.country;
    province.text = address.province;
    city.text = address.city;
    zip.text = address.zip;
    phone.text = address.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [KAppBar()],
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: [
            TextField(
              controller: firstName,
              decoration: buildInputDecoration("First Name"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: lastName,
              decoration: buildInputDecoration("Last Name"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: company,
              decoration: buildInputDecoration("Company"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: address1,
              decoration: buildInputDecoration("Address1"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: address2,
              decoration: buildInputDecoration("Address2"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: country,
              decoration: buildInputDecoration("Country"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: province,
              decoration: buildInputDecoration("Province"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: city,
              decoration: buildInputDecoration("City"),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number,
              controller: zip,
              decoration: buildInputDecoration("Zip Code"),
            ),
            SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.phone,
              controller: phone,
              decoration: buildInputDecoration("Phone"),
            ),
            SizedBox(height: 8.0),
            CheckboxListTile(
              value: isDefault ?? false,
              title: Text("Default Address"),
              onChanged: (value) => setState(() => isDefault = value),
            ),
            SizedBox(height: 8.0),
            ButtonBar(
              children: [
                RaisedButton(
                  onPressed: submit,
                  colorBrightness: Brightness.dark,
                  child: Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }

  void submit() {
    if (modify) {
      UserBloc.of(context).add(UEModifyAddress(shopifyAddress));
    } else {
      UserBloc.of(context).add(UEAddAddress(shopifyAddress));
    }
    Navigator.pop(context);
  }
}
