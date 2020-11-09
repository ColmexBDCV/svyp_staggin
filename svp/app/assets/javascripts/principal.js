window.addEventListener("resize", function(){
	document.querySelector("#body-wrap").style.paddingBottom = document.querySelector("#footer").offsetHeight + "px";
	try {
		document.querySelector("#slider").style.height = (Math.max(document.documentElement.clientWidth, window.innerWidth || 0) * 11 / 20) + "px";
	} catch(e) { }
});

window.addEventListener("load", function(){
	window.dispatchEvent(new Event("resize"));
});
