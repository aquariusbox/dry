import "dart:isolate" as q;import "dart:html" as AB;import "dart:math" as GD;import "dart:async" as OB;import "dart:mirrors" as hC;class iC{static const  jC="Chrome";final  RC;final  minimumVersion;const iC(this.RC,[this.minimumVersion]);}class kC{const kC();}class lC{final  name;const lC(this.name);}class mC{const mC();}class nC{const nC();} main(){rB();} rB(){var h=new GD.Random();KC((){final g=new sB()..zoom=(h.nextInt(9)+5)..TC=true..oB=new dB(cB(-85,85,3),cB(-180,180,3))..qB=WB.wB;g.SC=true;g.bC=false;final i=new tB(AB.query("#map_canvas"),g);});} cB(var g,var i,var o){var h=new GD.Random();var j=(h.nextDouble()*(i-g)+g).toStringAsFixed(o);return double.parse(j)*1;}const JB=const oC();class tB extends uB{var ND;var OD;var PD;var QD;var RD;var SD;var TD;var UD;var VD;var WD;var XD;var YD;var ZD;var aD;var bD;var cD;var dD;var eD;var fD;tB( g,[ h]):super(PB.Map,[g,h]){gD();} gD(){ND=l.m(this,"bounds_changed");OD=l.m(this,"center_changed");PD=l.m(this,"click",BB.KB);QD=l.m(this,"dblclick",BB.KB);RD=l.m(this,"drag");SD=l.m(this,"dragend");TD=l.m(this,"dragstart");UD=l.m(this,"heading_changed");VD=l.m(this,"idle");WD=l.m(this,"maptypeid_changed");XD=l.m(this,"mousemove",BB.KB);YD=l.m(this,"mouseout",BB.KB);ZD=l.m(this,"mouseover",BB.KB);aD=l.m(this,"projection_changed");bD=l.m(this,"resize");cD=l.m(this,"rightclick",BB.KB);dD=l.m(this,"tilesloaded");eD=l.m(this,"tilt_changed");fD=l.m(this,"zoom_changed");}set oB( g)=>v.CD(g);set qB( g)=>v.DD(g);set zoom( g)=>v.ED(g);yB get on=>new yB.ID(this);}class sB extends MB{sB():super();set oB( g)=>v['center']=g;set SC( g)=>v['disableDefaultUI']=g;set TC( g)=>v['disableDoubleClickZoom']=g;set qB( g)=>v['mapTypeId']=g;set zoom( g)=>v['zoom']=g;set bC( g)=>v['zoomControl']=g;}class WB extends zB<String>{static final wB=new WB.ID(PB.xC.yC);WB.ID( g):super(g); operator==( g)=>value==(g is WB?(g as WB).value:g);}class BB extends MB{static  KB( g)=>g==null?null:new BB.HD(g);BB.HD( g):super.MD(g);}class dB extends MB{dB( g, h,[ i]):super(PB.vC,[g,h,i]); toString()=>v.toString();}class uB extends MB{uB([ g, h]):super(g!=null?g:PB.wC,h);Object get( g)=>v.get(g);}typedef  vB();class XB extends MB{final  onRelease;XB.HD( g,[this.onRelease]):super.MD(g);}class oC{const oC();}final  l=nB(new xB());class xB extends MB{xB():super.MD(PB.event); addListener( o, i, j){final g=new pC.JD(j);final  h=v.addListener(o,i,g);return h==null?null:new XB.HD(h,()=>g.UC());} removeListener( g){if(g.onRelease!=null){g.onRelease();}v.removeListener(g);} m( cC, dC,[ h]){var i=null;return new k(subscribe:( j){i=addListener(cC,dC,([bB=JB,eC=JB,fC=JB,gC=JB,o=JB]){var g=[bB,eC,fC,gC,o].takeWhile((CB)=>CB!=JB).toList(growable:false);var IB=g.length==0?null:g.length==1?g.first:g;j.add(h==null?IB:Function.apply(h,g));});},unsubscribe:( j){removeListener(i);});}}class yB{final  hD;yB.ID(this.hD);}final PB=nB(mB.zC.BD);class zB<YB> implements DB<YB>{var value;zB(this.value); NB()=>value;}typedef eB<LB>( eventSink);class k<LB> implements OB.EventSink<LB>{final  ZC;final  aC;final iD=new List<OB.StreamController<LB>>();k({subscribe( eventSink),unsubscribe( eventSink)}):ZC=subscribe,aC=unsubscribe; add( h)=>iD.forEach((g)=>g.add(h)); close()=>iD.forEach((g)=>g.close());}final AC=r"""
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
"""; BC(h){final g=new AB.ScriptElement();g.type='text/javascript';g.innerHtml=h;AB.document.body.nodes.add(g);}var QB=null;var fB=null;var CC=null;var gB=null;var DC=null;var EC=null;var FC=null;var GC=null;var hB=null;var iB=null;var jB=null;var HC=null;var kB=null;var lB=null; IC(){if(QB!=null)return;try {QB=AB.window.lookupPort('dart-js-interop-context');}catch (h){}if(QB==null){BC(AC);QB=AB.window.lookupPort('dart-js-interop-context');}fB=AB.window.lookupPort('dart-js-interop-create');CC=AB.window.lookupPort('dart-js-interop-proxy-count');gB=AB.window.lookupPort('dart-js-interop-equals');DC=AB.window.lookupPort('dart-js-interop-instanceof');EC=AB.window.lookupPort('dart-js-interop-has-property');FC=AB.window.lookupPort('dart-js-interop-delete-property');GC=AB.window.lookupPort('dart-js-interop-convert');hB=AB.window.lookupPort('dart-js-interop-enter-scope');iB=AB.window.lookupPort('dart-js-interop-exit-scope');jB=AB.window.lookupPort('dart-js-interop-globalize');HC=AB.window.lookupPort('dart-js-interop-invalidate');kB=new AB.ReceivePortSync()..receive((jD)=>ZB());lB=new AB.ReceivePortSync()..receive((g)=>aB(g[0]));AB.window.registerPort('js-dart-interop-enter-scope',kB.toSendPort());AB.window.registerPort('js-dart-interop-exit-scope',lB.toSendPort());} get mB{TB();return SB(QB.callSync([] ));}get JC=>u.kD.length; TB(){if(JC==0){var g=ZB();OB.runAsync(()=>aB(g));}}KC(g){var h=ZB();try {return g();}finally {aB(h);}} ZB(){IC();u.VC();hB.callSync([] );return u.kD.length;} aB( g){assert(u.kD.length==g);iB.callSync([] );u.WC();} nB( g){jB.callSync(HB(g.NB()));return g;}class pC implements DB<GB>{var lD;var mD;var nD;IC(g){lD=g;mD=u.add(nD);u.XC(mD);}oD(){var g=u.YC(mD);} NB()=>new GB.LD(u.VB,mD);UC(){assert(lD);oD();}pC.JD( h,{ withThis: false}){nD=( g)=>Function.apply(h,withThis?g:g.skip(1).toList());IC(true);}}class qC{const qC();}const FB=const qC(); LC(i,CB,o,j,bB,IB){final g=[i,CB,o,j,bB,IB];final h=g.indexOf(FB);if(h<0)return g;return g.sublist(0,h);}class t implements DB<t>{var pD;final mD;factory t.KD( g, h){TB();final i=([g]..addAll(h)).map(HB).toList();final j=fB.callSync(i);return SB(j);}t.LD(this.pD,this.mD); NB()=>this;operator[](g)=>RB(this,'[]','method',[g]);operator[]=(h,g)=>RB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is t&&gB.callSync([HB(this),HB(g)])); toString(){try {return RB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=hC.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return RB(this,g,h,j);}static RB( g, i, o, j){TB();var h=g.pD.callSync([g.mD,i,o,j.map(HB).toList()]);switch (h[0]){case 'return':return SB(h[1]);case 'throws':throw SB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class GB extends t implements DB<GB>{GB.LD( h,g):super.LD(h,g);call([g=FB,j=FB,i=FB,h=FB,IB=FB,o=FB]){var CB=LC(g,j,i,h,IB,o);return t.RB(this,'','apply',CB);}}abstract class DB<MC>{ NB();}class NC{final  qD;var rD;var sD;final  tD;final  pD;final  uD;final  vD;final  kD;VC(){kD.add(vD.length);}WC(){var h=kD.removeLast();for(int g=h;g<vD.length; ++g){var i=vD[g];if(!uD.contains(i)){tD.remove(vD[g]);sD++ ;}}if(h!=vD.length){vD.removeRange(h,vD.length-h);}}XC(g)=>uD.add(g);YC(g){var h=tD[g];uD.remove(g);tD.remove(g);sD++ ;return h;}NC():qD='dart-ref',rD=0,sD=0,tD={},pD=new AB.ReceivePortSync(),vD=new List<String>(),kD=new List<int>(),uD=new Set<String>(){pD.receive((g){try {final h=tD[g[0]];final o=g[1];final j=g[2].map(SB).toList();if(o=='#call'){final CB=h as Function;var IB=HB(CB(j));return ['return',IB];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){TB();final g='${qD}-${rD++ }';tD[g]=h;vD.add(g);return g;}Object get( g){return tD[g];}get VB=>pD.toSendPort();}var u=new NC();HB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is q.SendPortSync){return g;}else if(g is AB.Element&&(g.document==null||g.document==AB.document)){return ['domref',PC(g)];}else if(g is GB){return ['funcref',g.mD,g.pD];}else if(g is t){return ['objref',g.mD,g.pD];}else if(g is DB){return HB(g.NB());}else{return ['objref',u.add(g),u.VB];}}SB(var g){CB(g){var h=g[1];var i=g[2];if(i==u.VB){return u.get(h);}else{return new GB.LD(i,h);}}o(g){var h=g[1];var i=g[2];if(i==u.VB){return u.get(h);}else{return new t.LD(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is q.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return CB(g);case 'objref':return o(g);case 'domref':return QC(g[1]);}throw 'Unsupported serialized data: ${g}';}var OC=0;const UB='data-dart_id';const EB='data-dart_temporary_attached';PC( h){var i;if(h.attributes.containsKey(UB)){i=h.attributes[UB];}else{i='dart-${OC++ }';h.attributes[UB]=i;}if(!identical(h,AB.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(EB)){final j=g.attributes[EB];final o=j+'a';g.attributes[EB]=o;break;}if(g.parent==null){g.attributes[EB]='a';AB.document.documentElement.children.add(g);break;}if(identical(g.parent,AB.document.documentElement)){break;}g=g.parent;}}return i;} QC(var i){var j=AB.queryAll('[${UB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,AB.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(EB)){final o=g.attributes[EB];final CB=o.substring(1);g.attributes[EB]=CB;if(g.attributes[EB].length==0){g.attributes.remove(EB);g.remove();}break;}if(identical(g.parent,AB.document.documentElement)){break;}g=g.parent;}}return h;}class MB implements DB<t>{final  v;MB([ g, h]):this.MD(new t.KD(g!=null?g:mB.Object,h!=null?h:[] ));MB.MD(this.v); NB()=>v;}const rC=const sC();class sC{const sC();}const tC=const uC();class uC{const uC();}