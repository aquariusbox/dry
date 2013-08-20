import "dart:async" as rB;import "dart:collection" as sB;import "dart:html" as l;import "dart:isolate" as sD;class dD{static const  eD="Chrome";final  QD;final  minimumVersion;const dD(this.QD,[this.minimumVersion]);}class fD{const fD();}class gD{final  name;const gD(this.name);}class hD{const hD();}class iD{const iD();}class jD extends AC with q{var wD;static final MC=new l.DocumentFragment.html('''
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
      ''');var xD; SD(){var yD=createShadowRoot("x-navbar");cD("x-navbar",new oB({"x-navbar":"[is=\"x-navbar\"]"}));wD=TD("x-navbar");xD=new rC(yD);yD.nodes.add(MC.clone(true));xD.TB();} UD(){xD.insert();} aD(){xD.remove();xD=null;}var zD=''; get aB{if(YC){ZC(this,EB.eB,'activeid');}return zD;}set aB( g){if(XC(this)){aC(this,EB.eB,'activeid',zD,g);}zD=g;}pB(){l.query('#${aB}').className="active";}} NC(){} OC(){var BE=l.document.body;var CE;var DE=new rC(BE);CE=BE.nodes[3].nodes[1];DE.ZD(()=>'li-home',(g){if(CE.xtag.aB!=g)CE.xtag.aB=g;},false,false);DE.LB(new jD()..host=CE);DE.TB();DE.insert();}main(){xB=true;CB.dB.YD.listen((g){print('${g.UB.name.toLowerCase()}: ${g.message}');});NC();OC();}class PC implements l.Element{var EE;var FE;var GE={}; get host{if(EE==null)throw new StateError('host element has not been set.');return EE;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(EE!=null){throw new StateError('host can only be set once.');}g.xtag=this;EE=g;}createShadowRoot([ g]){var h=host.createShadowRoot();if(g!=null){GE[g]=h;}return h;} CC(){} pB(){} IC(){} get nodes=>host.nodes; replaceWith( g){host.replaceWith(g);} remove()=>host.remove();set text( g){host.text=g;} contains( g)=>host.contains(g); insertBefore( g, h)=>host.insertBefore(g,h); insertAllBefore( g, h)=>host.insertAllBefore(g,h); get attributes=>host.attributes; get children=>host.children; clone( g)=>host.clone(g); get parent=>host.parent; get parentNode=>host.parentNode; get nodeValue=>host.nodeValue; get id=>host.id;set id( g){host.id=g;} set innerHtml( g){host.innerHtml=g;} get tagName=>host.tagName; matches( g)=>host.matches(g); query( g)=>host.query(g); queryAll( g)=>host.queryAll(g); get ED=>host.ED;set className( g){host.className=g;} get FD=>host.FD; get ID=>host.ID; GD( g)=>host.GD(g); HD( g)=>host.HD(g); LD( g)=>host.LD(g); MD( g)=>host.MD(g); PD( h, g)=>host.PD(h,g);get CD=>host.CD; get DD=>host.DD; get firstChild=>host.firstChild; get localName=>host.localName; get JD=>host.JD; get KD=>host.KD; ND( g)=>host.ND(g); OD( g, h)=>host.OD(g,h);get xtag=>host.xtag;set xtag(g){host.xtag=g;} append( g)=>host.append(g);}var cB=false;var QC=o.tB;class CB{final  name; get EC=>(parent==null||parent.name=='')?name:'${parent.EC}.${name}';final  parent;var HE;var children;var IE;var JE;factory CB( g){if(g.startsWith('.')){throw new ArgumentError("name shouldn't start with a '.'");}if(NB==null)NB=<String,CB>{};if(NB.containsKey(g))return NB[g];var j=g.lastIndexOf('.');var h=null;var i;if(j==-1){if(g!='')h=new CB('');i=g;}else{h=new CB(g.substring(0,j));i=g.substring(j+1);}final k=new CB.tD(i,h);NB[g]=k;return k;}CB.tD(this.name,this.parent):children=new Map<String,CB>(){if(parent!=null)parent.children[name]=this;} get UB{if(cB){if(HE!=null)return HE;if(parent!=null)return parent.UB;}return QC;} get YD=>KE(); VD( g)=>(g>=UB); log( i, k,[j]){if(VD(i)){var h=new OB(i,k,EC,j);if(cB){var g=this;while (g!=null){g.LE(h);g=g.parent;}}else{dB.LE(h);}}} info( h,[g])=>log(o.tB,h,g); KC( h,[g])=>log(o.RC,h,g); KE(){if(cB||parent==null){if(IE==null){IE=new rB.StreamController<OB>.broadcast(sync:true);JE=IE.stream;}return JE;}else{return dB.KE();}} LE( g){if(IE!=null){IE.add(g);}}static  get dB=>new CB('');static var NB;}class o implements Comparable<o>{final  name;final  value;const o(this.name,this.value);static const  tB=const o('INFO',800);static const  RC=const o('WARNING',900); operator==( g)=>g!=null&&value==g.value; operator<( g)=>value<g.value; operator<=( g)=>value<=g.value; operator>( g)=>value>g.value; operator>=( g)=>value>=g.value; compareTo( g)=>value-g.value; get hashCode=>value; toString()=>name;}class OB{final  UB;final  message;final  WD;final  time;final  bD;static var SC=0;var exception;OB(this.UB,this.message,this.WD,[this.exception]):time=new DateTime.now(),bD=OB.SC++ ;}typedef  BB( e);typedef  TC( changes);typedef  DB();typedef  UC();class VB{final oldValue;final newValue;final  changes;VB(this.oldValue,this.newValue,[this.changes]); operator==(g){return g is VB&&oldValue==g.oldValue&&newValue==g.newValue&&changes==g.changes;} get hashCode=>kC(oldValue,newValue,changes); toString(){if(changes!=null)return '#<ChangeNotification to ${newValue}: ${changes}>';return '#<ChangeNotification from ${oldValue} to ${newValue}>';}}class EB{static const eB=1;static const fB=2;static const uB=fB|4;static const vB=fB|8;final  type;final key;final oldValue;final newValue;EB(this.type,this.key,this.oldValue,this.newValue); operator==(g){return g is EB&&type==g.type&&key==g.key&&oldValue==g.oldValue&&newValue==g.newValue;} get hashCode=>lC(type,key,oldValue,newValue); toString(){var g;switch (type){case eB:g='field';break;case fB:g='index';break;case uB:g='insert';break;case vB:g='remove';break;}return '#<ChangeRecord ${g} ${key} from ${oldValue} to ${newValue}>';}} VC(g, i,[ k]){if(g is q){var h=g;return gB(h,(m){i(new VB(h,h,m));});}var j=new WB(g,i,k);if(!j.ME()){return bC;}return j.NE;} gB( g, i){if(g.KB==null)g.KB=new hB();var h=g.KB.add(i);return h.remove;}class q{var KB;var JB;final  hashCode= ++q.WC;static var WC=0;} XC( g)=>g.KB!=null&&g.KB.head!=null; get YC=>IB!=null; ZC( g, h,i)=>IB.OE(g,h,i); aC( g, j,k, h, i){if((j&(EB.uB|EB.vB))==0){if(h==i)return;}if(GB==null){GB=[] ;mC(cC);}if(g.JB==null){g.JB=[] ;GB.add(g);}g.JB.add(new EB(j,k,h,i));} bC(){}var IB;var wB=100;var GB;var HB; cC(){var m=0;while (GB!=null||HB!=null){var j=GB;GB=null;var i=HB;HB=null;if(m++ ==wB){dC(j,i);return;}if(j!=null){for(var h in j){var FB=h.JB;h.JB=null;for(var g=h.KB.head;g!=null;g=g.next){var k=g.value;try {k(FB);}catch (MB,u){PB(MB,u,k,'from ${h}');}}}}if(i!=null){i.forEach((LC,qB){qB.PE();});}}} dC( k, j){var g=[] ;if(k!=null){for(var i in k){var FB=i.JB;g.add('${i} ${FB}');}}if(j!=null){for(var m in j.values){var h=m.PE();if(h!=null)g.add('${m} ${h}');}}GB=null;HB=null;var u='exceeded notifiction limit of ${wB}, possible ' 'circular reference in observer callbacks: ${g.take(10).join(", ")}';gC(u);}class WB{static var eC=0;final  QE= ++WB.eC;final  RE;final  SE;final  TE;final  UE=new Map();final  VE=[] ;var WE=false;var XE;WB(this.RE,this.SE,this.TE); toString()=>TE!=null?'<observer ${QE}: ${TE}>':'<observer ${QE}>'; ME(){var h=IB;IB=this;try {XE=RE();if(XE is Iterable&&XE is !List&&XE is !q){XE=(XE as Iterable).toList();}}catch (g,i){PB(g,i,RE,'from ${this}');XE=null;}UE.forEach(YE);UE.clear();assert(IB==this);IB=h;ZE();return VE.length>0;} aE( i){try {SE(i);}catch (g,h){PB(g,h,SE,'from ${this}');}} ZE(){var g=XE;if(g is !q)return;VE.add(gB(g,(h){aE(new VB(g,g,h));}));} OE( m, u,g){var i=UE.putIfAbsent(m,()=>new Map());try {var h=i[g];if(h==null)h=0;i[g]=h|u;}catch (j,k){PB(j,k,g,'hashCode or operator == from ${this}');}} YE( i, j){VE.add(gB(i,(k){if(WE)return;for(var g in k){var h=j[g.key];if(h!=null&&(h&g.type)!=0){WE=true;if(HB==null){HB=new sB.SplayTreeMap();}HB[QE]=this;return;}}}));} NE(){for(var g in VE){g();}WE=false;} PE(){if(!WE)return null;var g=XE;NE();ME();try {if(g==XE)return null;}catch (i,j){PB(i,j,g,'operator == from ${this}');return null;}var h=new VB(g,XE);aE(h);return h;}}typedef  fC( message);var gC=(g)=>print(g);typedef  hC(error,stackTrace,obj, message);var PB=iC; iC(i,g,h, j){print('web_ui.observe: unhandled error calling ${h} ${j}.\n' 'error:\n${i}\n\nstack trace:\n${g}');}class jC{}class v<AB>{var bE;var cE;var dE;var eE;v.uD( g,this.dE):eE=g{if(dE!=null)dE.fE++ ;} get next=>cE; get value=>eE;set value( g)=>eE=g; gE( g, h){cE=h;bE=g;if(g!=null)g.cE=this;if(h!=null)h.bE=this;return this;} append( g)=>new v<AB>.uD(g,dE).gE(this,cE); remove(){if(dE==null)return;dE.fE-- ;if(bE!=null){bE.cE=cE;}else{dE.hE=cE;}if(cE!=null){cE.bE=bE;}else{dE.iE=bE;}cE=null;bE=null;dE=null;}}class hB<AB> extends sB.IterableBase<AB>{var hE;var iE; get length=>fE;var fE=0;hB(){} get head=>hE; add( h){var g=new v<AB>.uD(h,this);if(iE==null)return hE=iE=g;return iE=g.gE(iE,null);} addLast( g)=>add(g); addAll( g)=>g.forEach(add); get iterator=>new kD<AB>(this);}class kD<AB> implements Iterator<AB>{var jE;var dE;var kE;var lE=-1;kD(this.dE){jE=new List<v>(dE.length);var h=0;var g=dE.head;while (g!=null){jE[h++ ]=g;g=g.next;}} get current=>kE; moveNext(){do{lE++ ;}while(lE<jE.length&&jE[lE].dE!=dE);if(lE<jE.length){kE=jE[lE].value;return true;}else{kE=null;return false;}}}QB(h,g)=>h.hashCode*31+g.hashCode;kC(h,g,i)=>QB(QB(h,g),i);lC(g,i,h,j)=>QB(QB(g,i),QB(h,j)); mC( h()){var g=new sD.ReceivePort();g.receive((i,j){g.close();h();});g.toSendPort().send(null);} nC(g){if(g is jC)return g.toString();g=g.toString();return pC(g)?g:'#';}const oC=const["http","https","ftp","mailto"]; pC( h){var g=Uri.parse(h).scheme;if(g=='')return true;return oC.contains(g.toLowerCase())||"MAILTO"==g.toUpperCase();}abstract class XB{ TB(){} insert(); remove();}abstract class qC extends XB{final exp;final  isFinal;final  DC;var bB;qC(this.exp,this.isFinal):DC=iB&&YB!=null?YB():null; insert(){if(isFinal){FC();}else if(bB!=null){throw new StateError('binding already attached');}else{bB=HC();}} remove(){if(!isFinal){bB();bB=null;}} FC(); HC();}class lD extends qC{final  JC;final  GC;lD( g,this.JC,this.GC, h):super(g,h); mE(g){JC(GC?nC(g):g);} FC()=>mE(exp()); HC()=>uC(exp,(g)=>mE(g.newValue),'dom-property-binding',DC);}class mD extends XB{final LB;mD(this.LB); TB(){LB..SD()..CC()..RD();} insert(){LB..pB()..UD();} remove(){LB..aD()..IC();}}class rC extends XB{final  XD;final  children=[] ;final  nodes=[] ;rC(this.XD); ZD(g,j,h,[i=false]){children.add(new lD(g,j,i,h));} LB( g){children.add(new mD(g));} add( g)=>nodes.add(g); addAll( g)=>nodes.addAll(g); TB(){for(var g=0,h=children.length;g<h;g++ ){children[g].TB();}} insert(){for(var g=0,h=children.length;g<h;g++ ){children[g].insert();}} remove(){for(var g=children.length-1;g>=0;g-- ){children[g].remove();}children.clear();}}var xB=false;var iB=false;var YB=(){try {throw "";}catch (h,g){return g.toString();}};final  ZB=new CB('watcher'); sC(g, u,[ j, m]){if(xB)return VC(g,u);if(u==null)return (){};if(jB==null)jB=new hB<RB>();j=j==null?'<unnamed>':j;var i;var h=t.yC;if(g is zB){i=(g as zB).nE;}else if(g is Function){i=g;try {var k=g();if(k is List){h=t.SB;}else if(k is Iterable){h=t.SB;i=()=>g().toList();}else if((k is sB.LinkedHashMap)||(k is sB.SplayTreeMap)){h=t.lB;}else if(k is Map){h=t.kB;}}catch (FB,qB){ZB.KC('evaluating ${j} watcher threw error (${FB}, ${qB})');}}else if(g is List){i=()=>g;h=t.SB;}else if(g is Iterable){i=()=>g.toList();h=t.SB;}else if((g is sB.LinkedHashMap)||(g is sB.SplayTreeMap)){i=()=>g;h=t.lB;}else if(g is Map){i=()=>g;h=t.kB;}if(iB&&m==null&&YB!=null){m=YB();}var LC=tC(h,i,u,j,m);var MB=jB.add(LC);return MB.remove;} tC( k, g, j, h, i){switch (k){case t.SB:return new nD(g,j,h,i);case t.lB:return new rD(g,j,h,i);case t.kB:return new oD(g,j,h,i);default:return new RB(g,j,h,i);}} uC(h, i,[ j, k]){var m=sC(h,i,j,k);var g=h;if(g is Function){g=g();}if(g is Iterable&&g is !List){g=g.toList();}i(new VB(null,g));return m;}var jB;class RB{final  debugName;var location;final  oE;static var vC=0;final  nE;final  pE;var qE;RB(this.nE,this.pE,this.debugName,this.location):oE=vC++ {qE=nE();} toString()=>'${debugName} (id: #${oE})'; rE(g){if(iB){if(location!=null){ZB.info('watcher updated: ${this}, defined at:\n${location}');location=null;}else{ZB.info('watcher updated: ${this}');}}qE=g;}sE(){try {return nE();}catch (g,h){ZB.KC('${this} watcher threw an exception: ${g}, ${h}');}return qE;}}typedef  yB<wC>();typedef  xC<wC>( value);class zB<wC>{}class nD<wC> extends RB{nD(g, j, h, i):super(g,j,h,i){rE(sE());} rE(g){qE=new List<wC>.from(g);}}class oD<pD,qD> extends RB{oD(g, j, h, i):super(g,j,h,i){rE(sE());} rE(g){qE=new Map<pD,qD>.from(g);}}class rD<pD,qD> extends RB{rD(g, j, h, i):super(g,j,h,i){rE(sE());} rE(g){qE=new sB.LinkedHashMap.from(g);}}class t{final tE;const t.vD(this.tE);toString()=>'Enum.${tE}';static const SB=const t.vD('LIST');static const kB=const t.vD('HASH_MAP');static const lB=const t.vD('ORDERED_MAP');static const yC=const t.vD('OTHER');}abstract class AC extends PC{var uE;var vE;var wE={};var xE=new oB({}); TD( g)=>xE; cD( h,var g){xE=g;} get host{if(uE==null)throw new StateError('host element has not been set.');return uE;}set host( g){if(g==null){throw new ArgumentError('host must not be null.');}var h=g.xtag;if(h!=null&&h!=g){throw new ArgumentError('host must not have its xtag property set.');}if(uE!=null){throw new StateError('host can only be set once.');}g.xtag=this;uE=g;}createShadowRoot([ g]){var h=yE();if(g!=null){wE[g]=h;}return h;}yE(){if(BC){return host.createShadowRoot();}if(vE==null)vE=[] ;vE.add(new l.DivElement());return vE.last;} CC(){} pB(){} IC(){} RD(){if(BC)return;if(vE.length==0){throw new StateError('Distribution algorithm requires at least one shadow' ' root and can only be run once.');}var j=vE;var g=j.removeLast();var u=g;var m=new List.from(nodes);var k=[] ;var FB=[] ;while (true){m=zE(g,m);var h=g.query('shadow');if(h!=null){if(j.length>0){g=j.removeLast();k.add(h);FB.add(g);}else{nB(h,m);break;}}else{break;}}for(int i=0;i<k.length;i++ ){var h=k[i];var g=FB[i];nB(h,g.nodes);}nodes.clear();nodes.addAll(u.nodes);for(var MB in wE.keys){if(wE[MB]==u){wE[MB]=this;break;}}} zE( u, j){for(var g in u.queryAll('content')){if(!AD(g))continue;var i=g.attributes['select'];if(i==null||i=='')i='*';var h=[] ;var m=[] ;for(var k in j){(zC(k,i)?h:m).add(k);}if(h.length==0){h=g.nodes;}nB(g,h);j=m;}return j;}static  zC( h, g){if(h is !l.Element)return g=='*';return (h as l.Element).matches(g);}static  mB( g)=>g.tagName=='CONTENT'||g.tagName=='SHADOW';static  AD( g){assert(mB(g));for(g=g.parent;g!=null;g=g.parent){if(mB(g))return false;}return true;}static  nB( g, h){assert(mB(g));g.parent.insertAllBefore(h,g);g.remove();}}class oB{final  AF;oB(this.AF); operator[]( g)=>AF[g];}var BD=false; get BC=>BD&&l.ShadowRoot.supported;