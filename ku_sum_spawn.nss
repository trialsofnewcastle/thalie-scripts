/************************ [On Spawn] *******************************************
    Filename: ku_ai_compan9 Animal companion
************************* [On Spawn] *******************************************
*/

#include "X0_INC_HENAI"



void main(){

 SetLocalInt(OBJECT_SELF, "AI_SUMMON",1);
 SetAssociateState(ASSOCIATE_TYPE_SUMMONED);
 ExecuteScript("nw_ch_ac9", OBJECT_SELF);


}
