// Simple JavaScript Templating
// John Resig - http://ejohn.org/ - MIT Licensed

(function(){
  var cache = {};
  
  this.Isotope = function tmpl(str, data, options){
    // Figure out if we're getting a template, or if we need to
    // load the template - and be sure to cache the result.
    var fn = cache[str] = cache[str] ||

      // Generate a reusable function that will serve as a template
      // generator (and which will be cached).
      new Function("obj",
        "var p=[],print=function(){p.push.apply(p,arguments);};" +
        
        // Introduce the data as local variables using with(){}
        "with(obj){p.push('" +
        
        // Convert the template into pure JavaScript
        str
          .replace(/[\r\t\n]/g, " ")
          .split("<%").join("\t")
          .replace(/((^|%>)[^\t]*)'/g, "$1\r")
          .replace(/\t=(.*?)%>/g, "',$1,'")
          .split("\t").join("');")
          .split("%>").join("p.push('")
          .split("\r").join("\\'")
      + "');}return p.join('');");
    
    // Provide some basic currying to the user

	if (data) {
		options=options || {};
		
		if (data instanceof Array) {
			var s=[];
			for (var i=0;i<data.length;i++) {
				var itemObject={};
				itemObject[options.localName || "item"]=data[i];
				
				s.push(fn(itemObject));
			}
			return s.join(options.delimiter || "");
		}
		else {
			return fn( data );
		}
	}

    return fn;
  };
})();