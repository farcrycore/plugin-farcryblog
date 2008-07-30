/*
dropdown menus based on son of suckerfish.

Beefed up a little by Grae to allow for multiple suckerfish drop downs within the one page, from one linked javascript.
Checks to ensure presence of element by id before attaching function.
*/

/* #nav dropdown */
function dropDownNav()
{
	var sfEls = document.getElementById("nav").getElementsByTagName("LI");
	for (var i=0; i<sfEls.length; i++)
	{
		sfEls[i].onmouseover=function()
		{
			this.className+=" sfhover";
			this.style.zIndex=200;
		}
		sfEls[i].onmouseout=function()
		{
			this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
		}
	}
}

/* Check for elements to attach drop down functions to */
function elementChecker()
{
	/* check for main nav */
	if (document.getElementById('nav') != null)
	{
		dropDownNav();
	}

}

/* onload run element checker function */
if (window.attachEvent)
{
	window.attachEvent("onload", elementChecker);
}