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
List<String> fields = toObservable(new List<String>());
List<String> rulecases = toObservable(new List<String>());

@observable
String selectedFormat = 'CTCS2X/315';
String selectedDatasource = 'b2bowner@stg';
String selectedConvType = '315';
String selectedSegment = 'Exception';
String selectedField = '*';
String selectedRulecase = '*';

Map metas;

main(){
  initialize();
}

void loading(bool show){
  if(show)
    query('#navbar-msg').classes.remove('hidden');
  else
    query('#navbar-msg').classes.add('hidden');
}
// Get the base url
String getBaseUrl(){
  return window.location.protocol + '//'+ window.location.hostname + ':$port$service';
}

void initialize(){  
  port = window.location.port == '3030' ? TESTING_PORT : window.location.port;
  service = window.location.port == '3030' ? SERVICE : '/dry'+SERVICE;
  fetchDatasources();
}

void fetchDatasources(){
  var url =  getBaseUrl()+'?opt=datasources';
  var request = HttpRequest.getString(url).then((jstr){
    datasources.addAll(json.parse(jstr));
    fetchFormats();
  });
}

void fetchFormats(){
  var url =  getBaseUrl()+'?opt=formats&ds=${selectedDatasource}';
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
  var url =  getBaseUrl()+'?opt=convTypes&ds=${selectedDatasource}&fmt=${selectedFormat}';
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
  var url =  getBaseUrl()+'?opt=segments&ds=${selectedDatasource}&fmt=${selectedFormat}&cvt=${selectedConvType}';
  var request = HttpRequest.getString(url).then((jstr){
    segments.clear();
    segments.addAll(json.parse(jstr));
    // Auto select first if not found
    if(!segments.contains(selectedSegment))
      selectedSegment = segments.first;
    fetchFields();
  });
}

void fetchFields(){
  var url =  getBaseUrl()+'?opt=fields&ds=$selectedDatasource&fmt=$selectedFormat&cvt=$selectedConvType&seg=$selectedSegment';
  var request = HttpRequest.getString(url).then((jstr){
    fields.clear();
    fields.addAll(json.parse(jstr));
    fields.add('*');
    // Auto select first if not found
    if(!fields.contains(selectedField))
      selectedField = fields.first;
    fetchCases();
  });
}

void fetchCases(){
  var url =  getBaseUrl()+'?opt=cases&ds=$selectedDatasource&fmt=$selectedFormat&cvt=$selectedConvType&seg=$selectedSegment&snum=$selectedField';
  var request = HttpRequest.getString(url).then((jstr){
    rulecases.clear();
    rulecases.addAll(json.parse(jstr));
    // Auto select first if not found
    if(!rulecases.contains(selectedRulecase))
      selectedRulecase = rulecases.first;
    fetchMatrix();
  });
}

void fetchMatrix(){
  loading(true);
  var url = getBaseUrl()+'?opt=matrix&ds=${selectedDatasource}&fmt=$selectedFormat&cvt=$selectedConvType&seg=$selectedSegment&snum=$selectedField&case=$selectedRulecase';
  var request = HttpRequest.getString(url).then((jstr){
    Map jmap = json.parse(jstr);
    // Create matrix table
    Matix matrix = new Matix("matrix", ['fancyTable']);
    List<String> headings = new List();
    headings.add(HEADING_OF_TABLE);
    headings.addAll(jmap['tpIds']);
    matrix.bindHeader(headings);
    matrix.bindData(headings, jmap['keys'], jmap['sequences'],jmap['detail']);
    
    var parent = query('#div-matrix');
    if(parent.hasChildNodes())
      parent.children.removeLast();
    
    add2Dom(matrix, parent);
    
    jsFixTableHeader("#matrix",  jmap['detail'].length);
    
    loading(false);
    fetchDocument();
  }); 
}

