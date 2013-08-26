part of dry;

/**
 * Call Google javascript pretty print.
 */
void jsprettyPrint(){
  js.scoped((){
    js.context.prettyPrint();
    }  
  );
}