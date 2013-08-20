import "dart:collection" as TC;import "dart:mirrors" as jF;import "dart:isolate" as EB;import "dart:json" as HC;import "dart:html" as o;import "dart:async" as YB;class kF{static const  lF="Chrome";static const  mF="Firefox";static const  nF="Internet Explorer";static const  oF="Safari";final  UF;final  minimumVersion;const kF(this.UF,[this.minimumVersion]);}class pF{const pF();}class qF{final  name;const qF(this.name);}class rF{const rF();}class sF{const sF();}class tF extends UD with BB{var TG;static final eD=new o.DocumentFragment.html('''
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
      ''');var UG; XF(){var VG=createShadowRoot("x-navbar");hF("x-navbar",new nC({"x-navbar":"[is=\"x-navbar\"]"}));TG=aF("x-navbar");UG=new fC(VG);VG.nodes.add(eD.clone(true));UG.fB();} bF(){UG.insert();} fF(){UG.remove();UG=null;}var WG=''; get PC{if(v){FB(this,l.u,'activeid');}return WG;}set PC( g){if(LB(this)){t(this,l.u,'activeid',WG,g);}WG=g;}pC(){o.query('#${PC}').className="active";}}const vC='/dry/service-rules-usage';const fD='8888';const UC='Rules / PMT';var wC;var xC;var pB=LC(new List<String>());var yC=LC(new List<String>());var qB=LC(new List<String>());var gB=LC(new List<String>());final VC=new BB();var WC='CTCS2X/315'; get hB{if(v){FB(VC,l.u,'selectedFormat');}return WC;}set hB( g){if(LB(VC)){t(VC,l.u,'selectedFormat',WC,g);}WC=g;}var ZB='b2bowner@stg';var aB='315';var iB='Exception';gD(){hD();} rB(){return o.window.location.protocol+'//'+o.window.location.hostname+':${wC}${xC}';} hD(){wC=o.window.location.port=='3030'?fD:o.window.location.port;xC=o.window.location.port=='3030'?vC:'/dry'+vC;iD();} iD(){var g=rB()+'?opt=datasources';var i=o.HttpRequest.getString(g).then((h){yC.addAll(HC.parse(h));zC();});} zC(){var g=rB()+'?opt=formats&ds=${ZB}';var i=o.HttpRequest.getString(g).then((h){pB.clear();pB.addAll(HC.parse(h));if(!pB.contains(hB))hB=pB.first;AD();});} AD(){var g=rB()+'?opt=convTypes&ds=${ZB}&fmt=${hB}';var i=o.HttpRequest.getString(g).then((h){qB.clear();qB.addAll(HC.parse(h));if(!qB.contains(aB))aB=qB.first;BD();});} BD(){var g=rB()+'?opt=segments&ds=${ZB}&fmt=${hB}&cvt=${aB}';var i=o.HttpRequest.getString(g).then((h){gB.clear();gB.addAll(HC.parse(h));gB.add('*');if(!gB.contains(iB))iB=gB.first;CD();});} CD(){var k=rB()+'?opt=matrix&ds=${ZB}&fmt=${hB}&cvt=${aB}&segid=${iB}';var q=o.HttpRequest.getString(k).then((m){var g=HC.parse(m);var j=new mD("matrix",['fancyTable']);var h=new List();h.add(UC);h.addAll(g['tpIds']);j.TF(h);j.SF(h,g['keys'],g['sequences'],g['paths']);var i=o.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();nD(j,i);lD("#matrix",g['paths'].length);});} jD(){zC();} kD(){AD();} lD( i, g){var h=(g+1)*50>750?750:(g+1)*40;CE((){var j=DE({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});AE.KG(i).JG(j);});}class mD extends DD{var ZG;mD( h, g){ZG=new o.Element.tag("table");ZG.id=h;ZG.classes=g;} TF( q,[ k, j]){var i=new o.Element.tag('thead');var g=new o.Element.tr();if(k!=null)g.classes=k;i.nodes.add(g);q.forEach((m){var h=new o.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});ZG.nodes.add(i);} SF( GC, iF, TB, SC){var j=new o.Element.tag('tbody');var i=0;iF.forEach((q){var m=new o.Element.tr();j.nodes.add(m);GC.forEach((k){var DB=q+"-"+k;var g=' ';if(k!=UC){if(TB.containsKey(DB))g='<span class="label label-info">'+TB[DB]+'</span>';}else if(i==0){g=UC;}else{g=SC[q];}var h=new o.Element.td();if(g.contains("span")){h.attributes={"align":"center"};h.nodes.add(new o.Element.html(g));}else h.text=g;m.nodes.add(h);});i++ ;});ZG.nodes.add(j);} get elements{var g=new List();g.add(ZG);return g;}}abstract class DD{var elements;} nD( h,[ g]){if(g==null){g=o.document.body;}g.nodes.addAll(h.elements);} oD(){var aG=o.document.body;final bG=new o.OptionElement(),cG=new o.OptionElement(),dG=new o.OptionElement(),eG=new o.OptionElement();var fG,gG,hG,iG,jG;var kG=new fC(aG);fG=aG.nodes[3];kG.SB(()=>'t-rbase',(g){if(fG.xtag.PC!=g)fG.xtag.PC=g;},false,false);kG.oB(new tF()..host=fG);hG=aG.nodes[5].nodes[3].nodes[1].nodes[1];kG.listen(hG.onChange,(j){ZB=hG.value;});kG.listen(hG.onChange,(j){jD();});kG.SB(()=>ZB,(g){if(hG.value!=g)hG.value=g;},false,false);kG.RC(hG,()=>yC,(i,h,kG){var q=i[h];var lG;lG=bG.clone(true);var mG=kG.QC(()=>q,false);lG.nodes.add(mG);kG.SB(()=>ZB==q,(g){if(lG.selected!=g)lG.selected=g;},false,false);kG.addAll([new o.Text('\n            '),lG,new o.Text('\n          ')]);});iG=aG.nodes[5].nodes[3].nodes[3].nodes[1];kG.listen(iG.onChange,(j){hB=iG.value;});kG.listen(iG.onChange,(j){kD();});kG.SB(()=>hB,(g){if(iG.value!=g)iG.value=g;},false,false);kG.RC(iG,()=>pB,(i,h,kG){var DB=i[h];var nG;nG=cG.clone(true);var oG=kG.QC(()=>DB,false);nG.nodes.add(oG);kG.SB(()=>hB==DB,(g){if(nG.selected!=g)nG.selected=g;},false,false);kG.addAll([new o.Text('\n            '),nG,new o.Text('\n          ')]);});jG=aG.nodes[5].nodes[3].nodes[5].nodes[1];kG.listen(jG.onChange,(j){aB=jG.value;});kG.listen(jG.onChange,(j){BD();});kG.SB(()=>aB,(g){if(jG.value!=g)jG.value=g;},false,false);kG.RC(jG,()=>qB,(i,h,kG){var k=i[h];var pG;pG=dG.clone(true);var qG=kG.QC(()=>k,false);pG.nodes.add(qG);kG.SB(()=>aB==k,(g){if(pG.selected!=g)pG.selected=g;},false,false);kG.addAll([new o.Text('\n            '),pG,new o.Text('\n          ')]);});gG=aG.nodes[5].nodes[3].nodes[7].nodes[1];kG.listen(gG.onChange,(j){iB=gG.value;});kG.listen(gG.onChange,(j){CD();});kG.SB(()=>iB,(g){if(gG.value!=g)gG.value=g;},false,false);kG.RC(gG,()=>gB,(i,h,kG){var m=i[h];var rG;rG=eG.clone(true);var sG=kG.QC(()=>m,false);rG.nodes.add(sG);kG.SB(()=>iB==m,(g){if(rG.selected!=g)rG.selected=g;},false,false);kG.addAll([new o.Text('\n            '),rG,new o.Text('\n          ')]);});kG.fB();kG.insert();}main(){QD=true;UB.cC.eF.listen((g){print('${g.FC.name.toLowerCase()}: ${g.message}');});gD();oD();}class pD implements o.Element{var tG;var uG;var vG={}; get host{if(tG==null)throw new StateError('host element has not been set.');return tG;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(tG!=null){throw new StateError('host can only be set once.');}g.xtag=this;tG=g;}createShadowRoot([ g]){var h=host.createShadowRoot();if(g!=null){vG[g]=h;}return h;} WD(){} pC(){} bD(){} get nodes=>host.nodes; replaceWith( g){host.replaceWith(g);} remove()=>host.remove(); get document=>host.document;set text( g){host.text=g;} contains( g)=>host.contains(g); hasChildNodes()=>host.hasChildNodes(); insertBefore( g, h)=>host.insertBefore(g,h); insertAllBefore( g, h)=>host.insertAllBefore(g,h); get attributes=>host.attributes;set attributes( g){host.attributes=g;} get elements=>host.children; get children=>host.children; get classes=>host.classes;set classes( g){host.classes=g;} clone( g)=>host.clone(g); get parent=>host.parent; get parentNode=>host.parentNode; get nodeValue=>host.nodeValue;dynamic get on{throw new UnsupportedError('on is deprecated');} get id=>host.id;set id( g){host.id=g;} set innerHtml( g){host.innerHtml=g;} get tagName=>host.tagName; matches( g)=>host.matches(g); matchesWithAncestors( g)=>host.matchesWithAncestors(g); query( g)=>host.query(g); queryAll( g)=>host.queryAll(g); get FF=>host.FF; get className=>host.className;set className( g){host.className=g;} get GF=>host.GF; get JF=>host.JF; HF( g)=>host.HF(g); IF( g)=>host.IF(g); MF( g)=>host.MF(g); NF( g)=>host.NF(g); RF( h, g)=>host.RF(h,g);get DF=>host.DF; get EF=>host.EF; get firstChild=>host.firstChild; get localName=>host.localName; get KF=>host.KF; get LF=>host.LF; CF( i, g,[ h]){host.CF(i,g,h);} dispatchEvent( g)=>host.dispatchEvent(g); OF( g)=>host.OF(g); PF( i, g,[ h]){host.PF(i,g,h);} QF( g, h)=>host.QF(g,h);get xtag=>host.xtag;set xtag(g){host.xtag=g;} append( g)=>host.append(g); get onChange=>host.onChange; get onError=>host.onError; get onLoad=>host.onLoad;}final qD=r"""
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
"""; rD(h){final g=new o.ScriptElement();g.type='text/javascript';g.innerHtml=h;o.document.body.nodes.add(g);}var sB=null;var sD=null;var tD=null;var ED=null;var uD=null;var vD=null;var wD=null;var FD=null;var GD=null;var HD=null;var xD=null;var yD=null;var ID=null;var JD=null; zD(){if(sB!=null)return;try {sB=o.window.lookupPort('dart-js-interop-context');}catch (h){}if(sB==null){rD(qD);sB=o.window.lookupPort('dart-js-interop-context');}sD=o.window.lookupPort('dart-js-interop-create');tD=o.window.lookupPort('dart-js-interop-proxy-count');ED=o.window.lookupPort('dart-js-interop-equals');uD=o.window.lookupPort('dart-js-interop-instanceof');vD=o.window.lookupPort('dart-js-interop-has-property');wD=o.window.lookupPort('dart-js-interop-delete-property');FD=o.window.lookupPort('dart-js-interop-convert');GD=o.window.lookupPort('dart-js-interop-enter-scope');HD=o.window.lookupPort('dart-js-interop-exit-scope');xD=o.window.lookupPort('dart-js-interop-globalize');yD=o.window.lookupPort('dart-js-interop-invalidate');ID=new o.ReceivePortSync()..receive((wG)=>XC());JD=new o.ReceivePortSync()..receive((g)=>YC(g[0]));o.window.registerPort('js-dart-interop-enter-scope',ID.toSendPort());o.window.registerPort('js-dart-interop-exit-scope',JD.toSendPort());} get AE{IC();return uB(sB.callSync([] ));}get BE=>NB.xG.length; IC(){if(BE==0){var g=XC();YB.runAsync(()=>YC(g));}}CE(g){var h=XC();try {return g();}finally {YC(h);}} XC(){zD();NB.YF();GD.callSync([] );return NB.xG.length;} YC( g){assert(NB.xG.length==g);HD.callSync([] );NB.ZF();} DE( g)=>new QB.LG(g);class uF{const uF();}const bB=const uF(); EE(i,m,k,j,DB,q){final g=[i,m,k,j,DB,q];final h=g.indexOf(bB);if(h<0)return g;return g.sublist(0,h);}class QB implements aC<QB>{var yG;final zG;factory QB.LG(g){IC();return FE(g);}static FE(g){return uB(FD.callSync(ZC(g)));}static ZC(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,ZC(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(ZC).toList()];}else{return ['simple',jB(g)];}}QB.MG(this.yG,this.zG); dD()=>this;operator[](g)=>tB(this,'[]','method',[g]);operator[]=(h,g)=>tB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is QB&&ED.callSync([jB(this),jB(g)])); toString(){try {return tB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=jF.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return tB(this,g,h,j);}static tB( g, i, k, j){IC();var h=g.yG.callSync([g.zG,i,k,j.map(jB).toList()]);switch (h[0]){case 'return':return uB(h[1]);case 'throws':throw uB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class KD extends QB implements aC<KD>{KD.MG( h,g):super.MG(h,g);call([g=bB,j=bB,i=bB,h=bB,q=bB,k=bB]){var m=EE(g,j,i,h,q,k);return QB.tB(this,'','apply',m);}}abstract class aC<GE>{ dD();}class HE{final  AH;var BH;var CH;final  DH;final  yG;final  EH;final  FH;final  xG;YF(){xG.add(FH.length);}ZF(){var h=xG.removeLast();for(int g=h;g<FH.length; ++g){var i=FH[g];if(!EH.contains(i)){DH.remove(FH[g]);CH++ ;}}if(h!=FH.length){FH.removeRange(h,FH.length-h);}}HE():AH='dart-ref',BH=0,CH=0,DH={},yG=new o.ReceivePortSync(),FH=new List<String>(),xG=new List<int>(),EH=new Set<String>(){yG.receive((g){try {final h=DH[g[0]];final k=g[1];final j=g[2].map(uB).toList();if(k=='#call'){final m=h as Function;var q=jB(m(j));return ['return',q];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){IC();final g='${AH}-${BH++ }';DH[g]=h;FH.add(g);return g;}Object get( g){return DH[g];}get tC=>yG.toSendPort();}var NB=new HE();jB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is EB.SendPortSync){return g;}else if(g is o.Element&&(g.document==null||g.document==o.document)){return ['domref',JE(g)];}else if(g is KD){return ['funcref',g.zG,g.yG];}else if(g is QB){return ['objref',g.zG,g.yG];}else if(g is aC){return jB(g.dD());}else{return ['objref',NB.add(g),NB.tC];}}uB(var g){m(g){var h=g[1];var i=g[2];if(i==NB.tC){return NB.get(h);}else{return new KD.MG(i,h);}}k(g){var h=g[1];var i=g[2];if(i==NB.tC){return NB.get(h);}else{return new QB.MG(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is EB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return k(g);case 'domref':return KE(g[1]);}throw 'Unsupported serialized data: ${g}';}var IE=0;const JC='data-dart_id';const RB='data-dart_temporary_attached';JE( h){var i;if(h.attributes.containsKey(JC)){i=h.attributes[JC];}else{i='dart-${IE++ }';h.attributes[JC]=i;}if(!identical(h,o.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(RB)){final j=g.attributes[RB];final k=j+'a';g.attributes[RB]=k;break;}if(g.parent==null){g.attributes[RB]='a';o.document.documentElement.children.add(g);break;}if(identical(g.parent,o.document.documentElement)){break;}g=g.parent;}}return i;} KE(var i){var j=o.queryAll('[${JC}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,o.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(RB)){final k=g.attributes[RB];final m=k.substring(1);g.attributes[RB]=m;if(g.attributes[RB].length==0){g.attributes.remove(RB);g.remove();}break;}if(identical(g.parent,o.document.documentElement)){break;}g=g.parent;}}return h;}var bC=false;var LE=AB.LD;class UB{final  name; get YD=>(parent==null||parent.name=='')?name:'${parent.YD}.${name}';final  parent;var GH;var children;var HH;var IH;factory UB( g){if(g.startsWith('.')){throw new ArgumentError("name shouldn't start with a '.'");}if(vB==null)vB=<String,UB>{};if(vB.containsKey(g))return vB[g];var j=g.lastIndexOf('.');var h=null;var i;if(j==-1){if(g!='')h=new UB('');i=g;}else{h=new UB(g.substring(0,j));i=g.substring(j+1);}final k=new UB.NG(i,h);vB[g]=k;return k;}UB.NG(this.name,this.parent):children=new Map<String,UB>(){if(parent!=null)parent.children[name]=this;} get FC{if(bC){if(GH!=null)return GH;if(parent!=null)return parent.FC;}return LE;} get eF=>JH(); cF( g)=>(g>=FC); log( i, k,[j]){if(cF(i)){var h=new wB(i,k,YD,j);if(bC){var g=this;while (g!=null){g.KH(h);g=g.parent;}}else{cC.KH(h);}}} info( h,[g])=>log(AB.LD,h,g); uC( h,[g])=>log(AB.ME,h,g); JH(){if(bC||parent==null){if(HH==null){HH=new YB.StreamController<wB>.broadcast(sync:true);IH=HH.stream;}return IH;}else{return cC.JH();}} KH( g){if(HH!=null){HH.add(g);}}static  get cC=>new UB('');static var vB;}class AB implements Comparable<AB>{final  name;final  value;const AB(this.name,this.value);static const  LD=const AB('INFO',800);static const  ME=const AB('WARNING',900); operator==( g)=>g!=null&&value==g.value; operator<( g)=>value<g.value; operator<=( g)=>value<=g.value; operator>( g)=>value>g.value; operator>=( g)=>value>=g.value; compareTo( g)=>value-g.value; get hashCode=>value; toString()=>name;}class wB{final  FC;final  message;final  dF;final  time;final  gF;static var NE=0;var exception;wB(this.FC,this.message,this.dF,[this.exception]):time=new DateTime.now(),gF=wB.NE++ ;}const vF=const wF();class wF{const wF();}class OE<VB> extends lE with BB implements List<VB>{final  LH;OE([ g]):LH=g!=null?new List<VB>(g):<VB>[] ;factory OE.OG( g)=>new OE<VB>()..addAll(g); get length{if(v)FB(this,l.u,'length');return LH.length;}set length( h){var i=LH.length;if(i==h)return;if(LB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){t(this,l.WB,g,LH[g],null);}t(this,l.u,'length',i,h);}else{t(this,l.u,'length',i,h);for(int g=i;g<h;g++ ){t(this,l.cB,g,null,null);}}}LH.length=h;} operator[]( g){if(v)FB(this,l.KB,g);return LH[g];}operator[]=( g, h){var i=LH[g];if(LB(this)){t(this,l.KB,g,i,h);}LH[g]=h;} sublist( h,[ g])=>new OE<VB>.OG(super.sublist(h,g)); add( h){var g=LH.length;if(LB(this)){t(this,l.u,'length',g,g+1);t(this,l.cB,g,null,h);}LH.add(h);} removeRange( h, g){if(g==0)return;OD.jE(this,h,g);if(LB(this)){for(int i=h;i<g;i++ ){t(this,l.WB,i,this[i],null);}}OD.iE(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(v){for(int g=0;g<length;g++ ){FB(this,l.KB,g);}}return LH.toString();}}typedef  xB<GB,CB>();class kB<GB,CB> extends BB implements Map<GB,CB>{final  MH;var NH;var OH;kB({ createMap}):MH=createMap!=null?createMap():new Map<GB,CB>(){NH=new PE<GB,CB>(this);OH=new QE<GB,CB>(this);}factory kB.PG( i,{ createMap}){var g=new kB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>NH; get values=>OH; get length{if(v)FB(this,l.u,'length');return MH.length;} get isEmpty=>length==0; get isNotEmpty=>length!=0; PH( g)=>FB(this,l.KB,g); QH(){FB(this,l.u,'length');MH.keys.forEach(PH);} containsKey( g){if(v)PH(g);return MH.containsKey(g);} operator[]( g){if(v)PH(g);return MH[g];} operator[]=( h, g){var j=MH.length;var i=MH[h];MH[h]=g;if(LB(this)){if(j!=MH.length){t(this,l.u,'length',j,MH.length);t(this,l.cB,h,i,g);}else if(i!=g){t(this,l.KB,h,i,g);}}} putIfAbsent( g, j()){if(v)PH(g);var h=MH.length;var i=MH.putIfAbsent(g,j);if(LB(this)&&h!=MH.length){t(this,l.u,'length',h,MH.length);t(this,l.cB,g,null,i);}return i;} remove( g){if(v)PH(g);var h=MH.length;var i=MH.remove(g);if(LB(this)&&h!=MH.length){t(this,l.WB,g,i,null);t(this,l.u,'length',h,MH.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=MH.length;if(LB(this)&&g>0){MH.forEach((i,h){t(this,l.WB,i,h,null);});t(this,l.u,'length',g,0);}MH.clear();} forEach( g( key, value)){if(v)QH();MH.forEach(g);} toString()=>TC.Maps.mapToString(this);}class PE<GB,CB> extends TC.IterableBase<GB>{final  MH;PE(this.MH); get iterator=>new xF<GB,CB>(MH);}class xF<GB,CB> implements Iterator<GB>{final  MH;final  NH;var RH=false;xF( g):MH=g,NH=g.MH.keys.iterator; moveNext(){if(v)FB(MH,l.u,'length');return RH=NH.moveNext();} get current{var g=NH.current;if(v&&RH)MH.PH(g);return g;}}class QE<GB,CB> extends TC.IterableBase<CB>{final  MH;QE(this.MH); get iterator=>new yF<GB,CB>(MH);}class yF<GB,CB> implements Iterator<CB>{final  MH;final  NH;final  OH;var RH;yF( g):MH=g,NH=g.MH.keys.iterator,OH=g.MH.values.iterator; moveNext(){if(v)FB(MH,l.u,'length');var h=NH.moveNext();var g=OH.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return RH=g;} get current{if(v&&RH)MH.PH(NH.current);return OH.current;}}typedef  OB( e);typedef  RE( changes);typedef  PB();typedef  SE();class KC{final oldValue;final newValue;final  changes;KC(this.oldValue,this.newValue,[this.changes]); operator==(g){return g is KC&&oldValue==g.oldValue&&newValue==g.newValue&&changes==g.changes;} get hashCode=>fE(oldValue,newValue,changes); toString(){if(changes!=null)return '#<ChangeNotification to ${newValue}: ${changes}>';return '#<ChangeNotification from ${oldValue} to ${newValue}>';}}class l{static const u=1;static const KB=2;static const cB=KB|4;static const WB=KB|8;final  type;final key;final oldValue;final newValue;l(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is l&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>gE(type,key,oldValue,newValue); toString(){var g;switch (type){case u:g='field';break;case KB:g='index';break;case cB:g='insert';break;case WB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}} TE(g, i,[ k]){if(g is BB){var h=g;return dC(h,(m){i(new KC(h,h,m));});}var j=new MC(g,i,k);if(!j.SH()){return VE;}return j.TH;} dC( g, i){if(g.nB==null)g.nB=new eC();var h=g.nB.add(i);return h.remove;}LC(g){if(g is Map){var h=null;if(g is TC.SplayTreeMap){h=()=>new TC.SplayTreeMap();}else if(g is TC.LinkedHashMap){h=()=>new TC.LinkedHashMap();}return new kB.PG(g,createMap:h);}if(g is Set)return new ND.QG(g);if(g is Iterable)return new OE.OG(g);return g;}class BB{var nB;var mB;final  hashCode= ++BB.UE;static var UE=0;} LB( g)=>g.nB!=null&&g.nB.head!=null; get v=>lB!=null; FB( g, h,i)=>lB.UH(g,h,i); t( g, j,k, h, i){if((j&(l.cB|l.WB))==0){if(h==i)return;}if(dB==null){dB=[] ;hE(WE);}if(g.mB==null){g.mB=[] ;dB.add(g);}g.mB.add(new l(j,k,h,i));} VE(){}var lB;var MD=100;var dB;var eB; WE(){var m=0;while (dB!=null||eB!=null){var j=dB;dB=null;var i=eB;eB=null;if(m++ ==MD){XE(j,i);return;}if(j!=null){for(var h in j){var DB=h.mB;h.mB=null;for(var g=h.nB.head;g!=null;g=g.next){var k=g.value;try {k(DB);}catch (TB,q){yB(TB,q,k,'from ${h}');}}}}if(i!=null){i.forEach((SC,GC){GC.VH();});}}} XE( k, j){var g=[] ;if(k!=null){for(var i in k){var DB=i.mB;g.add('${i} ${DB}');}}if(j!=null){for(var m in j.values){var h=m.VH();if(h!=null)g.add('${m} ${h}');}}dB=null;eB=null;var q='exceeded notifiction limit of ${MD}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';aE(q);}class MC{static var YE=0;final  WH= ++MC.YE;final  XH;final  YH;final  ZH;final  aH=new Map();final  bH=[] ;var cH=false;var dH;MC(this.XH,this.YH,this.ZH); toString()=>ZH!=null?'<observer ${WH}: ${ZH}>':'<observer ${WH}>'; SH(){var h=lB;lB=this;try {dH=XH();if(dH is Iterable&&dH is !List&&dH is !BB){dH=(dH as Iterable).toList();}}catch (g,i){yB(g,i,XH,'from ${this}');dH=null;}aH.forEach(eH);aH.clear();assert(lB==this);lB=h;fH();return bH.length>0;} gH( i){try {YH(i);}catch (g,h){yB(g,h,YH,'from ${this}');}} fH(){var g=dH;if(g is !BB)return;bH.add(dC(g,(h){gH(new KC(g,g,h));}));} UH( m, q,g){var i=aH.putIfAbsent(m,()=>new Map());try {var h=i[g];if(h==null)h=0;i[g]=h|q;}catch (j,k){yB(j,k,g,'hashCode or operator == from ${this}');}} eH( i, j){bH.add(dC(i,(k){if(cH)return;for(var g in k){var h=j[g.key];if(h!=null&&(h&g.type)!=0){cH=true;if(eB==null){eB=new TC.SplayTreeMap();}eB[WH]=this;return;}}}));} TH(){for(var g in bH){g();}cH=false;} VH(){if(!cH)return null;var g=dH;TH();SH();try {if(g==dH)return null;}catch (i,j){yB(i,j,g,'operator == from ${this}');return null;}var h=new KC(g,dH);gH(h);return h;}}typedef  ZE( message);var aE=(g)=>print(g);typedef  bE(error,stackTrace,obj, message);var yB=cE; cE(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class ND<MB> extends kE with BB implements Set<MB>{final  hH;final  iH;ND({ createMap}):hH=createMap!=null?createMap():new Map<MB,Object>(),iH=createMap;factory ND.QG( g,{ createMap}){return new ND<MB>(createMap:createMap)..addAll(g);} contains( g){if(v)FB(this,l.KB,g);return hH.containsKey(g);} add( g){var h=hH.length;hH[g]=const Object();if(h!=hH.length){t(this,l.u,'length',h,hH.length);t(this,l.cB,g,null,g);}} remove( g){if(v)FB(this,l.KB,g);var h=hH.length;hH.remove(g);if(h!=hH.length){if(LB(this)){t(this,l.WB,g,g,null);t(this,l.u,'length',h,hH.length);}return true;}return false;} clear(){if(LB(this)){for(var g in hH.keys){t(this,l.WB,g,g,null);}t(this,l.u,'length',hH.length,0);}hH.clear();} get length{if(v)FB(this,l.u,'length');return hH.length;} get isEmpty=>length==0; get iterator=>new zF<MB>(this); addAll( g)=>g.forEach(add); toString(){if(v){for(MB g in hH.keys){FB(this,l.KB,g);}}return hH.keys.toSet().toString();}}class zF<MB> implements Iterator<MB>{final  jH;final  kH;var lH=false;zF( g):jH=g,kH=g.hH.keys.iterator; moveNext(){jH.length;return lH=kH.moveNext();} get current{var g=kH.current;if(v&&lH)FB(jH,l.KB,g);return g;}}class dE{}class eE{}class IB<JB>{var mH;var nH;var oH;var pH;IB.RG( g,this.oH):pH=g{if(oH!=null)oH.qH++ ;} get next=>nH; get value=>pH;set value( g)=>pH=g; rH( g, h){nH=h;mH=g;if(g!=null)g.nH=this;if(h!=null)h.mH=this;return this;} append( g)=>new IB<JB>.RG(g,oH).rH(this,nH); remove(){if(oH==null)return;oH.qH-- ;if(mH!=null){mH.nH=nH;}else{oH.sH=nH;}if(nH!=null){nH.mH=mH;}else{oH.tH=mH;}nH=null;mH=null;oH=null;}}class eC<JB> extends TC.IterableBase<JB>{var sH;var tH; get length=>qH;var qH=0;eC(){} get head=>sH; add( h){var g=new IB<JB>.RG(h,this);if(tH==null)return sH=tH=g;return tH=g.rH(tH,null);} addLast( g)=>add(g); addAll( g)=>g.forEach(add); get iterator=>new AG<JB>(this);}class AG<JB> implements Iterator<JB>{var uH;var oH;var vH;var wH=-1;AG(this.oH){uH=new List<IB>(oH.length);var h=0;var g=oH.head;while (g!=null){uH[h++ ]=g;g=g.next;}} get current=>vH; moveNext(){do{wH++ ;}while(wH<uH.length&&uH[wH].oH!=oH);if(wH<uH.length){vH=uH[wH].value;return true;}else{vH=null;return false;}}}zB(h,g)=>h.hashCode*31+g.hashCode;fE(h,g,i)=>zB(zB(h,g),i);gE(g,i,h,j)=>zB(zB(g,i),zB(h,j)); hE( h()){var g=new EB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class OD{static  iE( m, g, q, i, k){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+k-1,j=i+k-1;h>=g;h-- ,j-- ){q[j]=m[h];}}else{for(int h=g,j=i;h<g+k;h++ ,j++ ){q[j]=m[h];}}}static  jE( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class kE extends TC.IterableBase<dynamic>{}abstract class lE extends TC.ListMixin<dynamic>{} mE(i, g,[ h]){var j=i is dE;if(h==null){h=i.toString();}if(!j&&g is o.Text){g.text=h;}else{var k=g;g=j?new o.Element.html(h):new o.Text(h);k.replaceWith(g);}return g;} nE(g){if(g is eE)return g.toString();g=g.toString();return pE(g)?g:'#';}const oE=const["http","https","ftp","mailto"]; pE( h){var g=Uri.parse(h).scheme;if(g=='')return true;return oE.contains(g.toLowerCase())||"MAILTO"==g.toUpperCase();}abstract class AC{ fB(){} insert(); remove();}class BG extends AC{final  XD;var xH;final  listener;BG(this.XD,this.listener); insert(){xH=XD.listen(listener);} remove(){xH.cancel();xH=null;}}abstract class PD extends AC{final exp;final  isFinal;final  oC;var XB;PD(this.exp,this.isFinal):oC=gC&&NC!=null?NC():null; insert(){if(isFinal){qC();}else if(XB!=null){throw new StateError('binding already attached');}else{XB=sC();}} remove(){if(!isFinal){XB();XB=null;}} qC(); sC();}class CG extends PD{final  action;CG(g,this.action, h):super(g,h); qC()=>action(new KC(null,exp())); sC()=>hC(exp,action,'generic-binding',oC);}class DG extends PD{final  cD;final  ZD;DG( g,this.cD,this.ZD, h):super(g,h); yH(g){cD(ZD?nE(g):g);} qC()=>yH(exp()); sC()=>hC(exp,(g)=>yH(g.newValue),'dom-property-binding',oC);}class EG extends AC{final oB;EG(this.oB); fB(){oB..XF()..WD()..WF();} insert(){oB..pC()..bF();} remove(){oB..fF()..bD();}}class fC extends AC{final  rC;final  children=[] ;final  nodes=[] ;fC(this.rC); listen( i, h){children.add(new BG(i,(g){h(g);uE();}));} QC( h,i){var g=new o.Text('');children.add(new CG(()=>'${h()}',(j){g=mE(h(),g,j.newValue);},i));return g;} SB(g,j,h,[i=false]){children.add(new DG(g,j,i,h));} RC( h,g,i){children.add(new FG(h,g,i));} oB( g){children.add(new EG(g));} add( g)=>nodes.add(g); addAll( g)=>nodes.addAll(g); fB(){for(var g=0,h=children.length;g<h;g++ ){children[g].fB();}} insert(){for(var g=0,h=children.length;g<h;g++ ){children[g].insert();}} remove(){for(var g=children.length-1;g>=0;g-- ){children[g].remove();}children.clear();}}typedef  qE( list, index, template);class FG extends fC{final  aD;final exp;var XB;FG( g,this.exp,this.aD):super(g); fB(){} insert(){XB=hC(exp,(i){zH();var h=i.newValue;for(int g=0;g<h.length;g++ ){aD(h,g,this);}super.fB();rC.nodes.addAll(nodes);super.insert();},'loop-attribute-binding');} zH(){super.remove();rC.nodes.clear();nodes.clear();} remove(){zH();XB();XB=null;}}var QD=false;var gC=false;var NC=(){try {throw "";}catch (h,g){return g.toString();}};final  BC=new UB('watcher'); rE(g, q,[ j, m]){if(QD)return TE(g,q);if(q==null)return (){};if(CC==null)CC=new eC<DC>();j=j==null?'<unnamed>':j;var i;var h=HB.yE;if(g is TD){i=(g as TD).AI;}else if(g is Function){i=g;try {var k=g();if(k is List){h=HB.EC;}else if(k is Iterable){h=HB.EC;i=()=>g().toList();}else if((k is TC.LinkedHashMap)||(k is TC.SplayTreeMap)){h=HB.kC;}else if(k is Map){h=HB.jC;}}catch (DB,GC){BC.uC('evaluating ${j} watcher threw error (${DB}, ${GC})');}}else if(g is List){i=()=>g;h=HB.EC;}else if(g is Iterable){i=()=>g.toList();h=HB.EC;}else if((g is TC.LinkedHashMap)||(g is TC.SplayTreeMap)){i=()=>g;h=HB.kC;}else if(g is Map){i=()=>g;h=HB.jC;}if(gC&&m==null&&NC!=null){m=NC();}var SC=sE(h,i,q,j,m);var TB=CC.add(SC);return TB.remove;} sE( k, g, j, h, i){switch (k){case HB.EC:return new GG(g,j,h,i);case HB.kC:return new IG(g,j,h,i);case HB.jC:return new HG(g,j,h,i);default:return new DC(g,j,h,i);}} hC(h, i,[ j, k]){var m=rE(h,i,j,k);var g=h;if(g is Function){g=g();}if(g is Iterable&&g is !List){g=g.toList();}i(new KC(null,g));return m;}var CC;class DC{final  debugName;var location;final  BI;static var tE=0;final  AI;final  CI;var DI;DC(this.AI,this.CI,this.debugName,this.location):BI=tE++ {DI=AI();} toString()=>'${debugName} (id: #${BI})'; VF(){var g=EI();if(FI(g)){var h=DI;GI(g);CI(new KC(h,g));return true;}return false;} FI(g)=>DI!=g; GI(g){if(gC){if(location!=null){BC.info('watcher updated: ${this}, defined at:\n${location}');location=null;}else{BC.info('watcher updated: ${this}');}}DI=g;}EI(){try {return AI();}catch (g,h){BC.uC('${this} watcher threw an exception: ${g}, ${h}');}return DI;}}final  RD=10; uE(){if(CC==null)return;var g;var h=0;do{g=false;for(var i in CC){if(i.VF()){g=true;}}}while(g&& ++h<RD);if(h==RD){BC.uC('Possible loop in watchers propagation, stopped dispatch.');}}typedef  SD<vE>();typedef  wE<vE>( value);class TD<vE>{}class GG<vE> extends DC{GG(g, j, h, i):super(g,j,h,i){GI(EI());} FI( g){return iC(DI,g);} GI(g){DI=new List<vE>.from(g);}}class HG<OC,xE> extends DC{HG(g, j, h, i):super(g,j,h,i){GI(EI());} FI( g){var i=DI.keys;if(i.length!=g.keys.length)return true;var j=i.iterator;while (j.moveNext()){var h=j.current;if(!g.containsKey(h))return true;if(DI[h]!=g[h])return true;}return false;} GI(g){DI=new Map<OC,xE>.from(g);}}class IG<OC,xE> extends DC{IG(g, j, h, i):super(g,j,h,i){GI(EI());} FI( g){return iC(g.keys,DI.keys)||iC(g.values,DI.values);} GI(g){DI=new TC.LinkedHashMap.from(g);}} iC( i, j){var h=i.iterator;var g=j.iterator;while (h.moveNext()){if(!g.moveNext())return true;if(h.current!=g.current)return true;}return g.moveNext();}class HB{final HI;const HB.SG(this.HI);toString()=>'Enum.${HI}';static const EC=const HB.SG('LIST');static const jC=const HB.SG('HASH_MAP');static const kC=const HB.SG('ORDERED_MAP');static const yE=const HB.SG('OTHER');}abstract class UD extends pD{var II;var JI;var KI={};var LI=new nC({}); aF( g)=>LI; hF( h,var g){LI=g;} get host{if(II==null)throw new StateError('host element has not been set.');return II;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(II!=null){throw new StateError('host can only be set once.');}g.xtag=this;II=g;}createShadowRoot([ g]){var h=MI();if(g!=null){KI[g]=h;}return h;}MI(){if(VD){return host.createShadowRoot();}if(JI==null)JI=[] ;JI.add(new o.DivElement());return JI.last;} WD(){} pC(){} bD(){} WF(){if(VD)return;if(JI.length==0){throw new StateError('Distribution algorithm requires at least one shadow' ' root and can only be run once.');}var j=JI;var g=j.removeLast();var q=g;var m=new List.from(nodes);var k=[] ;var DB=[] ;while (true){m=NI(g,m);var h=g.query('shadow');if(h!=null){if(j.length>0){g=j.removeLast();k.add(h);DB.add(g);}else{mC(h,m);break;}}else{break;}}for(int i=0;i<k.length;i++ ){var h=k[i];var g=DB[i];mC(h,g.nodes);}nodes.clear();nodes.addAll(q.nodes);for(var TB in KI.keys){if(KI[TB]==q){KI[TB]=this;break;}}} NI( q, j){for(var g in q.queryAll('content')){if(!AF(g))continue;var i=g.attributes['select'];if(i==null||i=='')i='*';var h=[] ;var m=[] ;for(var k in j){(zE(k,i)?h:m).add(k);}if(h.length==0){h=g.nodes;}mC(g,h);j=m;}return j;}static  zE( h, g){if(h is !o.Element)return g=='*';return (h as o.Element).matches(g);}static  lC( g)=>g.tagName=='CONTENT'||g.tagName=='SHADOW';static  AF( g){assert(lC(g));for(g=g.parent;g!=null;g=g.parent){if(lC(g))return false;}return true;}static  mC( g, h){assert(lC(g));g.parent.insertAllBefore(h,g);g.remove();}}class nC{final  OI;nC(this.OI); operator[]( g)=>OI[g];}var BF=false; get VD=>BF&&o.ShadowRoot.supported;