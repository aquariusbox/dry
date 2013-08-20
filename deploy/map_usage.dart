import "dart:html" as q;import "dart:collection" as wB;import "dart:mirrors" as SD;import "dart:async" as RD;import "dart:isolate" as AB;import "dart:json" as bB;class TD{static const  UD="Chrome";static const  VD="Firefox";static const  WD="Internet Explorer";static const  XD="Safari";final  ND;final  minimumVersion;const TD(this.ND,[this.minimumVersion]);}class YD{const YD();}class ZD{final  name;const ZD(this.name);}class aD{const aD();}class bD{const bD();}const xB='/dry/service-rules-usage';const OC='8888';const lB='Rules / PMT';var yB;var zB;var cB=iB(new List<String>());var PC=iB(new List<String>());var dB=iB(new List<String>());var UB=iB(new List<String>());var VB='CTCS2X/315';var eB='b2bowner@stg';var fB='315';var mB='Exception';main(){QC();} WB(){return q.window.location.protocol+'//'+q.window.location.hostname+':${yB}${zB}';} QC(){yB=q.window.location.port=='3030'?OC:q.window.location.port;zB=q.window.location.port=='3030'?xB:'/dry'+xB;RC();} RC(){var g=WB()+'?opt=datasources';var i=q.HttpRequest.getString(g).then((h){PC.addAll(bB.parse(h));SC();});} SC(){var g=WB()+'?opt=formats&ds=${eB}';var i=q.HttpRequest.getString(g).then((h){cB.clear();cB.addAll(bB.parse(h));if(!cB.contains(VB))VB=cB.first;TC();});} TC(){var g=WB()+'?opt=convTypes&ds=${eB}&fmt=${VB}';var i=q.HttpRequest.getString(g).then((h){dB.clear();dB.addAll(bB.parse(h));if(!dB.contains(fB))fB=dB.first;UC();});} UC(){var g=WB()+'?opt=segments&ds=${eB}&fmt=${VB}&cvt=${fB}';var i=q.HttpRequest.getString(g).then((h){UB.clear();UB.addAll(bB.parse(h));UB.add('*');if(!UB.contains(mB))mB=UB.first;VC();});} VC(){var l=WB()+'?opt=matrix&ds=${eB}&fmt=${VB}&cvt=${fB}&segid=${mB}';var t=q.HttpRequest.getString(l).then((m){var g=bB.parse(m);var j=new XC("matrix",['fancyTable']);var h=new List();h.add(lB);h.addAll(g['tpIds']);j.MD(h);j.LD(h,g['keys'],g['sequences'],g['paths']);var i=q.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();YC(j,i);WC("#matrix",g['paths'].length);});} WC( i, g){var h=(g+1)*50>750?750:(g+1)*40;lC((){var j=mC({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});jC.jD(i).iD(j);});}class XC extends AC{var pD;XC( h, g){pD=new q.Element.tag("table");pD.id=h;pD.classes=g;} MD( t,[ l, j]){var i=new q.Element.tag('thead');var g=new q.Element.tr();if(l!=null)g.classes=l;i.nodes.add(g);t.forEach((m){var h=new q.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});pD.nodes.add(i);} LD( vB, QD, kB, NC){var j=new q.Element.tag('tbody');var i=0;QD.forEach((t){var m=new q.Element.tr();j.nodes.add(m);vB.forEach((l){var NB=t+"-"+l;var g=' ';if(l!=lB){if(kB.containsKey(NB))g='<span class="label label-info">'+kB[NB]+'</span>';}else if(i==0){g=lB;}else{g=NC[t];}var h=new q.Element.td();if(g.contains("span")){h.attributes={"align":"center"};h.nodes.add(new q.Element.html(g));}else h.text=g;m.nodes.add(h);});i++ ;});pD.nodes.add(j);} get elements{var g=new List();g.add(pD);return g;}}abstract class AC{var elements;} YC( h,[ g]){if(g==null){g=q.document.body;}g.nodes.addAll(h.elements);}final ZC=r"""
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
"""; aC(h){final g=new q.ScriptElement();g.type='text/javascript';g.innerHtml=h;q.document.body.nodes.add(g);}var XB=null;var bC=null;var cC=null;var BC=null;var dC=null;var eC=null;var fC=null;var CC=null;var DC=null;var EC=null;var gC=null;var hC=null;var FC=null;var GC=null; iC(){if(XB!=null)return;try {XB=q.window.lookupPort('dart-js-interop-context');}catch (h){}if(XB==null){aC(ZC);XB=q.window.lookupPort('dart-js-interop-context');}bC=q.window.lookupPort('dart-js-interop-create');cC=q.window.lookupPort('dart-js-interop-proxy-count');BC=q.window.lookupPort('dart-js-interop-equals');dC=q.window.lookupPort('dart-js-interop-instanceof');eC=q.window.lookupPort('dart-js-interop-has-property');fC=q.window.lookupPort('dart-js-interop-delete-property');CC=q.window.lookupPort('dart-js-interop-convert');DC=q.window.lookupPort('dart-js-interop-enter-scope');EC=q.window.lookupPort('dart-js-interop-exit-scope');gC=q.window.lookupPort('dart-js-interop-globalize');hC=q.window.lookupPort('dart-js-interop-invalidate');FC=new q.ReceivePortSync()..receive((qD)=>nB());GC=new q.ReceivePortSync()..receive((g)=>oB(g[0]));q.window.registerPort('js-dart-interop-enter-scope',FC.toSendPort());q.window.registerPort('js-dart-interop-exit-scope',GC.toSendPort());} get jC{gB();return ZB(XB.callSync([] ));}get kC=>GB.rD.length; gB(){if(kC==0){var g=nB();RD.runAsync(()=>oB(g));}}lC(g){var h=nB();try {return g();}finally {oB(h);}} nB(){iC();GB.OD();DC.callSync([] );return GB.rD.length;} oB( g){assert(GB.rD.length==g);EC.callSync([] );GB.PD();} mC( g)=>new HB.kD(g);class cD{const cD();}const OB=const cD(); nC(i,m,l,j,NB,t){final g=[i,m,l,j,NB,t];final h=g.indexOf(OB);if(h<0)return g;return g.sublist(0,h);}class HB implements qB<HB>{var sD;final tD;factory HB.kD(g){gB();return oC(g);}static oC(g){return ZB(CC.callSync(pB(g)));}static pB(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,pB(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(pB).toList()];}else{return ['simple',QB(g)];}}HB.lD(this.sD,this.tD); MC()=>this;operator[](g)=>YB(this,'[]','method',[g]);operator[]=(h,g)=>YB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is HB&&BC.callSync([QB(this),QB(g)])); toString(){try {return YB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=SD.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return YB(this,g,h,j);}static YB( g, i, l, j){gB();var h=g.sD.callSync([g.tD,i,l,j.map(QB).toList()]);switch (h[0]){case 'return':return ZB(h[1]);case 'throws':throw ZB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class HC extends HB implements qB<HC>{HC.lD( h,g):super.lD(h,g);call([g=OB,j=OB,i=OB,h=OB,t=OB,l=OB]){var m=nC(g,j,i,h,t,l);return HB.YB(this,'','apply',m);}}abstract class qB<pC>{ MC();}class qC{final  uD;var vD;var wD;final  xD;final  sD;final  yD;final  zD;final  rD;OD(){rD.add(zD.length);}PD(){var h=rD.removeLast();for(int g=h;g<zD.length; ++g){var i=zD[g];if(!yD.contains(i)){xD.remove(zD[g]);wD++ ;}}if(h!=zD.length){zD.removeRange(h,zD.length-h);}}qC():uD='dart-ref',vD=0,wD=0,xD={},sD=new q.ReceivePortSync(),zD=new List<String>(),rD=new List<int>(),yD=new Set<String>(){sD.receive((g){try {final h=xD[g[0]];final l=g[1];final j=g[2].map(ZB).toList();if(l=='#call'){final m=h as Function;var t=QB(m(j));return ['return',t];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){gB();final g='${uD}-${vD++ }';xD[g]=h;zD.add(g);return g;}Object get( g){return xD[g];}get uB=>sD.toSendPort();}var GB=new qC();QB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}else if(g is q.Element&&(g.document==null||g.document==q.document)){return ['domref',sC(g)];}else if(g is HC){return ['funcref',g.tD,g.sD];}else if(g is HB){return ['objref',g.tD,g.sD];}else if(g is qB){return QB(g.MC());}else{return ['objref',GB.add(g),GB.uB];}}ZB(var g){m(g){var h=g[1];var i=g[2];if(i==GB.uB){return GB.get(h);}else{return new HC.lD(i,h);}}l(g){var h=g[1];var i=g[2];if(i==GB.uB){return GB.get(h);}else{return new HB.lD(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return l(g);case 'domref':return tC(g[1]);}throw 'Unsupported serialized data: ${g}';}var rC=0;const hB='data-dart_id';const IB='data-dart_temporary_attached';sC( h){var i;if(h.attributes.containsKey(hB)){i=h.attributes[hB];}else{i='dart-${rC++ }';h.attributes[hB]=i;}if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(IB)){final j=g.attributes[IB];final l=j+'a';g.attributes[IB]=l;break;}if(g.parent==null){g.attributes[IB]='a';q.document.documentElement.children.add(g);break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return i;} tC(var i){var j=q.queryAll('[${hB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(IB)){final l=g.attributes[IB];final m=l.substring(1);g.attributes[IB]=m;if(g.attributes[IB].length==0){g.attributes.remove(IB);g.remove();}break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return h;}class uC<LB> extends KD with JB implements List<LB>{final  AE;uC([ g]):AE=g!=null?new List<LB>(g):<LB>[] ;factory uC.mD( g)=>new uC<LB>()..addAll(g); get length{if(u)DB(this,k.v,'length');return AE.length;}set length( h){var i=AE.length;if(i==h)return;if(KB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){o(this,k.MB,g,AE[g],null);}o(this,k.v,'length',i,h);}else{o(this,k.v,'length',i,h);for(int g=i;g<h;g++ ){o(this,k.SB,g,null,null);}}}AE.length=h;} operator[]( g){if(u)DB(this,k.EB,g);return AE[g];}operator[]=( g, h){var i=AE[g];if(KB(this)){o(this,k.EB,g,i,h);}AE[g]=h;} sublist( h,[ g])=>new uC<LB>.mD(super.sublist(h,g)); add( h){var g=AE.length;if(KB(this)){o(this,k.v,'length',g,g+1);o(this,k.SB,g,null,h);}AE.add(h);} removeRange( h, g){if(g==0)return;LC.ID(this,h,g);if(KB(this)){for(int i=h;i<g;i++ ){o(this,k.MB,i,this[i],null);}}LC.HD(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(u){for(int g=0;g<length;g++ ){DB(this,k.EB,g);}}return AE.toString();}}typedef  aB<BB,CB>();class RB<BB,CB> extends JB implements Map<BB,CB>{final  BE;var CE;var DE;RB({ createMap}):BE=createMap!=null?createMap():new Map<BB,CB>(){CE=new vC<BB,CB>(this);DE=new wC<BB,CB>(this);}factory RB.nD( i,{ createMap}){var g=new RB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>CE; get values=>DE; get length{if(u)DB(this,k.v,'length');return BE.length;} get isEmpty=>length==0; EE( g)=>DB(this,k.EB,g); FE(){DB(this,k.v,'length');BE.keys.forEach(EE);} containsKey( g){if(u)EE(g);return BE.containsKey(g);} operator[]( g){if(u)EE(g);return BE[g];} operator[]=( h, g){var j=BE.length;var i=BE[h];BE[h]=g;if(KB(this)){if(j!=BE.length){o(this,k.v,'length',j,BE.length);o(this,k.SB,h,i,g);}else if(i!=g){o(this,k.EB,h,i,g);}}} remove( g){if(u)EE(g);var h=BE.length;var i=BE.remove(g);if(KB(this)&&h!=BE.length){o(this,k.MB,g,i,null);o(this,k.v,'length',h,BE.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=BE.length;if(KB(this)&&g>0){BE.forEach((i,h){o(this,k.MB,i,h,null);});o(this,k.v,'length',g,0);}BE.clear();} forEach( g( key, value)){if(u)FE();BE.forEach(g);} toString()=>wB.Maps.mapToString(this);}class vC<BB,CB> extends wB.IterableBase<BB>{final  BE;vC(this.BE); get iterator=>new dD<BB,CB>(BE);}class dD<BB,CB> implements Iterator<BB>{final  BE;final  CE;var GE=false;dD( g):BE=g,CE=g.BE.keys.iterator; moveNext(){if(u)DB(BE,k.v,'length');return GE=CE.moveNext();} get current{var g=CE.current;if(u&&GE)BE.EE(g);return g;}}class wC<BB,CB> extends wB.IterableBase<CB>{final  BE;wC(this.BE); get iterator=>new eD<BB,CB>(BE);}class eD<BB,CB> implements Iterator<CB>{final  BE;final  CE;final  DE;var GE;eD( g):BE=g,CE=g.BE.keys.iterator,DE=g.BE.values.iterator; moveNext(){if(u)DB(BE,k.v,'length');var h=CE.moveNext();var g=DE.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return GE=g;} get current{if(u&&GE)BE.EE(CE.current);return DE.current;}}const fD=const gD();class k{static const v=1;static const EB=2;static const SB=EB|4;static const MB=EB|8;final  type;final key;final oldValue;final newValue;k(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is k&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>FD(type,key,oldValue,newValue); toString(){var g;switch (type){case v:g='field';break;case EB:g='index';break;case SB:g='insert';break;case MB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}}iB(g){if(g is Map){var h=null;if(g is wB.SplayTreeMap){h=()=>new wB.SplayTreeMap();}else if(g is wB.LinkedHashMap){h=()=>new wB.LinkedHashMap();}return new RB.nD(g,createMap:h);}if(g is Set)return new KC.oD(g);if(g is Iterable)return new uC.mD(g);return g;}class JB{var tB;var TB;final  hashCode= ++JB.xC;static var xC=0;} KB( g)=>g.tB!=null&&g.tB.head!=null; get u=>IC!=null; DB( g, h,i)=>IC.HE(g,h,i); o( g, j,l, h, i){if((j&(k.SB|k.MB))==0){if(h==i)return;}if(PB==null){PB=[] ;GD(yC);}if(g.TB==null){g.TB=[] ;PB.add(g);}g.TB.add(new k(j,l,h,i));}var IC;var JC=100;var PB;var jB; yC(){var m=0;while (PB!=null||jB!=null){var j=PB;PB=null;var i=jB;jB=null;if(m++ ==JC){zC(j,i);return;}if(j!=null){for(var h in j){var NB=h.TB;h.TB=null;for(var g=h.tB.head;g!=null;g=g.next){var l=g.value;try {l(NB);}catch (kB,t){DD(kB,t,l,'from ${h}');}}}}if(i!=null){i.forEach((NC,vB){vB.IE();});}}} zC( l, j){var g=[] ;if(l!=null){for(var i in l){var NB=i.TB;g.add('${i} ${NB}');}}if(j!=null){for(var m in j.values){var h=m.IE();if(h!=null)g.add('${m} ${h}');}}PB=null;jB=null;var t='exceeded notifiction limit of ${JC}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';BD(t);}class rB{}typedef  AD( message);var BD=(g)=>print(g);typedef  CD(error,stackTrace,obj, message);var DD=ED; ED(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class gD{const gD();}class KC<FB> extends JD with JB implements Set<FB>{final  JE;final  KE;KC({ createMap}):JE=createMap!=null?createMap():new Map<FB,Object>(),KE=createMap;factory KC.oD( g,{ createMap}){return new KC<FB>(createMap:createMap)..addAll(g);} contains( g){if(u)DB(this,k.EB,g);return JE.containsKey(g);} add( g){var h=JE.length;JE[g]=const Object();if(h!=JE.length){o(this,k.v,'length',h,JE.length);o(this,k.SB,g,null,g);}} remove( g){if(u)DB(this,k.EB,g);var h=JE.length;JE.remove(g);if(h!=JE.length){if(KB(this)){o(this,k.MB,g,g,null);o(this,k.v,'length',h,JE.length);}return true;}return false;} clear(){if(KB(this)){for(var g in JE.keys){o(this,k.MB,g,g,null);}o(this,k.v,'length',JE.length,0);}JE.clear();} get length{if(u)DB(this,k.v,'length');return JE.length;} get isEmpty=>length==0; get iterator=>new hD<FB>(this); addAll( g)=>g.forEach(add); toString(){if(u){for(FB g in JE.keys){DB(this,k.EB,g);}}return JE.keys.toSet().toString();}}class hD<FB> implements Iterator<FB>{final  LE;final  ME;var NE=false;hD( g):LE=g,ME=g.JE.keys.iterator; moveNext(){LE.length;return NE=ME.moveNext();} get current{var g=ME.current;if(u&&NE)DB(LE,k.EB,g);return g;}}sB(h,g)=>h.hashCode*31+g.hashCode;FD(g,i,h,j)=>sB(sB(g,i),sB(h,j)); GD( h()){var g=new AB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class LC{static  HD( m, g, t, i, l){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+l-1,j=i+l-1;h>=g;h-- ,j-- ){t[j]=m[h];}}else{for(int h=g,j=i;h<g+l;h++ ,j++ ){t[j]=m[h];}}}static  ID( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class JD extends wB.IterableBase<dynamic>{}abstract class KD extends wB.ListMixin<dynamic>{}