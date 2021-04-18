/*
 * Holds procs designed to help with filtering text
 * Contains groups:
 *			SQL sanitization
 *			Text sanitization
 *			Text searches
 *			Text modification
 *			Misc
 */


/*
 * SQL sanitization
 */

// Run all strings to be used in an SQL query through this proc first to properly escape out injection attempts.
/proc/sanitizeSQL(var/t as text)
	var/sqltext = dbcon.Quote(t);
	/* Bastion of Endeavor Edit: I wonder if this works the way I think it will.
	return copytext(sqltext, 2, length(sqltext));//Quote() adds quotes around input, we already do that
	*/
	return copytext_char(sqltext, 2, length_char(sqltext));
	// End of Bastion of Endeavor Edit

/*
 * Text sanitization
 */
// Can be used almost the same way as normal input for text
/proc/clean_input(Message, Title, Default, mob/user=usr)
	var/txt = input(user, Message, Title, Default) as text | null
	if(txt)
		return html_encode(txt)

//Simply removes < and > and limits the length of the message
/* Bastion of Endeavor Edit: Unicode support.
/proc/strip_html_simple(var/t,var/limit=MAX_MESSAGE_LEN)
	var/list/strip_chars = list("<",">")
	t = copytext(t,1,limit)
	for(var/char in strip_chars)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + copytext(t, index+1)
			index = findtext(t, char)
	return t
*/
/proc/strip_html_simple(var/t,var/limit=MAX_MESSAGE_LEN)
	var/list/strip_chars = list("<",">")
	t = copytext_char(t,1,limit)
	for(var/char in strip_chars)
		var/index = findtext_char(t, char)
		while(index)
			t = copytext_char(t, 1, index) + copytext_char(t, index+1)
			index = findtext_char(t, char)
	return t
// End of Bastion of Endeavor Edit

//Runs byond's sanitization proc along-side strip_html_simple
//I believe strip_html_simple() is required to run first to prevent '<' from displaying as '&lt;' that html_encode() would cause
/proc/adminscrub(var/t,var/limit=MAX_MESSAGE_LEN)
	/* Bastion of Endeavor Edit: Unicode support.
	return copytext((html_encode(strip_html_simple(t))),1,limit)
	*/
	return copytext_char((html_encode(strip_html_simple(t))),1,limit)
	// End of Bastion of Endeavor Edit

//Used for preprocessing entered text
/proc/sanitize(var/input, var/max_length = MAX_MESSAGE_LEN, var/encode = 1, var/trim = 1, var/extra = 1)
	if(!input)
		return

	if(max_length)
	/* Bastion of Endeavor Edit: Unicode support.
		input = copytext(input,1,max_length)
	*/
		input = copytext_char(input,1,max_length)
	// End of Bastion of Endeavor Edit

	if(extra)
		input = replace_characters(input, list("\n"=" ","\t"=" "))

	if(encode)
		// The below \ escapes have a space inserted to attempt to enable CI auto-checking of span class usage. Please do not remove the space.
		//In addition to processing html, html_encode removes byond formatting codes like "\ red", "\ i" and other.
		//It is important to avoid double-encode text, it can "break" quotes and some other characters.
		//Also, keep in mind that escaped characters don't work in the interface (window titles, lower left corner of the main window, etc.)
		input = html_encode(input)
	else
		//If not need encode text, simply remove < and >
		//note: we can also remove here byond formatting codes: 0xFF + next byte
		input = replace_characters(input, list("<"=" ", ">"=" "))

	if(trim)
		//Maybe, we need trim text twice? Here and before copytext?
		input = trim(input)

	return input

//Run sanitize(), but remove <, >, " first to prevent displaying them as &gt; &lt; &34; in some places, after html_encode().
//Best used for sanitize object names, window titles.
//If you have a problem with sanitize() in chat, when quotes and >, < are displayed as html entites -
//this is a problem of double-encode(when & becomes &amp;), use sanitize() with encode=0, but not the sanitizeSafe()!
/proc/sanitizeSafe(var/input, var/max_length = MAX_MESSAGE_LEN, var/encode = 1, var/trim = 1, var/extra = 1)
	return sanitize(replace_characters(input, list(">"=" ","<"=" ", "\""="'")), max_length, encode, trim, extra)

