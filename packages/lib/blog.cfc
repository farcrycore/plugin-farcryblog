<cfcomponent displayname="Blog Utilities" output="false">

	<cfscript>
	/**
	* Abbreviates a given string to roughly the given length, stripping any tags, making sure the ending doesn't chop a word in two, and adding an ellipsis character at the end.
	* Fix by Patrick McElhaney
	* v3 by Ken Fricklas kenf@accessnet.net, takes care of too many spaces in text.
	*
	* @param string      String to use. (Required)
	* @param len      Length to use. (Required)
	* @return Returns a string.
	* @author Gyrus (kenf@accessnet.netgyrus@norlonto.net)
	* @version 3, September 6, 2005
	*/
	function abbreviate(string,len) {
	    var newString = REReplace(string, "<[^>]*>", " ", "ALL");
	    var lastSpace = 0;
	    newString = REReplace(newString, " \s*", " ", "ALL");
	    if (len(newString) gt len) {
	        newString = left(newString, len-2);
	        lastSpace = find(" ", reverse(newString));
	        lastSpace = len(newString) - lastSpace;
	        newString = left(newString, lastSpace) & " &##8230;";
	    }    
	    return newString;
	}
	</cfscript>

</cfcomponent>