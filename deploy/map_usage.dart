import "dart:mirrors" as YD;import "dart:html" as q;import "dart:isolate" as AB;import "dart:json" as SB;import "dart:collection" as zB;import "dart:async" as XD;class ZD{static const  aD="Chrome";static const  bD="Firefox";static const  cD="Internet Explorer";static const  dD="Safari";final  TD;final  minimumVersion;const ZD(this.TD,[this.minimumVersion]);}class eD{const eD();}class fD{final  name;const fD(this.name);}class gD{const gD();}class hD{const hD();}const AC='/dry/service-rules-usage';const SC='8888';const BC='Rules / PMT';var CC;var DC;var gB=YB(new List<String>());var TC=YB(new List<String>());var hB=YB(new List<String>());var iB=YB(new List<String>());var aB=YB(new List<String>());var jB=YB(new List<String>());var OB='CTCS2X/315';var TB='b2bowner@stg';var UB='315';var bB='Exception';var kB='*';var pB='*';main(){UC();} PB(){return q.window.location.protocol+'//'+q.window.location.hostname+':${CC}${DC}';} UC(){CC=q.window.location.port=='3030'?SC:q.window.location.port;DC=q.window.location.port=='3030'?AC:'/dry'+AC;VC();} VC(){var g=PB()+'?opt=datasources';var i=q.HttpRequest.getString(g).then((h){TC.addAll(SB.parse(h));WC();});} WC(){var g=PB()+'?opt=formats&ds=${TB}';var i=q.HttpRequest.getString(g).then((h){gB.clear();gB.addAll(SB.parse(h));if(!gB.contains(OB))OB=gB.first;XC();});} XC(){var g=PB()+'?opt=convTypes&ds=${TB}&fmt=${OB}';var i=q.HttpRequest.getString(g).then((h){hB.clear();hB.addAll(SB.parse(h));if(!hB.contains(UB))UB=hB.first;YC();});} YC(){var g=PB()+'?opt=segments&ds=${TB}&fmt=${OB}&cvt=${UB}';var i=q.HttpRequest.getString(g).then((h){iB.clear();iB.addAll(SB.parse(h));if(!iB.contains(bB))bB=iB.first;ZC();});} ZC(){var g=PB()+'?opt=fields&ds=${TB}&fmt=${OB}&cvt=${UB}&seg=${bB}';var i=q.HttpRequest.getString(g).then((h){aB.clear();aB.addAll(SB.parse(h));aB.add('*');if(!aB.contains(kB))kB=aB.first;aC();});} aC(){var g=PB()+'?opt=cases&ds=${TB}&fmt=${OB}&cvt=${UB}&seg=${bB}&snum=${kB}';var i=q.HttpRequest.getString(g).then((h){jB.clear();jB.addAll(SB.parse(h));if(!jB.contains(pB))pB=jB.first;bC();});} bC(){var l=PB()+'?opt=matrix&ds=${TB}&fmt=${OB}&cvt=${UB}&seg=${bB}&snum=${kB}&case=${pB}';var t=q.HttpRequest.getString(l).then((m){var g=SB.parse(m);var j=new dC("matrix",['fancyTable']);var h=new List();h.add(BC);h.addAll(g['tpIds']);j.SD(h);j.RD(h,g['keys'],g['sequences'],g['paths']);var i=q.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();eC(j,i);cC("#matrix",g['paths'].length);});} cC( i, g){var h=(g+1)*40>750?750:((g+1)*40)+10;rC((){var j=sC({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});pC.pD(i).oD(j);});}class dC extends EC{var vD;dC( h, g){vD=new q.Element.tag("table");vD.id=h;vD.classes=g;} SD( t,[ l, j]){var i=new q.Element.tag('thead');var g=new q.Element.tr();if(l!=null)g.classes=l;i.nodes.add(g);t.forEach((m){var h=new q.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});vD.nodes.add(i);} RD( RC, WD, oB, j){var l=new q.Element.tag('tbody');WD.forEach((i){var t=new q.Element.tr();l.nodes.add(t);var yB=0;RC.forEach((m){var NB=i+"-"+m;var g=' ';if(m!=BC){if(oB.containsKey(NB))g='<span class="label label-info">'+oB[NB]+'</span>';}else{g='<p><span class="badge">'+j[i]['ruleCase']+'</span> '+j[i]['segNum']+" / "+j[i]['ruleName']+"</p>";}var h=new q.Element.td();if(g.contains("span")){if(yB++ >0)h.attributes={"align":"center"};h.nodes.add(new q.Element.html(g));}else h.text=g;t.nodes.add(h);});});vD.nodes.add(l);} get elements{var g=new List();g.add(vD);return g;}}abstract class EC{var elements;} eC( h,[ g]){if(g==null){g=q.document.body;}g.nodes.addAll(h.elements);}final fC=r"""
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
"""; gC(h){final g=new q.ScriptElement();g.type='text/javascript';g.innerHtml=h;q.document.body.nodes.add(g);}var cB=null;var hC=null;var iC=null;var FC=null;var jC=null;var kC=null;var lC=null;var GC=null;var HC=null;var IC=null;var mC=null;var nC=null;var JC=null;var KC=null; oC(){if(cB!=null)return;try {cB=q.window.lookupPort('dart-js-interop-context');}catch (h){}if(cB==null){gC(fC);cB=q.window.lookupPort('dart-js-interop-context');}hC=q.window.lookupPort('dart-js-interop-create');iC=q.window.lookupPort('dart-js-interop-proxy-count');FC=q.window.lookupPort('dart-js-interop-equals');jC=q.window.lookupPort('dart-js-interop-instanceof');kC=q.window.lookupPort('dart-js-interop-has-property');lC=q.window.lookupPort('dart-js-interop-delete-property');GC=q.window.lookupPort('dart-js-interop-convert');HC=q.window.lookupPort('dart-js-interop-enter-scope');IC=q.window.lookupPort('dart-js-interop-exit-scope');mC=q.window.lookupPort('dart-js-interop-globalize');nC=q.window.lookupPort('dart-js-interop-invalidate');JC=new q.ReceivePortSync()..receive((wD)=>qB());KC=new q.ReceivePortSync()..receive((g)=>rB(g[0]));q.window.registerPort('js-dart-interop-enter-scope',JC.toSendPort());q.window.registerPort('js-dart-interop-exit-scope',KC.toSendPort());} get pC{lB();return eB(cB.callSync([] ));}get qC=>GB.xD.length; lB(){if(qC==0){var g=qB();XD.runAsync(()=>rB(g));}}rC(g){var h=qB();try {return g();}finally {rB(h);}} qB(){oC();GB.UD();HC.callSync([] );return GB.xD.length;} rB( g){assert(GB.xD.length==g);IC.callSync([] );GB.VD();} sC( g)=>new HB.qD(g);class iD{const iD();}const QB=const iD(); tC(i,m,l,j,NB,t){final g=[i,m,l,j,NB,t];final h=g.indexOf(QB);if(h<0)return g;return g.sublist(0,h);}class HB implements tB<HB>{var yD;final zD;factory HB.qD(g){lB();return uC(g);}static uC(g){return eB(GC.callSync(sB(g)));}static sB(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,sB(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(sB).toList()];}else{return ['simple',VB(g)];}}HB.rD(this.yD,this.zD); QC()=>this;operator[](g)=>dB(this,'[]','method',[g]);operator[]=(h,g)=>dB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is HB&&FC.callSync([VB(this),VB(g)])); toString(){try {return dB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=YD.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return dB(this,g,h,j);}static dB( g, i, l, j){lB();var h=g.yD.callSync([g.zD,i,l,j.map(VB).toList()]);switch (h[0]){case 'return':return eB(h[1]);case 'throws':throw eB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class LC extends HB implements tB<LC>{LC.rD( h,g):super.rD(h,g);call([g=QB,j=QB,i=QB,h=QB,t=QB,l=QB]){var m=tC(g,j,i,h,t,l);return HB.dB(this,'','apply',m);}}abstract class tB<vC>{ QC();}class wC{final  AE;var BE;var CE;final  DE;final  yD;final  EE;final  FE;final  xD;UD(){xD.add(FE.length);}VD(){var h=xD.removeLast();for(int g=h;g<FE.length; ++g){var i=FE[g];if(!EE.contains(i)){DE.remove(FE[g]);CE++ ;}}if(h!=FE.length){FE.removeRange(h,FE.length-h);}}wC():AE='dart-ref',BE=0,CE=0,DE={},yD=new q.ReceivePortSync(),FE=new List<String>(),xD=new List<int>(),EE=new Set<String>(){yD.receive((g){try {final h=DE[g[0]];final l=g[1];final j=g[2].map(eB).toList();if(l=='#call'){final m=h as Function;var t=VB(m(j));return ['return',t];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){lB();final g='${AE}-${BE++ }';DE[g]=h;FE.add(g);return g;}Object get( g){return DE[g];}get xB=>yD.toSendPort();}var GB=new wC();VB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}else if(g is q.Element&&(g.document==null||g.document==q.document)){return ['domref',yC(g)];}else if(g is LC){return ['funcref',g.zD,g.yD];}else if(g is HB){return ['objref',g.zD,g.yD];}else if(g is tB){return VB(g.QC());}else{return ['objref',GB.add(g),GB.xB];}}eB(var g){m(g){var h=g[1];var i=g[2];if(i==GB.xB){return GB.get(h);}else{return new LC.rD(i,h);}}l(g){var h=g[1];var i=g[2];if(i==GB.xB){return GB.get(h);}else{return new HB.rD(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return l(g);case 'domref':return zC(g[1]);}throw 'Unsupported serialized data: ${g}';}var xC=0;const mB='data-dart_id';const IB='data-dart_temporary_attached';yC( h){var i;if(h.attributes.containsKey(mB)){i=h.attributes[mB];}else{i='dart-${xC++ }';h.attributes[mB]=i;}if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(IB)){final j=g.attributes[IB];final l=j+'a';g.attributes[IB]=l;break;}if(g.parent==null){g.attributes[IB]='a';q.document.documentElement.children.add(g);break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return i;} zC(var i){var j=q.queryAll('[${mB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(IB)){final l=g.attributes[IB];final m=l.substring(1);g.attributes[IB]=m;if(g.attributes[IB].length==0){g.attributes.remove(IB);g.remove();}break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return h;}class AD<LB> extends QD with JB implements List<LB>{final  GE;AD([ g]):GE=g!=null?new List<LB>(g):<LB>[] ;factory AD.sD( g)=>new AD<LB>()..addAll(g); get length{if(u)DB(this,k.v,'length');return GE.length;}set length( h){var i=GE.length;if(i==h)return;if(KB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){o(this,k.MB,g,GE[g],null);}o(this,k.v,'length',i,h);}else{o(this,k.v,'length',i,h);for(int g=i;g<h;g++ ){o(this,k.XB,g,null,null);}}}GE.length=h;} operator[]( g){if(u)DB(this,k.EB,g);return GE[g];}operator[]=( g, h){var i=GE[g];if(KB(this)){o(this,k.EB,g,i,h);}GE[g]=h;} sublist( h,[ g])=>new AD<LB>.sD(super.sublist(h,g)); add( h){var g=GE.length;if(KB(this)){o(this,k.v,'length',g,g+1);o(this,k.XB,g,null,h);}GE.add(h);} removeRange( h, g){if(g==0)return;PC.OD(this,h,g);if(KB(this)){for(int i=h;i<g;i++ ){o(this,k.MB,i,this[i],null);}}PC.ND(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(u){for(int g=0;g<length;g++ ){DB(this,k.EB,g);}}return GE.toString();}}typedef  fB<BB,CB>();class WB<BB,CB> extends JB implements Map<BB,CB>{final  HE;var IE;var JE;WB({ createMap}):HE=createMap!=null?createMap():new Map<BB,CB>(){IE=new BD<BB,CB>(this);JE=new CD<BB,CB>(this);}factory WB.tD( i,{ createMap}){var g=new WB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>IE; get values=>JE; get length{if(u)DB(this,k.v,'length');return HE.length;} get isEmpty=>length==0; KE( g)=>DB(this,k.EB,g); LE(){DB(this,k.v,'length');HE.keys.forEach(KE);} containsKey( g){if(u)KE(g);return HE.containsKey(g);} operator[]( g){if(u)KE(g);return HE[g];} operator[]=( h, g){var j=HE.length;var i=HE[h];HE[h]=g;if(KB(this)){if(j!=HE.length){o(this,k.v,'length',j,HE.length);o(this,k.XB,h,i,g);}else if(i!=g){o(this,k.EB,h,i,g);}}} remove( g){if(u)KE(g);var h=HE.length;var i=HE.remove(g);if(KB(this)&&h!=HE.length){o(this,k.MB,g,i,null);o(this,k.v,'length',h,HE.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=HE.length;if(KB(this)&&g>0){HE.forEach((i,h){o(this,k.MB,i,h,null);});o(this,k.v,'length',g,0);}HE.clear();} forEach( g( key, value)){if(u)LE();HE.forEach(g);} toString()=>zB.Maps.mapToString(this);}class BD<BB,CB> extends zB.IterableBase<BB>{final  HE;BD(this.HE); get iterator=>new jD<BB,CB>(HE);}class jD<BB,CB> implements Iterator<BB>{final  HE;final  IE;var ME=false;jD( g):HE=g,IE=g.HE.keys.iterator; moveNext(){if(u)DB(HE,k.v,'length');return ME=IE.moveNext();} get current{var g=IE.current;if(u&&ME)HE.KE(g);return g;}}class CD<BB,CB> extends zB.IterableBase<CB>{final  HE;CD(this.HE); get iterator=>new kD<BB,CB>(HE);}class kD<BB,CB> implements Iterator<CB>{final  HE;final  IE;final  JE;var ME;kD( g):HE=g,IE=g.HE.keys.iterator,JE=g.HE.values.iterator; moveNext(){if(u)DB(HE,k.v,'length');var h=IE.moveNext();var g=JE.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return ME=g;} get current{if(u&&ME)HE.KE(IE.current);return JE.current;}}const lD=const mD();class k{static const v=1;static const EB=2;static const XB=EB|4;static const MB=EB|8;final  type;final key;final oldValue;final newValue;k(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is k&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>LD(type,key,oldValue,newValue); toString(){var g;switch (type){case v:g='field';break;case EB:g='index';break;case XB:g='insert';break;case MB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}}YB(g){if(g is Map){var h=null;if(g is zB.SplayTreeMap){h=()=>new zB.SplayTreeMap();}else if(g is zB.LinkedHashMap){h=()=>new zB.LinkedHashMap();}return new WB.tD(g,createMap:h);}if(g is Set)return new OC.uD(g);if(g is Iterable)return new AD.sD(g);return g;}class JB{var wB;var ZB;final  hashCode= ++JB.DD;static var DD=0;} KB( g)=>g.wB!=null&&g.wB.head!=null; get u=>MC!=null; DB( g, h,i)=>MC.NE(g,h,i); o( g, j,l, h, i){if((j&(k.XB|k.MB))==0){if(h==i)return;}if(RB==null){RB=[] ;MD(ED);}if(g.ZB==null){g.ZB=[] ;RB.add(g);}g.ZB.add(new k(j,l,h,i));}var MC;var NC=100;var RB;var nB; ED(){var m=0;while (RB!=null||nB!=null){var j=RB;RB=null;var i=nB;nB=null;if(m++ ==NC){FD(j,i);return;}if(j!=null){for(var h in j){var NB=h.ZB;h.ZB=null;for(var g=h.wB.head;g!=null;g=g.next){var l=g.value;try {l(NB);}catch (oB,t){JD(oB,t,l,'from ${h}');}}}}if(i!=null){i.forEach((RC,yB){yB.OE();});}}} FD( l, j){var g=[] ;if(l!=null){for(var i in l){var NB=i.ZB;g.add('${i} ${NB}');}}if(j!=null){for(var m in j.values){var h=m.OE();if(h!=null)g.add('${m} ${h}');}}RB=null;nB=null;var t='exceeded notifiction limit of ${NC}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';HD(t);}class uB{}typedef  GD( message);var HD=(g)=>print(g);typedef  ID(error,stackTrace,obj, message);var JD=KD; KD(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class mD{const mD();}class OC<FB> extends PD with JB implements Set<FB>{final  PE;final  QE;OC({ createMap}):PE=createMap!=null?createMap():new Map<FB,Object>(),QE=createMap;factory OC.uD( g,{ createMap}){return new OC<FB>(createMap:createMap)..addAll(g);} contains( g){if(u)DB(this,k.EB,g);return PE.containsKey(g);} add( g){var h=PE.length;PE[g]=const Object();if(h!=PE.length){o(this,k.v,'length',h,PE.length);o(this,k.XB,g,null,g);}} remove( g){if(u)DB(this,k.EB,g);var h=PE.length;PE.remove(g);if(h!=PE.length){if(KB(this)){o(this,k.MB,g,g,null);o(this,k.v,'length',h,PE.length);}return true;}return false;} clear(){if(KB(this)){for(var g in PE.keys){o(this,k.MB,g,g,null);}o(this,k.v,'length',PE.length,0);}PE.clear();} get length{if(u)DB(this,k.v,'length');return PE.length;} get isEmpty=>length==0; get iterator=>new nD<FB>(this); addAll( g)=>g.forEach(add); toString(){if(u){for(FB g in PE.keys){DB(this,k.EB,g);}}return PE.keys.toSet().toString();}}class nD<FB> implements Iterator<FB>{final  RE;final  SE;var TE=false;nD( g):RE=g,SE=g.PE.keys.iterator; moveNext(){RE.length;return TE=SE.moveNext();} get current{var g=SE.current;if(u&&TE)DB(RE,k.EB,g);return g;}}vB(h,g)=>h.hashCode*31+g.hashCode;LD(g,i,h,j)=>vB(vB(g,i),vB(h,j)); MD( h()){var g=new AB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class PC{static  ND( m, g, t, i, l){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+l-1,j=i+l-1;h>=g;h-- ,j-- ){t[j]=m[h];}}else{for(int h=g,j=i;h<g+l;h++ ,j++ ){t[j]=m[h];}}}static  OD( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class PD extends zB.IterableBase<dynamic>{}abstract class QD extends zB.ListMixin<dynamic>{}