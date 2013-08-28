import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'dart:async'; 
import 'dart:json' as json;
import 'package:js/js.dart' as js;
import 'utils.dart' as dry;

const int MATRIX_HEIGHT = 1400;
const MATRIX_HEADING = 'Rules / PMT';
const SERVICE = '/dry/service-rules-usage';

List<String> formats = toObservable(new List<String>());
List<String> datasources = toObservable(new List<String>());
List<String> tps = toObservable(new List<String>());


@observable
String selectedFormat = 'CTCS2X/315';
String selectedDatasource = 'b2bowner@stg';
String selectedTp = 'GTNEXUS';

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
    if(!formats.contains(selectedFormat)){
      selectedFormat = formats.first;
    }
    fetchTps();
  });
}

void fetchTps(){
  var url = dry.getBaseUrl(SERVICE)+parametersStr('md_tps', selectedDatasource,selectedFormat);
  var request = HttpRequest.getString(url).then((jstr){
    tps.clear();
    tps.addAll(json.parse(jstr)); 
    // Auto select first if not found
    if(!tps.contains(selectedTp))
      selectedTp = tps.first;
    fetchMd();
  });
}

void fetchMd(){
  dry.loading(true);
  var url = dry.getBaseUrl(SERVICE)+parametersStr('md_by_tp', selectedDatasource,selectedFormat,selectedTp);
  var request = HttpRequest.getString(url).then((jstr){
    Map jmap = json.parse(jstr);
    // Create matrix table
    Matrix matrix = new Matrix("matrix", ['fancyTable']);
    List<String> headings = ['Segment','Element','MOC','Type','Len','Max','Mapping'];
    matrix.bindHeader(headings);
    matrix.bindData(jmap, headings);
    
    var parent = query('#div-matrix');
    if(parent.hasChildNodes())
      parent.children.removeLast();
    
    dry.add2Dom(matrix, parent);
    
    jsFixTableHeader("#matrix",  jmap.length - 1);
    // Pretty print code.
    dry.jsprettyPrint();
    
    dry.loading(false);
  });
}


String parametersStr(String operation, [String datasource, String format, String tp1, String segId, String segNum, String ruleCase]){
  var parameters = '?opt='+operation;
  if(datasource != null)
    parameters = parameters +'&ds=' + datasource;
  if(format != null)
    parameters = parameters +'&fmt=' + format;
  if(tp1 != null)
    parameters = parameters +'&tp=' + tp1;
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
  fetchTps();
}

/**
 * When list of formats is changed.
 */
void onTpChange(){
  fetchMd();
}


/**
 * Call javascript to fix the first row and first colume in matrix table.
 */
void jsFixTableHeader(String selector, int numOfRec){
  var height = (numOfRec+1) * 40 > MATRIX_HEIGHT ? MATRIX_HEIGHT : ((numOfRec+1) * 40) + 10;
  js.scoped((){
    // Need footer if height of table LT matrix height.
    var param = js.map({'footer': height >= MATRIX_HEIGHT, 'cloneHeadToFoot': true,'height':height,'fixedColumns' : 0});
    js.context.jQuery(selector).fixedHeaderTable(param);
    }  
  );
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
  void bindData(Map jmap, List<String> headings){
    Element tbody = new Element.tag('tbody');
     jmap.values.forEach((map){
      TableRowElement tr = new Element.tr();
      tbody.nodes.add(tr);
      headings.forEach((heading){
        TableCellElement td = new Element.td();
        var text = '';
        if (heading == 'Segment')
          text = map['segId'];
        if (heading == 'Element')
          text = map['segNum'];        
        else if(heading == 'MOC')
          text = map['moc'];
        else if(heading == 'Type')
          text = map['dataType'];
        else if(heading == 'Len')
          text = map['dataLength'];    
        else if(heading == 'Max')
          text = map['maxUse'];           
        if(heading == 'Mapping'){   
          Element pre = new Element.pre();
          pre.classes = ['prettyprint lang-dart'];
          pre.text = map['code'];
          td.nodes.add(pre);
        }else{
          td.text = text;
        }
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
