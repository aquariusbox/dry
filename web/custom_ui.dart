import 'package:web_ui/web_ui.dart';
import 'dart:html';

class Navbar extends WebComponent {
  
  // Element id of current li item like li-home
  @observable String activeid = '';
  
  // Change style of current li item to active
  inserted(){
    query('#$activeid').className="active";
  }
}