window.addEventListener("resize", function(){
	document.querySelector("#body-wrap").style.paddingBottom = document.querySelector("#footer").offsetHeight + "px";
	try {
		document.querySelector("#slider").style.height = (window.outerWidth * 11 / 20) + "px";
	} catch(e) { }
});

window.addEventListener("load", function(){
	window.dispatchEvent(new Event("resize"));
});
