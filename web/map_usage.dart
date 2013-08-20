import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'dart:async'; 
import 'dart:json' as json;
import 'package:js/js.dart' as js;

const SERVICE = '/dry/service-rules-usage';
const TESTING_PORT = '8888';
const HEADING_OF_TABLE = 'Rules / PMT';
String port;
String service;
List<String> formats = toObservable(new List<String>());
List<String> datasources = toObservable(new List<String>());
List<String> convTypes = toObservable(new List<String>());
List<String> segments = toObservable(new List<String>());

@observable
String selectedFormat = 'CTCS2X/315';
String selectedDatasource = 'b2bowner@stg';
String selectedConvType = '315';
String selectedSegment = 'Exception';

main(){
  initialize();
}

String getUrl(){
  return window.location.protocol + '//'+ window.location.hostname + ':$port$service';
  //return 'http://chanro32:8080/dry'+SERVICE;
}
void initialize(){  
  port = window.location.port == '3030' ? TESTING_PORT : window.location.port;
  service = window.location.port == '3030' ? SERVICE : '/dry'+SERVICE;
  fetchDatasources();
}

void fetchDatasources(){
  var url =  getUrl()+'?opt=datasources';
  var request = HttpRequest.getString(url).then((jstr){
    datasources.addAll(json.parse(jstr));
    fetchFormats();
  });
}

void fetchFormats(){
  var url =  getUrl()+'?opt=formats&ds=${selectedDatasource}';
  var request = HttpRequest.getString(url).then((jstr){
    formats.clear();
    formats.addAll(json.parse(jstr)); 
    // Auto select first if not found
    if(!formats.contains(selectedFormat))
      selectedFormat = formats.first;
    fetchConvTypes();
  });
}

void fetchConvTypes(){
  var url =  getUrl()+'?opt=convTypes&ds=${selectedDatasource}&fmt=${selectedFormat}';
  var request = HttpRequest.getString(url).then((jstr){
    convTypes.clear();
    convTypes.addAll(json.parse(jstr));
    // Auto select first if not found
    if(!convTypes.contains(selectedConvType))
      selectedConvType = convTypes.first;
    fetchSegments();
  });
}

void fetchSegments(){
  var url =  getUrl()+'?opt=segments&ds=${selectedDatasource}&fmt=${selectedFormat}&cvt=${selectedConvType}';
  var request = HttpRequest.getString(url).then((jstr){
    segments.clear();
    segments.addAll(json.parse(jstr));
    segments.add('*');
    // Auto select first if not found
    if(!segments.contains(selectedSegment))
      selectedSegment = segments.first;
    fetchMatrix();
  });
}

void fetchMatrix(){
  var url = getUrl()+'?opt=matrix&ds=${selectedDatasource}&fmt=${selectedFormat}&cvt=${selectedConvType}&segid=${selectedSegment}';
  var request = HttpRequest.getString(url).then((jstr){
    Map jmap = json.parse(jstr);
    // Create matrix table
    Matix matrix = new Matix("matrix", ['fancyTable']);
    List<String> headings = new List();
    headings.add(HEADING_OF_TABLE);
    headings.addAll(jmap['tpIds']);
    matrix.bindHeader(headings);
    matrix.bindData(headings, jmap['keys'], jmap['sequences'],jmap['paths']);
    
    var parent = query('#div-matrix');
    if(parent.hasChildNodes())
      parent.children.removeLast();
    
    add2Dom(matrix, parent);
    
    jsFixTableHeader("#matrix",  jmap['paths'].length);
  });
}

void onDatasourcesChange(){
  fetchFormats();
}
void onFormatsChange(){
  fetchConvTypes();
}


void jsFixTableHeader(String selector, int numOfRec){
  var height = (numOfRec+1) * 50 > 750 ? 750 : (numOfRec+1) * 40;
  js.scoped((){
    //var param = js.map({'footer': true, 'cloneHeadToFoot': true, 'fixedColumns' : 1});
    var param = js.map({'footer': height >= 750, 'cloneHeadToFoot': true,'height':height,'fixedColumns' : 1});
    js.context.jQuery(selector).fixedHeaderTable(param);
    }  
  );
}

class Matix extends View{
  // Tag table
  TableElement _table;
  
  Matix(String id, List<String> styles){
    _table = new Element.tag("table");
    _table.id = id;
    //_table.classes = ['table table-bordered table-condensed table-hover fancyTable'];
    //_table.classes = ['fancyTable'];
    _table.classes = styles;
  }
  
  // Bind table header
  void bindHeader(List<String> headings, [List<String> rowStyle, List<String> cellStyle]){
    Element thead = new Element.tag('thead');
    TableRowElement row = new Element.tr();
    if(rowStyle != null)
      row.classes = rowStyle;
    thead.nodes.add(row);
    headings.forEach((heading){
      TableCellElement cell = new Element.th();
      if(cellStyle != null)
        cell.classes = cellStyle;
      cell.text = heading;
      row.nodes.add(cell);      
    });
    _table.nodes.add(thead);
  }
  
  // bind the data item into the table
  void bindData(List<String> headings, List<String> keysOfRule, Map<String,String> sequences,  Map<String,String> paths){
    Element tbody = new Element.tag('tbody');
    int rowIdx = 0;
    keysOfRule.forEach((current){
      TableRowElement row = new Element.tr();
      tbody.nodes.add(row);
      headings.forEach((heading){
        var id = current+"-"+heading;
        var fieldValue = ' ';
        if(heading != HEADING_OF_TABLE){
          if(sequences.containsKey(id))
            fieldValue = '<span class="label label-info">'+sequences[id]+'</span>';  
        } else if(rowIdx == 0){
          fieldValue = HEADING_OF_TABLE;
        }
        else { // Print the rule name
          fieldValue = paths[current];
        }
          
        TableCellElement cell = new Element.td();

        if(fieldValue.contains("span")){
          cell.attributes = {"align":"center"};
          cell.nodes.add(new Element.html(fieldValue));
        }else
          cell.text = fieldValue;
        row.nodes.add(cell);
      });
      rowIdx++;
    });
    _table.nodes.add(tbody);
  }
  
  // Returns a list of elements to be added to DOM.
  List<Element> get elements {
    List<Element> result = new List();
    result.add(_table);
    return result;
  }  
  
}

abstract class View{
  List<Element> elements;
}

// Add view to DOM tree
void add2Dom(View view, [Element parent]){
  if(parent == null){
    parent = document.body;
  }
  parent.nodes.addAll(view.elements);
}