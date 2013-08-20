import "dart:html" as q;import "dart:isolate" as AB;import "dart:json" as VB;import "dart:async" as WD;import "dart:collection" as zB;import "dart:mirrors" as XD;class YD{static const  ZD="Chrome";static const  aD="Firefox";static const  bD="Internet Explorer";static const  cD="Safari";final  SD;final  minimumVersion;const YD(this.SD,[this.minimumVersion]);}class dD{const dD();}class eD{final  name;const eD(this.name);}class fD{const fD();}class gD{const gD();}const AC='/dry/service-rules-usage';const SC='8888';const BC='Rules / PMT';var CC;var DC;var fB=eB(new List<String>());var TC=eB(new List<String>());var gB=eB(new List<String>());var hB=eB(new List<String>());var WB=eB(new List<String>());final nB=new KB();var oB='CTCS2X/315'; get XB{if(u){BB(nB,k.t,'selectedFormat');}return oB;}set XB( g){if(HB(nB)){o(nB,k.t,'selectedFormat',oB,g);}oB=g;}var YB='b2bowner@stg';var ZB='315';var iB='Exception';var pB='*';main(){UC();} QB(){return q.window.location.protocol+'//'+q.window.location.hostname+':${CC}${DC}';} UC(){CC=q.window.location.port=='3030'?SC:q.window.location.port;DC=q.window.location.port=='3030'?AC:'/dry'+AC;VC();} VC(){var g=QB()+'?opt=datasources';var i=q.HttpRequest.getString(g).then((h){TC.addAll(VB.parse(h));WC();});} WC(){var g=QB()+'?opt=formats&ds=${YB}';var i=q.HttpRequest.getString(g).then((h){fB.clear();fB.addAll(VB.parse(h));if(!fB.contains(XB))XB=fB.first;XC();});} XC(){var g=QB()+'?opt=convTypes&ds=${YB}&fmt=${XB}';var i=q.HttpRequest.getString(g).then((h){gB.clear();gB.addAll(VB.parse(h));if(!gB.contains(ZB))ZB=gB.first;YC();});} YC(){var g=QB()+'?opt=segments&ds=${YB}&fmt=${XB}&cvt=${ZB}';var i=q.HttpRequest.getString(g).then((h){hB.clear();hB.addAll(VB.parse(h));if(!hB.contains(iB))iB=hB.first;ZC();});} ZC(){var g=QB()+'?opt=fields&ds=${YB}&fmt=${XB}&cvt=${ZB}&seg=${iB}';var i=q.HttpRequest.getString(g).then((h){WB.clear();WB.addAll(VB.parse(h));WB.add('*');if(!WB.contains(pB))pB=WB.first;aC();});} aC(){var l=QB()+'?opt=matrix&ds=${YB}&fmt=${XB}&cvt=${ZB}&seg=${iB}&snum=${pB}';var v=q.HttpRequest.getString(l).then((m){var g=VB.parse(m);var j=new cC("matrix",['fancyTable']);var h=new List();h.add(BC);h.addAll(g['tpIds']);j.RD(h);j.QD(h,g['keys'],g['sequences'],g['paths']);var i=q.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();dC(j,i);bC("#matrix",g['paths'].length);});} bC( i, g){var h=(g+1)*40>750?750:((g+1)*40)+10;qC((){var j=rC({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});oC.mD(i).lD(j);});}class cC extends EC{var tD;cC( h, g){tD=new q.Element.tag("table");tD.id=h;tD.classes=g;} RD( v,[ l, j]){var i=new q.Element.tag('thead');var g=new q.Element.tr();if(l!=null)g.classes=l;i.nodes.add(g);v.forEach((m){var h=new q.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});tD.nodes.add(i);} QD( RC, VD, mB, j){var l=new q.Element.tag('tbody');VD.forEach((i){var v=new q.Element.tr();l.nodes.add(v);var yB=0;RC.forEach((m){var NB=i+"-"+m;var g=' ';if(m!=BC){if(mB.containsKey(NB))g='<span class="label label-info">'+mB[NB]+'</span>';}else{g='<p><span class="badge">'+j[i]['ruleCase']+'</span> '+j[i]['segNum']+" / "+j[i]['ruleName']+"</p>";}var h=new q.Element.td();if(g.contains("span")){if(yB++ >0)h.attributes={"align":"center"};h.nodes.add(new q.Element.html(g));}else h.text=g;v.nodes.add(h);});});tD.nodes.add(l);} get elements{var g=new List();g.add(tD);return g;}}abstract class EC{var elements;} dC( h,[ g]){if(g==null){g=q.document.body;}g.nodes.addAll(h.elements);}final eC=r"""
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
"""; fC(h){final g=new q.ScriptElement();g.type='text/javascript';g.innerHtml=h;q.document.body.nodes.add(g);}var aB=null;var gC=null;var hC=null;var FC=null;var iC=null;var jC=null;var kC=null;var GC=null;var HC=null;var IC=null;var lC=null;var mC=null;var JC=null;var KC=null; nC(){if(aB!=null)return;try {aB=q.window.lookupPort('dart-js-interop-context');}catch (h){}if(aB==null){fC(eC);aB=q.window.lookupPort('dart-js-interop-context');}gC=q.window.lookupPort('dart-js-interop-create');hC=q.window.lookupPort('dart-js-interop-proxy-count');FC=q.window.lookupPort('dart-js-interop-equals');iC=q.window.lookupPort('dart-js-interop-instanceof');jC=q.window.lookupPort('dart-js-interop-has-property');kC=q.window.lookupPort('dart-js-interop-delete-property');GC=q.window.lookupPort('dart-js-interop-convert');HC=q.window.lookupPort('dart-js-interop-enter-scope');IC=q.window.lookupPort('dart-js-interop-exit-scope');lC=q.window.lookupPort('dart-js-interop-globalize');mC=q.window.lookupPort('dart-js-interop-invalidate');JC=new q.ReceivePortSync()..receive((uD)=>qB());KC=new q.ReceivePortSync()..receive((g)=>rB(g[0]));q.window.registerPort('js-dart-interop-enter-scope',JC.toSendPort());q.window.registerPort('js-dart-interop-exit-scope',KC.toSendPort());} get oC{jB();return cB(aB.callSync([] ));}get pC=>GB.vD.length; jB(){if(pC==0){var g=qB();WD.runAsync(()=>rB(g));}}qC(g){var h=qB();try {return g();}finally {rB(h);}} qB(){nC();GB.TD();HC.callSync([] );return GB.vD.length;} rB( g){assert(GB.vD.length==g);IC.callSync([] );GB.UD();} rC( g)=>new IB.nD(g);class hD{const hD();}const OB=const hD(); sC(i,m,l,j,NB,v){final g=[i,m,l,j,NB,v];final h=g.indexOf(OB);if(h<0)return g;return g.sublist(0,h);}class IB implements tB<IB>{var wD;final xD;factory IB.nD(g){jB();return tC(g);}static tC(g){return cB(GC.callSync(sB(g)));}static sB(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,sB(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(sB).toList()];}else{return ['simple',RB(g)];}}IB.oD(this.wD,this.xD); QC()=>this;operator[](g)=>bB(this,'[]','method',[g]);operator[]=(h,g)=>bB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is IB&&FC.callSync([RB(this),RB(g)])); toString(){try {return bB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=XD.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return bB(this,g,h,j);}static bB( g, i, l, j){jB();var h=g.wD.callSync([g.xD,i,l,j.map(RB).toList()]);switch (h[0]){case 'return':return cB(h[1]);case 'throws':throw cB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class LC extends IB implements tB<LC>{LC.oD( h,g):super.oD(h,g);call([g=OB,j=OB,i=OB,h=OB,v=OB,l=OB]){var m=sC(g,j,i,h,v,l);return IB.bB(this,'','apply',m);}}abstract class tB<uC>{ QC();}class vC{final  yD;var zD;var AE;final  BE;final  wD;final  CE;final  DE;final  vD;TD(){vD.add(DE.length);}UD(){var h=vD.removeLast();for(int g=h;g<DE.length; ++g){var i=DE[g];if(!CE.contains(i)){BE.remove(DE[g]);AE++ ;}}if(h!=DE.length){DE.removeRange(h,DE.length-h);}}vC():yD='dart-ref',zD=0,AE=0,BE={},wD=new q.ReceivePortSync(),DE=new List<String>(),vD=new List<int>(),CE=new Set<String>(){wD.receive((g){try {final h=BE[g[0]];final l=g[1];final j=g[2].map(cB).toList();if(l=='#call'){final m=h as Function;var v=RB(m(j));return ['return',v];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){jB();final g='${yD}-${zD++ }';BE[g]=h;DE.add(g);return g;}Object get( g){return BE[g];}get xB=>wD.toSendPort();}var GB=new vC();RB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}else if(g is q.Element&&(g.document==null||g.document==q.document)){return ['domref',xC(g)];}else if(g is LC){return ['funcref',g.xD,g.wD];}else if(g is IB){return ['objref',g.xD,g.wD];}else if(g is tB){return RB(g.QC());}else{return ['objref',GB.add(g),GB.xB];}}cB(var g){m(g){var h=g[1];var i=g[2];if(i==GB.xB){return GB.get(h);}else{return new LC.oD(i,h);}}l(g){var h=g[1];var i=g[2];if(i==GB.xB){return GB.get(h);}else{return new IB.oD(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return l(g);case 'domref':return yC(g[1]);}throw 'Unsupported serialized data: ${g}';}var wC=0;const kB='data-dart_id';const JB='data-dart_temporary_attached';xC( h){var i;if(h.attributes.containsKey(kB)){i=h.attributes[kB];}else{i='dart-${wC++ }';h.attributes[kB]=i;}if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(JB)){final j=g.attributes[JB];final l=j+'a';g.attributes[JB]=l;break;}if(g.parent==null){g.attributes[JB]='a';q.document.documentElement.children.add(g);break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return i;} yC(var i){var j=q.queryAll('[${kB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(JB)){final l=g.attributes[JB];final m=l.substring(1);g.attributes[JB]=m;if(g.attributes[JB].length==0){g.attributes.remove(JB);g.remove();}break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return h;}class zC<LB> extends PD with KB implements List<LB>{final  EE;zC([ g]):EE=g!=null?new List<LB>(g):<LB>[] ;factory zC.pD( g)=>new zC<LB>()..addAll(g); get length{if(u)BB(this,k.t,'length');return EE.length;}set length( h){var i=EE.length;if(i==h)return;if(HB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){o(this,k.MB,g,EE[g],null);}o(this,k.t,'length',i,h);}else{o(this,k.t,'length',i,h);for(int g=i;g<h;g++ ){o(this,k.TB,g,null,null);}}}EE.length=h;} operator[]( g){if(u)BB(this,k.EB,g);return EE[g];}operator[]=( g, h){var i=EE[g];if(HB(this)){o(this,k.EB,g,i,h);}EE[g]=h;} sublist( h,[ g])=>new zC<LB>.pD(super.sublist(h,g)); add( h){var g=EE.length;if(HB(this)){o(this,k.t,'length',g,g+1);o(this,k.TB,g,null,h);}EE.add(h);} removeRange( h, g){if(g==0)return;PC.ND(this,h,g);if(HB(this)){for(int i=h;i<g;i++ ){o(this,k.MB,i,this[i],null);}}PC.MD(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(u){for(int g=0;g<length;g++ ){BB(this,k.EB,g);}}return EE.toString();}}typedef  dB<CB,DB>();class SB<CB,DB> extends KB implements Map<CB,DB>{final  FE;var GE;var HE;SB({ createMap}):FE=createMap!=null?createMap():new Map<CB,DB>(){GE=new AD<CB,DB>(this);HE=new BD<CB,DB>(this);}factory SB.qD( i,{ createMap}){var g=new SB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>GE; get values=>HE; get length{if(u)BB(this,k.t,'length');return FE.length;} get isEmpty=>length==0; IE( g)=>BB(this,k.EB,g); JE(){BB(this,k.t,'length');FE.keys.forEach(IE);} containsKey( g){if(u)IE(g);return FE.containsKey(g);} operator[]( g){if(u)IE(g);return FE[g];} operator[]=( h, g){var j=FE.length;var i=FE[h];FE[h]=g;if(HB(this)){if(j!=FE.length){o(this,k.t,'length',j,FE.length);o(this,k.TB,h,i,g);}else if(i!=g){o(this,k.EB,h,i,g);}}} remove( g){if(u)IE(g);var h=FE.length;var i=FE.remove(g);if(HB(this)&&h!=FE.length){o(this,k.MB,g,i,null);o(this,k.t,'length',h,FE.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=FE.length;if(HB(this)&&g>0){FE.forEach((i,h){o(this,k.MB,i,h,null);});o(this,k.t,'length',g,0);}FE.clear();} forEach( g( key, value)){if(u)JE();FE.forEach(g);} toString()=>zB.Maps.mapToString(this);}class AD<CB,DB> extends zB.IterableBase<CB>{final  FE;AD(this.FE); get iterator=>new iD<CB,DB>(FE);}class iD<CB,DB> implements Iterator<CB>{final  FE;final  GE;var KE=false;iD( g):FE=g,GE=g.FE.keys.iterator; moveNext(){if(u)BB(FE,k.t,'length');return KE=GE.moveNext();} get current{var g=GE.current;if(u&&KE)FE.IE(g);return g;}}class BD<CB,DB> extends zB.IterableBase<DB>{final  FE;BD(this.FE); get iterator=>new jD<CB,DB>(FE);}class jD<CB,DB> implements Iterator<DB>{final  FE;final  GE;final  HE;var KE;jD( g):FE=g,GE=g.FE.keys.iterator,HE=g.FE.values.iterator; moveNext(){if(u)BB(FE,k.t,'length');var h=GE.moveNext();var g=HE.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return KE=g;} get current{if(u&&KE)FE.IE(GE.current);return HE.current;}}class k{static const t=1;static const EB=2;static const TB=EB|4;static const MB=EB|8;final  type;final key;final oldValue;final newValue;k(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is k&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>KD(type,key,oldValue,newValue); toString(){var g;switch (type){case t:g='field';break;case EB:g='index';break;case TB:g='insert';break;case MB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}}eB(g){if(g is Map){var h=null;if(g is zB.SplayTreeMap){h=()=>new zB.SplayTreeMap();}else if(g is zB.LinkedHashMap){h=()=>new zB.LinkedHashMap();}return new SB.qD(g,createMap:h);}if(g is Set)return new OC.rD(g);if(g is Iterable)return new zC.pD(g);return g;}class KB{var wB;var UB;final  hashCode= ++KB.CD;static var CD=0;} HB( g)=>g.wB!=null&&g.wB.head!=null; get u=>MC!=null; BB( g, h,i)=>MC.LE(g,h,i); o( g, j,l, h, i){if((j&(k.TB|k.MB))==0){if(h==i)return;}if(PB==null){PB=[] ;LD(DD);}if(g.UB==null){g.UB=[] ;PB.add(g);}g.UB.add(new k(j,l,h,i));}var MC;var NC=100;var PB;var lB; DD(){var m=0;while (PB!=null||lB!=null){var j=PB;PB=null;var i=lB;lB=null;if(m++ ==NC){ED(j,i);return;}if(j!=null){for(var h in j){var NB=h.UB;h.UB=null;for(var g=h.wB.head;g!=null;g=g.next){var l=g.value;try {l(NB);}catch (mB,v){ID(mB,v,l,'from ${h}');}}}}if(i!=null){i.forEach((RC,yB){yB.ME();});}}} ED( l, j){var g=[] ;if(l!=null){for(var i in l){var NB=i.UB;g.add('${i} ${NB}');}}if(j!=null){for(var m in j.values){var h=m.ME();if(h!=null)g.add('${m} ${h}');}}PB=null;lB=null;var v='exceeded notifiction limit of ${NC}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';GD(v);}class uB{}typedef  FD( message);var GD=(g)=>print(g);typedef  HD(error,stackTrace,obj, message);var ID=JD; JD(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class OC<FB> extends OD with KB implements Set<FB>{final  NE;final  OE;OC({ createMap}):NE=createMap!=null?createMap():new Map<FB,Object>(),OE=createMap;factory OC.rD( g,{ createMap}){return new OC<FB>(createMap:createMap)..addAll(g);} contains( g){if(u)BB(this,k.EB,g);return NE.containsKey(g);} add( g){var h=NE.length;NE[g]=const Object();if(h!=NE.length){o(this,k.t,'length',h,NE.length);o(this,k.TB,g,null,g);}} remove( g){if(u)BB(this,k.EB,g);var h=NE.length;NE.remove(g);if(h!=NE.length){if(HB(this)){o(this,k.MB,g,g,null);o(this,k.t,'length',h,NE.length);}return true;}return false;} clear(){if(HB(this)){for(var g in NE.keys){o(this,k.MB,g,g,null);}o(this,k.t,'length',NE.length,0);}NE.clear();} get length{if(u)BB(this,k.t,'length');return NE.length;} get isEmpty=>length==0; get iterator=>new kD<FB>(this); addAll( g)=>g.forEach(add); toString(){if(u){for(FB g in NE.keys){BB(this,k.EB,g);}}return NE.keys.toSet().toString();}}class kD<FB> implements Iterator<FB>{final  PE;final  QE;var RE=false;kD( g):PE=g,QE=g.NE.keys.iterator; moveNext(){PE.length;return RE=QE.moveNext();} get current{var g=QE.current;if(u&&RE)BB(PE,k.EB,g);return g;}}vB(h,g)=>h.hashCode*31+g.hashCode;KD(g,i,h,j)=>vB(vB(g,i),vB(h,j)); LD( h()){var g=new AB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class PC{static  MD( m, g, v, i, l){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+l-1,j=i+l-1;h>=g;h-- ,j-- ){v[j]=m[h];}}else{for(int h=g,j=i;h<g+l;h++ ,j++ ){v[j]=m[h];}}}static  ND( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class OD extends zB.IterableBase<dynamic>{}abstract class PD extends zB.ListMixin<dynamic>{}