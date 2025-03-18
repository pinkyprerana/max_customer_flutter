import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_customer/core/routes/app_router.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/app_text_styles.dart';
import '../core/utils/app_urls.dart';
import '../models/customer_model.dart';
import '../core/infrastructure/db_helper.dart';
import 'package:url_launcher/url_launcher.dart';


@RoutePage()
class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<Customer> customers = [];

  Future<void> loadCustomers() async {
    final dbHelper = DBHelper();
    final data = await dbHelper.getCustomers();
    setState(() { customers = data; });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: Container(
          alignment: Alignment.center,
          margin:
          const EdgeInsets.only(top: 10, left: 20, right: 0, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.colorPrimary.withValues(alpha:0.20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              5.horizontalSpace,
              Icon(Icons.person,
                  color: AppColors.colorPrimary, size: 15.h),
            ],
          ),
        ),
        title: Text(
          'Customer List',
          style: AppTextStyles.textStylePoppinsBold.copyWith(
            color: AppColors.colorPrimary,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: customer.image.isNotEmpty
                  ? FileImage(File(customer.image))  // Use FileImage for local images
                  : AssetImage('assets/images/default_avatar.png') as ImageProvider,  // Fallback image
            ),

            title: Text(customer.name,
            style: AppTextStyles.textStylePoppinsMedium.copyWith(
            fontSize: 13.sp,
            color: AppColors.colorPrimary,
            ),),
            subtitle: Text(customer.geoAddress,
              style: AppTextStyles.textStylePoppinsRegular.copyWith(
                fontSize: 11.sp,
                color: AppColors.colorPrimaryAlpha,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.location_on, color: AppColors.colorRed,),
              onPressed: () => launchUrl(Uri.parse("${AppUrls.googleMapUrl}${customer.latitude},${customer.longitude}")),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorPrimary,
        child: Icon(Icons.add, color: AppColors.colorWhite,),
        onPressed: () async {
          final result = await AutoRouter.of(context).push(AddCustomerRoute(),
          );
          if (result == true) {
            await loadCustomers();
          }
        },
      ),
    );
  }
}
