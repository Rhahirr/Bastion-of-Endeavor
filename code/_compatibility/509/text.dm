#if DM_VERSION < 510

/* Bastion of Endeavor Edit: Russian compatibility. Unsure if needed, but just in case.
/proc/replacetext(text, find, replacement)
	return jointext(splittext(text, find), replacement)
*/
/proc/replacetext(text, find, replacement)
	return jointext_char(splittext_char(text, find), replacement)
// End of Bastion of Endeavor Edit.

#endif