//::///////////////////////////////////////////////
//:: Fox's Cunning
//:: NW_S0_FoxCunng
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Raises targets Int by 1d4+1
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "sh_deity_inc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRaise;
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    int nMetaMagic = GetMetaMagicFeat();
    int nRaise = 4;
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = GetThalieCaster(OBJECT_SELF,oTarget,nDuration);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FOXS_CUNNING, FALSE));

    //Enter Metamagic conditions
    if ((nMetaMagic == METAMAGIC_EMPOWER) || (GetThalieClericDeity(OBJECT_SELF)==DEITY_GORDUL))
    {
        nRaise = 6; //Damage/Healing is +50%
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Set Adjust Ability Score effect
    eRaise = EffectAbilityIncrease(ABILITY_INTELLIGENCE, nRaise);
    effect eLink = EffectLinkEffects(eRaise, eDur);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