//Filters out undesirable characters from names
/proc/sanitizeName(var/input, var/max_length = MAX_NAME_LEN, var/allow_numbers = 0)
	/* Bastion of Endeavor Edit: Unicode support.
	if(!input || length(input) > max_length)
	*/
	if(!input || length_char(input) > max_length)
	// End of Bastion of Endeavor Edit
		return //Rejects the input if it is null or if it is longer then the max length allowed

	var/number_of_alphanumeric	= 0
	var/last_char_group			= 0
	var/output = ""

	/* Bastion of Endeavor Edit: Ditto.
	for(var/i=1, i<=length(input), i++)
		var/ascii_char = text2ascii(input,i)
	*/
	for(var/i=1, i<=length_char(input), i++)
		var/ascii_char = text2ascii_char(input,i)
	// End of Bastion of Endeavor Edit
		switch(ascii_char)
			// A  .. Z
			/* Bastion of Endeavor Edit: Adds russian letters too.
			if(65 to 90)			//Uppercase Letters
			*/
			if(65 to 90, 1040 to 1071)
			// End of Bastion of Endeavor Edit
				output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 4

			// a  .. z
			/* Bastion of Endeavor Edit: Same as above.
			if(97 to 122)			//Lowercase Letters
			*/
			if(97 to 122, 1070 to 1103)
			// End of Bastion of Endeavor Edit
				if(last_char_group<2)		output += ascii2text(ascii_char-32)	//Force uppercase first character
				else						output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 4

			// 0  .. 9
			if(48 to 57)			//Numbers
				if(!allow_numbers)			continue	// If allow_numbers is 0, then don't do this.
				output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 3

			// '  -  .
			if(39,45,46)			//Common name punctuation
				if(!last_char_group) continue
				output += ascii2text(ascii_char)
				last_char_group = 2

			// ~   |   @  :  #  $  %  &  *  +
			if(126,124,64,58,35,36,37,38,42,43)			//Other symbols that we'll allow (mainly for AI)
				if(!last_char_group)		continue	//suppress at start of string
				if(!allow_numbers)			continue
				output += ascii2text(ascii_char)
				last_char_group = 2

			//Space
			if(32)
				if(last_char_group <= 1)	continue	//suppress double-spaces and spaces at start of string
				output += ascii2text(ascii_char)
				last_char_group = 1
			else
				return

	if(number_of_alphanumeric < 2)	return		//protects against tiny names like "A" and also names like "' ' ' ' ' ' ' '"

	if(last_char_group == 1)
	/* Bastion of Endeavor Edit: Unicode support.
		output = copytext(output,1,length(output))	//removes the last character (in this case a space)
	*/
		output = copytext_char(output,1,length(output))
	// End of Bastion of Endeavor Edit.

	/* Bastion of Endeavor Translation: Unlikely needed, but whatever.
	for(var/bad_name in list("space","floor","wall","r-wall","monkey","unknown","inactive ai","plating"))	//prevents these common metagamey names
	*/
	for(var/bad_name in list("космос","стена","пол","укрепленная стена","мартышка","неизвестно","неактивный ии","покрытие"))	//prevents these common metagamey names
	// End of Bastion of Endeavor Translation
		if(cmptext(output,bad_name))	return	//(not case sensitive)

	return output

//Returns null if there is any bad text in the string
/proc/reject_bad_text(var/text, var/max_length=512)
	/* Bastion of Endeavor Edit: Unicode support.
	if(length(text) > max_length)	return			//message too long
	var/non_whitespace = 0
	for(var/i=1, i<=length(text), i++)
		switch(text2ascii(text,i))
	*/
	if(length_char(text) > max_length)	return			//message too long
	var/non_whitespace = 0
	for(var/i=1, i<=length_char(text), i++)
		switch(text2ascii_char(text,i))
			if(62,60,92,47)	return			//rejects the text if it contains these bad characters: <, >, \ or /
			if(127 to 255)	return			//rejects weird letters like �
			if(0 to 31)		return			//more weird stuff
			if(32)			continue		//whitespace
			else			non_whitespace = 1
	if(non_whitespace)		return text		//only accepts the text if it has some non-spaces


