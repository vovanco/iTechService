/*
Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
!function(){function e(e,t,a){t.is&&t.getCustomData("block_processed")||(t.is&&CKEDITOR.dom.element.setMarker(a,t,"block_processed",!0),e.push(t))}function t(t,a){function n(e){for(var t,a=new CKEDITOR.dom.elementPath(e).elements,n=0;n<a.length;n++)if(a[n].getName()in d){t=a[n];break}return t}function i(){this.foreach(function(e){/^(?!vbox|hbox)/.test(e.type)&&(e.setup||(e.setup=function(t){e.setValue(t.getAttribute(e.id)||"")}),e.commit||(e.commit=function(t){var a=this.getValue();("dir"!=e.id||t.getComputedStyle("direction")!=a)&&(a?t.setAttribute(e.id,a):t.removeAttribute(e.id))}))})}function o(t){var a,n,i,o=[],r={},l=[],u=t.document.getSelection(),p=u.getRanges(),m=u.createBookmarks();for(t.config.enterMode==CKEDITOR.ENTER_DIV?"div":"p",n=0;n<p.length;n++)for(i=p[n].createIterator();a=i.getNextParagraph();)if(a.getName()in d){var h,g=a.getChildren();for(h=0;h<g.count();h++)e(l,g.getItem(h),r)}else{for(;!c[a.getName()]&&"body"!=a.getName();)a=a.getParent();e(l,a,r)}CKEDITOR.dom.element.clearAllMarkers(r);var f,v,b=s(l);for(n=0;n<b.length;n++){var y=b[n][0];for(f=y.getParent(),h=1;h<b[n].length;h++)f=f.getCommonAncestor(b[n][h]);for(v=new CKEDITOR.dom.element("div",t.document),h=0;h<b[n].length;h++){for(y=b[n][h];!y.getParent().equals(f);)y=y.getParent();b[n][h]=y}for(h=0;h<b[n].length;h++)y=b[n][h],y.getCustomData&&y.getCustomData("block_processed")||(y.is&&CKEDITOR.dom.element.setMarker(r,y,"block_processed",!0),h||v.insertBefore(y),v.append(y));CKEDITOR.dom.element.clearAllMarkers(r),o.push(v)}return u.selectBookmarks(m),o}function r(e){var t=new CKEDITOR.dom.elementPath(e.getSelection().getStartElement()),a=t.blockLimit,n=a&&a.getAscendant("div",!0);return n}function s(e){for(var t,a=[],i=null,o=0;o<e.length;o++){t=e[o];var r=n(t);r.equals(i)||(i=r,a.push([])),a[a.length-1].push(t)}return a}function l(e){var a=this.getDialog(),n=a._element&&a._element.clone()||new CKEDITOR.dom.element("div",t.document);this.commit(n,!0),e=[].concat(e);for(var i,o=e.length,r=0;o>r;r++)i=a.getContentElement.apply(a,e[r].split(":")),i&&i.setup&&i.setup(n,!0)}var d=function(){var e=CKEDITOR.tools.extend({},CKEDITOR.dtd.$blockLimit);return delete e.div,t.config.div_wrapTable&&(delete e.td,delete e.th),e}(),c=CKEDITOR.dtd.div,u={},p=[];return{title:t.lang.div.title,minWidth:400,minHeight:165,contents:[{id:"info",label:t.lang.common.generalTab,title:t.lang.common.generalTab,elements:[{type:"hbox",widths:["50%","50%"],children:[{id:"elementStyle",type:"select",style:"width: 100%;",label:t.lang.div.styleSelectLabel,"default":"",items:[[t.lang.common.notSet,""]],onChange:function(){l.call(this,["info:class","advanced:dir","advanced:style"])},setup:function(e){for(var t in u)u[t].checkElementRemovable(e,!0)&&this.setValue(t)},commit:function(e){var t;if(t=this.getValue()){var a=u[t],n=e.getCustomData("elementStyle")||"";a.applyToObject(e),e.setCustomData("elementStyle",n+a._.definition.attributes.style)}}},{id:"class",type:"text",label:t.lang.common.cssClass,"default":""}]}]},{id:"advanced",label:t.lang.common.advancedTab,title:t.lang.common.advancedTab,elements:[{type:"vbox",padding:1,children:[{type:"hbox",widths:["50%","50%"],children:[{type:"text",id:"id",label:t.lang.common.id,"default":""},{type:"text",id:"lang",label:t.lang.link.langCode,"default":""}]},{type:"hbox",children:[{type:"text",id:"style",style:"width: 100%;",label:t.lang.common.cssStyle,"default":"",commit:function(e){var t=this.getValue()+(e.getCustomData("elementStyle")||"");e.setAttribute("style",t)}}]},{type:"hbox",children:[{type:"text",id:"title",style:"width: 100%;",label:t.lang.common.advisoryTitle,"default":""}]},{type:"select",id:"dir",style:"width: 100%;",label:t.lang.common.langDir,"default":"",items:[[t.lang.common.notSet,""],[t.lang.common.langDirLtr,"ltr"],[t.lang.common.langDirRtl,"rtl"]]}]}]}],onLoad:function(){i.call(this);var e=this,a=this.getContentElement("info","elementStyle");t.getStylesSet(function(t){var n;if(t)for(var i=0;i<t.length;i++){var o=t[i];o.element&&"div"==o.element&&(n=o.name,u[n]=new CKEDITOR.style(o),a.items.push([n,n]),a.add(n,n))}a[a.items.length>1?"enable":"disable"](),setTimeout(function(){a.setup(e._element)},0)})},onShow:function(){if("editdiv"==a){var e=r(t);e&&this.setupContent(this._element=e)}},onOk:function(){p="editdiv"==a?[this._element]:o(t,!0);for(var e=p.length,n=0;e>n;n++)this.commitContent(p[n]),!p[n].getAttribute("style")&&p[n].removeAttribute("style");this.hide()},onHide:function(){"editdiv"==a&&this._element.removeCustomData("elementStyle"),delete this._element}}}CKEDITOR.dialog.add("creatediv",function(e){return t(e,"creatediv")}),CKEDITOR.dialog.add("editdiv",function(e){return t(e,"editdiv")})}();