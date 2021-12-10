class ApplicationRouteService{
  List<String> _routeList = [];
  ApplicationRouteService(){
    _routeList.add("Splash");
  }
  addAndRemoveScreen({required String screenName}){
    if(_routeList.length == 0){
      _routeList.add(screenName);
    }else{
      _routeList.removeAt(0);
      _routeList.add(screenName);
    }
  }

  addScreen({required String screenName}){
      _routeList.add(screenName);
  }
  removeAllAndAdd({required String screenName}){
    _routeList = [];
    _routeList.add(screenName);
  }

  removeScreen({required String screenName}){
    _routeList.remove(screenName);
  }

  String currentScreen(){
    return _routeList.last;
  }
}