//Old variant. Haven't dared to replace in some places.
/proc/sanitize_old(var/t,var/list/repl_chars = list("\n"="#","\t"="#"))
	return html_encode(replace_characters(t,repl_chars))


//Removes a few problematic characters
/proc/sanitize_simple(t,list/repl_chars = list("\n"="#","\t"="#"))
	/* Bastion of Endeavor Edit: Unicode support.
	for(var/char in repl_chars)
		var/index = findtext(t, char)
		while(index)
			t = copytext(t, 1, index) + repl_chars[char] + copytext(t, index + length(char))
			index = findtext(t, char, index + length(char))
	*/
	for(var/char in repl_chars)
		var/index = findtext_char(t, char)
		while(index)
			t = copytext_char(t, 1, index) + repl_chars[char] + copytext_char(t, index + length_char(char))
			index = findtext_char(t, char, index + length_char(char))
	// End of Bastion of Endeavor Edit
	return t

/proc/sanitize_filename(t)
	return sanitize_simple(t, list("\n"="", "\t"="", "/"="", "\\"="", "?"="", "%"="", "*"="", ":"="", "|"="", "\""="", "<"="", ">"=""))

/*
 * Text searches
 */

//Checks the beginning of a string for a specified sub-string
//Returns the position of the substring or 0 if it was not found
/proc/dd_hasprefix(text, prefix)
	var/start = 1
	/* Bastion of Endeavor Edit: Unicode support.
	var/end = length(prefix) + 1
	return findtext(text, prefix, start, end)
	*/
	var/end = length_char(prefix) + 1
	return findtext_char(text, prefix, start, end)
	// End of Bastion of Endeavor Edit

//Checks the beginning of a string for a specified sub-string. This proc is case sensitive
//Returns the position of the substring or 0 if it was not found
/proc/dd_hasprefix_case(text, prefix)
	var/start = 1
	/* Bastion of Endeavor Edit: Unicode support.
	var/end = length(prefix) + 1
	return findtextEx(text, prefix, start, end)
	*/
	var/end = length_char(prefix) + 1
	return findtextEx_char(text, prefix, start, end)
	// End of Bastion of Endeavor Edit

//Checks the end of a string for a specified substring.
//Returns the position of the substring or 0 if it was not found
/proc/dd_hassuffix(text, suffix)
	/* Bastion of Endeavor Edit: Unicode support.
	var/start = length(text) - length(suffix)
	if(start)
		return findtext(text, suffix, start, null)
	*/
	var/start = length_char(text) - length_char(suffix)
	if(start)
		return findtext_char(text, suffix, start, null)
	// End of Bastion of Endeavor Edit
	return

//Checks the end of a string for a specified substring. This proc is case sensitive
//Returns the position of the substring or 0 if it was not found
/proc/dd_hassuffix_case(text, suffix)
	/* Bastion of Endeavor Edit: Unicode support.
	var/start = length(text) - length(suffix)
	if(start)
		return findtextEx(text, suffix, start, null)
	*/
	var/start = length_char(text) - length_char(suffix)
	if(start)
		return findtextEx_char(text, suffix, start, null)
	// End of Bastion of Endeavor Edit

/*
 * Text modification
 */
/proc/replace_characters(var/t,var/list/repl_chars)
	for(var/char in repl_chars)
		/* Bastion of Endeavor Edit: Unicode support.
		t = replacetext(t, char, repl_chars[char])
		*/
		t = replacetext_char(t, char, repl_chars[char])
		// End of Bastion of Endeavor Edit
	return t

