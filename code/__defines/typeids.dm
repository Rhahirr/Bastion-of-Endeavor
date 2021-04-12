//Byond type ids
#define TYPEID_NULL "0"
#define TYPEID_NORMAL_LIST "f"
//helper macros
/* Bastion of Endeavor Edit: Frankly, I'm not sure if this is needed, but I'm willing to risk it just in case. What could go wrong?
#define GET_TYPEID(ref) ( ( (length(ref) <= 10) ? "TYPEID_NULL" : copytext(ref, 4, -7) ) )
*/
#define GET_TYPEID(ref) ( ( (length_char(ref) <= 10) ? "TYPEID_NULL" : copytext_char(ref, 4, -7) ) )
// End of Bastion of Endeavor Edit
#define IS_NORMAL_LIST(L) (GET_TYPEID("\ref[L]") == TYPEID_NORMAL_LIST)
