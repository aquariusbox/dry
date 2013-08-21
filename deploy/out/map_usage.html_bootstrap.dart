import "dart:async" as dB;import "dart:mirrors" as pF;import "dart:html" as o;import "dart:json" as lB;import "dart:isolate" as EB;import "dart:collection" as XC;class qF{static const  rF="Chrome";static const  sF="Firefox";static const  tF="Internet Explorer";static const  uF="Safari";final  aF;final  minimumVersion;const qF(this.aF,[this.minimumVersion]);}class vF{const vF();}class wF{final  name;const wF(this.name);}class xF{const xF();}class yF{const yF();}class zF extends aD with BB{var ZG;static final kD=new o.DocumentFragment.html('''
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
      ''');var aG; dF(){var bG=createShadowRoot("x-navbar");nF("x-navbar",new qC({"x-navbar":"[is=\"x-navbar\"]"}));ZG=gF("x-navbar");aG=new iC(bG);bG.nodes.add(kD.clone(true));aG.kB();} hF(){aG.insert();} lF(){aG.remove();aG=null;}var cG=''; get VC{if(v){FB(this,l.u,'activeid');}return cG;}set VC( g){if(MB(this)){t(this,l.u,'activeid',cG,g);}cG=g;}sC(){o.query('#${VC}').className="active";}}const yC='/dry/service-rules-usage';const lD='8888';const zC='Rules / PMT';var AD;var BD;var xB=qB(new List<String>());var CD=qB(new List<String>());var yB=qB(new List<String>());var zB=qB(new List<String>());var mB=qB(new List<String>());var AC=qB(new List<String>());final YC=new BB();var ZC='CTCS2X/315'; get WB{if(v){FB(YC,l.u,'selectedFormat');}return ZC;}set WB( g){if(MB(YC)){t(YC,l.u,'selectedFormat',ZC,g);}ZC=g;}var SB='b2bowner@stg';var TB='315';var XB='Exception';var eB='*';var nB='*';mD(){nD();} fB(){return o.window.location.protocol+'//'+o.window.location.hostname+':${AD}${BD}';} nD(){AD=o.window.location.port=='3030'?lD:o.window.location.port;BD=o.window.location.port=='3030'?yC:'/dry'+yC;oD();} oD(){var g=fB()+'?opt=datasources';var i=o.HttpRequest.getString(g).then((h){CD.addAll(lB.parse(h));DD();});} DD(){var g=fB()+'?opt=formats&ds=${SB}';var i=o.HttpRequest.getString(g).then((h){xB.clear();xB.addAll(lB.parse(h));if(!xB.contains(WB))WB=xB.first;ED();});} ED(){var g=fB()+'?opt=convTypes&ds=${SB}&fmt=${WB}';var i=o.HttpRequest.getString(g).then((h){yB.clear();yB.addAll(lB.parse(h));if(!yB.contains(TB))TB=yB.first;FD();});} FD(){var g=fB()+'?opt=segments&ds=${SB}&fmt=${WB}&cvt=${TB}';var i=o.HttpRequest.getString(g).then((h){zB.clear();zB.addAll(lB.parse(h));if(!zB.contains(XB))XB=zB.first;GD();});} GD(){var g=fB()+'?opt=fields&ds=${SB}&fmt=${WB}&cvt=${TB}&seg=${XB}';var i=o.HttpRequest.getString(g).then((h){mB.clear();mB.addAll(lB.parse(h));mB.add('*');if(!mB.contains(eB))eB=mB.first;HD();});} HD(){var g=fB()+'?opt=cases&ds=${SB}&fmt=${WB}&cvt=${TB}&seg=${XB}&snum=${eB}';var i=o.HttpRequest.getString(g).then((h){AC.clear();AC.addAll(lB.parse(h));if(!AC.contains(nB))nB=AC.first;ID();});} ID(){var k=fB()+'?opt=matrix&ds=${SB}&fmt=${WB}&cvt=${TB}&seg=${XB}&snum=${eB}&case=${nB}';var q=o.HttpRequest.getString(k).then((m){var g=lB.parse(m);var j=new sD("matrix",['fancyTable']);var h=new List();h.add(zC);h.addAll(g['tpIds']);j.ZF(h);j.YF(h,g['keys'],g['sequences'],g['paths']);var i=o.query('#div-matrix');if(i.hasChildNodes())i.children.removeLast();tD(j,i);rD("#matrix",g['paths'].length);});} pD(){DD();} qD(){ED();} rD( i, g){var h=(g+1)*40>750?750:((g+1)*40)+10;IE((){var j=JE({'footer':h>=750,'cloneHeadToFoot':true,'height':h,'fixedColumns':1});GE.QG(i).PG(j);});}class sD extends JD{var fG;sD( h, g){fG=new o.Element.tag("table");fG.id=h;fG.classes=g;} ZF( q,[ k, j]){var i=new o.Element.tag('thead');var g=new o.Element.tr();if(k!=null)g.classes=k;i.nodes.add(g);q.forEach((m){var h=new o.Element.th();if(j!=null)h.classes=j;h.text=m;g.nodes.add(h);});fG.nodes.add(i);} YF( WC, oF, OB, j){var k=new o.Element.tag('tbody');oF.forEach((i){var q=new o.Element.tr();k.nodes.add(q);var cB=0;WC.forEach((m){var DB=i+"-"+m;var g=' ';if(m!=zC){if(OB.containsKey(DB))g='<span class="label label-info">'+OB[DB]+'</span>';}else{g='<p><span class="badge">'+j[i]['ruleCase']+'</span> '+j[i]['segNum']+" / "+j[i]['ruleName']+"</p>";}var h=new o.Element.td();if(g.contains("span")){if(cB++ >0)h.attributes={"align":"center"};h.nodes.add(new o.Element.html(g));}else h.text=g;q.nodes.add(h);});});fG.nodes.add(k);} get elements{var g=new List();g.add(fG);return g;}}abstract class JD{var elements;} tD( h,[ g]){if(g==null){g=o.document.body;}g.nodes.addAll(h.elements);} uD(){var gG=o.document.body;final hG=new o.OptionElement(),iG=new o.OptionElement(),jG=new o.OptionElement(),kG=new o.OptionElement(),lG=new o.OptionElement(),mG=new o.OptionElement();var nG,oG,pG,qG,rG,sG,tG;var uG=new iC(gG);nG=gG.nodes[3];uG.KB(()=>'t-rbase',(g){if(nG.xtag.VC!=g)nG.xtag.VC=g;},false,false);uG.uB(new zF()..host=nG);rG=gG.nodes[5].nodes[3].nodes[1].nodes[1];uG.listen(rG.onChange,(j){SB=rG.value;});uG.listen(rG.onChange,(j){pD();});uG.KB(()=>SB,(g){if(rG.value!=g)rG.value=g;},false,false);uG.wB(rG,()=>CD,(i,h,uG){var q=i[h];var vG;vG=hG.clone(true);var wG=uG.vB(()=>q,false);vG.nodes.add(wG);uG.KB(()=>SB==q,(g){if(vG.selected!=g)vG.selected=g;},false,false);uG.addAll([new o.Text('\n            '),vG,new o.Text('\n          ')]);});sG=gG.nodes[5].nodes[3].nodes[3].nodes[1];uG.listen(sG.onChange,(j){WB=sG.value;});uG.listen(sG.onChange,(j){qD();});uG.KB(()=>WB,(g){if(sG.value!=g)sG.value=g;},false,false);uG.wB(sG,()=>xB,(i,h,uG){var DB=i[h];var xG;xG=iG.clone(true);var yG=uG.vB(()=>DB,false);xG.nodes.add(yG);uG.KB(()=>WB==DB,(g){if(xG.selected!=g)xG.selected=g;},false,false);uG.addAll([new o.Text('\n            '),xG,new o.Text('\n          ')]);});tG=gG.nodes[5].nodes[3].nodes[5].nodes[1];uG.listen(tG.onChange,(j){TB=tG.value;});uG.listen(tG.onChange,(j){FD();});uG.KB(()=>TB,(g){if(tG.value!=g)tG.value=g;},false,false);uG.wB(tG,()=>yB,(i,h,uG){var k=i[h];var zG;zG=jG.clone(true);var AH=uG.vB(()=>k,false);zG.nodes.add(AH);uG.KB(()=>TB==k,(g){if(zG.selected!=g)zG.selected=g;},false,false);uG.addAll([new o.Text('\n            '),zG,new o.Text('\n          ')]);});oG=gG.nodes[5].nodes[3].nodes[7].nodes[1];uG.listen(oG.onChange,(j){XB=oG.value;});uG.listen(oG.onChange,(j){GD();});uG.KB(()=>XB,(g){if(oG.value!=g)oG.value=g;},false,false);uG.wB(oG,()=>zB,(i,h,uG){var m=i[h];var BH;BH=kG.clone(true);var CH=uG.vB(()=>m,false);BH.nodes.add(CH);uG.KB(()=>XB==m,(g){if(BH.selected!=g)BH.selected=g;},false,false);uG.addAll([new o.Text('\n            '),BH,new o.Text('\n          ')]);});pG=gG.nodes[5].nodes[3].nodes[9].nodes[1];uG.listen(pG.onChange,(j){eB=pG.value;});uG.listen(pG.onChange,(j){HD();});uG.KB(()=>eB,(g){if(pG.value!=g)pG.value=g;},false,false);uG.wB(pG,()=>mB,(i,h,uG){var cB=i[h];var DH;DH=lG.clone(true);var EH=uG.vB(()=>cB,false);DH.nodes.add(EH);uG.KB(()=>eB==cB,(g){if(DH.selected!=g)DH.selected=g;},false,false);uG.addAll([new o.Text('\n            '),DH,new o.Text('\n          ')]);});qG=gG.nodes[5].nodes[3].nodes[11].nodes[1];uG.listen(qG.onChange,(j){nB=qG.value;});uG.listen(qG.onChange,(j){ID();});uG.KB(()=>nB,(g){if(qG.value!=g)qG.value=g;},false,false);uG.wB(qG,()=>AC,(i,h,uG){var OB=i[h];var FH;FH=mG.clone(true);var GH=uG.vB(()=>OB,false);FH.nodes.add(GH);uG.KB(()=>nB==OB,(g){if(FH.selected!=g)FH.selected=g;},false,false);uG.addAll([new o.Text('\n            '),FH,new o.Text('\n          ')]);});uG.kB();uG.insert();}main(){WD=true;YB.fC.kF.listen((g){print('${g.OC.name.toLowerCase()}: ${g.message}');});mD();uD();}class vD implements o.Element{var HH;var IH;var JH={}; get host{if(HH==null)throw new StateError('host element has not been set.');return HH;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(HH!=null){throw new StateError('host can only be set once.');}g.xtag=this;HH=g;}createShadowRoot([ g]){var h=host.createShadowRoot();if(g!=null){JH[g]=h;}return h;} cD(){} sC(){} hD(){} get nodes=>host.nodes; replaceWith( g){host.replaceWith(g);} remove()=>host.remove(); get document=>host.document;set text( g){host.text=g;} contains( g)=>host.contains(g); hasChildNodes()=>host.hasChildNodes(); insertBefore( g, h)=>host.insertBefore(g,h); insertAllBefore( g, h)=>host.insertAllBefore(g,h); get attributes=>host.attributes;set attributes( g){host.attributes=g;} get elements=>host.children; get children=>host.children; get classes=>host.classes;set classes( g){host.classes=g;} clone( g)=>host.clone(g); get parent=>host.parent; get parentNode=>host.parentNode; get nodeValue=>host.nodeValue;dynamic get on{throw new UnsupportedError('on is deprecated');} get id=>host.id;set id( g){host.id=g;} set innerHtml( g){host.innerHtml=g;} get tagName=>host.tagName; matches( g)=>host.matches(g); matchesWithAncestors( g)=>host.matchesWithAncestors(g); query( g)=>host.query(g); queryAll( g)=>host.queryAll(g); get LF=>host.LF; get className=>host.className;set className( g){host.className=g;} get MF=>host.MF; get PF=>host.PF; NF( g)=>host.NF(g); OF( g)=>host.OF(g); SF( g)=>host.SF(g); TF( g)=>host.TF(g); XF( h, g)=>host.XF(h,g);get JF=>host.JF; get KF=>host.KF; get firstChild=>host.firstChild; get localName=>host.localName; get QF=>host.QF; get RF=>host.RF; IF( i, g,[ h]){host.IF(i,g,h);} dispatchEvent( g)=>host.dispatchEvent(g); UF( g)=>host.UF(g); VF( i, g,[ h]){host.VF(i,g,h);} WF( g, h)=>host.WF(g,h);get xtag=>host.xtag;set xtag(g){host.xtag=g;} append( g)=>host.append(g); get onChange=>host.onChange; get onError=>host.onError; get onLoad=>host.onLoad;}final wD=r"""
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
"""; xD(h){final g=new o.ScriptElement();g.type='text/javascript';g.innerHtml=h;o.document.body.nodes.add(g);}var BC=null;var yD=null;var zD=null;var KD=null;var AE=null;var BE=null;var CE=null;var LD=null;var MD=null;var ND=null;var DE=null;var EE=null;var OD=null;var PD=null; FE(){if(BC!=null)return;try {BC=o.window.lookupPort('dart-js-interop-context');}catch (h){}if(BC==null){xD(wD);BC=o.window.lookupPort('dart-js-interop-context');}yD=o.window.lookupPort('dart-js-interop-create');zD=o.window.lookupPort('dart-js-interop-proxy-count');KD=o.window.lookupPort('dart-js-interop-equals');AE=o.window.lookupPort('dart-js-interop-instanceof');BE=o.window.lookupPort('dart-js-interop-has-property');CE=o.window.lookupPort('dart-js-interop-delete-property');LD=o.window.lookupPort('dart-js-interop-convert');MD=o.window.lookupPort('dart-js-interop-enter-scope');ND=o.window.lookupPort('dart-js-interop-exit-scope');DE=o.window.lookupPort('dart-js-interop-globalize');EE=o.window.lookupPort('dart-js-interop-invalidate');OD=new o.ReceivePortSync()..receive((KH)=>aC());PD=new o.ReceivePortSync()..receive((g)=>bC(g[0]));o.window.registerPort('js-dart-interop-enter-scope',OD.toSendPort());o.window.registerPort('js-dart-interop-exit-scope',PD.toSendPort());} get GE{PC();return DC(BC.callSync([] ));}get HE=>PB.LH.length; PC(){if(HE==0){var g=aC();dB.runAsync(()=>bC(g));}}IE(g){var h=aC();try {return g();}finally {bC(h);}} aC(){FE();PB.eF();MD.callSync([] );return PB.LH.length;} bC( g){assert(PB.LH.length==g);ND.callSync([] );PB.fF();} JE( g)=>new UB.RG(g);class AG{const AG();}const gB=const AG(); KE(i,m,k,j,DB,q){final g=[i,m,k,j,DB,q];final h=g.indexOf(gB);if(h<0)return g;return g.sublist(0,h);}class UB implements dC<UB>{var MH;final NH;factory UB.RG(g){PC();return LE(g);}static LE(g){return DC(LD.callSync(cC(g)));}static cC(g){if(g is Map){final h=new List();for(var i in g.keys){h.add([i,cC(g[i])]);}return ['map',h];}else if(g is Iterable){return ['list',g.map(cC).toList()];}else{return ['simple',oB(g)];}}UB.SG(this.MH,this.NH); jD()=>this;operator[](g)=>CC(this,'[]','method',[g]);operator[]=(h,g)=>CC(this,'[]=','method',[h,g]);operator==(g)=>identical(this,g)?true:(g is UB&&KD.callSync([oB(this),oB(g)])); toString(){try {return CC(this,'toString','method',[] );}catch (g){return super.toString();}}noSuchMethod( i){var g=pF.MirrorSystem.getName(i.memberName);if(g.indexOf('@')!=-1){g=g.substring(0,g.indexOf('@'));}var h;var j=i.positionalArguments;if(j==null)j=[] ;if(i.isGetter){h='get';}else if(i.isSetter){h='set';if(g.endsWith('=')){g=g.substring(0,g.length-1);}}else if(g=='call'){h='apply';}else{h='method';}return CC(this,g,h,j);}static CC( g, i, k, j){PC();var h=g.MH.callSync([g.NH,i,k,j.map(oB).toList()]);switch (h[0]){case 'return':return DC(h[1]);case 'throws':throw DC(h[1]);case 'none':throw new NoSuchMethodError(g,i,j,{});default:throw 'Invalid return value';}}}class QD extends UB implements dC<QD>{QD.SG( h,g):super.SG(h,g);call([g=gB,j=gB,i=gB,h=gB,q=gB,k=gB]){var m=KE(g,j,i,h,q,k);return UB.CC(this,'','apply',m);}}abstract class dC<ME>{ jD();}class NE{final  OH;var PH;var QH;final  RH;final  MH;final  SH;final  TH;final  LH;eF(){LH.add(TH.length);}fF(){var h=LH.removeLast();for(int g=h;g<TH.length; ++g){var i=TH[g];if(!SH.contains(i)){RH.remove(TH[g]);QH++ ;}}if(h!=TH.length){TH.removeRange(h,TH.length-h);}}NE():OH='dart-ref',PH=0,QH=0,RH={},MH=new o.ReceivePortSync(),TH=new List<String>(),LH=new List<int>(),SH=new Set<String>(){MH.receive((g){try {final h=RH[g[0]];final k=g[1];final j=g[2].map(DC).toList();if(k=='#call'){final m=h as Function;var q=oB(m(j));return ['return',q];}else{throw 'Invocation unsupported on non-function Dart proxies';}}catch (i){return ['throws','${i}'];}});} add(h){PC();final g='${OH}-${PH++ }';RH[g]=h;TH.add(g);return g;}Object get( g){return RH[g];}get wC=>MH.toSendPort();}var PB=new NE();oB(var g){if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is EB.SendPortSync){return g;}else if(g is o.Element&&(g.document==null||g.document==o.document)){return ['domref',PE(g)];}else if(g is QD){return ['funcref',g.NH,g.MH];}else if(g is UB){return ['objref',g.NH,g.MH];}else if(g is dC){return oB(g.jD());}else{return ['objref',PB.add(g),PB.wC];}}DC(var g){m(g){var h=g[1];var i=g[2];if(i==PB.wC){return PB.get(h);}else{return new QD.SG(i,h);}}k(g){var h=g[1];var i=g[2];if(i==PB.wC){return PB.get(h);}else{return new UB.SG(i,h);}}if(g==null){return null;}else if(g is String||g is num||g is bool){return g;}else if(g is EB.SendPortSync){return g;}var j=g[0];switch (j){case 'funcref':return m(g);case 'objref':return k(g);case 'domref':return QE(g[1]);}throw 'Unsupported serialized data: ${g}';}var OE=0;const QC='data-dart_id';const VB='data-dart_temporary_attached';PE( h){var i;if(h.attributes.containsKey(QC)){i=h.attributes[QC];}else{i='dart-${OE++ }';h.attributes[QC]=i;}if(!identical(h,o.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(VB)){final j=g.attributes[VB];final k=j+'a';g.attributes[VB]=k;break;}if(g.parent==null){g.attributes[VB]='a';o.document.documentElement.children.add(g);break;}if(identical(g.parent,o.document.documentElement)){break;}g=g.parent;}}return i;} QE(var i){var j=o.queryAll('[${QC}="${i}"]');if(j.length>1)throw 'Non unique ID: ${i}';if(j.length==0){throw 'Only elements attached to document can be serialized: ${i}';}final h=j[0];if(!identical(h,o.document.documentElement)){var g=h;while (true){if(g.attributes.containsKey(VB)){final k=g.attributes[VB];final m=k.substring(1);g.attributes[VB]=m;if(g.attributes[VB].length==0){g.attributes.remove(VB);g.remove();}break;}if(identical(g.parent,o.document.documentElement)){break;}g=g.parent;}}return h;}var eC=false;var RE=AB.RD;class YB{final  name; get eD=>(parent==null||parent.name=='')?name:'${parent.eD}.${name}';final  parent;var UH;var children;var VH;var WH;factory YB( g){if(g.startsWith('.')){throw new ArgumentError("name shouldn't start with a '.'");}if(EC==null)EC=<String,YB>{};if(EC.containsKey(g))return EC[g];var j=g.lastIndexOf('.');var h=null;var i;if(j==-1){if(g!='')h=new YB('');i=g;}else{h=new YB(g.substring(0,j));i=g.substring(j+1);}final k=new YB.TG(i,h);EC[g]=k;return k;}YB.TG(this.name,this.parent):children=new Map<String,YB>(){if(parent!=null)parent.children[name]=this;} get OC{if(eC){if(UH!=null)return UH;if(parent!=null)return parent.OC;}return RE;} get kF=>XH(); iF( g)=>(g>=OC); log( i, k,[j]){if(iF(i)){var h=new FC(i,k,eD,j);if(eC){var g=this;while (g!=null){g.YH(h);g=g.parent;}}else{fC.YH(h);}}} info( h,[g])=>log(AB.RD,h,g); xC( h,[g])=>log(AB.SE,h,g); XH(){if(eC||parent==null){if(VH==null){VH=new dB.StreamController<FC>.broadcast(sync:true);WH=VH.stream;}return WH;}else{return fC.XH();}} YH( g){if(VH!=null){VH.add(g);}}static  get fC=>new YB('');static var EC;}class AB implements Comparable<AB>{final  name;final  value;const AB(this.name,this.value);static const  RD=const AB('INFO',800);static const  SE=const AB('WARNING',900); operator==( g)=>g!=null&&value==g.value; operator<( g)=>value<g.value; operator<=( g)=>value<=g.value; operator>( g)=>value>g.value; operator>=( g)=>value>=g.value; compareTo( g)=>value-g.value; get hashCode=>value; toString()=>name;}class FC{final  OC;final  message;final  jF;final  time;final  mF;static var TE=0;var exception;FC(this.OC,this.message,this.jF,[this.exception]):time=new DateTime.now(),mF=FC.TE++ ;}const BG=const CG();class CG{const CG();}class UE<ZB> extends rE with BB implements List<ZB>{final  ZH;UE([ g]):ZH=g!=null?new List<ZB>(g):<ZB>[] ;factory UE.UG( g)=>new UE<ZB>()..addAll(g); get length{if(v)FB(this,l.u,'length');return ZH.length;}set length( h){var i=ZH.length;if(i==h)return;if(MB(this)){if(h<i){for(int g=i-1;g>=h;g-- ){t(this,l.aB,g,ZH[g],null);}t(this,l.u,'length',i,h);}else{t(this,l.u,'length',i,h);for(int g=i;g<h;g++ ){t(this,l.hB,g,null,null);}}}ZH.length=h;} operator[]( g){if(v)FB(this,l.LB,g);return ZH[g];}operator[]=( g, h){var i=ZH[g];if(MB(this)){t(this,l.LB,g,i,h);}ZH[g]=h;} sublist( h,[ g])=>new UE<ZB>.UG(super.sublist(h,g)); add( h){var g=ZH.length;if(MB(this)){t(this,l.u,'length',g,g+1);t(this,l.hB,g,null,h);}ZH.add(h);} removeRange( h, g){if(g==0)return;UD.pE(this,h,g);if(MB(this)){for(int i=h;i<g;i++ ){t(this,l.aB,i,this[i],null);}}UD.oE(this,h+g,this,h,this.length-g-h);this.length=this.length-g;} toString(){if(v){for(int g=0;g<length;g++ ){FB(this,l.LB,g);}}return ZH.toString();}}typedef  GC<GB,CB>();class pB<GB,CB> extends BB implements Map<GB,CB>{final  aH;var bH;var cH;pB({ createMap}):aH=createMap!=null?createMap():new Map<GB,CB>(){bH=new VE<GB,CB>(this);cH=new WE<GB,CB>(this);}factory pB.VG( i,{ createMap}){var g=new pB(createMap:createMap);i.forEach((h,j){g[h]=j;});return g;} get keys=>bH; get values=>cH; get length{if(v)FB(this,l.u,'length');return aH.length;} get isEmpty=>length==0; get isNotEmpty=>length!=0; dH( g)=>FB(this,l.LB,g); eH(){FB(this,l.u,'length');aH.keys.forEach(dH);} containsKey( g){if(v)dH(g);return aH.containsKey(g);} operator[]( g){if(v)dH(g);return aH[g];} operator[]=( h, g){var j=aH.length;var i=aH[h];aH[h]=g;if(MB(this)){if(j!=aH.length){t(this,l.u,'length',j,aH.length);t(this,l.hB,h,i,g);}else if(i!=g){t(this,l.LB,h,i,g);}}} putIfAbsent( g, j()){if(v)dH(g);var h=aH.length;var i=aH.putIfAbsent(g,j);if(MB(this)&&h!=aH.length){t(this,l.u,'length',h,aH.length);t(this,l.hB,g,null,i);}return i;} remove( g){if(v)dH(g);var h=aH.length;var i=aH.remove(g);if(MB(this)&&h!=aH.length){t(this,l.aB,g,i,null);t(this,l.u,'length',h,aH.length);}return i;} addAll( h)=>h.forEach((g,i){this[g]=i;}); clear(){var g=aH.length;if(MB(this)&&g>0){aH.forEach((i,h){t(this,l.aB,i,h,null);});t(this,l.u,'length',g,0);}aH.clear();} forEach( g( key, value)){if(v)eH();aH.forEach(g);} toString()=>XC.Maps.mapToString(this);}class VE<GB,CB> extends XC.IterableBase<GB>{final  aH;VE(this.aH); get iterator=>new DG<GB,CB>(aH);}class DG<GB,CB> implements Iterator<GB>{final  aH;final  bH;var fH=false;DG( g):aH=g,bH=g.aH.keys.iterator; moveNext(){if(v)FB(aH,l.u,'length');return fH=bH.moveNext();} get current{var g=bH.current;if(v&&fH)aH.dH(g);return g;}}class WE<GB,CB> extends XC.IterableBase<CB>{final  aH;WE(this.aH); get iterator=>new EG<GB,CB>(aH);}class EG<GB,CB> implements Iterator<CB>{final  aH;final  bH;final  cH;var fH;EG( g):aH=g,bH=g.aH.keys.iterator,cH=g.aH.values.iterator; moveNext(){if(v)FB(aH,l.u,'length');var h=bH.moveNext();var g=cH.moveNext();if(h!=g){throw new StateError('keys and values should be the same length');}return fH=g;} get current{if(v&&fH)aH.dH(bH.current);return cH.current;}}typedef  QB( e);typedef  XE( changes);typedef  RB();typedef  YE();class RC{final oldValue;final newValue;final  changes;RC(this.oldValue,this.newValue,[this.changes]); operator==(g){return g is RC&&oldValue==g.oldValue&&newValue==g.newValue&&changes==g.changes;} get hashCode=>lE(oldValue,newValue,changes); toString(){if(changes!=null)return '#<ChangeNotification to ${newValue}: ${changes}>';return '#<ChangeNotification from ${oldValue} to ${newValue}>';}}class l{static const u=1;static const LB=2;static const hB=LB|4;static const aB=LB|8;final  type;final key;final oldValue;final newValue;l(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is l&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>mE(type,key,oldValue,newValue); toString(){var g;switch (type){case u:g='field';break;case LB:g='index';break;case hB:g='insert';break;case aB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}} ZE(g, i,[ k]){if(g is BB){var h=g;return gC(h,(m){i(new RC(h,h,m));});}var j=new SC(g,i,k);if(!j.gH()){return bE;}return j.hH;} gC( g, i){if(g.tB==null)g.tB=new hC();var h=g.tB.add(i);return h.remove;}qB(g){if(g is Map){var h=null;if(g is XC.SplayTreeMap){h=()=>new XC.SplayTreeMap();}else if(g is XC.LinkedHashMap){h=()=>new XC.LinkedHashMap();}return new pB.VG(g,createMap:h);}if(g is Set)return new TD.WG(g);if(g is Iterable)return new UE.UG(g);return g;}class BB{var tB;var sB;final  hashCode= ++BB.aE;static var aE=0;} MB( g)=>g.tB!=null&&g.tB.head!=null; get v=>rB!=null; FB( g, h,i)=>rB.iH(g,h,i); t( g, j,k, h, i){if((j&(l.hB|l.aB))==0){if(h==i)return;}if(iB==null){iB=[] ;nE(cE);}if(g.sB==null){g.sB=[] ;iB.add(g);}g.sB.add(new l(j,k,h,i));} bE(){}var rB;var SD=100;var iB;var jB; cE(){var m=0;while (iB!=null||jB!=null){var j=iB;iB=null;var i=jB;jB=null;if(m++ ==SD){dE(j,i);return;}if(j!=null){for(var h in j){var DB=h.sB;h.sB=null;for(var g=h.tB.head;g!=null;g=g.next){var k=g.value;try {k(DB);}catch (OB,q){HC(OB,q,k,'from ${h}');}}}}if(i!=null){i.forEach((WC,cB){cB.jH();});}}} dE( k, j){var g=[] ;if(k!=null){for(var i in k){var DB=i.sB;g.add('${i} ${DB}');}}if(j!=null){for(var m in j.values){var h=m.jH();if(h!=null)g.add('${m} ${h}');}}iB=null;jB=null;var q='exceeded notifiction limit of ${SD}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';gE(q);}class SC{static var eE=0;final  kH= ++SC.eE;final  lH;final  mH;final  nH;final  oH=new Map();final  pH=[] ;var qH=false;var rH;SC(this.lH,this.mH,this.nH); toString()=>nH!=null?'<observer ${kH}: ${nH}>':'<observer ${kH}>'; gH(){var h=rB;rB=this;try {rH=lH();if(rH is Iterable&&rH is !List&&rH is !BB){rH=(rH as Iterable).toList();}}catch (g,i){HC(g,i,lH,'from ${this}');rH=null;}oH.forEach(sH);oH.clear();assert(rB==this);rB=h;tH();return pH.length>0;} uH( i){try {mH(i);}catch (g,h){HC(g,h,mH,'from ${this}');}} tH(){var g=rH;if(g is !BB)return;pH.add(gC(g,(h){uH(new RC(g,g,h));}));} iH( m, q,g){var i=oH.putIfAbsent(m,()=>new Map());try {var h=i[g];if(h==null)h=0;i[g]=h|q;}catch (j,k){HC(j,k,g,'hashCode or operator == from ${this}');}} sH( i, j){pH.add(gC(i,(k){if(qH)return;for(var g in k){var h=j[g.key];if(h!=null&&(h&g.type)!=0){qH=true;if(jB==null){jB=new XC.SplayTreeMap();}jB[kH]=this;return;}}}));} hH(){for(var g in pH){g();}qH=false;} jH(){if(!qH)return null;var g=rH;hH();gH();try {if(g==rH)return null;}catch (i,j){HC(i,j,g,'operator == from ${this}');return null;}var h=new RC(g,rH);uH(h);return h;}}typedef  fE( message);var gE=(g)=>print(g);typedef  hE(error,stackTrace,obj, message);var HC=iE; iE(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class TD<NB> extends qE with BB implements Set<NB>{final  vH;final  wH;TD({ createMap}):vH=createMap!=null?createMap():new Map<NB,Object>(),wH=createMap;factory TD.WG( g,{ createMap}){return new TD<NB>(createMap:createMap)..addAll(g);} contains( g){if(v)FB(this,l.LB,g);return vH.containsKey(g);} add( g){var h=vH.length;vH[g]=const Object();if(h!=vH.length){t(this,l.u,'length',h,vH.length);t(this,l.hB,g,null,g);}} remove( g){if(v)FB(this,l.LB,g);var h=vH.length;vH.remove(g);if(h!=vH.length){if(MB(this)){t(this,l.aB,g,g,null);t(this,l.u,'length',h,vH.length);}return true;}return false;} clear(){if(MB(this)){for(var g in vH.keys){t(this,l.aB,g,g,null);}t(this,l.u,'length',vH.length,0);}vH.clear();} get length{if(v)FB(this,l.u,'length');return vH.length;} get isEmpty=>length==0; get iterator=>new FG<NB>(this); addAll( g)=>g.forEach(add); toString(){if(v){for(NB g in vH.keys){FB(this,l.LB,g);}}return vH.keys.toSet().toString();}}class FG<NB> implements Iterator<NB>{final  xH;final  yH;var zH=false;FG( g):xH=g,yH=g.vH.keys.iterator; moveNext(){xH.length;return zH=yH.moveNext();} get current{var g=yH.current;if(v&&zH)FB(xH,l.LB,g);return g;}}class jE{}class kE{}class IB<JB>{var AI;var BI;var CI;var DI;IB.XG( g,this.CI):DI=g{if(CI!=null)CI.EI++ ;} get next=>BI; get value=>DI;set value( g)=>DI=g; FI( g, h){BI=h;AI=g;if(g!=null)g.BI=this;if(h!=null)h.AI=this;return this;} append( g)=>new IB<JB>.XG(g,CI).FI(this,BI); remove(){if(CI==null)return;CI.EI-- ;if(AI!=null){AI.BI=BI;}else{CI.GI=BI;}if(BI!=null){BI.AI=AI;}else{CI.HI=AI;}BI=null;AI=null;CI=null;}}class hC<JB> extends XC.IterableBase<JB>{var GI;var HI; get length=>EI;var EI=0;hC(){} get head=>GI; add( h){var g=new IB<JB>.XG(h,this);if(HI==null)return GI=HI=g;return HI=g.FI(HI,null);} addLast( g)=>add(g); addAll( g)=>g.forEach(add); get iterator=>new GG<JB>(this);}class GG<JB> implements Iterator<JB>{var II;var CI;var JI;var KI=-1;GG(this.CI){II=new List<IB>(CI.length);var h=0;var g=CI.head;while (g!=null){II[h++ ]=g;g=g.next;}} get current=>JI; moveNext(){do{KI++ ;}while(KI<II.length&&II[KI].CI!=CI);if(KI<II.length){JI=II[KI].value;return true;}else{JI=null;return false;}}}IC(h,g)=>h.hashCode*31+g.hashCode;lE(h,g,i)=>IC(IC(h,g),i);mE(g,i,h,j)=>IC(IC(g,i),IC(h,j)); nE( h()){var g=new EB.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);}class UD{static  oE( m, g, q, i, k){if(g==null)g=0;if(i==null)i=0;if(g<i){for(int h=g+k-1,j=i+k-1;h>=g;h-- ,j-- ){q[j]=m[h];}}else{for(int h=g,j=i;h<g+k;h++ ,j++ ){q[j]=m[h];}}}static  pE( j, h, g){if(g<0){throw new ArgumentError("negative length ${g}");}if(h<0){var i="${h} must be greater than or equal to 0";throw new RangeError(i);}if(h+g>j.length){var i="${h} + ${g} must be in the range [0..${j.length})";throw new RangeError(i);}}}abstract class qE extends XC.IterableBase<dynamic>{}abstract class rE extends XC.ListMixin<dynamic>{} sE(i, g,[ h]){var j=i is jE;if(h==null){h=i.toString();}if(!j&&g is o.Text){g.text=h;}else{var k=g;g=j?new o.Element.html(h):new o.Text(h);k.replaceWith(g);}return g;} tE(g){if(g is kE)return g.toString();g=g.toString();return vE(g)?g:'#';}const uE=const["http","https","ftp","mailto"]; vE( h){var g=Uri.parse(h).scheme;if(g=='')return true;return uE.contains(g.toLowerCase())||"MAILTO"==g.toUpperCase();}abstract class JC{ kB(){} insert(); remove();}class HG extends JC{final  dD;var LI;final  listener;HG(this.dD,this.listener); insert(){LI=dD.listen(listener);} remove(){LI.cancel();LI=null;}}abstract class VD extends JC{final exp;final  isFinal;final  rC;var bB;VD(this.exp,this.isFinal):rC=jC&&TC!=null?TC():null; insert(){if(isFinal){tC();}else if(bB!=null){throw new StateError('binding already attached');}else{bB=vC();}} remove(){if(!isFinal){bB();bB=null;}} tC(); vC();}class IG extends VD{final  action;IG(g,this.action, h):super(g,h); tC()=>action(new RC(null,exp())); vC()=>kC(exp,action,'generic-binding',rC);}class JG extends VD{final  iD;final  fD;JG( g,this.iD,this.fD, h):super(g,h); MI(g){iD(fD?tE(g):g);} tC()=>MI(exp()); vC()=>kC(exp,(g)=>MI(g.newValue),'dom-property-binding',rC);}class KG extends JC{final uB;KG(this.uB); kB(){uB..dF()..cD()..cF();} insert(){uB..sC()..hF();} remove(){uB..lF()..hD();}}class iC extends JC{final  uC;final  children=[] ;final  nodes=[] ;iC(this.uC); listen( i, h){children.add(new HG(i,(g){h(g);AF();}));} vB( h,i){var g=new o.Text('');children.add(new IG(()=>'${h()}',(j){g=sE(h(),g,j.newValue);},i));return g;} KB(g,j,h,[i=false]){children.add(new JG(g,j,i,h));} wB( h,g,i){children.add(new LG(h,g,i));} uB( g){children.add(new KG(g));} add( g)=>nodes.add(g); addAll( g)=>nodes.addAll(g); kB(){for(var g=0,h=children.length;g<h;g++ ){children[g].kB();}} insert(){for(var g=0,h=children.length;g<h;g++ ){children[g].insert();}} remove(){for(var g=children.length-1;g>=0;g-- ){children[g].remove();}children.clear();}}typedef  wE( list, index, template);class LG extends iC{final  gD;final exp;var bB;LG( g,this.exp,this.gD):super(g); kB(){} insert(){bB=kC(exp,(i){NI();var h=i.newValue;for(int g=0;g<h.length;g++ ){gD(h,g,this);}super.kB();uC.nodes.addAll(nodes);super.insert();},'loop-attribute-binding');} NI(){super.remove();uC.nodes.clear();nodes.clear();} remove(){NI();bB();bB=null;}}var WD=false;var jC=false;var TC=(){try {throw "";}catch (h,g){return g.toString();}};final  KC=new YB('watcher'); xE(g, q,[ j, m]){if(WD)return ZE(g,q);if(q==null)return (){};if(LC==null)LC=new hC<MC>();j=j==null?'<unnamed>':j;var i;var h=HB.EF;if(g is ZD){i=(g as ZD).OI;}else if(g is Function){i=g;try {var k=g();if(k is List){h=HB.NC;}else if(k is Iterable){h=HB.NC;i=()=>g().toList();}else if((k is XC.LinkedHashMap)||(k is XC.SplayTreeMap)){h=HB.nC;}else if(k is Map){h=HB.mC;}}catch (DB,cB){KC.xC('evaluating ${j} watcher threw error (${DB}, ${cB})');}}else if(g is List){i=()=>g;h=HB.NC;}else if(g is Iterable){i=()=>g.toList();h=HB.NC;}else if((g is XC.LinkedHashMap)||(g is XC.SplayTreeMap)){i=()=>g;h=HB.nC;}else if(g is Map){i=()=>g;h=HB.mC;}if(jC&&m==null&&TC!=null){m=TC();}var WC=yE(h,i,q,j,m);var OB=LC.add(WC);return OB.remove;} yE( k, g, j, h, i){switch (k){case HB.NC:return new MG(g,j,h,i);case HB.nC:return new OG(g,j,h,i);case HB.mC:return new NG(g,j,h,i);default:return new MC(g,j,h,i);}} kC(h, i,[ j, k]){var m=xE(h,i,j,k);var g=h;if(g is Function){g=g();}if(g is Iterable&&g is !List){g=g.toList();}i(new RC(null,g));return m;}var LC;class MC{final  debugName;var location;final  QI;static var zE=0;final  OI;final  RI;var SI;MC(this.OI,this.RI,this.debugName,this.location):QI=zE++ {SI=OI();} toString()=>'${debugName} (id: #${QI})'; bF(){var g=TI();if(UI(g)){var h=SI;VI(g);RI(new RC(h,g));return true;}return false;} UI(g)=>SI!=g; VI(g){if(jC){if(location!=null){KC.info('watcher updated: ${this}, defined at:\n${location}');location=null;}else{KC.info('watcher updated: ${this}');}}SI=g;}TI(){try {return OI();}catch (g,h){KC.xC('${this} watcher threw an exception: ${g}, ${h}');}return SI;}}final  XD=10; AF(){if(LC==null)return;var g;var h=0;do{g=false;for(var i in LC){if(i.bF()){g=true;}}}while(g&& ++h<XD);if(h==XD){KC.xC('Possible loop in watchers propagation, stopped dispatch.');}}typedef  YD<BF>();typedef  CF<BF>( value);class ZD<BF>{}class MG<BF> extends MC{MG(g, j, h, i):super(g,j,h,i){VI(TI());} UI( g){return lC(SI,g);} VI(g){SI=new List<BF>.from(g);}}class NG<UC,DF> extends MC{NG(g, j, h, i):super(g,j,h,i){VI(TI());} UI( g){var i=SI.keys;if(i.length!=g.keys.length)return true;var j=i.iterator;while (j.moveNext()){var h=j.current;if(!g.containsKey(h))return true;if(SI[h]!=g[h])return true;}return false;} VI(g){SI=new Map<UC,DF>.from(g);}}class OG<UC,DF> extends MC{OG(g, j, h, i):super(g,j,h,i){VI(TI());} UI( g){return lC(g.keys,SI.keys)||lC(g.values,SI.values);} VI(g){SI=new XC.LinkedHashMap.from(g);}} lC( i, j){var h=i.iterator;var g=j.iterator;while (h.moveNext()){if(!g.moveNext())return true;if(h.current!=g.current)return true;}return g.moveNext();}class HB{final WI;const HB.YG(this.WI);toString()=>'Enum.${WI}';static const NC=const HB.YG('LIST');static const mC=const HB.YG('HASH_MAP');static const nC=const HB.YG('ORDERED_MAP');static const EF=const HB.YG('OTHER');}abstract class aD extends vD{var XI;var YI;var ZI={};var aI=new qC({}); gF( g)=>aI; nF( h,var g){aI=g;} get host{if(XI==null)throw new StateError('host element has not been set.');return XI;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(XI!=null){throw new StateError('host can only be set once.');}g.xtag=this;XI=g;}createShadowRoot([ g]){var h=bI();if(g!=null){ZI[g]=h;}return h;}bI(){if(bD){return host.createShadowRoot();}if(YI==null)YI=[] ;YI.add(new o.DivElement());return YI.last;} cD(){} sC(){} hD(){} cF(){if(bD)return;if(YI.length==0){throw new StateError('Distribution algorithm requires at least one shadow' ' root and can only be run once.');}var j=YI;var g=j.removeLast();var q=g;var m=new List.from(nodes);var k=[] ;var DB=[] ;while (true){m=cI(g,m);var h=g.query('shadow');if(h!=null){if(j.length>0){g=j.removeLast();k.add(h);DB.add(g);}else{pC(h,m);break;}}else{break;}}for(int i=0;i<k.length;i++ ){var h=k[i];var g=DB[i];pC(h,g.nodes);}nodes.clear();nodes.addAll(q.nodes);for(var OB in ZI.keys){if(ZI[OB]==q){ZI[OB]=this;break;}}} cI( q, j){for(var g in q.queryAll('content')){if(!GF(g))continue;var i=g.attributes['select'];if(i==null||i=='')i='*';var h=[] ;var m=[] ;for(var k in j){(FF(k,i)?h:m).add(k);}if(h.length==0){h=g.nodes;}pC(g,h);j=m;}return j;}static  FF( h, g){if(h is !o.Element)return g=='*';return (h as o.Element).matches(g);}static  oC( g)=>g.tagName=='CONTENT'||g.tagName=='SHADOW';static  GF( g){assert(oC(g));for(g=g.parent;g!=null;g=g.parent){if(oC(g))return false;}return true;}static  pC( g, h){assert(oC(g));g.parent.insertAllBefore(h,g);g.remove();}}class qC{final  dI;qC(this.dI); operator[]( g)=>dI[g];}var HF=false; get bD=>HF&&o.ShadowRoot.supported;