//Adds 'u' number of zeros ahead of the text 't'
/proc/add_zero(t, u)
	/* Bastion of Endeavor Edit: Unicode support?
	while (length(t) < u)
	*/
	while (length_char(t) < u)
	// End of Bastion of Endeavor Edit
		t = "0[t]"
	return t

//Adds 'u' number of spaces ahead of the text 't'
/proc/add_lspace(t, u)
	/* Bastion of Endeavor Edit: Unicode support?
	while(length(t) < u)
	*/
	while (length_char(t) < u)
	// End of Bastion of Endeavor Edit
		t = " [t]"
	return t

//Adds 'u' number of spaces behind the text 't'
/proc/add_tspace(t, u)
	/* Bastion of Endeavor Edit: Unicode support?
	while(length(t) < u)
	*/
	while (length_char(t) < u)
	// End of Bastion of Endeavor Edit
		t = "[t] "
	return t

//Returns a string with reserved characters and spaces before the first letter removed
/proc/trim_left(text)
	/* Bastion of Endeavor Edit: Unicode support.
	for (var/i = 1 to length(text))
		if (text2ascii(text, i) > 32)
			return copytext(text, i)
	*/
	for (var/i = 1 to length_char(text))
		if (text2ascii_char(text, i) > 32)
			return copytext_char(text, i)
	// End of Bastion of Endeavor Edit
	return ""

//Returns a string with reserved characters and spaces after the last letter removed
/proc/trim_right(text)
	/* Bastion of Endeavor Edit: Unicode support.
	for (var/i = length(text), i > 0, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, 1, i + 1)
	*/
	for (var/i = length_char(text), i > 0, i--)
		if (text2ascii_char(text, i) > 32)
			return copytext_char(text, 1, i + 1)
	// End of Bastion of Endeavor Edit
	return ""

//Returns a string with reserved characters and spaces before the first word and after the last word removed.
/proc/trim(text)
	return trim_left(trim_right(text))

//Returns a string with the first element of the string capitalized.
/proc/capitalize(var/t as text)
	/* Bastion of Endeavor Edit: Unicode support.
	return uppertext(copytext(t, 1, 2)) + copytext(t, 2)
	*/
	return uppertext(copytext_char(t, 1, 2)) + copytext_char(t, 2)
	// End of Baston of Endeavor Edit

//This proc strips html properly, remove < > and all text between
//for complete text sanitizing should be used sanitize()
/proc/strip_html_properly(var/input)
	if(!input)
		return
	var/opentag = 1 //These store the position of < and > respectively.
	var/closetag = 1
	while(1)
	/* Bastion of Endeavor Edit: Unicode support.
		opentag = findtext(input, "<")
		closetag = findtext(input, ">")
		if(closetag && opentag)
			if(closetag < opentag)
				input = copytext(input, (closetag + 1))
			else
				input = copytext(input, 1, opentag) + copytext(input, (closetag + 1))
		else if(closetag || opentag)
			if(opentag)
				input = copytext(input, 1, opentag)
			else
				input = copytext(input, (closetag + 1))
		else
			break
	*/
		opentag = findtext_char(input, "<")
		closetag = findtext_char(input, ">")
		if(closetag && opentag)
			if(closetag < opentag)
				input = copytext_char(input, (closetag + 1))
			else
				input = copytext_char(input, 1, opentag) + copytext_char(input, (closetag + 1))
		else if(closetag || opentag)
			if(opentag)
				input = copytext_char(input, 1, opentag)
			else
				input = copytext_char(input, (closetag + 1))
		else
			break
	// End of Bastion of Endeavor Edit

	return input

