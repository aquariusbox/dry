// Auto-generated from map_field.html.
// DO NOT EDIT.

library map_field_html;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'custom_ui.dart';
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'dart:async';
import 'dart:json' as json;
import 'package:js/js.dart' as js;
import '../utils.dart' as dry;


// Original code


const int MATRIX_HEIGHT = 1400;
const MATRIX_HEADING = 'Rules / PMT';
const SERVICE = '/dry/service-rules-usage';

List<String> formats = toObservable(new List<String>());
List<String> datasources = toObservable(new List<String>());
List<String> tps = toObservable(new List<String>());
List<String> tp2s = toObservable(new List<String>());

final __changes = new __observe.Observable();

String __$selectedFormat = 'CTCS2X/315';
String get selectedFormat {
  if (__observe.observeReads) {
    __observe.notifyRead(__changes, __observe.ChangeRecord.FIELD, 'selectedFormat');
  }
  return __$selectedFormat;
}
set selectedFormat(String value) {
  if (__observe.hasObservers(__changes)) {
    __observe.notifyChange(__changes, __observe.ChangeRecord.FIELD, 'selectedFormat',
        __$selectedFormat, value);
  }
  __$selectedFormat = value;
}
String selectedDatasource = 'b2bowner@stg';
String selectedTp = 'GTNEXUS';
String selectedTp2 = '-';

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
    tp2s.add('-');
    tp2s.addAll(tps);
    
    // Auto select first if not found
    if(!tps.contains(selectedTp))
      selectedTp = tps.first;
    if(!tp2s.contains(selectedTp2))
      selectedTp2 = tp2s.first;    
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
        tr.nodes.add(td);
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
          if(map['code'] != ""){
            Element pre = new Element.pre();
            pre.classes = ['prettyprint lang-dart'];
            pre.text = map['code'];
            td.nodes.add(pre);
            return;
          }else{
            text = 'NOT USED';
            //td.text = text;
          }
        } 
        td.text = text;
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

// Additional generated code
void init_autogenerated() {
  var __root = autogenerated.document.body;
  final __html0 = new autogenerated.OptionElement(), __html1 = new autogenerated.OptionElement(), __html2 = new autogenerated.OptionElement();
  var __e0, __e3, __e6, __e9;
  var __t = new autogenerated.Template(__root);
  __e0 = __root.nodes[3];
  __t.oneWayBind(() => 't-rbase', (e) { if (__e0.xtag.activeid != e) __e0.xtag.activeid = e; }, false, false);
  __t.component(new Navbar()..host = __e0);
  __e3 = __root.nodes[5].nodes[3].nodes[1].nodes[1];
  __t.listen(__e3.onChange, ($event) { selectedDatasource = __e3.value; });
  __t.listen(__e3.onChange, ($event) { onDatasourcesChange(); });
  __t.oneWayBind(() => selectedDatasource, (e) { if (__e3.value != e) __e3.value = e; }, false, false);
  __t.loopIterateAttr(__e3, () => datasources, ($list, $index, __t) {
    var datasource = $list[$index];
    var __e2;
    __e2 = __html0.clone(true);
    var __binding1 = __t.contentBind(() => datasource, false);
    __e2.nodes.add(__binding1);
    __t.oneWayBind(() => selectedDatasource == datasource, (e) { if (__e2.selected != e) __e2.selected = e; }, false, false);
  __t.addAll([new autogenerated.Text('\n                  '),
      __e2,
      new autogenerated.Text('\n               ')]);
  });
  __e6 = __root.nodes[5].nodes[3].nodes[3].nodes[1];
  __t.listen(__e6.onChange, ($event) { selectedFormat = __e6.value; });
  __t.listen(__e6.onChange, ($event) { onFormatsChange(); });
  __t.oneWayBind(() => selectedFormat, (e) { if (__e6.value != e) __e6.value = e; }, false, false);
  __t.loopIterateAttr(__e6, () => formats, ($list, $index, __t) {
    var format = $list[$index];
    var __e5;
    __e5 = __html1.clone(true);
    var __binding4 = __t.contentBind(() => format, false);
    __e5.nodes.add(__binding4);
    __t.oneWayBind(() => selectedFormat == format, (e) { if (__e5.selected != e) __e5.selected = e; }, false, false);
  __t.addAll([new autogenerated.Text('\n                  '),
      __e5,
      new autogenerated.Text('\n               ')]);
  });
  __e9 = __root.nodes[5].nodes[3].nodes[5].nodes[1];
  __t.listen(__e9.onChange, ($event) { selectedTp = __e9.value; });
  __t.listen(__e9.onChange, ($event) { onFormatsChange(); });
  __t.oneWayBind(() => selectedTp, (e) { if (__e9.value != e) __e9.value = e; }, false, false);
  __t.loopIterateAttr(__e9, () => tps, ($list, $index, __t) {
    var tp = $list[$index];
    var __e8;
    __e8 = __html2.clone(true);
    var __binding7 = __t.contentBind(() => tp, false);
    __e8.nodes.add(__binding7);
    __t.oneWayBind(() => selectedTp == tp, (e) { if (__e8.selected != e) __e8.selected = e; }, false, false);
  __t.addAll([new autogenerated.Text('\n                  '),
      __e8,
      new autogenerated.Text('\n               ')]);
  });
  __t.create();
  __t.insert();
}

//# sourceMappingURL=map_field.dart.map