string no_nazev;
int no_pocet;
int no_stacksize;
void main()
{
no_oPC = GetPCSpeaker();
int momentalni_price = 0;
int price = 0;


no_nazev = GetLocalString(OBJECT_SELF,"no_nazevveci");//nahrani promene do skriptu
no_pocet = GetLocalInt(OBJECT_SELF,"no_pocetveci");
int zbozi = GetLocalInt(OBJECT_SELF,"no_poptavka");


int cnt=0;
price == 0;


  no_Item = GetFirstItemInInventory(no_oPC);
  while (GetIsObjectValid(no_Item)) {
    if (no_pocet <= 0)
      break;

    if(GetResRef(no_Item) != no_nazev) {
      no_Item = GetNextItemInInventory(no_oPC);
      continue;
    }

    int iStack = GetItemStackSize(no_Item);
    cnt = cnt + iStack;

    no_pocet = no_pocet - iStack;

    momentalni_price = GetLocalInt(no_Item,"HOSTINSKY");

    if (momentalni_price == 0)
      momentalni_price = 50;  //nastavi vykupni cenu

    price = price + (momentalni_price * iStack);

    DestroyObject(no_Item,0.3);
    no_Item = GetNextItemInInventory(no_oPC);
  }

  if (price == 0) {
    SpeakString( " Zadne takove veci co bych potreboval u sebe nemas " );
    return;
  }

  if(no_pocet < 0)
    no_pocet == 0;
  SetLocalInt(OBJECT_SELF,"no_pocetveci",no_pocet);



    //cena o 4x vyssi
  float price2 = price * 4;
  no_nazev = IntToString( FloatToInt(price2));

  SpeakString( "Tady mas za tech  " + IntToString(cnt) + " ryb " + no_nazev + " zlatek");

   GiveGoldToCreature(no_oPC, StringToInt(no_nazev)); //vykoupi 4 draze, nez normalne