//This proc fills in all spaces with the "replace" var (* by default) with whatever
//is in the other string at the same spot (assuming it is not a replace char).
//This is used for fingerprints
/proc/stringmerge(var/text,var/compare,replace = "*")
	/* Bastion of Endeavor Edit: Unicode support.
	var/newtext = text
	if(length(text) != length(compare))
		return 0
	for(var/i = 1, i < length(text), i++)
		var/a = copytext(text,i,i+1)
		var/b = copytext(compare,i,i+1)
		//if it isn't both the same letter, or if they are both the replacement character
		//(no way to know what it was supposed to be)
		if(a != b)
			if(a == replace) //if A is the replacement char
				newtext = copytext(newtext,1,i) + b + copytext(newtext, i+1)
			else if(b == replace) //if B is the replacement char
				newtext = copytext(newtext,1,i) + a + copytext(newtext, i+1)
	*/
	var/newtext = text
	if(length_char(text) != length_char(compare))
		return 0
	for(var/i = 1, i < length_char(text), i++)
		var/a = copytext_char(text,i,i+1)
		var/b = copytext_char(compare,i,i+1)
		//if it isn't both the same letter, or if they are both the replacement character
		//(no way to know what it was supposed to be)
		if(a != b)
			if(a == replace) //if A is the replacement char
				newtext = copytext_char(newtext,1,i) + b + copytext_char(newtext, i+1)
			else if(b == replace) //if B is the replacement char
				newtext = copytext_char(newtext,1,i) + a + copytext_char(newtext, i+1)
	// End of Bastion of Endeavor Edit
			else //The lists disagree, Uh-oh!
				return 0
	return newtext

//This proc returns the number of chars of the string that is the character
//This is used for detective work to determine fingerprint completion.
/proc/stringpercent(var/text,character = "*")
	if(!text || !character)
		return 0
	var/count = 0
	/* Bastion of Endeavor Edit: Unicode support.
	for(var/i = 1, i <= length(text), i++)
		var/a = copytext(text,i,i+1)
	*/
	for(var/i = 1, i <= length_char(text), i++)
		var/a = copytext_char(text,i,i+1)
	// End of Bastion of Endeavor Edit
		if(a == character)
			count++
	return count

/proc/reverse_text(var/text = "")
	var/new_text = ""
	/* Bastion of Endeavor Edit: Unicode support.
	for(var/i = length(text); i > 0; i--)
		new_text += copytext(text, i, i+1)
	*/
	for(var/i = length_char(text); i > 0; i--)
		new_text += copytext_char(text, i, i+1)
	// End of Bastion of Endeavor Edit
	return new_text

//Used in preferences' SetFlavorText and human's set_flavor verb
//Previews a string of len or less length
proc/TextPreview(var/string,var/len=40)
	/* Bastion of Endeavor Edit: Unicode support.
	if(length(string) <= len)
		if(!length(string))
	*/
	if(length_char(string) <= len)
		if(!length_char(string))
	// End of Bastion of Endeavor Edit
			return "\[...\]"
		else
			return string
	else
		return "[copytext_preserve_html(string, 1, 37)]..."

//alternative copytext() for encoded text, doesn't break html entities (&#34; and other)
/proc/copytext_preserve_html(var/text, var/first, var/last)
	/* Bastion of Endeavor Edit: Unincode support.
	return html_encode(copytext(html_decode(text), first, last))
	*/
	return html_encode(copytext_char(html_decode(text), first, last))
	// End of Bastion of Endeavor Edit

//For generating neat chat tag-images
//The icon var could be local in the proc, but it's a waste of resources
//	to always create it and then throw it out.
/var/icon/text_tag_icons = 'icons/chattags.dmi'
/var/list/text_tag_cache = list()
/proc/create_text_tag(var/tagname, var/tagdesc = tagname, var/client/C = null)
	if(!(C && C.is_preference_enabled(/datum/client_preference/chat_tags)))
		return tagdesc
	if(!text_tag_cache[tagname])
		var/icon/tag = icon(text_tag_icons, tagname)
		text_tag_cache[tagname] = bicon(tag, TRUE, "text_tag")
	return text_tag_cache[tagname]

