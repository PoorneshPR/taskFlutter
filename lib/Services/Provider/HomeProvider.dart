import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import '../../Models/ecommercemodels.dart';
import '../../common/helpers.dart';
import '../service_config.dart';

class HomeProvider extends ChangeNotifier{
  ServiceConfig serviceConfig = ServiceConfig();
  EcommerceModel? ecommerceModel;
  LoadState pageLoadState = LoadState.loaded;
  void homeInit() {
    pageLoadState = LoadState.loading;
    notifyListeners();
  }
  Future<void>gethomeData() async{
    updatePageLoadState(LoadState.loading);
    final network =await Helpers.isInternetAvailable();
    if(network){
      ecommerceModel = await serviceConfig.getHomeData();
      updatePageLoadState(LoadState.loaded);
      notifyListeners();
    }
    else{
      updatePageLoadState(LoadState.networkError);
    }
  }
  void updatePageLoadState(LoadState val) {
    pageLoadState = val;
    notifyListeners();
  }
}