void fetchDocument(){
  loading(true);
  var url = getBaseUrl()+'?opt=document&ds=${selectedDatasource}&fmt=$selectedFormat&cvt=$selectedConvType&seg=$selectedSegment&snum=$selectedField&case=$selectedRulecase';
  var request = HttpRequest.getString(url).then((jstr){
      metas = json.parse(jstr);
      if(query('#definition') != null){
        var divs = queryAll('#definition');
        for(Element div in divs){
          div.remove();
        }
      }
  
      for(String fingerprint in metas.keys){
        var rule = metas[fingerprint]['rule'];
        var meta = metas[fingerprint]['meta'];
        Definition def = new Definition();
        def.bindData(fingerprint, rule, meta);
        //query('#div-definitions').children.addAll(def.elements);
        add2Dom(def);    
      }
      
      jsprettyPrint();
  });
  loading(false);
  return;
}

void onDatasourcesChange(){
  fetchFormats();
}
void onFormatsChange(){
  fetchConvTypes();
}


void jsFixTableHeader(String selector, int numOfRec){
  var height = (numOfRec+1) * 40 > 750 ? 750 : ((numOfRec+1) * 40) + 10;
  js.scoped((){
    //var param = js.map({'footer': true, 'cloneHeadToFoot': true, 'fixedColumns' : 1});
    var param = js.map({'footer': height >= 750, 'cloneHeadToFoot': true,'height':height,'fixedColumns' : 1});
    js.context.jQuery(selector).fixedHeaderTable(param);
    }  
  );
}

void jsprettyPrint(){
  js.scoped((){
    js.context.prettyPrint();
    }  
  );
}

class Definition extends View {
  DivElement _div;
  
  Definition(){
    _div = new Element.div();
    _div.classes = ['container'];
    _div.id = 'definition';
  }
  
  void bindData(String fingerprint, Map rule, Map meta){
    Element h4 = new Element.tag('h4');
    h4.text = 'Definition of ${rule['ruleName']}';
    _div.nodes.add(h4);
    // Prepare anchor
    Element anchor = new Element.a();
    anchor.attributes = {"name":fingerprint};
    anchor.text ="#";
    h4.nodes.add(anchor);
    
    Element p = new Element.p(); 
    p.id = 'description';
    p.innerHtml = meta != null ? meta['description'] : "No description";

    Element pre = new Element.pre();
    pre.classes = ['prettyprint lang-dart'];
    pre.text = meta != null ? meta['pseudocode'] : "No logic";
    
    anchor = new Element.a();
    anchor.attributes = {'href':'#top'};
    anchor.classes = ['anchor-top'];
    anchor.text = 'Back to top';
    
    _div.nodes.add(p);
    _div.nodes.add(pre);
    _div.nodes.add(anchor);
  }
  
  // Returns a list of elements to be added to DOM.
  List<Element> get elements {
    List<Element> result = new List();
    result.add(_div);
    return result;
  }  
  
}

class Matix extends View{
  // Tag table
  TableElement _table;
  
  Matix(String id, List<String> styles){
    _table = new Element.tag("table");
    _table.id = id;
    //_table.classes = ['table table-bordered table-condensed table-hover fancyTable'];
    // _table.classes = ['fancyTable'];
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
  
  Element createAnchor(String id, String text){
    AnchorElement anchor = new Element.a();
    anchor.text = text;
    return anchor;
  }
  
  // bind the data item into the table
  void bindData(List<String> headings, List<String> keysOfRule, Map<String,String> sequences,  Map<String,Map<String,String>> detail){
    Element tbody = new Element.tag('tbody');
    keysOfRule.forEach((current){
      TableRowElement row = new Element.tr();
      tbody.nodes.add(row);
      var idxColn = 0;
      headings.forEach((heading){
        var id = current+"-"+heading;
        var fieldValue = ' ';
        if(heading != HEADING_OF_TABLE){
          if(sequences.containsKey(id))
            fieldValue = '<span class="label label-info">'+sequences[id]+'</span>';  
        } else { // Print the rule name
            fieldValue = '<p><span class="badge">'+detail[current]['ruleCase']+'</span> ' + 
                //detail[current]['segNum']+" / "+detail[current]['ruleName']+
                '<a href="#$current">'+detail[current]['segNum']+" / "+detail[current]['ruleName']+'</a>'
                "</p>"; 
        }
          
        TableCellElement cell = new Element.td();
        if(fieldValue.contains("span")){
          if(idxColn++ > 0)
             cell.attributes = {"align":"center"};
          cell.nodes.add(new Element.html(fieldValue));
        }else
          cell.text = fieldValue;
        row.nodes.add(cell);
      });
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