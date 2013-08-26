part of dry;

abstract class View{
  List<Element> elements;
}

/**
 * Add view to DOM tree
 */
void add2Dom(View view, [Element parent]){
  if(parent == null){
    parent = document.body;
  }
  parent.nodes.addAll(view.elements);
}

void loading(bool show){
  if(show)
    query('#navbar-msg').classes.remove('hidden');
  else
    query('#navbar-msg').classes.add('hidden');
}