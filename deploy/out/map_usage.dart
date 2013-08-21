import "dart:json" as RB;import "dart:isolate" as AB;import "dart:collection" as BC;import "dart:mirrors" as aD;import "dart:async" as ZD;import "dart:html" as q;class bD{static const  cD="Chrome";static const  dD="Firefox";static const  eD="Internet Explorer";static const  fD="Safari";final  VD;final  minimumVersion;const bD(this.VD,[this.minimumVersion]);}class gD{const gD();}class hD{final  name;const hD(this.name);}class iD{const iD();}class jD{const jD();}const CC='/dry/service-rules-usage';const UC='8888';const DC='Rules / PMT';var EC;var FC;var gB=YB(new List<String>());var VC=YB(new List<String>());var hB=YB(new List<String>());var iB=YB(new List<String>());var aB=YB(new List<String>());var jB=YB(new List<String>());final pB=new KB();var qB='CTCS2X/315'; get SB{if(u){BB(pB,k.t,'selectedFormat');}return qB;}set SB( g){if(HB(pB)){o(pB,k.t,'selectedFormat',qB,g);}qB=g;}var TB='b2bowner@stg';var UB='315';var bB='Exception';var kB='*';var rB='*';main(){WC();} OB(){return q.window.location.protocol+'//'+q.window.location.hostname+':${EC}${FC}';} WC(){EC=q.window.location.port=='3030'?UC:q.window.location.port;FC=q.window.location.port=='3030'?CC:'/dry'+CC;XC();} XC(){var g=OB()+'?opt=datasources';var i=q.HttpRequest.getString(g).then((h){VC.addAll(RB.parse(h));YC();});} YC(){var g=OB()+'?opt=formats&ds=${TB}';var i=q.HttpRequest.getString(g).then((h){gB.clear();gB.addAll(RB.parse(h));if(!gB.contains(SB))SB=gB.first;ZC();});} ZC(){var g=OB()+'?opt=convTypes&ds=${TB}&fmt=${SB}';var i=q.HttpRequest.getString(g).then((h){hB.clear();hB.addAll(RB.parse(h));if(!hB.contains(UB))UB=hB.first;aC();});} aC(){var g=OB()+'?opt=segments&ds=${TB}&fmt=${SB}&cvt=${UB}';var i=q.HttpRequest.getString(g).then((h){iB.clear();iB.addAll(RB.parse(h));if(!iB.contains(bB))bB=iB.first;bC();});} bC(){var g=OB()+'?opt=fields&ds=${TB}&fmt=${SB}&cvt=${UB}&seg=${bB}';var i=q.HttpRequest.getString(g).then((h){aB.clear();aB.addAll(RB.parse(h));aB.add('*');if(!aB.contains(kB))kB=aB.first;cC();});} cC(){var g=OB()+'?opt=cases&ds=${TB}&fmt=${SB}&cvt=${UB}&seg=${bB}&snum=${kB}';var i=q.HttpRequest.getString(g).then((h){jB.clear();jB.addAll(RB.parse(h));if(!jB.contains(rB))rB=jB.first;dC();});} dC(){var l=OB()+'?opt=matrix&ds=${TB}&fmt=${SB}&cvt=${UB}&seg=${bB}&snum=${kB}&case=${rB}';var v=q.HttpRequest.getString(l).then((m){var g=RB.parse(m);var j=new fC("matrix",['fancyTable']);var h=new List();h.add(DC);h.addAll(g['tpIds']);j.UD(h);j.TD(h,g['keys'],g['sequences'],g['paths']);var i=q.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();gC(j,i);eC("#matrix",g['paths'].length);});} eC( i, g){var h=(g+1)*40>750?750:((g+1)*40)+10;tC((){var j=uC({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});rC.pD(i).oD(j);});}class fC extends GC{var wD;fC( h, g){wD=new q.Element.tag("table");wD.id=h;wD.classes=g;} UD( v,[ l, j]){var i=new q.Element.tag('thead');var g=new q.Element.tr();if(l!=null)g.classes=l;i.nodes.add(g);v.forEach((m){var h=new q.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});wD.nodes.add(i);} TD( TC, YD, oB, j){var l=new q.Element.tag('tbody');YD.forEach((i){var v=new q.Element.tr();l.nodes.add(v);var AC=0;TC.forEach((m){var NB=i+"-"+m;var g=' ';if(m!=DC){if(oB.containsKey(NB))g='<span class="label label-info">'+oB[NB]+'</span>';}else{g='<p><span class="badge">'+j[i]['ruleCase']+'</span> '+j[i]['segNum']+" / "+j[i]['ruleName']+"</p>";}var h=new q.Element.td();if(g.contains("span")){if(AC++ >0)h.attributes={"align":"center"};h.nodes.add(new q.Element.html(g));}else h.text=g;v.nodes.add(h);});});wD.nodes.add(l);} get elements{var g=new List();g.add(wD);return g;}}abstract class GC{var elements;} gC( h,[ g]){if(g==null){g=q.document.body;}g.nodes.addAll(h.elements);}final hC=r"""
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
"""; iC(h){final g=new q.ScriptElement();g.type='text/javascript';g.innerHtml=h;q.document.body.nodes.add(g);}var cB=null;var jC=null;var kC=null;var HC=null;var lC=null;var mC=null;var nC=null;var IC=null;var JC=null;var KC=null;var oC=null;var pC=null;var LC=null;var MC=null; qC(){if(cB!=null)return;try {cB=q.window.lookupPort('dart-js-interop-context');}catch (h){}if(cB==null){iC(hC);cB=q.window.lookupPort('dart-js-interop-context');}jC=q.window.lookupPort('dart-js-interop-create');kC=q.window.lookupPort('dart-js-interop-proxy-count');HC=q.window.lookupPort('dart-js-interop-equals');lC=q.window.lookupPort('dart-js-interop-instanceof');mC=q.window.lookupPort('dart-js-interop-has-property');nC=q.window.lookupPort('dart-js-interop-delete-property');IC=q.window.lookupPort('dart-js-interop-convert');JC=q.window.lookupPort('dart-js-interop-enter-scope');KC=q.window.lookupPort('dart-js-interop-exit-scope');oC=q.window.lookupPort('dart-js-interop-globalize');pC=q.window.lookupPort('dart-js-interop-invalidate');LC=new q.ReceivePortSync()..receive((xD)=>sB());MC=new q.ReceivePortSync()..receive((g)=>tB(g[0]));q.window.registerPort('js-dart-interop-enter-scope',LC.toSendPort());q.window.registerPort('js-dart-interop-exit-scope',MC.toSendPort());} get rC{lB();return eB(cB.callSync([] ));}get sC=>GB.yD.length; lB(){if(sC==0){var g=sB();ZD.runAsync(()=>tB(g));}}tC(g){var h=sB();try {return g();}finally {tB(h);}} sB(){qC();GB.WD();JC.callSync([] );return GB.yD.length;} tB( g){assert(GB.yD.length==g);KC.callSync([] );GB.XD();} uC( g)=>new IB.qD(g);class kD{const kD();}const PB=const kD(); vC(i,m,l,j,NB,v){final g=[i,m,l,j,NB,v];final h=g.indexOf(PB);if(h<0)return g;return g.sublist(0,h);}class IB implements vB<IB>{var zD;final AE;factory IB.qD(g){lB();return wC(g);}static wC(g){return eB(IC.callSync(uB(g)));}static uB(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,uB(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(uB).toList()];}else{return ['simple',VB(g)];}}IB.rD(this.zD,this.AE); SC()=>this;operator[](g)=>dB(this,'[]','method',[g]);operator[]=(h,g)=>dB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is IB&&HC.callSync([VB(this),VB(g)])); toString(){try {return dB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=aD.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return dB(this,g,h,j);}static dB( g, i, l, j){lB();var h=g.zD.callSync([g.AE,i,l,j.map(VB).toList()]);switch (h[0]){case 'return':return eB(h[1]);case 'throws':throw eB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class NC extends IB implements vB<NC>{NC.rD( h,g):super.rD(h,g);call([g=PB,j=PB,i=PB,h=PB,v=PB,l=PB]){var m=vC(g,j,i,h,v,l);return IB.dB(this,'','apply',m);}}abstract class vB<xC>{ SC();}class yC{final  BE;var CE;var DE;final  EE;final  zD;final  FE;final  GE;final  yD;WD(){yD.add(GE.length);}XD(){var h=yD.removeLast();for(int g=h;g<GE.length; ++g){var i=GE[g];if(!FE.contains(i)){EE.remove(GE[g]);DE++ ;}}if(h!=GE.length){GE.removeRange(h,GE.length-h);}}yC():BE='dart-ref',CE=0,DE=0,EE={},zD=new q.ReceivePortSync(),GE=new List<String>(),yD=new List<int>(),FE=new Set<String>(){zD.receive((g){try {final h=EE[g[0]];final l=g[1];final j=g[2].map(eB).toList();if(l=='#call'){final m=h as Function;var v=VB(m(j));return ['return',v];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){lB();final g='${BE}-${CE++ }';EE[g]=h;GE.add(g);return g;}Object get( g){return EE[g];}get zB=>zD.toSendPort();}var GB=new yC();VB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}else if(g is q.Element&&(g.document==null||g.document==q.document)){return ['domref',AD(g)];}else if(g is NC){return ['funcref',g.AE,g.zD];}else if(g is IB){return ['objref',g.AE,g.zD];}else if(g is vB){return VB(g.SC());}else{return ['objref',GB.add(g),GB.zB];}}eB(var g){m(g){var h=g[1];var i=g[2];if(i==GB.zB){return GB.get(h);}else{return new NC.rD(i,h);}}l(g){var h=g[1];var i=g[2];if(i==GB.zB){return GB.get(h);}else{return new IB.rD(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return l(g);case 'domref':return BD(g[1]);}throw 'Unsupported serialized data: ${g}';}var zC=0;const mB='data-dart_id';const JB='data-dart_temporary_attached';AD( h){var i;if(h.attributes.containsKey(mB)){i=h.attributes[mB];}else{i='dart-${zC++ }';h.attributes[mB]=i;}if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(JB)){final j=g.attributes[JB];final l=j+'a';g.attributes[JB]=l;break;}if(g.parent==null){g.attributes[JB]='a';q.document.documentElement.children.add(g);break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return i;} BD(var i){var j=q.queryAll('[${mB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,q.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(JB)){final l=g.attributes[JB];final m=l.substring(1);g.attributes[JB]=m;if(g.attributes[JB].length==0){g.attributes.remove(JB);g.remove();}break;}if(identical(g.parent,q.document.documentElement)){break;}g=g.parent;}}return h;}class CD<LB> extends SD with KB implements List<LB>{final  HE;CD([ g]):HE=g!=null?new List<LB>(g):<LB>[] ;factory CD.sD( g)=>new CD<LB>()..addAll(g); get length{if(u)BB(this,k.t,'length');return HE.length;}set length( h){var i=HE.length;if(i==h)return;if(HB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){o(this,k.MB,g,HE[g],null);}o(this,k.t,'length',i,h);}else{o(this,k.t,'length',i,h);for(int g=i;g<h;g++ ){o(this,k.XB,g,null,null);}}}HE.length=h;} operator[]( g){if(u)BB(this,k.EB,g);return HE[g];}operator[]=( g, h){var i=HE[g];if(HB(this)){o(this,k.EB,g,i,h);}HE[g]=h;} sublist( h,[ g])=>new CD<LB>.sD(super.sublist(h,g)); add( h){var g=HE.length;if(HB(this)){o(this,k.t,'length',g,g+1);o(this,k.XB,g,null,h);}HE.add(h);} removeRange( h, g){if(g==0)return;RC.QD(this,h,g);if(HB(this)){for(int i=h;i<g;i++ ){o(this,k.MB,i,this[i],null);}}RC.PD(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(u){for(int g=0;g<length;g++ ){BB(this,k.EB,g);}}return HE.toString();}}typedef  fB<CB,DB>();class WB<CB,DB> extends KB implements Map<CB,DB>{final  IE;var JE;var KE;WB({ createMap}):IE=createMap!=null?createMap():new Map<CB,DB>(){JE=new DD<CB,DB>(this);KE=new ED<CB,DB>(this);}factory WB.tD( i,{ createMap}){var g=new WB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>JE; get values=>KE; get length{if(u)BB(this,k.t,'length');return IE.length;} get isEmpty=>length==0; LE( g)=>BB(this,k.EB,g); ME(){BB(this,k.t,'length');IE.keys.forEach(LE);} containsKey( g){if(u)LE(g);return IE.containsKey(g);} operator[]( g){if(u)LE(g);return IE[g];} operator[]=( h, g){var j=IE.length;var i=IE[h];IE[h]=g;if(HB(this)){if(j!=IE.length){o(this,k.t,'length',j,IE.length);o(this,k.XB,h,i,g);}else if(i!=g){o(this,k.EB,h,i,g);}}} remove( g){if(u)LE(g);var h=IE.length;var i=IE.remove(g);if(HB(this)&&h!=IE.length){o(this,k.MB,g,i,null);o(this,k.t,'length',h,IE.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=IE.length;if(HB(this)&&g>0){IE.forEach((i,h){o(this,k.MB,i,h,null);});o(this,k.t,'length',g,0);}IE.clear();} forEach( g( key, value)){if(u)ME();IE.forEach(g);} toString()=>BC.Maps.mapToString(this);}class DD<CB,DB> extends BC.IterableBase<CB>{final  IE;DD(this.IE); get iterator=>new lD<CB,DB>(IE);}class lD<CB,DB> implements Iterator<CB>{final  IE;final  JE;var NE=false;lD( g):IE=g,JE=g.IE.keys.iterator; moveNext(){if(u)BB(IE,k.t,'length');return NE=JE.moveNext();} get current{var g=JE.current;if(u&&NE)IE.LE(g);return g;}}class ED<CB,DB> extends BC.IterableBase<DB>{final  IE;ED(this.IE); get iterator=>new mD<CB,DB>(IE);}class mD<CB,DB> implements Iterator<DB>{final  IE;final  JE;final  KE;var NE;mD( g):IE=g,JE=g.IE.keys.iterator,KE=g.IE.values.iterator; moveNext(){if(u)BB(IE,k.t,'length');var h=JE.moveNext();var g=KE.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return NE=g;} get current{if(u&&NE)IE.LE(JE.current);return KE.current;}}class k{static const t=1;static const EB=2;static const XB=EB|4;static const MB=EB|8;final  type;final key;final oldValue;final newValue;k(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is k&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>ND(type,key,oldValue,newValue); toString(){var g;switch (type){case t:g='field';break;case EB:g='index';break;case XB:g='insert';break;case MB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}}YB(g){if(g is Map){var h=null;if(g is BC.SplayTreeMap){h=()=>new BC.SplayTreeMap();}else if(g is BC.LinkedHashMap){h=()=>new BC.LinkedHashMap();}return new WB.tD(g,createMap:h);}if(g is Set)return new QC.uD(g);if(g is Iterable)return new CD.sD(g);return g;}class KB{var yB;var ZB;final  hashCode= ++KB.FD;static var FD=0;} HB( g)=>g.yB!=null&&g.yB.head!=null; get u=>OC!=null; BB( g, h,i)=>OC.OE(g,h,i); o( g, j,l, h, i){if((j&(k.XB|k.MB))==0){if(h==i)return;}if(QB==null){QB=[] ;OD(GD);}if(g.ZB==null){g.ZB=[] ;QB.add(g);}g.ZB.add(new k(j,l,h,i));}var OC;var PC=100;var QB;var nB; GD(){var m=0;while (QB!=null||nB!=null){var j=QB;QB=null;var i=nB;nB=null;if(m++ ==PC){HD(j,i);return;}if(j!=null){for(var h in j){var NB=h.ZB;h.ZB=null;for(var g=h.yB.head;g!=null;g=g.next){var l=g.value;try {l(NB);}catch (oB,v){LD(oB,v,l,'from ${h}');}}}}if(i!=null){i.forEach((TC,AC){AC.PE();});}}} HD( l, j){var g=[] ;if(l!=null){for(var i in l){var NB=i.ZB;g.add('${i} ${NB}');}}if(j!=null){for(var m in j.values){var h=m.PE();if(h!=null)g.add('${m} ${h}');}}QB=null;nB=null;var v='exceeded notifiction limit of ${PC}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';JD(v);}class wB{}typedef  ID( message);var JD=(g)=>print(g);typedef  KD(error,stackTrace,obj, message);var LD=MD; MD(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class QC<FB> extends RD with KB implements Set<FB>{final  QE;final  RE;QC({ createMap}):QE=createMap!=null?createMap():new Map<FB,Object>(),RE=createMap;factory QC.uD( g,{ createMap}){return new QC<FB>(createMap:createMap)..addAll(g);} contains( g){if(u)BB(this,k.EB,g);return QE.containsKey(g);} add( g){var h=QE.length;QE[g]=const Object();if(h!=QE.length){o(this,k.t,'length',h,QE.length);o(this,k.XB,g,null,g);}} remove( g){if(u)BB(this,k.EB,g);var h=QE.length;QE.remove(g);if(h!=QE.length){if(HB(this)){o(this,k.MB,g,g,null);o(this,k.t,'length',h,QE.length);}return true;}return false;} clear(){if(HB(this)){for(var g in QE.keys){o(this,k.MB,g,g,null);}o(this,k.t,'length',QE.length,0);}QE.clear();} get length{if(u)BB(this,k.t,'length');return QE.length;} get isEmpty=>length==0; get iterator=>new nD<FB>(this); addAll( g)=>g.forEach(add); toString(){if(u){for(FB g in QE.keys){BB(this,k.EB,g);}}return QE.keys.toSet().toString();}}class nD<FB> implements Iterator<FB>{final  SE;final  TE;var UE=false;nD( g):SE=g,TE=g.QE.keys.iterator; moveNext(){SE.length;return UE=TE.moveNext();} get current{var g=TE.current;if(u&&UE)BB(SE,k.EB,g);return g;}}xB(h,g)=>h.hashCode*31+g.hashCode;ND(g,i,h,j)=>xB(xB(g,i),xB(h,j)); OD( h()){var g=new AB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class RC{static  PD( m, g, v, i, l){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+l-1,j=i+l-1;h>=g;h-- ,j-- ){v[j]=m[h];}}else{for(int h=g,j=i;h<g+l;h++ ,j++ ){v[j]=m[h];}}}static  QD( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class RD extends BC.IterableBase<dynamic>{}abstract class SD extends BC.ListMixin<dynamic>{}