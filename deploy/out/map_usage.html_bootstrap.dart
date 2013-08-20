import "dart:isolate" as EB;import "dart:html" as o;import "dart:json" as rB;import "dart:async" as aB;import "dart:collection" as VC;import "dart:mirrors" as mF;class nF{static const  oF="Chrome";static const  pF="Firefox";static const  qF="Internet Explorer";static const  rF="Safari";final  XF;final  minimumVersion;const nF(this.XF,[this.minimumVersion]);}class sF{const sF();}class tF{final  name;const tF(this.name);}class uF{const uF();}class vF{const vF();}class wF extends XD with BB{var WG;static final hD=new o.DocumentFragment.html('''
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
      ''');var XG; aF(){var YG=createShadowRoot("x-navbar");kF("x-navbar",new oC({"x-navbar":"[is=\"x-navbar\"]"}));WG=dF("x-navbar");XG=new gC(YG);YG.nodes.add(hD.clone(true));XG.hB();} eF(){XG.insert();} iF(){XG.remove();XG=null;}var ZG=''; get TC{if(v){FB(this,l.u,'activeid');}return ZG;}set TC( g){if(LB(this)){t(this,l.u,'activeid',ZG,g);}ZG=g;}qC(){o.query('#${TC}').className="active";}}const wC='/dry/service-rules-usage';const iD='8888';const xC='Rules / PMT';var yC;var zC;var sB=BC(new List<String>());var AD=BC(new List<String>());var tB=BC(new List<String>());var uB=BC(new List<String>());var iB=BC(new List<String>());final WC=new BB();var XC='CTCS2X/315'; get bB{if(v){FB(WC,l.u,'selectedFormat');}return XC;}set bB( g){if(LB(WC)){t(WC,l.u,'selectedFormat',XC,g);}XC=g;}var UB='b2bowner@stg';var VB='315';var cB='Exception';var jB='*';jD(){kD();} kB(){return o.window.location.protocol+'//'+o.window.location.hostname+':${yC}${zC}';} kD(){yC=o.window.location.port=='3030'?iD:o.window.location.port;zC=o.window.location.port=='3030'?wC:'/dry'+wC;lD();} lD(){var g=kB()+'?opt=datasources';var i=o.HttpRequest.getString(g).then((h){AD.addAll(rB.parse(h));BD();});} BD(){var g=kB()+'?opt=formats&ds=${UB}';var i=o.HttpRequest.getString(g).then((h){sB.clear();sB.addAll(rB.parse(h));if(!sB.contains(bB))bB=sB.first;CD();});} CD(){var g=kB()+'?opt=convTypes&ds=${UB}&fmt=${bB}';var i=o.HttpRequest.getString(g).then((h){tB.clear();tB.addAll(rB.parse(h));if(!tB.contains(VB))VB=tB.first;DD();});} DD(){var g=kB()+'?opt=segments&ds=${UB}&fmt=${bB}&cvt=${VB}';var i=o.HttpRequest.getString(g).then((h){uB.clear();uB.addAll(rB.parse(h));if(!uB.contains(cB))cB=uB.first;ED();});} ED(){var g=kB()+'?opt=fields&ds=${UB}&fmt=${bB}&cvt=${VB}&seg=${cB}';var i=o.HttpRequest.getString(g).then((h){iB.clear();iB.addAll(rB.parse(h));iB.add('*');if(!iB.contains(jB))jB=iB.first;FD();});} FD(){var k=kB()+'?opt=matrix&ds=${UB}&fmt=${bB}&cvt=${VB}&seg=${cB}&snum=${jB}';var q=o.HttpRequest.getString(k).then((m){var g=rB.parse(m);var j=new pD("matrix",['fancyTable']);var h=new List();h.add(xC);h.addAll(g['tpIds']);j.WF(h);j.VF(h,g['keys'],g['sequences'],g['paths']);var i=o.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();qD(j,i);oD("#matrix",g['paths'].length);});} mD(){BD();} nD(){CD();} oD( i, g){var h=(g+1)*40>750?750:((g+1)*40)+10;FE((){var j=GE({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});DE.NG(i).MG(j);});}class pD extends GD{var cG;pD( h, g){cG=new o.Element.tag("table");cG.id=h;cG.classes=g;} WF( q,[ k, j]){var i=new o.Element.tag('thead');var g=new o.Element.tr();if(k!=null)g.classes=k;i.nodes.add(g);q.forEach((m){var h=new o.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});cG.nodes.add(i);} VF( UC, lF, NB, j){var k=new o.Element.tag('tbody');lF.forEach((i){var q=new o.Element.tr();k.nodes.add(q);var MC=0;UC.forEach((m){var DB=i+"-"+m;var g=' ';if(m!=xC){if(NB.containsKey(DB))g='<span class="label label-info">'+NB[DB]+'</span>';}else{g='<p><span class="badge">'+j[i]['ruleCase']+'</span> '+j[i]['segNum']+" / "+j[i]['ruleName']+"</p>";}var h=new o.Element.td();if(g.contains("span")){if(MC++ >0)h.attributes={"align":"center"};h.nodes.add(new o.Element.html(g));}else h.text=g;q.nodes.add(h);});});cG.nodes.add(k);} get elements{var g=new List();g.add(cG);return g;}}abstract class GD{var elements;} qD( h,[ g]){if(g==null){g=o.document.body;}g.nodes.addAll(h.elements);} rD(){var dG=o.document.body;final eG=new o.OptionElement(),fG=new o.OptionElement(),gG=new o.OptionElement(),hG=new o.OptionElement(),iG=new o.OptionElement();var jG,kG,lG,mG,nG,oG;var pG=new gC(dG);jG=dG.nodes[3];pG.PB(()=>'t-rbase',(g){if(jG.xtag.TC!=g)jG.xtag.TC=g;},false,false);pG.qB(new wF()..host=jG);mG=dG.nodes[5].nodes[3].nodes[1].nodes[1];pG.listen(mG.onChange,(j){UB=mG.value;});pG.listen(mG.onChange,(j){mD();});pG.PB(()=>UB,(g){if(mG.value!=g)mG.value=g;},false,false);pG.LC(mG,()=>AD,(i,h,pG){var q=i[h];var qG;qG=eG.clone(true);var rG=pG.JC(()=>q,false);qG.nodes.add(rG);pG.PB(()=>UB==q,(g){if(qG.selected!=g)qG.selected=g;},false,false);pG.addAll([new o.Text('\n            '),qG,new o.Text('\n          ')]);});nG=dG.nodes[5].nodes[3].nodes[3].nodes[1];pG.listen(nG.onChange,(j){bB=nG.value;});pG.listen(nG.onChange,(j){nD();});pG.PB(()=>bB,(g){if(nG.value!=g)nG.value=g;},false,false);pG.LC(nG,()=>sB,(i,h,pG){var DB=i[h];var sG;sG=fG.clone(true);var tG=pG.JC(()=>DB,false);sG.nodes.add(tG);pG.PB(()=>bB==DB,(g){if(sG.selected!=g)sG.selected=g;},false,false);pG.addAll([new o.Text('\n            '),sG,new o.Text('\n          ')]);});oG=dG.nodes[5].nodes[3].nodes[5].nodes[1];pG.listen(oG.onChange,(j){VB=oG.value;});pG.listen(oG.onChange,(j){DD();});pG.PB(()=>VB,(g){if(oG.value!=g)oG.value=g;},false,false);pG.LC(oG,()=>tB,(i,h,pG){var k=i[h];var uG;uG=gG.clone(true);var vG=pG.JC(()=>k,false);uG.nodes.add(vG);pG.PB(()=>VB==k,(g){if(uG.selected!=g)uG.selected=g;},false,false);pG.addAll([new o.Text('\n            '),uG,new o.Text('\n          ')]);});kG=dG.nodes[5].nodes[3].nodes[7].nodes[1];pG.listen(kG.onChange,(j){cB=kG.value;});pG.listen(kG.onChange,(j){ED();});pG.PB(()=>cB,(g){if(kG.value!=g)kG.value=g;},false,false);pG.LC(kG,()=>uB,(i,h,pG){var m=i[h];var wG;wG=hG.clone(true);var xG=pG.JC(()=>m,false);wG.nodes.add(xG);pG.PB(()=>cB==m,(g){if(wG.selected!=g)wG.selected=g;},false,false);pG.addAll([new o.Text('\n            '),wG,new o.Text('\n          ')]);});lG=dG.nodes[5].nodes[3].nodes[9].nodes[1];pG.listen(lG.onChange,(j){jB=lG.value;});pG.listen(lG.onChange,(j){FD();});pG.PB(()=>jB,(g){if(lG.value!=g)lG.value=g;},false,false);pG.LC(lG,()=>iB,(i,h,pG){var NB=i[h];var yG;yG=iG.clone(true);var zG=pG.JC(()=>NB,false);yG.nodes.add(zG);pG.PB(()=>jB==NB,(g){if(yG.selected!=g)yG.selected=g;},false,false);pG.addAll([new o.Text('\n            '),yG,new o.Text('\n          ')]);});pG.hB();pG.insert();}main(){TD=true;WB.dC.hF.listen((g){print('${g.KC.name.toLowerCase()}: ${g.message}');});jD();rD();}class sD implements o.Element{var AH;var BH;var CH={}; get host{if(AH==null)throw new StateError('host element has not been set.');return AH;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(AH!=null){throw new StateError('host can only be set once.');}g.xtag=this;AH=g;}createShadowRoot([ g]){var h=host.createShadowRoot();if(g!=null){CH[g]=h;}return h;} ZD(){} qC(){} eD(){} get nodes=>host.nodes; replaceWith( g){host.replaceWith(g);} remove()=>host.remove(); get document=>host.document;set text( g){host.text=g;} contains( g)=>host.contains(g); hasChildNodes()=>host.hasChildNodes(); insertBefore( g, h)=>host.insertBefore(g,h); insertAllBefore( g, h)=>host.insertAllBefore(g,h); get attributes=>host.attributes;set attributes( g){host.attributes=g;} get elements=>host.children; get children=>host.children; get classes=>host.classes;set classes( g){host.classes=g;} clone( g)=>host.clone(g); get parent=>host.parent; get parentNode=>host.parentNode; get nodeValue=>host.nodeValue;dynamic get on{throw new UnsupportedError('on is deprecated');} get id=>host.id;set id( g){host.id=g;} set innerHtml( g){host.innerHtml=g;} get tagName=>host.tagName; matches( g)=>host.matches(g); matchesWithAncestors( g)=>host.matchesWithAncestors(g); query( g)=>host.query(g); queryAll( g)=>host.queryAll(g); get IF=>host.IF; get className=>host.className;set className( g){host.className=g;} get JF=>host.JF; get MF=>host.MF; KF( g)=>host.KF(g); LF( g)=>host.LF(g); PF( g)=>host.PF(g); QF( g)=>host.QF(g); UF( h, g)=>host.UF(h,g);get GF=>host.GF; get HF=>host.HF; get firstChild=>host.firstChild; get localName=>host.localName; get NF=>host.NF; get OF=>host.OF; FF( i, g,[ h]){host.FF(i,g,h);} dispatchEvent( g)=>host.dispatchEvent(g); RF( g)=>host.RF(g); SF( i, g,[ h]){host.SF(i,g,h);} TF( g, h)=>host.TF(g,h);get xtag=>host.xtag;set xtag(g){host.xtag=g;} append( g)=>host.append(g); get onChange=>host.onChange; get onError=>host.onError; get onLoad=>host.onLoad;}final tD=r"""
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
"""; uD(h){final g=new o.ScriptElement();g.type='text/javascript';g.innerHtml=h;o.document.body.nodes.add(g);}var vB=null;var vD=null;var wD=null;var HD=null;var xD=null;var yD=null;var zD=null;var ID=null;var JD=null;var KD=null;var AE=null;var BE=null;var LD=null;var MD=null; CE(){if(vB!=null)return;try {vB=o.window.lookupPort('dart-js-interop-context');}catch (h){}if(vB==null){uD(tD);vB=o.window.lookupPort('dart-js-interop-context');}vD=o.window.lookupPort('dart-js-interop-create');wD=o.window.lookupPort('dart-js-interop-proxy-count');HD=o.window.lookupPort('dart-js-interop-equals');xD=o.window.lookupPort('dart-js-interop-instanceof');yD=o.window.lookupPort('dart-js-interop-has-property');zD=o.window.lookupPort('dart-js-interop-delete-property');ID=o.window.lookupPort('dart-js-interop-convert');JD=o.window.lookupPort('dart-js-interop-enter-scope');KD=o.window.lookupPort('dart-js-interop-exit-scope');AE=o.window.lookupPort('dart-js-interop-globalize');BE=o.window.lookupPort('dart-js-interop-invalidate');LD=new o.ReceivePortSync()..receive((DH)=>YC());MD=new o.ReceivePortSync()..receive((g)=>ZC(g[0]));o.window.registerPort('js-dart-interop-enter-scope',LD.toSendPort());o.window.registerPort('js-dart-interop-exit-scope',MD.toSendPort());} get DE{NC();return xB(vB.callSync([] ));}get EE=>OB.EH.length; NC(){if(EE==0){var g=YC();aB.runAsync(()=>ZC(g));}}FE(g){var h=YC();try {return g();}finally {ZC(h);}} YC(){CE();OB.bF();JD.callSync([] );return OB.EH.length;} ZC( g){assert(OB.EH.length==g);KD.callSync([] );OB.cF();} GE( g)=>new SB.OG(g);class xF{const xF();}const dB=const xF(); HE(i,m,k,j,DB,q){final g=[i,m,k,j,DB,q];final h=g.indexOf(dB);if(h<0)return g;return g.sublist(0,h);}class SB implements bC<SB>{var FH;final GH;factory SB.OG(g){NC();return IE(g);}static IE(g){return xB(ID.callSync(aC(g)));}static aC(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,aC(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(aC).toList()];}else{return ['simple',lB(g)];}}SB.PG(this.FH,this.GH); gD()=>this;operator[](g)=>wB(this,'[]','method',[g]);operator[]=(h,g)=>wB(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is SB&&HD.callSync([lB(this),lB(g)])); toString(){try {return wB(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=mF.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return wB(this,g,h,j);}static wB( g, i, k, j){NC();var h=g.FH.callSync([g.GH,i,k,j.map(lB).toList()]);switch (h[0]){case 'return':return xB(h[1]);case 'throws':throw xB(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class ND extends SB implements bC<ND>{ND.PG( h,g):super.PG(h,g);call([g=dB,j=dB,i=dB,h=dB,q=dB,k=dB]){var m=HE(g,j,i,h,q,k);return SB.wB(this,'','apply',m);}}abstract class bC<JE>{ gD();}class KE{final  HH;var IH;var JH;final  KH;final  FH;final  LH;final  MH;final  EH;bF(){EH.add(MH.length);}cF(){var h=EH.removeLast();for(int g=h;g<MH.length; ++g){var i=MH[g];if(!LH.contains(i)){KH.remove(MH[g]);JH++ ;}}if(h!=MH.length){MH.removeRange(h,MH.length-h);}}KE():HH='dart-ref',IH=0,JH=0,KH={},FH=new o.ReceivePortSync(),MH=new List<String>(),EH=new List<int>(),LH=new Set<String>(){FH.receive((g){try {final h=KH[g[0]];final k=g[1];final j=g[2].map(xB).toList();if(k=='#call'){final m=h as Function;var q=lB(m(j));return ['return',q];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){NC();final g='${HH}-${IH++ }';KH[g]=h;MH.add(g);return g;}Object get( g){return KH[g];}get uC=>FH.toSendPort();}var OB=new KE();lB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is EB.SendPortSync){return g;}else if(g is o.Element&&(g.document==null||g.document==o.document)){return ['domref',ME(g)];}else if(g is ND){return ['funcref',g.GH,g.FH];}else if(g is SB){return ['objref',g.GH,g.FH];}else if(g is bC){return lB(g.gD());}else{return ['objref',OB.add(g),OB.uC];}}xB(var g){m(g){var h=g[1];var i=g[2];if(i==OB.uC){return OB.get(h);}else{return new ND.PG(i,h);}}k(g){var h=g[1];var i=g[2];if(i==OB.uC){return OB.get(h);}else{return new SB.PG(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is EB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return k(g);case 'domref':return NE(g[1]);}throw 'Unsupported serialized data: ${g}';}var LE=0;const OC='data-dart_id';const TB='data-dart_temporary_attached';ME( h){var i;if(h.attributes.containsKey(OC)){i=h.attributes[OC];}else{i='dart-${LE++ }';h.attributes[OC]=i;}if(!identical(h,o.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(TB)){final j=g.attributes[TB];final k=j+'a';g.attributes[TB]=k;break;}if(g.parent==null){g.attributes[TB]='a';o.document.documentElement.children.add(g);break;}if(identical(g.parent,o.document.documentElement)){break;}g=g.parent;}}return i;} NE(var i){var j=o.queryAll('[${OC}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,o.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(TB)){final k=g.attributes[TB];final m=k.substring(1);g.attributes[TB]=m;if(g.attributes[TB].length==0){g.attributes.remove(TB);g.remove();}break;}if(identical(g.parent,o.document.documentElement)){break;}g=g.parent;}}return h;}var cC=false;var OE=AB.OD;class WB{final  name; get bD=>(parent==null||parent.name=='')?name:'${parent.bD}.${name}';final  parent;var NH;var children;var OH;var PH;factory WB( g){if(g.startsWith('.')){throw new ArgumentError("name shouldn't start with a '.'");}if(yB==null)yB=<String,WB>{};if(yB.containsKey(g))return yB[g];var j=g.lastIndexOf('.');var h=null;var i;if(j==-1){if(g!='')h=new WB('');i=g;}else{h=new WB(g.substring(0,j));i=g.substring(j+1);}final k=new WB.QG(i,h);yB[g]=k;return k;}WB.QG(this.name,this.parent):children=new Map<String,WB>(){if(parent!=null)parent.children[name]=this;} get KC{if(cC){if(NH!=null)return NH;if(parent!=null)return parent.KC;}return OE;} get hF=>QH(); fF( g)=>(g>=KC); log( i, k,[j]){if(fF(i)){var h=new zB(i,k,bD,j);if(cC){var g=this;while (g!=null){g.RH(h);g=g.parent;}}else{dC.RH(h);}}} info( h,[g])=>log(AB.OD,h,g); vC( h,[g])=>log(AB.PE,h,g); QH(){if(cC||parent==null){if(OH==null){OH=new aB.StreamController<zB>.broadcast(sync:true);PH=OH.stream;}return PH;}else{return dC.QH();}} RH( g){if(OH!=null){OH.add(g);}}static  get dC=>new WB('');static var yB;}class AB implements Comparable<AB>{final  name;final  value;const AB(this.name,this.value);static const  OD=const AB('INFO',800);static const  PE=const AB('WARNING',900); operator==( g)=>g!=null&&value==g.value; operator<( g)=>value<g.value; operator<=( g)=>value<=g.value; operator>( g)=>value>g.value; operator>=( g)=>value>=g.value; compareTo( g)=>value-g.value; get hashCode=>value; toString()=>name;}class zB{final  KC;final  message;final  gF;final  time;final  jF;static var QE=0;var exception;zB(this.KC,this.message,this.gF,[this.exception]):time=new DateTime.now(),jF=zB.QE++ ;}const yF=const zF();class zF{const zF();}class RE<XB> extends oE with BB implements List<XB>{final  SH;RE([ g]):SH=g!=null?new List<XB>(g):<XB>[] ;factory RE.RG( g)=>new RE<XB>()..addAll(g); get length{if(v)FB(this,l.u,'length');return SH.length;}set length( h){var i=SH.length;if(i==h)return;if(LB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){t(this,l.YB,g,SH[g],null);}t(this,l.u,'length',i,h);}else{t(this,l.u,'length',i,h);for(int g=i;g<h;g++ ){t(this,l.eB,g,null,null);}}}SH.length=h;} operator[]( g){if(v)FB(this,l.KB,g);return SH[g];}operator[]=( g, h){var i=SH[g];if(LB(this)){t(this,l.KB,g,i,h);}SH[g]=h;} sublist( h,[ g])=>new RE<XB>.RG(super.sublist(h,g)); add( h){var g=SH.length;if(LB(this)){t(this,l.u,'length',g,g+1);t(this,l.eB,g,null,h);}SH.add(h);} removeRange( h, g){if(g==0)return;RD.mE(this,h,g);if(LB(this)){for(int i=h;i<g;i++ ){t(this,l.YB,i,this[i],null);}}RD.lE(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(v){for(int g=0;g<length;g++ ){FB(this,l.KB,g);}}return SH.toString();}}typedef  AC<GB,CB>();class mB<GB,CB> extends BB implements Map<GB,CB>{final  TH;var UH;var VH;mB({ createMap}):TH=createMap!=null?createMap():new Map<GB,CB>(){UH=new SE<GB,CB>(this);VH=new TE<GB,CB>(this);}factory mB.SG( i,{ createMap}){var g=new mB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>UH; get values=>VH; get length{if(v)FB(this,l.u,'length');return TH.length;} get isEmpty=>length==0; get isNotEmpty=>length!=0; WH( g)=>FB(this,l.KB,g); XH(){FB(this,l.u,'length');TH.keys.forEach(WH);} containsKey( g){if(v)WH(g);return TH.containsKey(g);} operator[]( g){if(v)WH(g);return TH[g];} operator[]=( h, g){var j=TH.length;var i=TH[h];TH[h]=g;if(LB(this)){if(j!=TH.length){t(this,l.u,'length',j,TH.length);t(this,l.eB,h,i,g);}else if(i!=g){t(this,l.KB,h,i,g);}}} putIfAbsent( g, j()){if(v)WH(g);var h=TH.length;var i=TH.putIfAbsent(g,j);if(LB(this)&&h!=TH.length){t(this,l.u,'length',h,TH.length);t(this,l.eB,g,null,i);}return i;} remove( g){if(v)WH(g);var h=TH.length;var i=TH.remove(g);if(LB(this)&&h!=TH.length){t(this,l.YB,g,i,null);t(this,l.u,'length',h,TH.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=TH.length;if(LB(this)&&g>0){TH.forEach((i,h){t(this,l.YB,i,h,null);});t(this,l.u,'length',g,0);}TH.clear();} forEach( g( key, value)){if(v)XH();TH.forEach(g);} toString()=>VC.Maps.mapToString(this);}class SE<GB,CB> extends VC.IterableBase<GB>{final  TH;SE(this.TH); get iterator=>new AG<GB,CB>(TH);}class AG<GB,CB> implements Iterator<GB>{final  TH;final  UH;var YH=false;AG( g):TH=g,UH=g.TH.keys.iterator; moveNext(){if(v)FB(TH,l.u,'length');return YH=UH.moveNext();} get current{var g=UH.current;if(v&&YH)TH.WH(g);return g;}}class TE<GB,CB> extends VC.IterableBase<CB>{final  TH;TE(this.TH); get iterator=>new BG<GB,CB>(TH);}class BG<GB,CB> implements Iterator<CB>{final  TH;final  UH;final  VH;var YH;BG( g):TH=g,UH=g.TH.keys.iterator,VH=g.TH.values.iterator; moveNext(){if(v)FB(TH,l.u,'length');var h=UH.moveNext();var g=VH.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return YH=g;} get current{if(v&&YH)TH.WH(UH.current);return VH.current;}}typedef  QB( e);typedef  UE( changes);typedef  RB();typedef  VE();class PC{final oldValue;final newValue;final  changes;PC(this.oldValue,this.newValue,[this.changes]); operator==(g){return g is PC&&oldValue==g.oldValue&&newValue==g.newValue&&changes==g.changes;} get hashCode=>iE(oldValue,newValue,changes); toString(){if(changes!=null)return '#<ChangeNotification to ${newValue}: ${changes}>';return '#<ChangeNotification from ${oldValue} to ${newValue}>';}}class l{static const u=1;static const KB=2;static const eB=KB|4;static const YB=KB|8;final  type;final key;final oldValue;final newValue;l(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is l&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>jE(type,key,oldValue,newValue); toString(){var g;switch (type){case u:g='field';break;case KB:g='index';break;case eB:g='insert';break;case YB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}} WE(g, i,[ k]){if(g is BB){var h=g;return eC(h,(m){i(new PC(h,h,m));});}var j=new QC(g,i,k);if(!j.ZH()){return YE;}return j.aH;} eC( g, i){if(g.pB==null)g.pB=new fC();var h=g.pB.add(i);return h.remove;}BC(g){if(g is Map){var h=null;if(g is VC.SplayTreeMap){h=()=>new VC.SplayTreeMap();}else if(g is VC.LinkedHashMap){h=()=>new VC.LinkedHashMap();}return new mB.SG(g,createMap:h);}if(g is Set)return new QD.TG(g);if(g is Iterable)return new RE.RG(g);return g;}class BB{var pB;var oB;final  hashCode= ++BB.XE;static var XE=0;} LB( g)=>g.pB!=null&&g.pB.head!=null; get v=>nB!=null; FB( g, h,i)=>nB.bH(g,h,i); t( g, j,k, h, i){if((j&(l.eB|l.YB))==0){if(h==i)return;}if(fB==null){fB=[] ;kE(ZE);}if(g.oB==null){g.oB=[] ;fB.add(g);}g.oB.add(new l(j,k,h,i));} YE(){}var nB;var PD=100;var fB;var gB; ZE(){var m=0;while (fB!=null||gB!=null){var j=fB;fB=null;var i=gB;gB=null;if(m++ ==PD){aE(j,i);return;}if(j!=null){for(var h in j){var DB=h.oB;h.oB=null;for(var g=h.pB.head;g!=null;g=g.next){var k=g.value;try {k(DB);}catch (NB,q){CC(NB,q,k,'from ${h}');}}}}if(i!=null){i.forEach((UC,MC){MC.cH();});}}} aE( k, j){var g=[] ;if(k!=null){for(var i in k){var DB=i.oB;g.add('${i} ${DB}');}}if(j!=null){for(var m in j.values){var h=m.cH();if(h!=null)g.add('${m} ${h}');}}fB=null;gB=null;var q='exceeded notifiction limit of ${PD}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';dE(q);}class QC{static var bE=0;final  dH= ++QC.bE;final  eH;final  fH;final  gH;final  hH=new Map();final  iH=[] ;var jH=false;var kH;QC(this.eH,this.fH,this.gH); toString()=>gH!=null?'<observer ${dH}: ${gH}>':'<observer ${dH}>'; ZH(){var h=nB;nB=this;try {kH=eH();if(kH is Iterable&&kH is !List&&kH is !BB){kH=(kH as Iterable).toList();}}catch (g,i){CC(g,i,eH,'from ${this}');kH=null;}hH.forEach(lH);hH.clear();assert(nB==this);nB=h;mH();return iH.length>0;} nH( i){try {fH(i);}catch (g,h){CC(g,h,fH,'from ${this}');}} mH(){var g=kH;if(g is !BB)return;iH.add(eC(g,(h){nH(new PC(g,g,h));}));} bH( m, q,g){var i=hH.putIfAbsent(m,()=>new Map());try {var h=i[g];if(h==null)h=0;i[g]=h|q;}catch (j,k){CC(j,k,g,'hashCode or operator == from ${this}');}} lH( i, j){iH.add(eC(i,(k){if(jH)return;for(var g in k){var h=j[g.key];if(h!=null&&(h&g.type)!=0){jH=true;if(gB==null){gB=new VC.SplayTreeMap();}gB[dH]=this;return;}}}));} aH(){for(var g in iH){g();}jH=false;} cH(){if(!jH)return null;var g=kH;aH();ZH();try {if(g==kH)return null;}catch (i,j){CC(i,j,g,'operator == from ${this}');return null;}var h=new PC(g,kH);nH(h);return h;}}typedef  cE( message);var dE=(g)=>print(g);typedef  eE(error,stackTrace,obj, message);var CC=fE; fE(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class QD<MB> extends nE with BB implements Set<MB>{final  oH;final  pH;QD({ createMap}):oH=createMap!=null?createMap():new Map<MB,Object>(),pH=createMap;factory QD.TG( g,{ createMap}){return new QD<MB>(createMap:createMap)..addAll(g);} contains( g){if(v)FB(this,l.KB,g);return oH.containsKey(g);} add( g){var h=oH.length;oH[g]=const Object();if(h!=oH.length){t(this,l.u,'length',h,oH.length);t(this,l.eB,g,null,g);}} remove( g){if(v)FB(this,l.KB,g);var h=oH.length;oH.remove(g);if(h!=oH.length){if(LB(this)){t(this,l.YB,g,g,null);t(this,l.u,'length',h,oH.length);}return true;}return false;} clear(){if(LB(this)){for(var g in oH.keys){t(this,l.YB,g,g,null);}t(this,l.u,'length',oH.length,0);}oH.clear();} get length{if(v)FB(this,l.u,'length');return oH.length;} get isEmpty=>length==0; get iterator=>new CG<MB>(this); addAll( g)=>g.forEach(add); toString(){if(v){for(MB g in oH.keys){FB(this,l.KB,g);}}return oH.keys.toSet().toString();}}class CG<MB> implements Iterator<MB>{final  qH;final  rH;var sH=false;CG( g):qH=g,rH=g.oH.keys.iterator; moveNext(){qH.length;return sH=rH.moveNext();} get current{var g=rH.current;if(v&&sH)FB(qH,l.KB,g);return g;}}class gE{}class hE{}class IB<JB>{var tH;var uH;var vH;var wH;IB.UG( g,this.vH):wH=g{if(vH!=null)vH.xH++ ;} get next=>uH; get value=>wH;set value( g)=>wH=g; yH( g, h){uH=h;tH=g;if(g!=null)g.uH=this;if(h!=null)h.tH=this;return this;} append( g)=>new IB<JB>.UG(g,vH).yH(this,uH); remove(){if(vH==null)return;vH.xH-- ;if(tH!=null){tH.uH=uH;}else{vH.zH=uH;}if(uH!=null){uH.tH=tH;}else{vH.AI=tH;}uH=null;tH=null;vH=null;}}class fC<JB> extends VC.IterableBase<JB>{var zH;var AI; get length=>xH;var xH=0;fC(){} get head=>zH; add( h){var g=new IB<JB>.UG(h,this);if(AI==null)return zH=AI=g;return AI=g.yH(AI,null);} addLast( g)=>add(g); addAll( g)=>g.forEach(add); get iterator=>new DG<JB>(this);}class DG<JB> implements Iterator<JB>{var BI;var vH;var CI;var DI=-1;DG(this.vH){BI=new List<IB>(vH.length);var h=0;var g=vH.head;while (g!=null){BI[h++ ]=g;g=g.next;}} get current=>CI; moveNext(){do{DI++ ;}while(DI<BI.length&&BI[DI].vH!=vH);if(DI<BI.length){CI=BI[DI].value;return true;}else{CI=null;return false;}}}DC(h,g)=>h.hashCode*31+g.hashCode;iE(h,g,i)=>DC(DC(h,g),i);jE(g,i,h,j)=>DC(DC(g,i),DC(h,j)); kE( h()){var g=new EB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class RD{static  lE( m, g, q, i, k){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+k-1,j=i+k-1;h>=g;h-- ,j-- ){q[j]=m[h];}}else{for(int h=g,j=i;h<g+k;h++ ,j++ ){q[j]=m[h];}}}static  mE( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class nE extends VC.IterableBase<dynamic>{}abstract class oE extends VC.ListMixin<dynamic>{} pE(i, g,[ h]){var j=i is gE;if(h==null){h=i.toString();}if(!j&&g is o.Text){g.text=h;}else{var k=g;g=j?new o.Element.html(h):new o.Text(h);k.replaceWith(g);}return g;} qE(g){if(g is hE)return g.toString();g=g.toString();return sE(g)?g:'#';}const rE=const["http","https","ftp","mailto"]; sE( h){var g=Uri.parse(h).scheme;if(g=='')return true;return rE.contains(g.toLowerCase())||"MAILTO"==g.toUpperCase();}abstract class EC{ hB(){} insert(); remove();}class EG extends EC{final  aD;var EI;final  listener;EG(this.aD,this.listener); insert(){EI=aD.listen(listener);} remove(){EI.cancel();EI=null;}}abstract class SD extends EC{final exp;final  isFinal;final  pC;var ZB;SD(this.exp,this.isFinal):pC=hC&&RC!=null?RC():null; insert(){if(isFinal){rC();}else if(ZB!=null){throw new StateError('binding already attached');}else{ZB=tC();}} remove(){if(!isFinal){ZB();ZB=null;}} rC(); tC();}class FG extends SD{final  action;FG(g,this.action, h):super(g,h); rC()=>action(new PC(null,exp())); tC()=>iC(exp,action,'generic-binding',pC);}class GG extends SD{final  fD;final  cD;GG( g,this.fD,this.cD, h):super(g,h); FI(g){fD(cD?qE(g):g);} rC()=>FI(exp()); tC()=>iC(exp,(g)=>FI(g.newValue),'dom-property-binding',pC);}class HG extends EC{final qB;HG(this.qB); hB(){qB..aF()..ZD()..ZF();} insert(){qB..qC()..eF();} remove(){qB..iF()..eD();}}class gC extends EC{final  sC;final  children=[] ;final  nodes=[] ;gC(this.sC); listen( i, h){children.add(new EG(i,(g){h(g);xE();}));} JC( h,i){var g=new o.Text('');children.add(new FG(()=>'${h()}',(j){g=pE(h(),g,j.newValue);},i));return g;} PB(g,j,h,[i=false]){children.add(new GG(g,j,i,h));} LC( h,g,i){children.add(new IG(h,g,i));} qB( g){children.add(new HG(g));} add( g)=>nodes.add(g); addAll( g)=>nodes.addAll(g); hB(){for(var g=0,h=children.length;g<h;g++ ){children[g].hB();}} insert(){for(var g=0,h=children.length;g<h;g++ ){children[g].insert();}} remove(){for(var g=children.length-1;g>=0;g-- ){children[g].remove();}children.clear();}}typedef  tE( list, index, template);class IG extends gC{final  dD;final exp;var ZB;IG( g,this.exp,this.dD):super(g); hB(){} insert(){ZB=iC(exp,(i){GI();var h=i.newValue;for(int g=0;g<h.length;g++ ){dD(h,g,this);}super.hB();sC.nodes.addAll(nodes);super.insert();},'loop-attribute-binding');} GI(){super.remove();sC.nodes.clear();nodes.clear();} remove(){GI();ZB();ZB=null;}}var TD=false;var hC=false;var RC=(){try {throw "";}catch (h,g){return g.toString();}};final  FC=new WB('watcher'); uE(g, q,[ j, m]){if(TD)return WE(g,q);if(q==null)return (){};if(GC==null)GC=new fC<HC>();j=j==null?'<unnamed>':j;var i;var h=HB.BF;if(g is WD){i=(g as WD).HI;}else if(g is Function){i=g;try {var k=g();if(k is List){h=HB.IC;}else if(k is Iterable){h=HB.IC;i=()=>g().toList();}else if((k is VC.LinkedHashMap)||(k is VC.SplayTreeMap)){h=HB.lC;}else if(k is Map){h=HB.kC;}}catch (DB,MC){FC.vC('evaluating ${j} watcher threw error (${DB}, ${MC})');}}else if(g is List){i=()=>g;h=HB.IC;}else if(g is Iterable){i=()=>g.toList();h=HB.IC;}else if((g is VC.LinkedHashMap)||(g is VC.SplayTreeMap)){i=()=>g;h=HB.lC;}else if(g is Map){i=()=>g;h=HB.kC;}if(hC&&m==null&&RC!=null){m=RC();}var UC=vE(h,i,q,j,m);var NB=GC.add(UC);return NB.remove;} vE( k, g, j, h, i){switch (k){case HB.IC:return new JG(g,j,h,i);case HB.lC:return new LG(g,j,h,i);case HB.kC:return new KG(g,j,h,i);default:return new HC(g,j,h,i);}} iC(h, i,[ j, k]){var m=uE(h,i,j,k);var g=h;if(g is Function){g=g();}if(g is Iterable&&g is !List){g=g.toList();}i(new PC(null,g));return m;}var GC;class HC{final  debugName;var location;final  II;static var wE=0;final  HI;final  JI;var KI;HC(this.HI,this.JI,this.debugName,this.location):II=wE++ {KI=HI();} toString()=>'${debugName} (id: #${II})'; YF(){var g=LI();if(MI(g)){var h=KI;NI(g);JI(new PC(h,g));return true;}return false;} MI(g)=>KI!=g; NI(g){if(hC){if(location!=null){FC.info('watcher updated: ${this}, defined at:\n${location}');location=null;}else{FC.info('watcher updated: ${this}');}}KI=g;}LI(){try {return HI();}catch (g,h){FC.vC('${this} watcher threw an exception: ${g}, ${h}');}return KI;}}final  UD=10; xE(){if(GC==null)return;var g;var h=0;do{g=false;for(var i in GC){if(i.YF()){g=true;}}}while(g&& ++h<UD);if(h==UD){FC.vC('Possible loop in watchers propagation, stopped dispatch.');}}typedef  VD<yE>();typedef  zE<yE>( value);class WD<yE>{}class JG<yE> extends HC{JG(g, j, h, i):super(g,j,h,i){NI(LI());} MI( g){return jC(KI,g);} NI(g){KI=new List<yE>.from(g);}}class KG<SC,AF> extends HC{KG(g, j, h, i):super(g,j,h,i){NI(LI());} MI( g){var i=KI.keys;if(i.length!=g.keys.length)return true;var j=i.iterator;while (j.moveNext()){var h=j.current;if(!g.containsKey(h))return true;if(KI[h]!=g[h])return true;}return false;} NI(g){KI=new Map<SC,AF>.from(g);}}class LG<SC,AF> extends HC{LG(g, j, h, i):super(g,j,h,i){NI(LI());} MI( g){return jC(g.keys,KI.keys)||jC(g.values,KI.values);} NI(g){KI=new VC.LinkedHashMap.from(g);}} jC( i, j){var h=i.iterator;var g=j.iterator;while (h.moveNext()){if(!g.moveNext())return true;if(h.current!=g.current)return true;}return g.moveNext();}class HB{final OI;const HB.VG(this.OI);toString()=>'Enum.${OI}';static const IC=const HB.VG('LIST');static const kC=const HB.VG('HASH_MAP');static const lC=const HB.VG('ORDERED_MAP');static const BF=const HB.VG('OTHER');}abstract class XD extends sD{var QI;var RI;var SI={};var TI=new oC({}); dF( g)=>TI; kF( h,var g){TI=g;} get host{if(QI==null)throw new StateError('host element has not been set.');return QI;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(QI!=null){throw new StateError('host can only be set once.');}g.xtag=this;QI=g;}createShadowRoot([ g]){var h=UI();if(g!=null){SI[g]=h;}return h;}UI(){if(YD){return host.createShadowRoot();}if(RI==null)RI=[] ;RI.add(new o.DivElement());return RI.last;} ZD(){} qC(){} eD(){} ZF(){if(YD)return;if(RI.length==0){throw new StateError('Distribution algorithm requires at least one shadow' ' root and can only be run once.');}var j=RI;var g=j.removeLast();var q=g;var m=new List.from(nodes);var k=[] ;var DB=[] ;while (true){m=VI(g,m);var h=g.query('shadow');if(h!=null){if(j.length>0){g=j.removeLast();k.add(h);DB.add(g);}else{nC(h,m);break;}}else{break;}}for(int i=0;i<k.length;i++ ){var h=k[i];var g=DB[i];nC(h,g.nodes);}nodes.clear();nodes.addAll(q.nodes);for(var NB in SI.keys){if(SI[NB]==q){SI[NB]=this;break;}}} VI( q, j){for(var g in q.queryAll('content')){if(!DF(g))continue;var i=g.attributes['select'];if(i==null||i=='')i='*';var h=[] ;var m=[] ;for(var k in j){(CF(k,i)?h:m).add(k);}if(h.length==0){h=g.nodes;}nC(g,h);j=m;}return j;}static  CF( h, g){if(h is !o.Element)return g=='*';return (h as o.Element).matches(g);}static  mC( g)=>g.tagName=='CONTENT'||g.tagName=='SHADOW';static  DF( g){assert(mC(g));for(g=g.parent;g!=null;g=g.parent){if(mC(g))return false;}return true;}static  nC( g, h){assert(mC(g));g.parent.insertAllBefore(h,g);g.remove();}}class oC{final  WI;oC(this.WI); operator[]( g)=>WI[g];}var EF=false; get YD=>EF&&o.ShadowRoot.supported;