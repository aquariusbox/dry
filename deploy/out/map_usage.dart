import "dart:mirrors" as UD;import "dart:collection" as yB;import "dart:async" as TD;import "dart:json" as aB;import "dart:isolate" as AB;import "dart:html" as q;class VD{static const  WD="Chrome";static const  XD="Firefox";static const  YD="Internet Explorer";static const  ZD="Safari";final  PD;final  minimumVersion;const VD(this.PD,[this.minimumVersion]);}class aD{const aD();}class bD{final  name;const bD(this.name);}class cD{const cD();}class dD{const dD();}const zB='/dry/service-rules-usage';const QC='8888';const lB='Rules / PMT';var AC;var BC;var bB=iB(new List<String>());var RC=iB(new List<String>());var cB=iB(new List<String>());var UB=iB(new List<String>());final mB=new KB();var nB='CTCS2X/315'; get dB{if(u){BB(mB,k.t,'selectedFormat');}return nB;}set dB( g){if(HB(mB)){o(mB,k.t,'selectedFormat',nB,g);}nB=g;}var eB='b2bowner@stg';var fB='315';var oB='Exception';main(){SC();} VB(){return q.window.location.protocol+'//'+q.window.location.hostname+':${AC}${BC}';} SC(){AC=q.window.location.port=='3030'?QC:q.window.location.port;BC=q.window.location.port=='3030'?zB:'/dry'+zB;TC();} TC(){var g=VB()+'?opt=datasources';var i=q.HttpRequest.getString(g).then((h){RC.addAll(aB.parse(h));UC();});} UC(){var g=VB()+'?opt=formats&ds=${eB}';var i=q.HttpRequest.getString(g).then((h){bB.clear();bB.addAll(aB.parse(h));if(!bB.contains(dB))dB=bB.first;VC();});} VC(){var g=VB()+'?opt=convTypes&ds=${eB}&fmt=${dB}';var i=q.HttpRequest.getString(g).then((h){cB.clear();cB.addAll(aB.parse(h));if(!cB.contains(fB))fB=cB.first;WC();});} WC(){var g=VB()+'?opt=segments&ds=${eB}&fmt=${dB}&cvt=${fB}';var i=q.HttpRequest.getString(g).then((h){UB.clear();UB.addAll(aB.parse(h));UB.add('*');if(!UB.contains(oB))oB=UB.first;XC();});} XC(){var l=VB()+'?opt=matrix&ds=${eB}&fmt=${dB}&cvt=${fB}&segid=${oB}';var v=q.HttpRequest.getString(l).then((m){var g=aB.parse(m);var j=new ZC("matrix",['fancyTable']);var h=new List();h.add(lB);h.addAll(g['tpIds']);j.OD(h);j.ND(h,g['keys'],g['sequences'],g['paths']);var i=q.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();aC(j,i);YC("#matrix",g['paths'].length);});} YC( i, g){var h=(g+1)*50>750?750:(g+1)*40;nC((){var j=oC({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});lC.jD(i).iD(j);});}class ZC extends CC{var qD;ZC( h, g){qD=new q.Element.tag("table");qD.id=h;qD.classes=g;} OD( v,[ l, j]){var i=new q.Element.tag('thead');var g=new q.Element.tr();if(l!=null)g.classes=l;i.nodes.add(g);v.forEach((m){var h=new q.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});qD.nodes.add(i);} ND( xB, SD, kB, PC){var j=new q.Element.tag('tbody');var i=0;SD.forEach((v){var m=new q.Element.tr();j.nodes.add(m);xB.forEach((l){var NB=v+"-"+l;var g=' ';if(l!=lB){if(kB.containsKey(NB))g='<span class="label label-info">'+kB[NB]+'</span>';}else if(i==0){g=lB;}else{g=PC[v];}var h=new q.Element.td();if(g.contains("span")){h.attributes={"align":"center"};h.nodes.add(new q.Element.html(g));}else h.text=g;m.nodes.add(h);});i++ ;});qD.nodes.add(j);} get elements{var g=new List();g.add(qD);return g;}}abstract class CC{var elements;} aC( h,[ g]){if(g==null){g=q.document.body;}g.nodes.addAll(h.elements);}final bC=r"""
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
"""; cC(h){final g=new q.ScriptElement();g.type='text/javascript';g.innerHtml=h;q.document.body.nodes.add(g);}var WB=null;var dC=null;var eC=null;var DC=null;var fC=null;var gC=null;var hC=null;var EC=null;var FC=null;var GC=null;var iC=null;var jC=null;var HC=null;var IC=null; kC(){if(WB!=null)return;try {WB=q.window.lookupPort('dart-js-interop-context');}catch (h){}if(WB==null){cC(bC);WB=q.window.lookupPort('dart-js-interop-context');}dC=q.window.lookupPort('dart-js-interop-create');eC=q.window.lookupPort('dart-js-interop-proxy-count');DC=q.window.lookupPort('dart-js-interop-equals');fC=q.window.lookupPort('dart-js-interop-instanceof');gC=q.window.lookupPort('dart-js-interop-has-property');hC=q.window.lookupPort('dart-js-interop-delete-property');EC=q.window.lookupPort('dart-js-interop-convert');FC=q.window.lookupPort('dart-js-interop-enter-scope');GC=q.window.lookupPort('dart-js-interop-exit-scope');iC=q.window.lookupPort('dart-js-interop-globalize');jC=q.window.lookupPort('dart-js-interop-invalidate');HC=new q.ReceivePortSync()..receive((rD)=>pB());IC=new q.ReceivePortSync()..receive((g)=>qB(g[0]));q.window.registerPort('js-dart-interop-enter-scope',HC.toSendPort());q.window.registerPort('js-dart-interop-exit-scope',IC.toSendPort());} get lC{gB();return YB(WB.callSync([] ));}get mC=>GB.sD.length; gB(){if(mC==0){var g=pB();TD.runAsync(()=>qB(g));}}nC(g){var h=pB();try {return g();}finally {qB(h);}} pB(){kC();GB.QD();FC.callSync([] );return GB.sD.length;} qB( g){assert(GB.sD.length==g);GC.callSync([] );GB.RD();} oC( g)=>new IB.kD(g);class eD{const eD();}const OB=const eD(); pC(i,m,l,j,NB,v){final g=[i,m,l,j,NB,v];final h=g.indexOf(OB);if(h<0)return g;return g.sublist(0,h);}class IB implements sB<IB>{var tD;final uD;factory IB.kD(g){gB();return qC(g);}static qC(g){return YB(EC.callSync(rB(g)));}static rB(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,rB(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(rB).toList()];}else{return ['simple',QB(g)];}}IB.lD(this.tD,this.uD); OC()=>this;operator[](g)=>XB(this,'[]','method',[g]);operator[]=(h,g)=>XB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is IB&&DC.callSync([QB(this),QB(g)])); toString(){try {return XB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=UD.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return XB(this,g,h,j);}static XB( g, i, l, j){gB();var h=g.tD.callSync([g.uD,i,l,j.map(QB).toList()]);switch (h[0]){case 'return':return YB(h[1]);case 'throws':throw YB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class JC extends IB implements sB<JC>{JC.lD( h,g):super.lD(h,g);call([g=OB,j=OB,i=OB,h=OB,v=OB,l=OB]){var m=pC(g,j,i,h,v,l);return IB.XB(this,'','apply',m);}}abstract class sB<rC>{ OC();}class sC{final  vD;var wD;var xD;final  yD;final  tD;final  zD;final  AE;final  sD;QD(){sD.add(AE.length);}RD(){var h=sD.removeLast();for(int g=h;g<AE.length; ++g){var i=AE[g];if(!zD.contains(i)){yD.remove(AE[g]);xD++ ;}}if(h!=AE.length){AE.removeRange(h,AE.length-h);}}sC():vD='dart-ref',wD=0,xD=0,yD={},tD=new q.ReceivePortSync(),AE=new List<String>(),sD=new List<int>(),zD=new Set<String>(){tD.receive((g){try {final h=yD[g[0]];final l=g[1];final j=g[2].map(YB).toList();if(l=='#call'){final m=h as Function;var v=QB(m(j));return ['return',v];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){gB();final g='${vD}-${wD++ }';yD[g]=h;AE.add(g);return g;}Object get( g){return yD[g];}get wB=>tD.toSendPort();}var GB=new sC();QB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}else if(g is q.Element&&(g.document==null||g.document==q.document)){return ['domref',uC(g)];}else if(g is JC){return ['funcref',g.uD,g.tD];}else if(g is IB){return ['objref',g.uD,g.tD];}else if(g is sB){return QB(g.OC());}else{return ['objref',GB.add(g),GB.wB];}}YB(var g){m(g){var h=g[1];var i=g[2];if(i==GB.wB){return GB.get(h);}else{return new JC.lD(i,h);}}l(g){var h=g[1];var i=g[2];if(i==GB.wB){return GB.get(h);}else{return new IB.lD(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return l(g);case 'domref':return vC(g[1]);}throw 'Unsupported serialized data: ${g}';}var tC=0;const hB='data-dart_id';const JB='data-dart_temporary_attached';uC( h){var i;if(h.attributes.containsKey(hB)){i=h.attributes[hB];}else{i='dart-${tC++ }';h.attributes[hB]=i;}if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(JB)){final j=g.attributes[JB];final l=j+'a';g.attributes[JB]=l;break;}if(g.parent==null){g.attributes[JB]='a';q.document.documentElement.children.add(g);break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return i;} vC(var i){var j=q.queryAll('[${hB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(JB)){final l=g.attributes[JB];final m=l.substring(1);g.attributes[JB]=m;if(g.attributes[JB].length==0){g.attributes.remove(JB);g.remove();}break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return h;}class wC<LB> extends MD with KB implements List<LB>{final  BE;wC([ g]):BE=g!=null?new List<LB>(g):<LB>[] ;factory wC.mD( g)=>new wC<LB>()..addAll(g); get length{if(u)BB(this,k.t,'length');return BE.length;}set length( h){var i=BE.length;if(i==h)return;if(HB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){o(this,k.MB,g,BE[g],null);}o(this,k.t,'length',i,h);}else{o(this,k.t,'length',i,h);for(int g=i;g<h;g++ ){o(this,k.SB,g,null,null);}}}BE.length=h;} operator[]( g){if(u)BB(this,k.EB,g);return BE[g];}operator[]=( g, h){var i=BE[g];if(HB(this)){o(this,k.EB,g,i,h);}BE[g]=h;} sublist( h,[ g])=>new wC<LB>.mD(super.sublist(h,g)); add( h){var g=BE.length;if(HB(this)){o(this,k.t,'length',g,g+1);o(this,k.SB,g,null,h);}BE.add(h);} removeRange( h, g){if(g==0)return;NC.KD(this,h,g);if(HB(this)){for(int i=h;i<g;i++ ){o(this,k.MB,i,this[i],null);}}NC.JD(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(u){for(int g=0;g<length;g++ ){BB(this,k.EB,g);}}return BE.toString();}}typedef  ZB<CB,DB>();class RB<CB,DB> extends KB implements Map<CB,DB>{final  CE;var DE;var EE;RB({ createMap}):CE=createMap!=null?createMap():new Map<CB,DB>(){DE=new xC<CB,DB>(this);EE=new yC<CB,DB>(this);}factory RB.nD( i,{ createMap}){var g=new RB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>DE; get values=>EE; get length{if(u)BB(this,k.t,'length');return CE.length;} get isEmpty=>length==0; FE( g)=>BB(this,k.EB,g); GE(){BB(this,k.t,'length');CE.keys.forEach(FE);} containsKey( g){if(u)FE(g);return CE.containsKey(g);} operator[]( g){if(u)FE(g);return CE[g];} operator[]=( h, g){var j=CE.length;var i=CE[h];CE[h]=g;if(HB(this)){if(j!=CE.length){o(this,k.t,'length',j,CE.length);o(this,k.SB,h,i,g);}else if(i!=g){o(this,k.EB,h,i,g);}}} remove( g){if(u)FE(g);var h=CE.length;var i=CE.remove(g);if(HB(this)&&h!=CE.length){o(this,k.MB,g,i,null);o(this,k.t,'length',h,CE.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=CE.length;if(HB(this)&&g>0){CE.forEach((i,h){o(this,k.MB,i,h,null);});o(this,k.t,'length',g,0);}CE.clear();} forEach( g( key, value)){if(u)GE();CE.forEach(g);} toString()=>yB.Maps.mapToString(this);}class xC<CB,DB> extends yB.IterableBase<CB>{final  CE;xC(this.CE); get iterator=>new fD<CB,DB>(CE);}class fD<CB,DB> implements Iterator<CB>{final  CE;final  DE;var HE=false;fD( g):CE=g,DE=g.CE.keys.iterator; moveNext(){if(u)BB(CE,k.t,'length');return HE=DE.moveNext();} get current{var g=DE.current;if(u&&HE)CE.FE(g);return g;}}class yC<CB,DB> extends yB.IterableBase<DB>{final  CE;yC(this.CE); get iterator=>new gD<CB,DB>(CE);}class gD<CB,DB> implements Iterator<DB>{final  CE;final  DE;final  EE;var HE;gD( g):CE=g,DE=g.CE.keys.iterator,EE=g.CE.values.iterator; moveNext(){if(u)BB(CE,k.t,'length');var h=DE.moveNext();var g=EE.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return HE=g;} get current{if(u&&HE)CE.FE(DE.current);return EE.current;}}class k{static const t=1;static const EB=2;static const SB=EB|4;static const MB=EB|8;final  type;final key;final oldValue;final newValue;k(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is k&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>HD(type,key,oldValue,newValue); toString(){var g;switch (type){case t:g='field';break;case EB:g='index';break;case SB:g='insert';break;case MB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}}iB(g){if(g is Map){var h=null;if(g is yB.SplayTreeMap){h=()=>new yB.SplayTreeMap();}else if(g is yB.LinkedHashMap){h=()=>new yB.LinkedHashMap();}return new RB.nD(g,createMap:h);}if(g is Set)return new MC.oD(g);if(g is Iterable)return new wC.mD(g);return g;}class KB{var vB;var TB;final  hashCode= ++KB.zC;static var zC=0;} HB( g)=>g.vB!=null&&g.vB.head!=null; get u=>KC!=null; BB( g, h,i)=>KC.IE(g,h,i); o( g, j,l, h, i){if((j&(k.SB|k.MB))==0){if(h==i)return;}if(PB==null){PB=[] ;ID(AD);}if(g.TB==null){g.TB=[] ;PB.add(g);}g.TB.add(new k(j,l,h,i));}var KC;var LC=100;var PB;var jB; AD(){var m=0;while (PB!=null||jB!=null){var j=PB;PB=null;var i=jB;jB=null;if(m++ ==LC){BD(j,i);return;}if(j!=null){for(var h in j){var NB=h.TB;h.TB=null;for(var g=h.vB.head;g!=null;g=g.next){var l=g.value;try {l(NB);}catch (kB,v){FD(kB,v,l,'from ${h}');}}}}if(i!=null){i.forEach((PC,xB){xB.JE();});}}} BD( l, j){var g=[] ;if(l!=null){for(var i in l){var NB=i.TB;g.add('${i} ${NB}');}}if(j!=null){for(var m in j.values){var h=m.JE();if(h!=null)g.add('${m} ${h}');}}PB=null;jB=null;var v='exceeded notifiction limit of ${LC}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';DD(v);}class tB{}typedef  CD( message);var DD=(g)=>print(g);typedef  ED(error,stackTrace,obj, message);var FD=GD; GD(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class MC<FB> extends LD with KB implements Set<FB>{final  KE;final  LE;MC({ createMap}):KE=createMap!=null?createMap():new Map<FB,Object>(),LE=createMap;factory MC.oD( g,{ createMap}){return new MC<FB>(createMap:createMap)..addAll(g);} contains( g){if(u)BB(this,k.EB,g);return KE.containsKey(g);} add( g){var h=KE.length;KE[g]=const Object();if(h!=KE.length){o(this,k.t,'length',h,KE.length);o(this,k.SB,g,null,g);}} remove( g){if(u)BB(this,k.EB,g);var h=KE.length;KE.remove(g);if(h!=KE.length){if(HB(this)){o(this,k.MB,g,g,null);o(this,k.t,'length',h,KE.length);}return true;}return false;} clear(){if(HB(this)){for(var g in KE.keys){o(this,k.MB,g,g,null);}o(this,k.t,'length',KE.length,0);}KE.clear();} get length{if(u)BB(this,k.t,'length');return KE.length;} get isEmpty=>length==0; get iterator=>new hD<FB>(this); addAll( g)=>g.forEach(add); toString(){if(u){for(FB g in KE.keys){BB(this,k.EB,g);}}return KE.keys.toSet().toString();}}class hD<FB> implements Iterator<FB>{final  ME;final  NE;var OE=false;hD( g):ME=g,NE=g.KE.keys.iterator; moveNext(){ME.length;return OE=NE.moveNext();} get current{var g=NE.current;if(u&&OE)BB(ME,k.EB,g);return g;}}uB(h,g)=>h.hashCode*31+g.hashCode;HD(g,i,h,j)=>uB(uB(g,i),uB(h,j)); ID( h()){var g=new AB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class NC{static  JD( m, g, v, i, l){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+l-1,j=i+l-1;h>=g;h-- ,j-- ){v[j]=m[h];}}else{for(int h=g,j=i;h<g+l;h++ ,j++ ){v[j]=m[h];}}}static  KD( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class LD extends yB.IterableBase<dynamic>{}abstract class MD extends yB.ListMixin<dynamic>{}