import 'package:ecommerce_amazonclone_flutter/common/widgets/loader.dart';
import 'package:ecommerce_amazonclone_flutter/features/admin/models/sales.dart';
import 'package:ecommerce_amazonclone_flutter/features/admin/services/admin_services.dart';
import 'package:ecommerce_amazonclone_flutter/features/admin/widgets/category_products_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  BarChartGroupData(
                    x: 0,
                    barRods: earnings!.map((sales) {
                      return BarChartRodData(
                        toY: sales.earning.toDouble(),
                        width: 22,
                        borderRadius: BorderRadius.zero,
                      );
                    }).toList(),
                  ),
                ]),
              )
            ],
          );
  }
}
