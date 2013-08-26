import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'dart:async'; 
import 'dart:json' as json;
import 'package:js/js.dart' as js;
import 'utils.dart' as dry;

const int MATRIX_HEIGHT = 750;
const MATRIX_HEADING = 'Rules / PMT';
const SERVICE = '/dry/service-rules-usage';

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
  // initialize
  fetchDatasources();
}

void fetchDatasources(){
  var url = dry.getBaseUrl(SERVICE)+parametersStr('datasources');
  var request = HttpRequest.getString(url).then((jstr){
    datasources.addAll(json.parse(jstr));
    fetchFormats();
  });
}

void fetchFormats(){
  var url = dry.getBaseUrl(SERVICE)+parametersStr('formats', selectedDatasource);
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
  var url = dry.getBaseUrl(SERVICE)+parametersStr('convTypes', selectedDatasource, selectedFormat);
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
  var url = dry.getBaseUrl(SERVICE)+parametersStr('segments', selectedDatasource, selectedFormat, selectedConvType);
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
  var url = dry.getBaseUrl(SERVICE)+parametersStr('fields', selectedDatasource, selectedFormat, selectedConvType, selectedSegment);
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
  var url = dry.getBaseUrl(SERVICE)+parametersStr('cases', selectedDatasource, selectedFormat, selectedConvType, selectedSegment, selectedField);
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
  dry.loading(true);
  var url = dry.getBaseUrl(SERVICE)+parametersStr('matrix', selectedDatasource, selectedFormat, selectedConvType, selectedSegment, selectedField, selectedRulecase);
  var request = HttpRequest.getString(url).then((jstr){
    Map jmap = json.parse(jstr);
    // Create matrix table
    Matrix matrix = new Matrix("matrix", ['fancyTable']);
    List<String> headings = new List();
    headings.add(MATRIX_HEADING);
    headings.addAll(jmap['tpIds']);
    matrix.bindHeader(headings);
    matrix.bindData(headings, jmap['keys'], jmap['sequences'],jmap['detail']);
    
    var parent = query('#div-matrix');
    if(parent.hasChildNodes())
      parent.children.removeLast();
    
    dry.add2Dom(matrix, parent);
    
    jsFixTableHeader("#matrix",  jmap['detail'].length);
    
    dry.loading(false);
    fetchDocument();
  }); 
}

String parametersStr(String operation, [String datasource, String format, String convertType, String segId, String segNum, String ruleCase]){
  var parameters = '?opt='+operation;
  if(datasource != null)
    parameters = parameters +'&ds=' + datasource;
  if(format != null)
    parameters = parameters +'&fmt=' + format;
  if(convertType != null)
    parameters = parameters +'&cvt=' + convertType;
  if(segId != null)
    parameters = parameters +'&seg=' + segId;
  if(segId != null)
    parameters = parameters +'&seg=' + segId;
  if(segNum != null)
    parameters = parameters +'&snum=' + segNum;
  if(ruleCase != null)
    parameters = parameters +'&case=' + ruleCase;
  return parameters;
}

void fetchDocument(){
  dry.loading(true);
  var url = dry.getBaseUrl(SERVICE)+parametersStr('document', selectedDatasource, selectedFormat, selectedConvType, selectedSegment, selectedField, selectedRulecase);
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
        dry.add2Dom(def);    
      }
      // Pretty print code.
      dry.jsprettyPrint();
  });
  dry.loading(false);
  return;
}

/**
 * When list of datasource is changed.
 */
void onDatasourcesChange(){
  fetchFormats();
}

/**
 * When list of formats is changed.
 */
void onFormatsChange(){
  fetchConvTypes();
}

/**
 * Call javascript to fix the first row and first colume in matrix table.
 */
void jsFixTableHeader(String selector, int numOfRec){
  var height = (numOfRec+1) * 40 > MATRIX_HEIGHT ? MATRIX_HEIGHT : ((numOfRec+1) * 40) + 10;
  js.scoped((){
    // Need footer if height of table LT matrix height.
    var param = js.map({'footer': height >= MATRIX_HEIGHT, 'cloneHeadToFoot': true,'height':height,'fixedColumns' : 1});
    js.context.jQuery(selector).fixedHeaderTable(param);
    }  
  );
}

/**
 * Definition view for each rule.
 */
class Definition extends dry.View {
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

/**
 * Matrix table of rules usage.
 */
class Matrix extends dry.View{
  // Tag table
  TableElement _table;
  
  Matrix(String id, List<String> styles){
    _table = new Element.tag("table");
    _table.id = id;
    _table.classes = styles;
  }
  
  // Bind header
  void bindHeader(List<String> headings, [List<String> rowStyle, List<String> cellStyles]){
    Element thead = new Element.tag('thead');
    TableRowElement tr = new Element.tr();
    if(rowStyle != null)
      tr.classes = rowStyle;
    thead.nodes.add(tr);
    
    headings.forEach((heading){
      TableCellElement th = new Element.th();
      if(cellStyles != null)
        th.classes = cellStyles;
      th.text = heading;
      tr.nodes.add(th);      
    });
    _table.nodes.add(thead);
  }
  
  Element createAnchor(String id, String text){
    AnchorElement anchor = new Element.a();
    anchor.text = text;
    return anchor;
  }
  
  /**
   * Assign value into table cell.
   */
  void bindData(List<String> headings, List<String> fingerprints, Map<String,String> sequences,  Map<String,Map<String,String>> detail){
    Element tbody = new Element.tag('tbody');
    fingerprints.forEach((fingerprint){
      TableRowElement tr = new Element.tr();
      tbody.nodes.add(tr);
      
      var idxColn = 0;
      headings.forEach((heading){
        var fingerprintTp = fingerprint+"-"+heading;
        var fieldValue = ' ';
        // Not 1st column
        if(heading != MATRIX_HEADING){
          if(sequences.containsKey(fingerprintTp))
            fieldValue = '<span class="label label-info">'+sequences[fingerprintTp]+'</span>';  
        } else { 
            // Print the rule name
            fieldValue = '<p><span class="badge">'+detail[fingerprint]['ruleCase']+'</span> ' + 
                '<a href="#$fingerprint">'+detail[fingerprint]['segNum']+" / "+detail[fingerprint]['ruleName']+'</a>'
                "</p>"; 
        }
          
        TableCellElement td = new Element.td();
        if(fieldValue.contains("span")){
          if(idxColn++ > 0)
             td.attributes = {"align":"center"};
          td.nodes.add(new Element.html(fieldValue));
        }
        else
          td.text = fieldValue;
        tr.nodes.add(td);
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
