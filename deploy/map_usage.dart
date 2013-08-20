import "dart:json" as WB;import "dart:async" as UD;import "dart:mirrors" as VD;import "dart:isolate" as AB;import "dart:collection" as xB;import "dart:html" as q;class WD{static const  XD="Chrome";static const  YD="Firefox";static const  ZD="Internet Explorer";static const  aD="Safari";final  QD;final  minimumVersion;const WD(this.QD,[this.minimumVersion]);}class bD{const bD();}class cD{final  name;const cD(this.name);}class dD{const dD();}class eD{const eD();}const yB='/dry/service-rules-usage';const QC='8888';const zB='Rules / PMT';var AC;var BC;var fB=eB(new List<String>());var RC=eB(new List<String>());var gB=eB(new List<String>());var hB=eB(new List<String>());var XB=eB(new List<String>());var QB='CTCS2X/315';var YB='b2bowner@stg';var ZB='315';var iB='Exception';var nB='*';main(){SC();} RB(){return q.window.location.protocol+'//'+q.window.location.hostname+':${AC}${BC}';} SC(){AC=q.window.location.port=='3030'?QC:q.window.location.port;BC=q.window.location.port=='3030'?yB:'/dry'+yB;TC();} TC(){var g=RB()+'?opt=datasources';var i=q.HttpRequest.getString(g).then((h){RC.addAll(WB.parse(h));UC();});} UC(){var g=RB()+'?opt=formats&ds=${YB}';var i=q.HttpRequest.getString(g).then((h){fB.clear();fB.addAll(WB.parse(h));if(!fB.contains(QB))QB=fB.first;VC();});} VC(){var g=RB()+'?opt=convTypes&ds=${YB}&fmt=${QB}';var i=q.HttpRequest.getString(g).then((h){gB.clear();gB.addAll(WB.parse(h));if(!gB.contains(ZB))ZB=gB.first;WC();});} WC(){var g=RB()+'?opt=segments&ds=${YB}&fmt=${QB}&cvt=${ZB}';var i=q.HttpRequest.getString(g).then((h){hB.clear();hB.addAll(WB.parse(h));if(!hB.contains(iB))iB=hB.first;XC();});} XC(){var g=RB()+'?opt=fields&ds=${YB}&fmt=${QB}&cvt=${ZB}&seg=${iB}';var i=q.HttpRequest.getString(g).then((h){XB.clear();XB.addAll(WB.parse(h));XB.add('*');if(!XB.contains(nB))nB=XB.first;YC();});} YC(){var l=RB()+'?opt=matrix&ds=${YB}&fmt=${QB}&cvt=${ZB}&seg=${iB}&snum=${nB}';var t=q.HttpRequest.getString(l).then((m){var g=WB.parse(m);var j=new aC("matrix",['fancyTable']);var h=new List();h.add(zB);h.addAll(g['tpIds']);j.PD(h);j.OD(h,g['keys'],g['sequences'],g['paths']);var i=q.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();bC(j,i);ZC("#matrix",g['paths'].length);});} ZC( i, g){var h=(g+1)*40>750?750:((g+1)*40)+10;oC((){var j=pC({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});mC.mD(i).lD(j);});}class aC extends CC{var sD;aC( h, g){sD=new q.Element.tag("table");sD.id=h;sD.classes=g;} PD( t,[ l, j]){var i=new q.Element.tag('thead');var g=new q.Element.tr();if(l!=null)g.classes=l;i.nodes.add(g);t.forEach((m){var h=new q.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});sD.nodes.add(i);} OD( PC, TD, mB, j){var l=new q.Element.tag('tbody');TD.forEach((i){var t=new q.Element.tr();l.nodes.add(t);var wB=0;PC.forEach((m){var NB=i+"-"+m;var g=' ';if(m!=zB){if(mB.containsKey(NB))g='<span class="label label-info">'+mB[NB]+'</span>';}else{g='<p><span class="badge">'+j[i]['ruleCase']+'</span> '+j[i]['segNum']+" / "+j[i]['ruleName']+"</p>";}var h=new q.Element.td();if(g.contains("span")){if(wB++ >0)h.attributes={"align":"center"};h.nodes.add(new q.Element.html(g));}else h.text=g;t.nodes.add(h);});});sD.nodes.add(l);} get elements{var g=new List();g.add(sD);return g;}}abstract class CC{var elements;} bC( h,[ g]){if(g==null){g=q.document.body;}g.nodes.addAll(h.elements);}final cC=r"""
(function() {
  // Proxy support for js.dart.

  var globalContext = window;

  // Support for binding the receiver (this) in proxied functions.
  function bindIfFunction(f, _this) {
    if (typeof(f) != "function") {
      return f;
    } else {
      return new BoundFunction(_this, f);
    }
  }

  function unbind(obj) {
    if (obj instanceof BoundFunction) {
      return obj.object;
    } else {
      return obj;
    }
  }

  function getBoundThis(obj) {
    if (obj instanceof BoundFunction) {
      return obj._this;
    } else {
      return globalContext;
    }
  }

  function BoundFunction(_this, object) {
    this._this = _this;
    this.object = object;
  }

  // Table for local objects and functions that are proxied.
  function ProxiedObjectTable() {
    // Name for debugging.
    this.name = 'js-ref';

    // Table from IDs to JS objects.
    this.map = {};

    // Generator for new IDs.
    this._nextId = 0;

    // Counter for deleted proxies.
    this._deletedCount = 0;

    // Flag for one-time initialization.
    this._initialized = false;

    // Ports for managing communication to proxies.
    this.port = new ReceivePortSync();
    this.sendPort = this.port.toSendPort();

    // Set of IDs that are global.
    // These will not be freed on an exitScope().
    this.globalIds = {};

    // Stack of scoped handles.
    this.handleStack = [];

    // Stack of active scopes where each value is represented by the size of
    // the handleStack at the beginning of the scope.  When an active scope
    // is popped, the handleStack is restored to where it was when the
    // scope was entered.
    this.scopeIndices = [];
  }

  // Number of valid IDs.  This is the number of objects (global and local)
  // kept alive by this table.
  ProxiedObjectTable.prototype.count = function () {
    return Object.keys(this.map).length;
  }

  // Number of total IDs ever allocated.
  ProxiedObjectTable.prototype.total = function () {
    return this.count() + this._deletedCount;
  }

  // Adds an object to the table and return an ID for serialization.
  ProxiedObjectTable.prototype.add = function (obj) {
    if (this.scopeIndices.length == 0) {
      throw "Cannot allocate a proxy outside of a scope.";
    }
    // TODO(vsm): Cache refs for each obj?
    var ref = this.name + '-' + this._nextId++;
    this.handleStack.push(ref);
    this.map[ref] = obj;
    return ref;
  }

  ProxiedObjectTable.prototype._initializeOnce = function () {
    if (!this._initialized) {
      this._initialize();
      this._initialized = true;
    }
  }

  // Enters a new scope for this table.
  ProxiedObjectTable.prototype.enterScope = function() {
    this._initializeOnce();
    this.scopeIndices.push(this.handleStack.length);
  }

  // Invalidates all non-global IDs in the current scope and
  // exit the current scope.
  ProxiedObjectTable.prototype.exitScope = function() {
    var start = this.scopeIndices.pop();
    for (var i = start; i < this.handleStack.length; ++i) {
      var key = this.handleStack[i];
      if (!this.globalIds.hasOwnProperty(key)) {
        delete this.map[this.handleStack[i]];
        this._deletedCount++;
      }
    }
    this.handleStack = this.handleStack.splice(0, start);
  }

  // Makes this ID globally scope.  It must be explicitly invalidated.
  ProxiedObjectTable.prototype.globalize = function(id) {
    this.globalIds[id] = true;
  }

  // Invalidates this ID, potentially freeing its corresponding object.
  ProxiedObjectTable.prototype.invalidate = function(id) {
    var old = this.get(id);
    delete this.globalIds[id];
    delete this.map[id];
    this._deletedCount++;
  }

  // Gets the object or function corresponding to this ID.
  ProxiedObjectTable.prototype.get = function (id) {
    if (!this.map.hasOwnProperty(id)) {
      throw 'Proxy ' + id + ' has been invalidated.'
    }
    return this.map[id];
  }

  ProxiedObjectTable.prototype._initialize = function () {
    // Configure this table's port to forward methods, getters, and setters
    // from the remote proxy to the local object.
    var table = this;

    this.port.receive(function (message) {
      // TODO(vsm): Support a mechanism to register a handler here.
      try {
        var object = table.get(message[0]);
        var receiver = unbind(object);
        var member = message[1];
        var kind = message[2];
        var args = message[3].map(deserialize);
        if (kind == 'get') {
          // Getter.
          var field = member;
          if (field in receiver && args.length == 0) {
            var result = bindIfFunction(receiver[field], receiver);
            return [ 'return', serialize(result) ];
          }
        } else if (kind == 'set') {
          // Setter.
          var field = member;
          if (args.length == 1) {
            return [ 'return', serialize(receiver[field] = args[0]) ];
          }
        } else if (kind == 'apply') {
          // Direct function invocation.
          var _this = getBoundThis(object);
          return [ 'return', serialize(receiver.apply(_this, args)) ];
        } else if (member == '[]' && args.length == 1) {
          // Index getter.
          var result = bindIfFunction(receiver[args[0]], receiver);
          return [ 'return', serialize(result) ];
        } else if (member == '[]=' && args.length == 2) {
          // Index setter.
          return [ 'return', serialize(receiver[args[0]] = args[1]) ];
        } else {
          // Member function invocation.
          var f = receiver[member];
          if (f) {
            var result = f.apply(receiver, args);
            return [ 'return', serialize(result) ];
          }
        }
        return [ 'none' ];
      } catch (e) {
        return [ 'throws', e.toString() ];
      }
    });
  }

  // Singleton for local proxied objects.
  var proxiedObjectTable = new ProxiedObjectTable();

  // DOM element serialization code.
  var _localNextElementId = 0;
  var _DART_ID = 'data-dart_id';
  var _DART_TEMPORARY_ATTACHED = 'data-dart_temporary_attached';

  function serializeElement(e) {
    // TODO(vsm): Use an isolate-specific id.
    var id;
    if (e.hasAttribute(_DART_ID)) {
      id = e.getAttribute(_DART_ID);
    } else {
      id = (_localNextElementId++).toString();
      e.setAttribute(_DART_ID, id);
    }
    if (e !== document.documentElement) {
      // Element must be attached to DOM to be retrieve in js part.
      // Attach top unattached parent to avoid detaching parent of "e" when
      // appending "e" directly to document. We keep count of elements
      // temporarily attached to prevent detaching top unattached parent to
      // early. This count is equals to the length of _DART_TEMPORARY_ATTACHED
      // attribute. There could be other elements to serialize having the same
      // top unattached parent.
      var top = e;
      while (true) {
        if (top.hasAttribute(_DART_TEMPORARY_ATTACHED)) {
          var oldValue = top.getAttribute(_DART_TEMPORARY_ATTACHED);
          var newValue = oldValue + "a";
          top.setAttribute(_DART_TEMPORARY_ATTACHED, newValue);
          break;
        }
        if (top.parentNode == null) {
          top.setAttribute(_DART_TEMPORARY_ATTACHED, "a");
          document.documentElement.appendChild(top);
          break;
        }
        if (top.parentNode === document.documentElement) {
          // e was already attached to dom
          break;
        }
        top = top.parentNode;
      }
    }
    return id;
  }

  function deserializeElement(id) {
    // TODO(vsm): Clear the attribute.
    var list = document.querySelectorAll('[' + _DART_ID + '="' + id + '"]');

    if (list.length > 1) throw 'Non unique ID: ' + id;
    if (list.length == 0) {
      throw 'Element must be attached to the document: ' + id;
    }
    var e = list[0];
    if (e !== document.documentElement) {
      // detach temporary attached element
      var top = e;
      while (true) {
        if (top.hasAttribute(_DART_TEMPORARY_ATTACHED)) {
          var oldValue = top.getAttribute(_DART_TEMPORARY_ATTACHED);
          var newValue = oldValue.substring(1);
          top.setAttribute(_DART_TEMPORARY_ATTACHED, newValue);
          // detach top only if no more elements have to be unserialized
          if (top.getAttribute(_DART_TEMPORARY_ATTACHED).length === 0) {
            top.removeAttribute(_DART_TEMPORARY_ATTACHED);
            document.documentElement.removeChild(top);
          }
          break;
        }
        if (top.parentNode === document.documentElement) {
          // e was already attached to dom
          break;
        }
        top = top.parentNode;
      }
    }
    return e;
  }


  // Type for remote proxies to Dart objects.
  function DartProxy(id, sendPort) {
    this.id = id;
    this.port = sendPort;
  }

  // Serializes JS types to SendPortSync format:
  // - primitives -> primitives
  // - sendport -> sendport
  // - DOM element -> [ 'domref', element-id ]
  // - Function -> [ 'funcref', function-id, sendport ]
  // - Object -> [ 'objref', object-id, sendport ]
  function serialize(message) {
    if (message == null) {
      return null;  // Convert undefined to null.
    } else if (typeof(message) == 'string' ||
               typeof(message) == 'number' ||
               typeof(message) == 'boolean') {
      // Primitives are passed directly through.
      return message;
    } else if (message instanceof SendPortSync) {
      // Non-proxied objects are serialized.
      return message;
    } else if (message instanceof Element &&
        (message.ownerDocument == null || message.ownerDocument == document)) {
      return [ 'domref', serializeElement(message) ];
    } else if (message instanceof BoundFunction &&
               typeof(message.object) == 'function') {
      // Local function proxy.
      return [ 'funcref',
               proxiedObjectTable.add(message),
               proxiedObjectTable.sendPort ];
    } else if (typeof(message) == 'function') {
      if ('_dart_id' in message) {
        // Remote function proxy.
        var remoteId = message._dart_id;
        var remoteSendPort = message._dart_port;
        return [ 'funcref', remoteId, remoteSendPort ];
      } else {
        // Local function proxy.
        return [ 'funcref',
                 proxiedObjectTable.add(message),
                 proxiedObjectTable.sendPort ];
      }
    } else if (message instanceof DartProxy) {
      // Remote object proxy.
      return [ 'objref', message.id, message.port ];
    } else {
      // Local object proxy.
      return [ 'objref',
               proxiedObjectTable.add(message),
               proxiedObjectTable.sendPort ];
    }
  }

  function deserialize(message) {
    if (message == null) {
      return null;  // Convert undefined to null.
    } else if (typeof(message) == 'string' ||
               typeof(message) == 'number' ||
               typeof(message) == 'boolean') {
      // Primitives are passed directly through.
      return message;
    } else if (message instanceof SendPortSync) {
      // Serialized type.
      return message;
    }
    var tag = message[0];
    switch (tag) {
      case 'funcref': return deserializeFunction(message);
      case 'objref': return deserializeObject(message);
      case 'domref': return deserializeElement(message[1]);
    }
    throw 'Unsupported serialized data: ' + message;
  }

  // Create a local function that forwards to the remote function.
  function deserializeFunction(message) {
    var id = message[1];
    var port = message[2];
    // TODO(vsm): Add a more robust check for a local SendPortSync.
    if ("receivePort" in port) {
      // Local function.
      return unbind(proxiedObjectTable.get(id));
    } else {
      // Remote function.  Forward to its port.
      var f = function () {
        var depth = enterScope();
        try {
          var args = Array.prototype.slice.apply(arguments);
          args.splice(0, 0, this);
          args = args.map(serialize);
          var result = port.callSync([id, '#call', args]);
          if (result[0] == 'throws') throw deserialize(result[1]);
          return deserialize(result[1]);
        } finally {
          exitScope(depth);
        }
      };
      // Cache the remote id and port.
      f._dart_id = id;
      f._dart_port = port;
      return f;
    }
  }

  // Creates a DartProxy to forwards to the remote object.
  function deserializeObject(message) {
    var id = message[1];
    var port = message[2];
    // TODO(vsm): Add a more robust check for a local SendPortSync.
    if ("receivePort" in port) {
      // Local object.
      return proxiedObjectTable.get(id);
    } else {
      // Remote object.
      return new DartProxy(id, port);
    }
  }

  // Remote handler to construct a new JavaScript object given its
  // serialized constructor and arguments.
  function construct(args) {
    args = args.map(deserialize);
    var constructor = unbind(args[0]);
    args = Array.prototype.slice.call(args, 1);

    // Until 10 args, the 'new' operator is used. With more arguments we use a
    // generic way that may not work, particulary when the constructor does not
    // have an "apply" method.
    var ret = null;
    if (args.length === 0) {
      ret = new constructor();
    } else if (args.length === 1) {
      ret = new constructor(args[0]);
    } else if (args.length === 2) {
      ret = new constructor(args[0], args[1]);
    } else if (args.length === 3) {
      ret = new constructor(args[0], args[1], args[2]);
    } else if (args.length === 4) {
      ret = new constructor(args[0], args[1], args[2], args[3]);
    } else if (args.length === 5) {
      ret = new constructor(args[0], args[1], args[2], args[3], args[4]);
    } else if (args.length === 6) {
      ret = new constructor(args[0], args[1], args[2], args[3], args[4],
                            args[5]);
    } else if (args.length === 7) {
      ret = new constructor(args[0], args[1], args[2], args[3], args[4],
                            args[5], args[6]);
    } else if (args.length === 8) {
      ret = new constructor(args[0], args[1], args[2], args[3], args[4],
                            args[5], args[6], args[7]);
    } else if (args.length === 9) {
      ret = new constructor(args[0], args[1], args[2], args[3], args[4],
                            args[5], args[6], args[7], args[8]);
    } else if (args.length === 10) {
      ret = new constructor(args[0], args[1], args[2], args[3], args[4],
                            args[5], args[6], args[7], args[8], args[9]);
    } else {
      // Dummy Type with correct constructor.
      var Type = function(){};
      Type.prototype = constructor.prototype;
  
      // Create a new instance
      var instance = new Type();
  
      // Call the original constructor.
      ret = constructor.apply(instance, args);
      ret = Object(ret) === ret ? ret : instance;
    }
    return serialize(ret);
  }

  // Remote handler to return the top-level JavaScript context.
  function context(data) {
    return serialize(globalContext);
  }

  // Remote handler to track number of live / allocated proxies.
  function proxyCount() {
    var live = proxiedObjectTable.count();
    var total = proxiedObjectTable.total();
    return [live, total];
  }

  // Return true if two JavaScript proxies are equal (==).
  function proxyEquals(args) {
    return deserialize(args[0]) == deserialize(args[1]);
  }

  // Return true if a JavaScript proxy is instance of a given type (instanceof).
  function proxyInstanceof(args) {
    var obj = unbind(deserialize(args[0]));
    var type = unbind(deserialize(args[1]));
    return obj instanceof type;
  }

  // Return true if a JavaScript proxy has a given property.
  function proxyHasProperty(args) {
    var obj = unbind(deserialize(args[0]));
    var member = unbind(deserialize(args[1]));
    return member in obj;
  }

  // Delete a given property of object.
  function proxyDeleteProperty(args) {
    var obj = unbind(deserialize(args[0]));
    var member = unbind(deserialize(args[1]));
    delete obj[member];
  }

  function proxyConvert(args) {
    return serialize(deserializeDataTree(args));
  }

  function deserializeDataTree(data) {
    var type = data[0];
    var value = data[1];
    if (type === 'map') {
      var obj = {};
      for (var i = 0; i < value.length; i++) {
        obj[value[i][0]] = deserializeDataTree(value[i][1]);
      }
      return obj;
    } else if (type === 'list') {
      var list = [];
      for (var i = 0; i < value.length; i++) {
        list.push(deserializeDataTree(value[i]));
      }
      return list;
    } else /* 'simple' */ {
      return deserialize(value);
    }
  }

  function makeGlobalPort(name, f) {
    var port = new ReceivePortSync();
    port.receive(f);
    window.registerPort(name, port.toSendPort());
  }

  // Enters a new scope in the JavaScript context.
  function enterJavaScriptScope() {
    proxiedObjectTable.enterScope();
  }

  // Enters a new scope in both the JavaScript and Dart context.
  var _dartEnterScopePort = null;
  function enterScope() {
    enterJavaScriptScope();
    if (!_dartEnterScopePort) {
      _dartEnterScopePort = window.lookupPort('js-dart-interop-enter-scope');
    }
    return _dartEnterScopePort.callSync([]);
  }

  // Exits the current scope (and invalidate local IDs) in the JavaScript
  // context.
  function exitJavaScriptScope() {
    proxiedObjectTable.exitScope();
  }

  // Exits the current scope in both the JavaScript and Dart context.
  var _dartExitScopePort = null;
  function exitScope(depth) {
    exitJavaScriptScope();
    if (!_dartExitScopePort) {
      _dartExitScopePort = window.lookupPort('js-dart-interop-exit-scope');
    }
    return _dartExitScopePort.callSync([ depth ]);
  }

  makeGlobalPort('dart-js-interop-context', context);
  makeGlobalPort('dart-js-interop-create', construct);
  makeGlobalPort('dart-js-interop-proxy-count', proxyCount);
  makeGlobalPort('dart-js-interop-equals', proxyEquals);
  makeGlobalPort('dart-js-interop-instanceof', proxyInstanceof);
  makeGlobalPort('dart-js-interop-has-property', proxyHasProperty);
  makeGlobalPort('dart-js-interop-delete-property', proxyDeleteProperty);
  makeGlobalPort('dart-js-interop-convert', proxyConvert);
  makeGlobalPort('dart-js-interop-enter-scope', enterJavaScriptScope);
  makeGlobalPort('dart-js-interop-exit-scope', exitJavaScriptScope);
  makeGlobalPort('dart-js-interop-globalize', function(data) {
    if (data[0] == "objref" || data[0] == "funcref") return proxiedObjectTable.globalize(data[1]);
    throw 'Illegal type: ' + data[0];
  });
  makeGlobalPort('dart-js-interop-invalidate', function(data) {
    if (data[0] == "objref" || data[0] == "funcref") return proxiedObjectTable.invalidate(data[1]);
    throw 'Illegal type: ' + data[0];
  });
})();
"""; dC(h){final g=new q.ScriptElement();g.type='text/javascript';g.innerHtml=h;q.document.body.nodes.add(g);}var aB=null;var eC=null;var fC=null;var DC=null;var gC=null;var hC=null;var iC=null;var EC=null;var FC=null;var GC=null;var jC=null;var kC=null;var HC=null;var IC=null; lC(){if(aB!=null)return;try {aB=q.window.lookupPort('dart-js-interop-context');}catch (h){}if(aB==null){dC(cC);aB=q.window.lookupPort('dart-js-interop-context');}eC=q.window.lookupPort('dart-js-interop-create');fC=q.window.lookupPort('dart-js-interop-proxy-count');DC=q.window.lookupPort('dart-js-interop-equals');gC=q.window.lookupPort('dart-js-interop-instanceof');hC=q.window.lookupPort('dart-js-interop-has-property');iC=q.window.lookupPort('dart-js-interop-delete-property');EC=q.window.lookupPort('dart-js-interop-convert');FC=q.window.lookupPort('dart-js-interop-enter-scope');GC=q.window.lookupPort('dart-js-interop-exit-scope');jC=q.window.lookupPort('dart-js-interop-globalize');kC=q.window.lookupPort('dart-js-interop-invalidate');HC=new q.ReceivePortSync()..receive((tD)=>oB());IC=new q.ReceivePortSync()..receive((g)=>pB(g[0]));q.window.registerPort('js-dart-interop-enter-scope',HC.toSendPort());q.window.registerPort('js-dart-interop-exit-scope',IC.toSendPort());} get mC{jB();return cB(aB.callSync([] ));}get nC=>GB.uD.length; jB(){if(nC==0){var g=oB();UD.runAsync(()=>pB(g));}}oC(g){var h=oB();try {return g();}finally {pB(h);}} oB(){lC();GB.RD();FC.callSync([] );return GB.uD.length;} pB( g){assert(GB.uD.length==g);GC.callSync([] );GB.SD();} pC( g)=>new HB.nD(g);class fD{const fD();}const OB=const fD(); qC(i,m,l,j,NB,t){final g=[i,m,l,j,NB,t];final h=g.indexOf(OB);if(h<0)return g;return g.sublist(0,h);}class HB implements rB<HB>{var vD;final wD;factory HB.nD(g){jB();return rC(g);}static rC(g){return cB(EC.callSync(qB(g)));}static qB(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,qB(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(qB).toList()];}else{return ['simple',SB(g)];}}HB.oD(this.vD,this.wD); OC()=>this;operator[](g)=>bB(this,'[]','method',[g]);operator[]=(h,g)=>bB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is HB&&DC.callSync([SB(this),SB(g)])); toString(){try {return bB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=VD.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return bB(this,g,h,j);}static bB( g, i, l, j){jB();var h=g.vD.callSync([g.wD,i,l,j.map(SB).toList()]);switch (h[0]){case 'return':return cB(h[1]);case 'throws':throw cB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class JC extends HB implements rB<JC>{JC.oD( h,g):super.oD(h,g);call([g=OB,j=OB,i=OB,h=OB,t=OB,l=OB]){var m=qC(g,j,i,h,t,l);return HB.bB(this,'','apply',m);}}abstract class rB<sC>{ OC();}class tC{final  xD;var yD;var zD;final  AE;final  vD;final  BE;final  CE;final  uD;RD(){uD.add(CE.length);}SD(){var h=uD.removeLast();for(int g=h;g<CE.length; ++g){var i=CE[g];if(!BE.contains(i)){AE.remove(CE[g]);zD++ ;}}if(h!=CE.length){CE.removeRange(h,CE.length-h);}}tC():xD='dart-ref',yD=0,zD=0,AE={},vD=new q.ReceivePortSync(),CE=new List<String>(),uD=new List<int>(),BE=new Set<String>(){vD.receive((g){try {final h=AE[g[0]];final l=g[1];final j=g[2].map(cB).toList();if(l=='#call'){final m=h as Function;var t=SB(m(j));return ['return',t];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){jB();final g='${xD}-${yD++ }';AE[g]=h;CE.add(g);return g;}Object get( g){return AE[g];}get vB=>vD.toSendPort();}var GB=new tC();SB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}else if(g is q.Element&&(g.document==null||g.document==q.document)){return ['domref',vC(g)];}else if(g is JC){return ['funcref',g.wD,g.vD];}else if(g is HB){return ['objref',g.wD,g.vD];}else if(g is rB){return SB(g.OC());}else{return ['objref',GB.add(g),GB.vB];}}cB(var g){m(g){var h=g[1];var i=g[2];if(i==GB.vB){return GB.get(h);}else{return new JC.oD(i,h);}}l(g){var h=g[1];var i=g[2];if(i==GB.vB){return GB.get(h);}else{return new HB.oD(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return l(g);case 'domref':return wC(g[1]);}throw 'Unsupported serialized data: ${g}';}var uC=0;const kB='data-dart_id';const IB='data-dart_temporary_attached';vC( h){var i;if(h.attributes.containsKey(kB)){i=h.attributes[kB];}else{i='dart-${uC++ }';h.attributes[kB]=i;}if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(IB)){final j=g.attributes[IB];final l=j+'a';g.attributes[IB]=l;break;}if(g.parent==null){g.attributes[IB]='a';q.document.documentElement.children.add(g);break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return i;} wC(var i){var j=q.queryAll('[${kB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(IB)){final l=g.attributes[IB];final m=l.substring(1);g.attributes[IB]=m;if(g.attributes[IB].length==0){g.attributes.remove(IB);g.remove();}break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return h;}class xC<LB> extends ND with JB implements List<LB>{final  DE;xC([ g]):DE=g!=null?new List<LB>(g):<LB>[] ;factory xC.pD( g)=>new xC<LB>()..addAll(g); get length{if(u)DB(this,k.v,'length');return DE.length;}set length( h){var i=DE.length;if(i==h)return;if(KB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){o(this,k.MB,g,DE[g],null);}o(this,k.v,'length',i,h);}else{o(this,k.v,'length',i,h);for(int g=i;g<h;g++ ){o(this,k.UB,g,null,null);}}}DE.length=h;} operator[]( g){if(u)DB(this,k.EB,g);return DE[g];}operator[]=( g, h){var i=DE[g];if(KB(this)){o(this,k.EB,g,i,h);}DE[g]=h;} sublist( h,[ g])=>new xC<LB>.pD(super.sublist(h,g)); add( h){var g=DE.length;if(KB(this)){o(this,k.v,'length',g,g+1);o(this,k.UB,g,null,h);}DE.add(h);} removeRange( h, g){if(g==0)return;NC.LD(this,h,g);if(KB(this)){for(int i=h;i<g;i++ ){o(this,k.MB,i,this[i],null);}}NC.KD(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(u){for(int g=0;g<length;g++ ){DB(this,k.EB,g);}}return DE.toString();}}typedef  dB<BB,CB>();class TB<BB,CB> extends JB implements Map<BB,CB>{final  EE;var FE;var GE;TB({ createMap}):EE=createMap!=null?createMap():new Map<BB,CB>(){FE=new yC<BB,CB>(this);GE=new zC<BB,CB>(this);}factory TB.qD( i,{ createMap}){var g=new TB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>FE; get values=>GE; get length{if(u)DB(this,k.v,'length');return EE.length;} get isEmpty=>length==0; HE( g)=>DB(this,k.EB,g); IE(){DB(this,k.v,'length');EE.keys.forEach(HE);} containsKey( g){if(u)HE(g);return EE.containsKey(g);} operator[]( g){if(u)HE(g);return EE[g];} operator[]=( h, g){var j=EE.length;var i=EE[h];EE[h]=g;if(KB(this)){if(j!=EE.length){o(this,k.v,'length',j,EE.length);o(this,k.UB,h,i,g);}else if(i!=g){o(this,k.EB,h,i,g);}}} remove( g){if(u)HE(g);var h=EE.length;var i=EE.remove(g);if(KB(this)&&h!=EE.length){o(this,k.MB,g,i,null);o(this,k.v,'length',h,EE.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=EE.length;if(KB(this)&&g>0){EE.forEach((i,h){o(this,k.MB,i,h,null);});o(this,k.v,'length',g,0);}EE.clear();} forEach( g( key, value)){if(u)IE();EE.forEach(g);} toString()=>xB.Maps.mapToString(this);}class yC<BB,CB> extends xB.IterableBase<BB>{final  EE;yC(this.EE); get iterator=>new gD<BB,CB>(EE);}class gD<BB,CB> implements Iterator<BB>{final  EE;final  FE;var JE=false;gD( g):EE=g,FE=g.EE.keys.iterator; moveNext(){if(u)DB(EE,k.v,'length');return JE=FE.moveNext();} get current{var g=FE.current;if(u&&JE)EE.HE(g);return g;}}class zC<BB,CB> extends xB.IterableBase<CB>{final  EE;zC(this.EE); get iterator=>new hD<BB,CB>(EE);}class hD<BB,CB> implements Iterator<CB>{final  EE;final  FE;final  GE;var JE;hD( g):EE=g,FE=g.EE.keys.iterator,GE=g.EE.values.iterator; moveNext(){if(u)DB(EE,k.v,'length');var h=FE.moveNext();var g=GE.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return JE=g;} get current{if(u&&JE)EE.HE(FE.current);return GE.current;}}const iD=const jD();class k{static const v=1;static const EB=2;static const UB=EB|4;static const MB=EB|8;final  type;final key;final oldValue;final newValue;k(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is k&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>ID(type,key,oldValue,newValue); toString(){var g;switch (type){case v:g='field';break;case EB:g='index';break;case UB:g='insert';break;case MB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}}eB(g){if(g is Map){var h=null;if(g is xB.SplayTreeMap){h=()=>new xB.SplayTreeMap();}else if(g is xB.LinkedHashMap){h=()=>new xB.LinkedHashMap();}return new TB.qD(g,createMap:h);}if(g is Set)return new MC.rD(g);if(g is Iterable)return new xC.pD(g);return g;}class JB{var uB;var VB;final  hashCode= ++JB.AD;static var AD=0;} KB( g)=>g.uB!=null&&g.uB.head!=null; get u=>KC!=null; DB( g, h,i)=>KC.KE(g,h,i); o( g, j,l, h, i){if((j&(k.UB|k.MB))==0){if(h==i)return;}if(PB==null){PB=[] ;JD(BD);}if(g.VB==null){g.VB=[] ;PB.add(g);}g.VB.add(new k(j,l,h,i));}var KC;var LC=100;var PB;var lB; BD(){var m=0;while (PB!=null||lB!=null){var j=PB;PB=null;var i=lB;lB=null;if(m++ ==LC){CD(j,i);return;}if(j!=null){for(var h in j){var NB=h.VB;h.VB=null;for(var g=h.uB.head;g!=null;g=g.next){var l=g.value;try {l(NB);}catch (mB,t){GD(mB,t,l,'from ${h}');}}}}if(i!=null){i.forEach((PC,wB){wB.LE();});}}} CD( l, j){var g=[] ;if(l!=null){for(var i in l){var NB=i.VB;g.add('${i} ${NB}');}}if(j!=null){for(var m in j.values){var h=m.LE();if(h!=null)g.add('${m} ${h}');}}PB=null;lB=null;var t='exceeded notifiction limit of ${LC}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';ED(t);}class sB{}typedef  DD( message);var ED=(g)=>print(g);typedef  FD(error,stackTrace,obj, message);var GD=HD; HD(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class jD{const jD();}class MC<FB> extends MD with JB implements Set<FB>{final  ME;final  NE;MC({ createMap}):ME=createMap!=null?createMap():new Map<FB,Object>(),NE=createMap;factory MC.rD( g,{ createMap}){return new MC<FB>(createMap:createMap)..addAll(g);} contains( g){if(u)DB(this,k.EB,g);return ME.containsKey(g);} add( g){var h=ME.length;ME[g]=const Object();if(h!=ME.length){o(this,k.v,'length',h,ME.length);o(this,k.UB,g,null,g);}} remove( g){if(u)DB(this,k.EB,g);var h=ME.length;ME.remove(g);if(h!=ME.length){if(KB(this)){o(this,k.MB,g,g,null);o(this,k.v,'length',h,ME.length);}return true;}return false;} clear(){if(KB(this)){for(var g in ME.keys){o(this,k.MB,g,g,null);}o(this,k.v,'length',ME.length,0);}ME.clear();} get length{if(u)DB(this,k.v,'length');return ME.length;} get isEmpty=>length==0; get iterator=>new kD<FB>(this); addAll( g)=>g.forEach(add); toString(){if(u){for(FB g in ME.keys){DB(this,k.EB,g);}}return ME.keys.toSet().toString();}}class kD<FB> implements Iterator<FB>{final  OE;final  PE;var QE=false;kD( g):OE=g,PE=g.ME.keys.iterator; moveNext(){OE.length;return QE=PE.moveNext();} get current{var g=PE.current;if(u&&QE)DB(OE,k.EB,g);return g;}}tB(h,g)=>h.hashCode*31+g.hashCode;ID(g,i,h,j)=>tB(tB(g,i),tB(h,j)); JD( h()){var g=new AB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class NC{static  KD( m, g, t, i, l){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+l-1,j=i+l-1;h>=g;h-- ,j-- ){t[j]=m[h];}}else{for(int h=g,j=i;h<g+l;h++ ,j++ ){t[j]=m[h];}}}static  LD( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class MD extends xB.IterableBase<dynamic>{}abstract class ND extends xB.ListMixin<dynamic>{}