/proc/contains_az09(var/input)
	/* Bastion of Endeavor Edit: Unicode support.
	for(var/i=1, i<=length(input), i++)
		var/ascii_char = text2ascii(input,i)
		switch(ascii_char)
			// A  .. Z
			if(65 to 90)			//Uppercase Letters
				return 1
			// a  .. z
			if(97 to 122)			//Lowercase Letters
				return 1

			// 0  .. 9
			if(48 to 57)			//Numbers
				return 1
	*/
	for(var/i=1, i<=length_char(input), i++)
		var/ascii_char = text2ascii_char(input,i)
		switch(ascii_char)
			// A  .. Z
			if(65 to 90)			//Uppercase Letters
				return 1
			// a  .. z
			if(97 to 122)			//Lowercase Letters
				return 1

			// 0  .. 9
			if(48 to 57)			//Numbers
				return 1

			if(1040 to 1071)		//Uppercase Russian Letters
				return 1
			if(1072 to 1103)		//Lowercase Russian Letters
				return 1
	// End of Bastion of Endeavor Edit
	return 0

/**
 * Strip out the special beyond characters for \proper and \improper
 * from text that will be sent to the browser.
 */
/proc/strip_improper(var/text)
	/* Bastion of Endeavor Edit: Unicode support.
	return replacetext(replacetext(text, "\proper", ""), "\improper", "")
	*/
	return replacetext_char(replacetext_char(text, "\proper", ""), "\improper", "")
	// End of Bastion of Endeavor Edit

/proc/pencode2html(t)
	/* Bastion of Endeavor Edit: Lord forgive me for what I am about to do.
	t = replacetext(t, "\n", "<BR>")
	t = replacetext(t, "\[center\]", "<center>")
	t = replacetext(t, "\[/center\]", "</center>")
	t = replacetext(t, "\[br\]", "<BR>")
	t = replacetext(t, "\[b\]", "<B>")
	t = replacetext(t, "\[/b\]", "</B>")
	t = replacetext(t, "\[i\]", "<I>")
	t = replacetext(t, "\[/i\]", "</I>")
	t = replacetext(t, "\[u\]", "<U>")
	t = replacetext(t, "\[/u\]", "</U>")
	t = replacetext(t, "\[time\]", "[stationtime2text()]")
	t = replacetext(t, "\[date\]", "[stationdate2text()]")
	t = replacetext(t, "\[large\]", "<font size=\"4\">")
	t = replacetext(t, "\[/large\]", "</font>")
	t = replacetext(t, "\[field\]", "<span class=\"paper_field\"></span>")
	t = replacetext(t, "\[h1\]", "<H1>")
	t = replacetext(t, "\[/h1\]", "</H1>")
	t = replacetext(t, "\[h2\]", "<H2>")
	t = replacetext(t, "\[/h2\]", "</H2>")
	t = replacetext(t, "\[h3\]", "<H3>")
	t = replacetext(t, "\[/h3\]", "</H3>")
	t = replacetext(t, "\[*\]", "<li>")
	t = replacetext(t, "\[hr\]", "<HR>")
	t = replacetext(t, "\[small\]", "<font size = \"1\">")
	t = replacetext(t, "\[/small\]", "</font>")
	t = replacetext(t, "\[list\]", "<ul>")
	t = replacetext(t, "\[/list\]", "</ul>")
	t = replacetext(t, "\[table\]", "<table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>")
	t = replacetext(t, "\[/table\]", "</td></tr></table>")
	t = replacetext(t, "\[grid\]", "<table>")
	t = replacetext(t, "\[/grid\]", "</td></tr></table>")
	t = replacetext(t, "\[row\]", "</td><tr>")
	t = replacetext(t, "\[cell\]", "<td>")
	t = replacetext(t, "\[logo\]", "<img src = ntlogo.png>")
	t = replacetext(t, "\[redlogo\]", "<img src = redntlogo.png>")
	t = replacetext(t, "\[sglogo\]", "<img src = sglogo.png>")
	t = replacetext(t, "\[editorbr\]", "")
	*/
	t = replacetext_char(t, "\n", "<BR>")
	t = replacetext_char(t, "\[center\]", "<center>")
	t = replacetext_char(t, "\[/center\]", "</center>")
	t = replacetext_char(t, "\[br\]", "<BR>")
	t = replacetext_char(t, "\[b\]", "<B>")
	t = replacetext_char(t, "\[/b\]", "</B>")
	t = replacetext_char(t, "\[i\]", "<I>")
	t = replacetext_char(t, "\[/i\]", "</I>")
	t = replacetext_char(t, "\[u\]", "<U>")
	t = replacetext_char(t, "\[/u\]", "</U>")
	t = replacetext_char(t, "\[time\]", "[stationtime2text()]")
	t = replacetext_char(t, "\[date\]", "[stationdate2text()]")
	t = replacetext_char(t, "\[large\]", "<font size=\"4\">")
	t = replacetext_char(t, "\[/large\]", "</font>")
	t = replacetext_char(t, "\[field\]", "<span class=\"paper_field\"></span>")
	t = replacetext_char(t, "\[h1\]", "<H1>")
	t = replacetext_char(t, "\[/h1\]", "</H1>")
	t = replacetext_char(t, "\[h2\]", "<H2>")
	t = replacetext_char(t, "\[/h2\]", "</H2>")
	t = replacetext_char(t, "\[h3\]", "<H3>")
	t = replacetext_char(t, "\[/h3\]", "</H3>")
	t = replacetext_char(t, "\[*\]", "<li>")
	t = replacetext_char(t, "\[hr\]", "<HR>")
	t = replacetext_char(t, "\[small\]", "<font size = \"1\">")
	t = replacetext_char(t, "\[/small\]", "</font>")
	t = replacetext_char(t, "\[list\]", "<ul>")
	t = replacetext_char(t, "\[/list\]", "</ul>")
	t = replacetext_char(t, "\[table\]", "<table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>")
	t = replacetext_char(t, "\[/table\]", "</td></tr></table>")
	t = replacetext_char(t, "\[grid\]", "<table>")
	t = replacetext_char(t, "\[/grid\]", "</td></tr></table>")
	t = replacetext_char(t, "\[row\]", "</td><tr>")
	t = replacetext_char(t, "\[cell\]", "<td>")
	t = replacetext_char(t, "\[logo\]", "<img src = ntlogo.png>")
	t = replacetext_char(t, "\[redlogo\]", "<img src = redntlogo.png>")
	t = replacetext_char(t, "\[sglogo\]", "<img src = sglogo.png>")
	t = replacetext_char(t, "\[editorbr\]", "")
	// End of Bastion of Endeavor Edit
	return t

