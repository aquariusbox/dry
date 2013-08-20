import "dart:math" as sF;import "dart:html" as m;import "dart:isolate" as AB;import "dart:mirrors" as KF;import "dart:async" as fB;import "dart:collection" as ZC;class LF{static const  MF="Chrome";final  nE;final  minimumVersion;const LF(this.nE,[this.minimumVersion]);}class NF{const NF();}class OF{final  name;const OF(this.name);}class PF{const PF();}class QF{const QF();}class RF extends tC with DB{var CG;static final HD=new m.DocumentFragment.html('''
  <div class="navbar navbar-white">
        <div class="container">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Dry</a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li id="t-dry"><a href="dry.html">Home</a></li>
              <!-- <li><a href="#about">About</a></li> -->
              <li id="t-rbase" class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Rbase <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="map_usage.html">Map of usage</a></li>
                  <li><a href="#">Another action</a></li>
                  <li><a href="#">Something else here</a></li>
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="#">Separated link</a></li>
                  <li><a href="#">One more separated link</a></li>
                </ul>
              </li>
            </ul>
            <!-- <ul class="nav navbar-nav navbar-right">
              <li><a href="http://examples.getbootstrap.com/navbar/index.html">Default</a></li>
              <li><a href="http://examples.getbootstrap.com/navbar-static-top/index.html">Static top</a></li>
              <li><a href="http://examples.getbootstrap.com/navbar-fixed-top/index.html">Fixed top</a></li>
            </ul>--> 
          </div><!--/.nav-collapse -->
        </div>
      </div>
      ''');var DG; pE(){var EG=createShadowRoot("x-navbar");GF("x-navbar",new VC({"x-navbar":"[is=\"x-navbar\"]"}));CG=vE("x-navbar");DG=new ME(EG);EG.nodes.add(HD.clone(true));DG.qB();} xE(){DG.insert();} EF(){DG.remove();DG=null;}var FG=''; get AC{if(tD){uD(this,QB.LC,'activeid');}return FG;}set AC( g){if(sD(this)){vD(this,QB.LC,'activeid',FG,g);}FG=g;}WC(){m.query('#${AC}').className="active";}} ID(){JD();} JD(){var h=new sF.Random();eD((){final g=new MD()..zoom=(h.nextInt(10)+5)..rE=true..vC=new bC(aC(-85,85,3),aC(-180,180,3))..CD=EC.QD;g.qE=true;g.HF=false;final i=new ND(m.query("#map_canvas"),g);});} aC(var g,var i,var k){var h=new sF.Random();var j=(h.nextDouble()*(i-g)+g).toStringAsFixed(k);return double.parse(j)*1;} KD(){var HG=m.document.body;var IG;var JG=new ME(HG);IG=HG.nodes[3].nodes[1];JG.DF(()=>'t-dry',(g){if(IG.xtag.AC!=g)IG.xtag.AC=g;},false,false);JG.dB(new RF()..host=IG);JG.qB();JG.insert();}main(){qC=true;OB.KC.CF.listen((g){print('${g.rB.name.toLowerCase()}: ${g.message}');});ID();KD();}class LD implements m.Element{var KG;var LG;var MG={}; get host{if(KG==null)throw new StateError('host element has not been set.');return KG;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(KG!=null){throw new StateError('host can only be set once.');}g.xtag=this;KG=g;}createShadowRoot([ g]){var h=host.createShadowRoot();if(g!=null){MG[g]=h;}return h;} wC(){} WC(){} ED(){} get nodes=>host.nodes; replaceWith( g){host.replaceWith(g);} remove()=>host.remove(); get document=>host.document;set text( g){host.text=g;} contains( g)=>host.contains(g); insertBefore( g, h)=>host.insertBefore(g,h); insertAllBefore( g, h)=>host.insertAllBefore(g,h); get attributes=>host.attributes; get children=>host.children; clone( g)=>host.clone(g); get parent=>host.parent; get parentNode=>host.parentNode; get nodeValue=>host.nodeValue;dynamic get on{throw new UnsupportedError('on is deprecated');} get id=>host.id;set id( g){host.id=g;} set innerHtml( g){host.innerHtml=g;} get tagName=>host.tagName; matches( g)=>host.matches(g); query( g)=>host.query(g); queryAll( g)=>host.queryAll(g); get aE=>host.aE;set className( g){host.className=g;} get bE=>host.bE; get eE=>host.eE; cE( g)=>host.cE(g); dE( g)=>host.dE(g); hE( g)=>host.hE(g); iE( g)=>host.iE(g); mE( h, g)=>host.mE(h,g);get YE=>host.YE; get ZE=>host.ZE; get firstChild=>host.firstChild; get localName=>host.localName; get fE=>host.fE; get gE=>host.gE; XE( i, g,[ h]){host.XE(i,g,h);} dispatchEvent( g)=>host.dispatchEvent(g); jE( g)=>host.jE(g); kE( i, g,[ h]){host.kE(i,g,h);} lE( g, h)=>host.lE(g,h);get xtag=>host.xtag;set xtag(g){host.xtag=g;} append( g)=>host.append(g);}const XB=const SF();class EC extends TD<String>{static final QD=new EC.uF(gB.jF.kF);EC.uF( g):super(g); operator==( g)=>value==(g is EC?(g as EC).value:g);}class MD extends ZB{MD():super();set vC( g)=>EB['center']=g;set qE( g)=>EB['disableDefaultUI']=g;set rE( g)=>EB['disableDoubleClickZoom']=g;set CD( g)=>EB['mapTypeId']=g;set zoom( g)=>EB['zoom']=g;set HF( g)=>EB['zoomControl']=g;}class ND extends OD{var NG;var OG;var PG;var QG;var RG;var SG;var TG;var UG;var VG;var WG;var XG;var YG;var ZG;var aG;var bG;var cG;var dG;var eG;var fG;ND( g,[ h]):super(gB.Map,[g,h]){gG();} gG(){NG=t.u(this,"bounds_changed");OG=t.u(this,"center_changed");PG=t.u(this,"click",GB.YB);QG=t.u(this,"dblclick",GB.YB);RG=t.u(this,"drag");SG=t.u(this,"dragend");TG=t.u(this,"dragstart");UG=t.u(this,"heading_changed");VG=t.u(this,"idle");WG=t.u(this,"maptypeid_changed");XG=t.u(this,"mousemove",GB.YB);YG=t.u(this,"mouseout",GB.YB);ZG=t.u(this,"mouseover",GB.YB);aG=t.u(this,"projection_changed");bG=t.u(this,"resize");cG=t.u(this,"rightclick",GB.YB);dG=t.u(this,"tilesloaded");eG=t.u(this,"tilt_changed");fG=t.u(this,"zoom_changed");}set vC( g)=>EB.oF(g);set CD( g)=>EB.pF(g);set zoom( g)=>EB.qF(g);SD get on=>new SD.uF(this);}class GB extends ZB{static  YB( g)=>g==null?null:new GB.tF(g);GB.tF( g):super.yF(g);}class bC extends ZB{bC( g, h,[ i]):super(gB.hF,[g,h,i]); toString()=>EB.toString();}class OD extends ZB{OD([ g, h]):super(g!=null?g:gB.iF,h);Object get( g)=>EB.get(g);}typedef  PD();class FC extends ZB{final  onRelease;FC.tF( g,[this.onRelease]):super.yF(g);}class SF{const SF();}final  t=lC(new RD());class RD extends ZB{RD():super.yF(gB.event); addListener( k, i, j){final g=new TF.vF(j);final  h=EB.addListener(k,i,g);return h==null?null:new FC.tF(h,()=>g.sE());} removeListener( g){if(g.onRelease!=null){g.onRelease();}EB.removeListener(g);} u( sB, IF,[ h]){var i=null;return new q(subscribe:( j){i=addListener(sB,IF,([JB=XB,DC=XB,JF=XB,RB=XB,k=XB]){var g=[JB,DC,JF,RB,k].takeWhile((l)=>l!=XB).toList(growable:false);var o=g.length==0?null:g.length==1?g.first:g;j.add(h==null?o:Function.apply(h,g));});},unsubscribe:( j){removeListener(i);});}}class SD{final  hG;SD.uF(this.hG);}final gB=lC(kC.lF.nF);class TD<GC> implements LB<GC>{var value;TD(this.value); eB()=>value;}typedef cC<KB>( eventSink);class q<KB> implements fB.EventSink<KB>{final  XC;final  YC;final iG=new List<fB.StreamController<KB>>();q({subscribe( eventSink),unsubscribe( eventSink)}):XC=subscribe,YC=unsubscribe; jG( g){iG.add(g);if(iG.length==1&&XC!=null)XC(this);} kG( g){iG.remove(g);if(iG.isEmpty&&YC!=null)YC(this);} get stream{var g;g=new fB.StreamController<KB>(onListen:()=>jG(g),onCancel:()=>kG(g),sync:true);return g.stream;} add( h)=>iG.forEach((g)=>g.add(h)); close()=>iG.forEach((g)=>g.close());}final UD=r"""
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
"""; VD(h){final g=new m.ScriptElement();g.type='text/javascript';g.innerHtml=h;m.document.body.nodes.add(g);}var hB=null;var dC=null;var WD=null;var eC=null;var XD=null;var YD=null;var ZD=null;var aD=null;var fC=null;var gC=null;var hC=null;var bD=null;var iC=null;var jC=null; cD(){if(hB!=null)return;try {hB=m.window.lookupPort('dart-js-interop-context');}catch (h){}if(hB==null){VD(UD);hB=m.window.lookupPort('dart-js-interop-context');}dC=m.window.lookupPort('dart-js-interop-create');WD=m.window.lookupPort('dart-js-interop-proxy-count');eC=m.window.lookupPort('dart-js-interop-equals');XD=m.window.lookupPort('dart-js-interop-instanceof');YD=m.window.lookupPort('dart-js-interop-has-property');ZD=m.window.lookupPort('dart-js-interop-delete-property');aD=m.window.lookupPort('dart-js-interop-convert');fC=m.window.lookupPort('dart-js-interop-enter-scope');gC=m.window.lookupPort('dart-js-interop-exit-scope');hC=m.window.lookupPort('dart-js-interop-globalize');bD=m.window.lookupPort('dart-js-interop-invalidate');iC=new m.ReceivePortSync()..receive((lG)=>HC());jC=new m.ReceivePortSync()..receive((g)=>IC(g[0]));m.window.registerPort('js-dart-interop-enter-scope',iC.toSendPort());m.window.registerPort('js-dart-interop-exit-scope',jC.toSendPort());} get kC{tB();return jB(hB.callSync([] ));}get dD=>CB.mG.length; tB(){if(dD==0){var g=HC();fB.runAsync(()=>IC(g));}}eD(g){var h=HC();try {return g();}finally {IC(h);}} HC(){cD();CB.tE();fC.callSync([] );return CB.mG.length;} IC( g){assert(CB.mG.length==g);gC.callSync([] );CB.uE();} lC( g){hC.callSync(UB(g.eB()));return g;}class TF implements LB<TB>{var nG;var oG;var pG;cD(g){nG=g;oG=CB.add(pG);CB.wE(oG);}qG(){var g=CB.yE(oG);} eB()=>new TB.xF(CB.BC,oG);sE(){assert(nG);qG();}TF.vF( h,{ withThis: false}){pG=( g)=>Function.apply(h,withThis?g:g.skip(1).toList());cD(true);}}class UF{const UF();}const SB=const UF(); fD(i,l,k,j,JB,o){final g=[i,l,k,j,JB,o];final h=g.indexOf(SB);if(h<0)return g;return g.sublist(0,h);}class BB implements LB<BB>{var rG;final oG;factory BB.wF( g, h){tB();final i=([g]..addAll(h)).map(UB).toList();final j=dC.callSync(i);return jB(j);}BB.xF(this.rG,this.oG); eB()=>this;operator[](g)=>iB(this,'[]','method',[g]);operator[]=(h,g)=>iB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is BB&&eC.callSync([UB(this),UB(g)])); toString(){try {return iB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=KF.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return iB(this,g,h,j);}static iB( g, i, k, j){tB();var h=g.rG.callSync([g.oG,i,k,j.map(UB).toList()]);switch (h[0]){case 'return':return jB(h[1]);case 'throws':throw jB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class TB extends BB implements LB<TB>{TB.xF( h,g):super.xF(h,g);call([g=SB,j=SB,i=SB,h=SB,o=SB,k=SB]){var l=fD(g,j,i,h,o,k);return BB.iB(this,'','apply',l);}}abstract class LB<gD>{ eB();}class hD{final  sG;var tG;var uG;final  vG;final  rG;final  wG;final  xG;final  mG;tE(){mG.add(xG.length);}uE(){var h=mG.removeLast();for(int g=h;g<xG.length; ++g){var i=xG[g];if(!wG.contains(i)){vG.remove(xG[g]);uG++ ;}}if(h!=xG.length){xG.removeRange(h,xG.length-h);}}wE(g)=>wG.add(g);yE(g){var h=vG[g];wG.remove(g);vG.remove(g);uG++ ;return h;}hD():sG='dart-ref',tG=0,uG=0,vG={},rG=new m.ReceivePortSync(),xG=new List<String>(),mG=new List<int>(),wG=new Set<String>(){rG.receive((g){try {final h=vG[g[0]];final k=g[1];final j=g[2].map(jB).toList();if(k=='#call'){final l=h as Function;var o=UB(l(j));return ['return',o];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){tB();final g='${sG}-${tG++ }';vG[g]=h;xG.add(g);return g;}Object get( g){return vG[g];}get BC=>rG.toSendPort();}var CB=new hD();UB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}else if(g is m.Element&&(g.document==null||g.document==m.document)){return ['domref',jD(g)];}else if(g is TB){return ['funcref',g.oG,g.rG];}else if(g is BB){return ['objref',g.oG,g.rG];}else if(g is LB){return UB(g.eB());}else{return ['objref',CB.add(g),CB.BC];}}jB(var g){l(g){var h=g[1];var i=g[2];if(i==CB.BC){return CB.get(h);}else{return new TB.xF(i,h);}}k(g){var h=g[1];var i=g[2];if(i==CB.BC){return CB.get(h);}else{return new BB.xF(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is AB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return l(g);case 'objref':return k(g);case 'domref':return kD(g[1]);}throw 'Unsupported serialized data: ${g}';}var iD=0;const uB='data-dart_id';const MB='data-dart_temporary_attached';jD( h){var i;if(h.attributes.containsKey(uB)){i=h.attributes[uB];}else{i='dart-${iD++ }';h.attributes[uB]=i;}if(!identical(h,m.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(MB)){final j=g.attributes[MB];final k=j+'a';g.attributes[MB]=k;break;}if(g.parent==null){g.attributes[MB]='a';m.document.documentElement.children.add(g);break;}if(identical(g.parent,m.document.documentElement)){break;}g=g.parent;}}return i;} kD(var i){var j=m.queryAll('[${uB}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,m.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(MB)){final k=g.attributes[MB];final l=k.substring(1);g.attributes[MB]=l;if(g.attributes[MB].length==0){g.attributes.remove(MB);g.remove();}break;}if(identical(g.parent,m.document.documentElement)){break;}g=g.parent;}}return h;}class ZB implements LB<BB>{final  EB;ZB([ g, h]):this.yF(new BB.wF(g!=null?g:kC.Object,h!=null?h:[] ));ZB.yF(this.EB); eB()=>EB;}var JC=false;var lD=v.mC;class OB{final  name; get zC=>(parent==null||parent.name=='')?name:'${parent.zC}.${name}';final  parent;var yG;var children;var zG;var AH;factory OB( g){if(g.startsWith('.')){throw new ArgumentError("name shouldn't start with a '.'");}if(kB==null)kB=<String,OB>{};if(kB.containsKey(g))return kB[g];var j=g.lastIndexOf('.');var h=null;var i;if(j==-1){if(g!='')h=new OB('');i=g;}else{h=new OB(g.substring(0,j));i=g.substring(j+1);}final k=new OB.zF(i,h);kB[g]=k;return k;}OB.zF(this.name,this.parent):children=new Map<String,OB>(){if(parent!=null)parent.children[name]=this;} get rB{if(JC){if(yG!=null)return yG;if(parent!=null)return parent.rB;}return lD;} get CF=>BH(); zE( g)=>(g>=rB); log( i, k,[j]){if(zE(i)){var h=new lB(i,k,zC,j);if(JC){var g=this;while (g!=null){g.CH(h);g=g.parent;}}else{KC.CH(h);}}} info( h,[g])=>log(v.mC,h,g); GD( h,[g])=>log(v.mD,h,g); BH(){if(JC||parent==null){if(zG==null){zG=new fB.StreamController<lB>.broadcast(sync:true);AH=zG.stream;}return AH;}else{return KC.BH();}} CH( g){if(zG!=null){zG.add(g);}}static  get KC=>new OB('');static var kB;}class v implements Comparable<v>{final  name;final  value;const v(this.name,this.value);static const  mC=const v('INFO',800);static const  mD=const v('WARNING',900); operator==( g)=>g!=null&&value==g.value; operator<( g)=>value<g.value; operator<=( g)=>value<=g.value; operator>( g)=>value>g.value; operator>=( g)=>value>=g.value; compareTo( g)=>value-g.value; get hashCode=>value; toString()=>name;}class lB{final  rB;final  message;final  AF;final  time;final  FF;static var nD=0;var exception;lB(this.rB,this.message,this.AF,[this.exception]):time=new DateTime.now(),FF=lB.nD++ ;}const VF=const WF();class WF{const WF();}const XF=const YF();class YF{const YF();}typedef  NB( e);typedef  oD( changes);typedef  PB();typedef  pD();class vB{final oldValue;final newValue;final  changes;vB(this.oldValue,this.newValue,[this.changes]); operator==(g){return g is vB&&oldValue==g.oldValue&&newValue==g.newValue&&changes==g.changes;} get hashCode=>FE(oldValue,newValue,changes); toString(){if(changes!=null)return '#<ChangeNotification to ${newValue}: ${changes}>';return '#<ChangeNotification from ${oldValue} to ${newValue}>';}}class QB{static const LC=1;static const MC=2;static const nC=MC|4;static const oC=MC|8;final  type;final key;final oldValue;final newValue;QB(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is QB&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>GE(type,key,oldValue,newValue); toString(){var g;switch (type){case LC:g='field';break;case MC:g='index';break;case nC:g='insert';break;case oC:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}} qD(g, i,[ k]){if(g is DB){var h=g;return NC(h,(l){i(new vB(h,h,l));});}var j=new wB(g,i,k);if(!j.DH()){return wD;}return j.EH;} NC( g, i){if(g.cB==null)g.cB=new OC();var h=g.cB.add(i);return h.remove;}class DB{var cB;var bB;final  hashCode= ++DB.rD;static var rD=0;} sD( g)=>g.cB!=null&&g.cB.head!=null; get tD=>aB!=null; uD( g, h,i)=>aB.FH(g,h,i); vD( g, j,k, h, i){if((j&(QB.nC|QB.oC))==0){if(h==i)return;}if(VB==null){VB=[] ;HE(xD);}if(g.bB==null){g.bB=[] ;VB.add(g);}g.bB.add(new QB(j,k,h,i));} wD(){}var aB;var pC=100;var VB;var WB; xD(){var l=0;while (VB!=null||WB!=null){var j=VB;VB=null;var i=WB;WB=null;if(l++ ==pC){yD(j,i);return;}if(j!=null){for(var h in j){var JB=h.bB;h.bB=null;for(var g=h.cB.head;g!=null;g=g.next){var k=g.value;try {k(JB);}catch (RB,o){mB(RB,o,k,'from ${h}');}}}}if(i!=null){i.forEach((DC,sB){sB.GH();});}}} yD( k, j){var g=[] ;if(k!=null){for(var i in k){var JB=i.bB;g.add('${i} ${JB}');}}if(j!=null){for(var l in j.values){var h=l.GH();if(h!=null)g.add('${l} ${h}');}}VB=null;WB=null;var o='exceeded notifiction limit of ${pC}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';BE(o);}class wB{static var zD=0;final  HH= ++wB.zD;final  IH;final  JH;final  KH;final  LH=new Map();final  MH=[] ;var NH=false;var OH;wB(this.IH,this.JH,this.KH); toString()=>KH!=null?'<observer ${HH}: ${KH}>':'<observer ${HH}>'; DH(){var h=aB;aB=this;try {OH=IH();if(OH is Iterable&&OH is !List&&OH is !DB){OH=(OH as Iterable).toList();}}catch (g,i){mB(g,i,IH,'from ${this}');OH=null;}LH.forEach(PH);LH.clear();assert(aB==this);aB=h;QH();return MH.length>0;} RH( i){try {JH(i);}catch (g,h){mB(g,h,JH,'from ${this}');}} QH(){var g=OH;if(g is !DB)return;MH.add(NC(g,(h){RH(new vB(g,g,h));}));} FH( l, o,g){var i=LH.putIfAbsent(l,()=>new Map());try {var h=i[g];if(h==null)h=0;i[g]=h|o;}catch (j,k){mB(j,k,g,'hashCode or operator == from ${this}');}} PH( i, j){MH.add(NC(i,(k){if(NH)return;for(var g in k){var h=j[g.key];if(h!=null&&(h&g.type)!=0){NH=true;if(WB==null){WB=new ZC.SplayTreeMap();}WB[HH]=this;return;}}}));} EH(){for(var g in MH){g();}NH=false;} GH(){if(!NH)return null;var g=OH;EH();DH();try {if(g==OH)return null;}catch (i,j){mB(i,j,g,'operator == from ${this}');return null;}var h=new vB(g,OH);RH(h);return h;}}typedef  AE( message);var BE=(g)=>print(g);typedef  CE(error,stackTrace,obj, message);var mB=DE; DE(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class EE{}class HB<IB>{var SH;var TH;var UH;var VH;HB.AG( g,this.UH):VH=g{if(UH!=null)UH.WH++ ;} get next=>TH; get value=>VH;set value( g)=>VH=g; XH( g, h){TH=h;SH=g;if(g!=null)g.TH=this;if(h!=null)h.SH=this;return this;} append( g)=>new HB<IB>.AG(g,UH).XH(this,TH); remove(){if(UH==null)return;UH.WH-- ;if(SH!=null){SH.TH=TH;}else{UH.YH=TH;}if(TH!=null){TH.SH=SH;}else{UH.ZH=SH;}TH=null;SH=null;UH=null;}}class OC<IB> extends ZC.IterableBase<IB>{var YH;var ZH; get length=>WH;var WH=0;OC(){} get head=>YH; add( h){var g=new HB<IB>.AG(h,this);if(ZH==null)return YH=ZH=g;return ZH=g.XH(ZH,null);} addLast( g)=>add(g); addAll( g)=>g.forEach(add); get iterator=>new ZF<IB>(this);}class ZF<IB> implements Iterator<IB>{var aH;var UH;var bH;var cH=-1;ZF(this.UH){aH=new List<HB>(UH.length);var h=0;var g=UH.head;while (g!=null){aH[h++ ]=g;g=g.next;}} get current=>bH; moveNext(){do{cH++ ;}while(cH<aH.length&&aH[cH].UH!=UH);if(cH<aH.length){bH=aH[cH].value;return true;}else{bH=null;return false;}}}nB(h,g)=>h.hashCode*31+g.hashCode;FE(h,g,i)=>nB(nB(h,g),i);GE(g,i,h,j)=>nB(nB(g,i),nB(h,j)); HE( h()){var g=new AB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);} IE(g){if(g is EE)return g.toString();g=g.toString();return KE(g)?g:'#';}const JE=const["http","https","ftp","mailto"]; KE( h){var g=Uri.parse(h).scheme;if(g=='')return true;return JE.contains(g.toLowerCase())||"MAILTO"==g.toUpperCase();}abstract class xB{ qB(){} insert(); remove();}abstract class LE extends xB{final exp;final  isFinal;final  xC;var CC;LE(this.exp,this.isFinal):xC=PC&&yB!=null?yB():null; insert(){if(isFinal){AD();}else if(CC!=null){throw new StateError('binding already attached');}else{CC=DD();}} remove(){if(!isFinal){CC();CC=null;}} AD(); DD();}class aF extends LE{final  FD;final  BD;aF( g,this.FD,this.BD, h):super(g,h); dH(g){FD(BD?IE(g):g);} AD()=>dH(exp()); DD()=>PE(exp,(g)=>dH(g.newValue),'dom-property-binding',xC);}class bF extends xB{final dB;bF(this.dB); qB(){dB..pE()..wC()..oE();} insert(){dB..WC()..xE();} remove(){dB..EF()..ED();}}class ME extends xB{final  BF;final  children=[] ;final  nodes=[] ;ME(this.BF); DF(g,j,h,[i=false]){children.add(new aF(g,j,i,h));} dB( g){children.add(new bF(g));} add( g)=>nodes.add(g); addAll( g)=>nodes.addAll(g); qB(){for(var g=0,h=children.length;g<h;g++ ){children[g].qB();}} insert(){for(var g=0,h=children.length;g<h;g++ ){children[g].insert();}} remove(){for(var g=children.length-1;g>=0;g-- ){children[g].remove();}children.clear();}}var qC=false;var PC=false;var yB=(){try {throw "";}catch (h,g){return g.toString();}};final  zB=new OB('watcher'); NE(g, o,[ j, l]){if(qC)return qD(g,o);if(o==null)return (){};if(QC==null)QC=new OC<oB>();j=j==null?'<unnamed>':j;var i;var h=FB.TE;if(g is sC){i=(g as sC).eH;}else if(g is Function){i=g;try {var k=g();if(k is List){h=FB.pB;}else if(k is Iterable){h=FB.pB;i=()=>g().toList();}else if((k is ZC.LinkedHashMap)||(k is ZC.SplayTreeMap)){h=FB.SC;}else if(k is Map){h=FB.RC;}}catch (JB,sB){zB.GD('evaluating ${j} watcher threw error (${JB}, ${sB})');}}else if(g is List){i=()=>g;h=FB.pB;}else if(g is Iterable){i=()=>g.toList();h=FB.pB;}else if((g is ZC.LinkedHashMap)||(g is ZC.SplayTreeMap)){i=()=>g;h=FB.SC;}else if(g is Map){i=()=>g;h=FB.RC;}if(PC&&l==null&&yB!=null){l=yB();}var DC=OE(h,i,o,j,l);var RB=QC.add(DC);return RB.remove;} OE( k, g, j, h, i){switch (k){case FB.pB:return new cF(g,j,h,i);case FB.SC:return new gF(g,j,h,i);case FB.RC:return new dF(g,j,h,i);default:return new oB(g,j,h,i);}} PE(h, i,[ j, k]){var l=NE(h,i,j,k);var g=h;if(g is Function){g=g();}if(g is Iterable&&g is !List){g=g.toList();}i(new vB(null,g));return l;}var QC;class oB{final  debugName;var location;final  fH;static var QE=0;final  eH;final  gH;var hH;oB(this.eH,this.gH,this.debugName,this.location):fH=QE++ {hH=eH();} toString()=>'${debugName} (id: #${fH})'; iH(g){if(PC){if(location!=null){zB.info('watcher updated: ${this}, defined at:\n${location}');location=null;}else{zB.info('watcher updated: ${this}');}}hH=g;}jH(){try {return eH();}catch (g,h){zB.GD('${this} watcher threw an exception: ${g}, ${h}');}return hH;}}typedef  rC<RE>();typedef  SE<RE>( value);class sC<RE>{}class cF<RE> extends oB{cF(g, j, h, i):super(g,j,h,i){iH(jH());} iH(g){hH=new List<RE>.from(g);}}class dF<eF,fF> extends oB{dF(g, j, h, i):super(g,j,h,i){iH(jH());} iH(g){hH=new Map<eF,fF>.from(g);}}class gF<eF,fF> extends oB{gF(g, j, h, i):super(g,j,h,i){iH(jH());} iH(g){hH=new ZC.LinkedHashMap.from(g);}}class FB{final kH;const FB.BG(this.kH);toString()=>'Enum.${kH}';static const pB=const FB.BG('LIST');static const RC=const FB.BG('HASH_MAP');static const SC=const FB.BG('ORDERED_MAP');static const TE=const FB.BG('OTHER');}abstract class tC extends LD{var lH;var mH;var nH={};var oH=new VC({}); vE( g)=>oH; GF( h,var g){oH=g;} get host{if(lH==null)throw new StateError('host element has not been set.');return lH;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(lH!=null){throw new StateError('host can only be set once.');}g.xtag=this;lH=g;}createShadowRoot([ g]){var h=pH();if(g!=null){nH[g]=h;}return h;}pH(){if(uC){return host.createShadowRoot();}if(mH==null)mH=[] ;mH.add(new m.DivElement());return mH.last;} wC(){} WC(){} ED(){} oE(){if(uC)return;if(mH.length==0){throw new StateError('Distribution algorithm requires at least one shadow' ' root and can only be run once.');}var j=mH;var g=j.removeLast();var o=g;var l=new List.from(nodes);var k=[] ;var JB=[] ;while (true){l=qH(g,l);var h=g.query('shadow');if(h!=null){if(j.length>0){g=j.removeLast();k.add(h);JB.add(g);}else{UC(h,l);break;}}else{break;}}for(int i=0;i<k.length;i++ ){var h=k[i];var g=JB[i];UC(h,g.nodes);}nodes.clear();nodes.addAll(o.nodes);for(var RB in nH.keys){if(nH[RB]==o){nH[RB]=this;break;}}} qH( o, j){for(var g in o.queryAll('content')){if(!VE(g))continue;var i=g.attributes['select'];if(i==null||i=='')i='*';var h=[] ;var l=[] ;for(var k in j){(UE(k,i)?h:l).add(k);}if(h.length==0){h=g.nodes;}UC(g,h);j=l;}return j;}static  UE( h, g){if(h is !m.Element)return g=='*';return (h as m.Element).matches(g);}static  TC( g)=>g.tagName=='CONTENT'||g.tagName=='SHADOW';static  VE( g){assert(TC(g));for(g=g.parent;g!=null;g=g.parent){if(TC(g))return false;}return true;}static  UC( g, h){assert(TC(g));g.parent.insertAllBefore(h,g);g.remove();}}class VC{final  rH;VC(this.rH); operator[]( g)=>rH[g];}var WE=false; get uC=>WE&&m.ShadowRoot.supported;