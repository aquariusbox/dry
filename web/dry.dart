import 'dart:html';
import 'package:google_maps/google_maps.dart';
import 'package:js/js.dart' as js;
import 'dart:math' as math;

void main() {

  // Embed google map 
  embedGoogleMap();
}

void embedGoogleMap(){
  var rng = new math.Random();
  js.scoped((){
    final mapOptions = new MapOptions()
      ..zoom = (rng.nextInt(10) + 5)
      ..disableDoubleClickZoom = true
      ..center = new LatLng(randomInRange(-85,85,3), randomInRange(-180,180,3))
      ..mapTypeId = MapTypeId.TERRAIN
      ;
    mapOptions.disableDefaultUI = true;
    mapOptions.zoomControl = false;
    final map = new GMap(query("#map_canvas"), mapOptions);
  });
}

// Random generate longitude & latitude range
double randomInRange(var from, var to, var fixed){
  var rng = new math.Random();
  var str = (rng.nextDouble() * (to - from) + from).toStringAsFixed(fixed);
  return double.parse(str) * 1;
}