// Random password generator
/proc/GenerateKey()
	//Feel free to move to Helpers.
	var/newKey
	/* Bastion of Endeavor Translation
	newKey += pick("the", "if", "of", "as", "in", "a", "you", "from", "to", "an", "too", "little", "snow", "dead", "drunk", "rosebud", "duck", "al", "le")
	newKey += pick("diamond", "beer", "mushroom", "assistant", "clown", "captain", "twinkie", "security", "nuke", "small", "big", "escape", "yellow", "gloves", "monkey", "engine", "nuclear", "ai")
	*/
	// I'm leaving this out because this hardly makes sense in Russian.
	//newKey += pick("the", "if", "of", "as", "in", "a", "you", "from", "to", "an", "too", "little", "snow", "dead", "drunk", "rosebud", "duck", "al", "le")
	newKey += pick("бриллиант", "пиво", "гриб", "ассистент", "клоун", "капитан", "бисквит", "охрана", "бомба", "побег", "перчатки", "мартышка", "двигатель", "взрывчатка", "ии")
	// And tossing in one more digit because it's kinda boring otherwise.
	newKey += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	// End of Bastion of Endeavor Translation
	newKey += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	return newKey

//Used for applying byonds text macros to strings that are loaded at runtime
/proc/apply_text_macros(string)
	/* Bastion of Endeavor Edit: Unicode support. Honestly, I'm not sure if macros are even needed in Russian in the first place. If I could wrap my head around how they work, I could maybe utilize them somehow.
	var/next_backslash = findtext(string, "\\")
	if(!next_backslash)
		return string

	var/leng = length(string)

	var/next_space = findtext(string, " ", next_backslash + 1)
	if(!next_space)
		next_space = leng - next_backslash

	if(!next_space)	//trailing bs
		return string

	var/base = next_backslash == 1 ? "" : copytext(string, 1, next_backslash)
	var/macro = lowertext(copytext(string, next_backslash + 1, next_space))
	var/rest = next_backslash > leng ? "" : copytext(string, next_space + 1)
	*/
	var/next_backslash = findtext_char(string, "\\")
	if(!next_backslash)
		return string

	var/leng = length_char(string)

	var/next_space = findtext_char(string, " ", next_backslash + 1)
	if(!next_space)
		next_space = leng - next_backslash

	if(!next_space)	//trailing bs
		return string

	var/base = next_backslash == 1 ? "" : copytext_char(string, 1, next_backslash)
	var/macro = lowertext(copytext_char(string, next_backslash + 1, next_space))
	var/rest = next_backslash > leng ? "" : copytext_char(string, next_space + 1)
	// End of Bastion of Endeavor Edit

	//See http://www.byond.com/docs/ref/info.html#/DM/text/macros
	switch(macro)
		//prefixes/agnostic
		if("the")
			rest = text("\the []", rest)
		if("a")
			rest = text("\a []", rest)
		if("an")
			rest = text("\an []", rest)
		if("proper")
			rest = text("\proper []", rest)
		if("improper")
			rest = text("\improper []", rest)
		if("roman")
			rest = text("\roman []", rest)
		//postfixes
		if("th")
			base = text("[]\th", rest)
		if("s")
			base = text("[]\s", rest)
		if("he")
			base = text("[]\he", rest)
		if("she")
			base = text("[]\she", rest)
		if("his")
			base = text("[]\his", rest)
		if("himself")
			base = text("[]\himself", rest)
		if("herself")
			base = text("[]\herself", rest)
		if("hers")
			base = text("[]\hers", rest)

	. = base
	if(rest)
		. += .(rest)


#define gender2text(gender) capitalize(gender)

/// Used to get a properly sanitized input, of max_length
/// no_trim is self explanatory but it prevents the input from being trimed if you intend to parse newlines or whitespace.
/proc/stripped_input(mob/user, message = "", title = "", default = "", max_length=MAX_MESSAGE_LEN, no_trim=FALSE)
	var/name = input(user, message, title, default) as text|null

	if(no_trim)
		/* Bastion of Endeavor Edit: Unicode support.
		return copytext(html_encode(name), 1, max_length)
		*/
		return copytext_char(html_encode(name), 1, max_length)
		// End of Bastion of Endeavor Edit
	else
		return trim(html_encode(name), max_length) //trim is "outside" because html_encode can expand single symbols into multiple symbols (such as turning < into &lt;)

// Used to get a properly sanitized multiline input, of max_length
/proc/stripped_multiline_input(mob/user, message = "", title = "", default = "", max_length=MAX_MESSAGE_LEN, no_trim=FALSE)
	var/name = input(user, message, title, default) as message|null
	if(no_trim)
		/* Bastion of Endeavor Edit: Unicode support.
		return copytext(html_encode(name), 1, max_length)
		*/
		return copytext_char(html_encode(name), 1, max_length)
		// End of Bastion of Endeavor Edit
	else
		return trim(html_encode(name), max_length)

//Adds 'char' ahead of 'text' until there are 'count' characters total
/proc/add_leading(text, count, char = " ")
	text = "[text]"
	var/charcount = count - length_char(text)
	var/list/chars_to_add[max(charcount + 1, 0)]
	return jointext(chars_to_add, char) + text

//Adds 'char' behind 'text' until there are 'count' characters total
/proc/add_trailing(text, count, char = " ")
	text = "[text]"
	var/charcount = count - length_char(text)
	var/list/chars_to_add[max(charcount + 1, 0)]
	return text + jointext(chars_to_add, char)
