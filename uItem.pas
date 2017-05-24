unit uItem;

interface

uses BearLibItems, uGame, uMap, uPlayer, uEntity;

type
  TItemType = (itCorpse, itKey, itCoin, itPotion, itFood, itBlade, itAxe,
    itSpear, itMace, itHelm, itArmor);

type
  TSlotType = (stNone, stHead, stChest, stFeet, stMainHand, stOffHand, stNeck,
    stFinger);

type
  TItemBase = record
    Symbol: Char;
    ItemType: TItemType;
    SlotType: TSlotType;
    MaxStack: Word;
    MaxDurability: Word;
    Level: Byte;
    Defense: Byte;
    Damage: TDamage;
    Price: Word;
    Color: Cardinal;
    Deep: set of TMapEnum;
    Value: Word;
  end;

type
  TItemEnum = (
    // All maps
    iCorpse, iGold, iPotionOfHealth1, iPotionOfHealth2, iPotionOfHealth3,
    iPotionOfMana1, iPotionOfMana2, iPotionOfMana3, iFood, iKey,
    // Dark Wood
    iQuiltedArmor, iLeatherArmor, // Armor
    iRustySword, iShortSword, // Blade
    iHatchet, iBattleAxe, // Axe
    iShortSpear, iSpear, // Spear
    iSlagHammer, iSpikedCudgel, // Mace
    // Gray Cave
    iHardLeatherArmor, iBattleArmor, // Armor
    iBroadSword, iLongSword, // Blade
    iMeatAxe, iFleshTearer, // Axe
    iJavelin, iFuscina, // Spear
    iWarhammer, iWarMace, // Mace
    // Deep Cave
    iBrigantineArmor, iRingMail, // Armor
    iMoonBlade, iScimitar, // Blade
    iWarAxe, iDarkAxe, // Axe
    iWarSpear, iHarpoon, // Spear
    iFlangedMace, iWarGavel, // Mace
    // Blood Cave
    iChainMail, iScaleMail, // Armor
    iBastardSword, iGreatSword, // Blade
    iBerserkerAxe, iMarauderAxe, // Axe
    iSilvanWhisper, iImpaler, // Spear
    iBarbarousMace, iAdeptHammer, // Mace
    // Drom
    iPlateMail, iBoneweaveHauberk, // Armor
    iRuneSword, iTrollSlayer, // Blade
    iChopper, iDemonAxe, // Axe
    iSoulReaver, iHonedSpear, // Spear
    iWarMaul, iDoomHammer // Mace
    );

const
  NotEquipItems = [iCorpse, iGold, iPotionOfHealth1, iPotionOfHealth2,
    iPotionOfHealth3, iPotionOfMana1, iPotionOfMana2, iPotionOfMana3,
    iFood, iKey];
  NotDropItems = [iCorpse, iFood, iKey];
  DrinkItems = [iPotionOfHealth1, iPotionOfHealth2, iPotionOfHealth3,
    iPotionOfMana1, iPotionOfMana2, iPotionOfMana3];
  EatItems = [iFood];
  AutoPickupItems = NotEquipItems - NotDropItems;

const
  ItemBase: array [TItemEnum] of TItemBase = (
    // == All maps == //

    // Corpse
    (Symbol: '%'; ItemType: itCorpse; SlotType: stNone; MaxStack: 1;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 0; Color: clGray; Deep: [deDarkWood .. deDrom]; Value: 0;),
    // Gold
    (Symbol: '$'; ItemType: itCoin; SlotType: stNone; MaxStack: 10000;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 1; Color: clYellow; Deep: [deDarkWood .. deDrom]; Value: 0;),

    // Life Potion 1
    (Symbol: '!'; ItemType: itPotion; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 50; Color: clRed; Deep: [deDarkWood .. deDeepCave]; Value: 50;),
    // Life Potion 2
    (Symbol: '!'; ItemType: itPotion; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 100; Color: clRed; Deep: [deGrayCave .. deBloodCave]; Value: 100;),
    // Life Potion 3
    (Symbol: '!'; ItemType: itPotion; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 200; Color: clRed; Deep: [deDeepCave .. deDrom]; Value: 200;),

    // Mana potion 1
    (Symbol: '!'; ItemType: itPotion; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 50; Color: clBlue; Deep: [deDarkWood .. deDeepCave]; Value: 50;),
    // Mana potion 2
    (Symbol: '!'; ItemType: itPotion; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 100; Color: clBlue; Deep: [deGrayCave .. deBloodCave]; Value: 100;),
    // Mana potion 3
    (Symbol: '!'; ItemType: itPotion; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 200; Color: clBlue; Deep: [deDeepCave .. deDrom]; Value: 200;),

    // Food
    (Symbol: ';'; ItemType: itFood; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 75; Color: clWhite; Deep: [deDarkWood .. deDrom]; Value: 250;),
    // Key
    (Symbol: ','; ItemType: itKey; SlotType: stNone; MaxStack: 10;
    MaxDurability: 0; Level: 0; Defense: 0; Damage: (Min: 0; Max: 0;);
    Price: 50; Color: clYellow; Deep: [deDarkWood .. deDrom]; Value: 0;),

    // == Dark Wood == //

    // Quilted Armor
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 25; Level: 1; Defense: 5; Damage: (Min: 0; Max: 0;);
    Price: 100; Color: clWhite; Deep: [deDarkWood];),
    // Leather Armor
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 50; Level: 2; Defense: 10; Damage: (Min: 0; Max: 0;);
    Price: 200; Color: clWhite; Deep: [deDarkWood];),
    // Rusty Sword
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 30; Level: 1; Defense: 1; Damage: (Min: 4; Max: 9;);
    Price: 85; Color: clDarkRed; Deep: [deDarkWood];),
    // Short Sword
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 35; Level: 2; Defense: 2; Damage: (Min: 7; Max: 14;);
    Price: 100; Color: clWhite; Deep: [deDarkWood];),
    // Hatchet
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 30; Level: 1; Defense: 1; Damage: (Min: 5; Max: 8;);
    Price: 65; Color: clDarkRed; Deep: [deDarkWood];),
    // Battle Axe
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 35; Level: 2; Defense: 2; Damage: (Min: 9; Max: 14;);
    Price: 95; Color: clDarkRed; Deep: [deDarkWood];),
    // Short Spear
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 30; Level: 1; Defense: 1; Damage: (Min: 2; Max: 4;);
    Price: 50; Color: clDarkRed; Deep: [deDarkWood];),
    // Spear
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 35; Level: 2; Defense: 2; Damage: (Min: 3; Max: 7;);
    Price: 80; Color: clDarkRed; Deep: [deDarkWood];),
    // Slag Hammer
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 30; Level: 1; Defense: 1; Damage: (Min: 3; Max: 5;);
    Price: 75; Color: clDarkRed; Deep: [deDarkWood];),
    // Spiked Cudgel
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 35; Level: 2; Defense: 2; Damage: (Min: 4; Max: 9;);
    Price: 110; Color: clDarkRed; Deep: [deDarkWood];),

    // == Gray Cave == //

    // HardLeather Armor
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 75; Level: 3; Defense: 15; Damage: (Min: 0; Max: 0;);
    Price: 300; Color: clWhite; Deep: [deGrayCave];),
    // Battle Armor
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 100; Level: 4; Defense: 20; Damage: (Min: 0; Max: 0;);
    Price: 400; Color: clWhite; Deep: [deGrayCave];),
    // Broad Sword
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 40; Level: 3; Defense: 3; Damage: (Min: 11; Max: 21;);
    Price: 145; Color: clDarkRed; Deep: [deGrayCave];),
    // Long Sword
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 45; Level: 4; Defense: 4; Damage: (Min: 14; Max: 26;);
    Price: 185; Color: clDarkRed; Deep: [deGrayCave];),
    // Meat Axe
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 40; Level: 3; Defense: 3; Damage: (Min: 13; Max: 19;);
    Price: 130; Color: clDarkRed; Deep: [deGrayCave];),
    // Flesh Tearer
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 45; Level: 4; Defense: 4; Damage: (Min: 17; Max: 24;);
    Price: 155; Color: clDarkRed; Deep: [deGrayCave];),
    // Javelin
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 40; Level: 3; Defense: 2; Damage: (Min: 4; Max: 12;);
    Price: 120; Color: clDarkRed; Deep: [deGrayCave];),
    // Fuscina
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 45; Level: 4; Defense: 3; Damage: (Min: 5; Max: 19;);
    Price: 160; Color: clDarkRed; Deep: [deGrayCave];),
    // Warhammer
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 40; Level: 3; Defense: 3; Damage: (Min: 6; Max: 13;);
    Price: 145; Color: clDarkRed; Deep: [deGrayCave];),
    // War Mace
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 45; Level: 4; Defense: 4; Damage: (Min: 8; Max: 19;);
    Price: 210; Color: clDarkRed; Deep: [deGrayCave];),

    // == Deep Cave == //

    // Brigantine Armor
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 125; Level: 5; Defense: 25; Damage: (Min: 0; Max: 0;);
    Price: 500; Color: clWhite; Deep: [deDeepCave];),
    // Ring Mail
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 150; Level: 6; Defense: 30; Damage: (Min: 0; Max: 0;);
    Price: 600; Color: clWhite; Deep: [deDeepCave];),
    // Moon Blade
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 50; Level: 5; Defense: 5; Damage: (Min: 17; Max: 31;);
    Price: 270; Color: clDarkRed; Deep: [deDeepCave];),
    // Scimitar
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 55; Level: 6; Defense: 6; Damage: (Min: 21; Max: 38;);
    Price: 300; Color: clDarkRed; Deep: [deDeepCave];),
    // War Axe
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 50; Level: 5; Defense: 5; Damage: (Min: 21; Max: 29;);
    Price: 260; Color: clDarkRed; Deep: [deDeepCave];),
    // Dark Axe
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 55; Level: 6; Defense: 6; Damage: (Min: 24; Max: 33;);
    Price: 285; Color: clDarkRed; Deep: [deDeepCave];),
    // War Spear
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 50; Level: 5; Defense: 3; Damage: (Min: 6; Max: 28;);
    Price: 240; Color: clDarkRed; Deep: [deDeepCave];),
    // Harpoon
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 55; Level: 6; Defense: 4; Damage: (Min: 7; Max: 39;);
    Price: 275; Color: clDarkRed; Deep: [deDeepCave];),
    // Flanged Mace
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 50; Level: 5; Defense: 5; Damage: (Min: 11; Max: 25;);
    Price: 290; Color: clDarkRed; Deep: [deDeepCave];),
    // War Gavel
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 55; Level: 6; Defense: 6; Damage: (Min: 15; Max: 33;);
    Price: 330; Color: clDarkRed; Deep: [deDeepCave];),

    // == Blood Cave == //

    // Chain Mail
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 175; Level: 7; Defense: 35; Damage: (Min: 0; Max: 0;);
    Price: 700; Color: clWhite; Deep: [deBloodCave];),
    // Scale Mail
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 200; Level: 8; Defense: 40; Damage: (Min: 0; Max: 0;);
    Price: 800; Color: clWhite; Deep: [deBloodCave];),
    // Bastard Sword
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 60; Level: 7; Defense: 7; Damage: (Min: 24; Max: 43;);
    Price: 370; Color: clDarkRed; Deep: [deBloodCave];),
    // Great Sword
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 65; Level: 8; Defense: 8; Damage: (Min: 27; Max: 48;);
    Price: 420; Color: clDarkRed; Deep: [deBloodCave];),
    // Berserker Axe
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 60; Level: 7; Defense: 7; Damage: (Min: 28; Max: 38;);
    Price: 350; Color: clDarkRed; Deep: [deDeepCave];),
    // Marauder Axe
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 65; Level: 8; Defense: 8; Damage: (Min: 32; Max: 44;);
    Price: 385; Color: clDarkRed; Deep: [deBloodCave];),
    // Silvan Whisper
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 60; Level: 7; Defense: 4; Damage: (Min: 8; Max: 52;);
    Price: 320; Color: clDarkRed; Deep: [deBloodCave];),
    // Impaler
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 65; Level: 8; Defense: 5; Damage: (Min: 9; Max: 67;);
    Price: 390; Color: clDarkRed; Deep: [deBloodCave];),
    // Barbarous Mace
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 60; Level: 7; Defense: 7; Damage: (Min: 19; Max: 41;);
    Price: 380; Color: clDarkRed; Deep: [deBloodCave];),
    // Adept Hammer
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 65; Level: 8; Defense: 8; Damage: (Min: 24; Max: 51;);
    Price: 450; Color: clDarkRed; Deep: [deBloodCave];),

    // == Drom == //

    // Plate Mail
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 225; Level: 9; Defense: 45; Damage: (Min: 0; Max: 0;);
    Price: 900; Color: clWhite; Deep: [deDrom];),
    // Boneweave Hauberk
    (Symbol: '&'; ItemType: itArmor; SlotType: stChest; MaxStack: 1;
    MaxDurability: 250; Level: 10; Defense: 50; Damage: (Min: 0; Max: 0;);
    Price: 1000; Color: clWhite; Deep: [deDrom];),
    // Rune Sword
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 70; Level: 9; Defense: 9; Damage: (Min: 30; Max: 53;);
    Price: 530; Color: clDarkRed; Deep: [deDrom];),
    // Troll Slayer,
    (Symbol: '/'; ItemType: itBlade; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 75; Level: 10; Defense: 10; Damage: (Min: 33; Max: 58;);
    Price: 590; Color: clDarkRed; Deep: [deDrom];),
    // Chopper
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 70; Level: 9; Defense: 9; Damage: (Min: 36; Max: 49;);
    Price: 540; Color: clDarkRed; Deep: [deDrom];),
    // Demon Axe,
    (Symbol: '('; ItemType: itAxe; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 75; Level: 10; Defense: 10; Damage: (Min: 40; Max: 54;);
    Price: 580; Color: clDarkRed; Deep: [deDrom];),
    // Soul Reaver
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 70; Level: 9; Defense: 5; Damage: (Min: 10; Max: 84;);
    Price: 540; Color: clDarkRed; Deep: [deDrom];),
    // Honed Spear,
    (Symbol: '|'; ItemType: itSpear; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 75; Level: 10; Defense: 6; Damage: (Min: 10; Max: 100;);
    Price: 570; Color: clDarkRed; Deep: [deDrom];),
    // War Maul
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 70; Level: 9; Defense: 9; Damage: (Min: 30; Max: 61;);
    Price: 550; Color: clDarkRed; Deep: [deDrom];),
    // Doom Hammer
    (Symbol: ')'; ItemType: itMace; SlotType: stMainHand; MaxStack: 1;
    MaxDurability: 75; Level: 10; Defense: 10; Damage: (Min: 36; Max: 73;);
    Price: 600; Color: clDarkRed; Deep: [deDrom];)

    );

type
  TItems = class(TEntity)
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render(AX, AY: Byte);
    procedure Add(AZ: TMapEnum; AX: Integer = -1; AY: Integer = -1;
      AID: Integer = -1; IsRare: Boolean = False);
    function GetName(AItemEnum: TItemEnum): string;
    function GetItemEnum(AItemID: Integer): TItemEnum;
    function GetItemInfo(AItem: Item; IsManyItems: Boolean = False;
      ACount: Byte = 0): string;
    function RenderInvItem(X, Y, I: Integer; AItem: Item;
      IsAdvInfo: Boolean = False; IsRender: Boolean = True;
      IsPrice: Boolean = False): string;
    function GetSlotName(const SlotType: TSlotType): string;
    procedure AddItemToInv(Index: Integer; AFlag: Boolean = False); overload;
    procedure AddItemToInv(AItemEnum: TItemEnum; AAmount: Word = 1;
      EqFlag: Boolean = False); overload;
    function GetInventory: string;
    procedure RenderInventory;
    procedure LootGold(const AX, AY: Byte);
    procedure Loot(AX, AY: Byte; AItemEnum: TItemEnum); overload;
    procedure Loot(AX, AY: Byte; AIsBoss: Boolean); overload;
    procedure RenderStore;
  end;

var
  Items: TItems = nil;

implementation

uses Math, Classes, Dialogs, SysUtils, uTerminal, gnugettext, uMsgLog, uScenes;

{ TItems }

function TItems.GetItemInfo(AItem: Item; IsManyItems: Boolean = False;
  ACount: Byte = 0): string;
var
  ID: Integer;
  S, T: string;
begin
  S := '';
  T := '';
  ID := AItem.ItemID;
  // Amount
  if (AItem.Stack > 1) then
    S := Format('(%dx)', [AItem.Amount])
    // Corpse
  else if (TItemEnum(ID) = iCorpse) then
    S := ''
    // Durability
  else
  begin
    case ItemBase[TItemEnum(ID)].ItemType of
      itHelm, itArmor:
        T := Format('<%d>', [ItemBase[TItemEnum(ID)].Defense]);
      else
        T := Format('<%d-%d>', [ItemBase[TItemEnum(ID)].Damage.Min, ItemBase[TItemEnum(ID)].Damage.Max]);
    end;
    S := Trim(Format('%s (%d/%d)', [T, AItem.Durability, ItemBase[TItemEnum(ID)].MaxDurability]));
  end;
  Result := Trim(Format('%s %s', [Items.GetName(TItemEnum(ID)), S]));
  // Map's item     
  if (IsManyItems or (ACount > 0)) then
  begin
    S := GetCapit(GetDescAn(Trim(Items.GetName(TItemEnum(AItem.ItemID)) +
      ' ' + S)));
    if IsManyItems then
    begin
      Result := Format(_('Several items (%dx) are lying here (%s).'),
        [ACount, S]);
    end
    else
      Result := Format(_('%s is lying here.'), [S]);
  end;
end;

procedure Make(ID: Byte; var AItem: Item);
begin
  Items_Clear_Item(AItem);
  AItem.ItemID := ID;
  AItem.SlotID := Ord(ItemBase[TItemEnum(ID)].SlotType);
  AItem.Stack := ItemBase[TItemEnum(ID)].MaxStack;
  AItem.Durability := ItemBase[TItemEnum(ID)].MaxDurability;
end;

procedure TItems.Add(AZ: TMapEnum; AX: Integer = -1; AY: Integer = -1;
  AID: Integer = -1; IsRare: Boolean = False);
var
  I, ID, FX, FY: Byte;
  FItem: Item;
  Value: Integer;
  IT: TItemType;
begin
  I := 0;
  repeat
    if (AID >= 0) then
      ID := AID
    else
      ID := Math.RandomRange(0, Ord(High(TItemEnum)) + 1);
    if (AX >= 0) then
      FX := AX
    else
      FX := Math.RandomRange(1, High(Byte) - 1);
    if (AY >= 0) then
      FY := AY
    else
      FY := Math.RandomRange(1, High(Byte) - 1);
    if (I >= High(Byte)) then
    begin
      ID := Ord(iGold);
      Break;
    end;
    Inc(I);
  until (Map.GetTileEnum(FX, FY, AZ) in SpawnTiles) and
    (AZ in ItemBase[TItemEnum(ID)].Deep);
  if ((AID < 0) and (TItemEnum(ID) in NotDropItems)) then
    Exit;
  Make(ID, FItem);
  FItem.MapID := Ord(AZ);
  FItem.Amount := EnsureRange(Math.RandomRange(0, ItemBase[TItemEnum(ID)
    ].MaxStack div 3) + 1, 1, ItemBase[TItemEnum(ID)].MaxStack);
  IT := ItemBase[TItemEnum(ID)].ItemType;
  case IT of
    itCoin:
      begin
        Value := Ord(AZ) + 1;
        FItem.Amount := Math.RandomRange(Value * Value, Value * Value * 10) + 1;
      end;
  end;
  if ((FItem.Stack = 1) and (IT <> itCorpse)) then
  begin
    Value := ItemBase[TItemEnum(ID)].MaxDurability;
    FItem.Durability := Math.RandomRange(Value div 4, Value) + 1;
  end;
  FItem.X := FX;
  FItem.Y := FY;
  FItem.Equipment := 0;
  Items_Dungeon_AppendItem(FItem);
end;

procedure TItems.AddItemToInv(AItemEnum: TItemEnum; AAmount: Word = 1;
  EqFlag: Boolean = False);
var
  FItem: Item;
begin
  Make(Ord(AItemEnum), FItem);
  FItem.Amount := AAmount;
  FItem.Equipment := IfThen(EqFlag, 1, 0);
  Items_Inventory_AppendItem(FItem);
end;

procedure TItems.Loot(AX, AY: Byte; AItemEnum: TItemEnum);
begin
  Add(Map.Current, AX, AY, Ord(AItemEnum));
end;

procedure TItems.Loot(AX, AY: Byte; AIsBoss: Boolean);
var
  V, I: Byte;
const
  M = 10;
begin
  V := Math.IfThen(AIsBoss, Ord(Map.Current) + 9, Ord(Map.Current) + 2);
  for I := 1 to V do
  begin
    // Gold
    if (Math.RandomRange(0, M) >= 5) then LootGold(AX, AY);
    // Potion
    if ((Math.RandomRange(0, M) >= 7) or AIsBoss) then Loot(AX, AY,
      TItemEnum(Math.RandomRange(Ord(iPotionOfHealth1), Ord(iPotionOfMana3) + 1)));
    // Item
    if (Math.RandomRange(0, M) >= 9) then Add(Map.Current, AX, AY, -1, AIsBoss);
  end;
end;

procedure TItems.Render(AX, AY: Byte);
var
  MapID, X, Y: Byte;
  I, Count: Integer;
  Color: Cardinal;
  FItem: Item;
begin
  MapID := Ord(Map.Current);
  Count := Items_Dungeon_GetMapCount(MapID);
  for I := Count - 1 downto 0 do
  begin
    FItem := Items_Dungeon_GetMapItem(MapID, I);
    if not Map.InView(FItem.X, FItem.Y) or
      (not Game.Wizard and not Map.GetFOV(FItem.X, FItem.Y)) then
      Continue;
    X := FItem.X - Player.X + AX + View.Left;
    Y := FItem.Y - Player.Y + AY + View.Top;
    if not Game.Wizard and (Player.GetDist(FItem.X, FItem.Y) > Player.GetRadius)
    then
      Color := clFog
    else
      Color := ItemBase[TItemEnum(FItem.ItemID)].Color;
    Terminal.Print(X, Y, ItemBase[TItemEnum(FItem.ItemID)].Symbol, Color);
  end;
end;

constructor TItems.Create;
begin
  Items_Open;
end;

destructor TItems.Destroy;
begin
  Items_Close;
  inherited;
end;

function TItems.GetName(AItemEnum: TItemEnum): string;
begin
  case AItemEnum of
    // == All maps == //
    // Corpse
    iCorpse:
      Result := _('Corpse');
    // Gold
    iGold:
      Result := _('Gold');
    // Potion of health
    iPotionOfHealth1:
      Result := _('Potion of health1');
    // Potion of health
    iPotionOfHealth2:
      Result := _('Potion of health2');
    // Potion of health
    iPotionOfHealth3:
      Result := _('Potion of health3');
    // Potion of mana
    iPotionOfMana1:
      Result := _('Potion of mana1');
    // Potion of mana
    iPotionOfMana2:
      Result := _('Potion of mana2');
    // Potion of mana
    iPotionOfMana3:
      Result := _('Potion of mana3');
    // Food
    iFood:
      Result := _('Food');
    // Key
    iKey:
      Result := _('Key');

    // == Dark Wood == //

    // Armor
    iQuiltedArmor:
      Result := _('Quilted Armor');
    iLeatherArmor:
      Result := _('Leather Armor');
    // Blade
    iRustySword:
      Result := _('Rusty Sword');
    iShortSword:
      Result := _('Short Sword');
    // Axe
    iHatchet:
      Result := _('Hatchet');
    iBattleAxe:
      Result := _('Battle Axe');
    // Spear
    iShortSpear:
      Result := _('Short Spear');
    iSpear:
      Result := _('Spear');
    // Mace
    iSlagHammer:
      Result := _('Slag Hammer');
    iSpikedCudgel:
      Result := _('Spiked Cudgel');

    // == Gray Cave == //

    // Armor
    iHardLeatherArmor:
      Result := _('HardLeather Armor');
    iBattleArmor:
      Result := _('Battle Armor');
    // Blade
    iBroadSword:
      Result := _('Broad Sword');
    iLongSword:
      Result := _('Long Sword');
    // Axe
    iMeatAxe:
      Result := _('Meat Axe');
    iFleshTearer:
      Result := _('Flesh Tearer');
    // Spear
    iJavelin:
      Result := _('Javelin');
    iFuscina:
      Result := _('Fuscina');
    // Mace
    iWarhammer:
      Result := _('Warhammer');
    iWarMace:
      Result := _('War Mace');

    // == Deep Cave == //

    // Armor
    iBrigantineArmor:
      Result := _('Brigantine Armor');
    iRingMail:
      Result := _('Ring Mail');
    // Blade
    iMoonBlade:
      Result := _('Moon Blade');
    iScimitar:
      Result := _('Scimitar');
    // Axe
    iWarAxe:
      Result := _('War Axe');
    iDarkAxe:
      Result := _('Dark Axe');
    // Spear
    iWarSpear:
      Result := _('War Spear');
    iHarpoon:
      Result := _('Harpoon');
    // Mace
    iFlangedMace:
      Result := _('Flanged Mace');
    iWarGavel:
      Result := _('War Gavel');

    // == Blood Cave == //

    // Armor
    iChainMail:
      Result := _('Chain Mail');
    iScaleMail:
      Result := _('Scale Mail');
    // Blade
    iBastardSword:
      Result := _('Bastard Sword');
    iGreatSword:
      Result := _('Great Sword');
    // Axe
    iBerserkerAxe:
      Result := _('Berserker Axe');
    iMarauderAxe:
      Result := _('Marauder Axe');
    // Spear
    iSilvanWhisper:
      Result := _('Silvan Whisper');
    iImpaler:
      Result := _('Impaler');
    // Mace
    iBarbarousMace:
      Result := _('Barbarous Mace');
    iAdeptHammer:
      Result := _('Adept Hammer');

    // == Drom == //

    // Armor
    iPlateMail:
      Result := _('Plate Mail');
    iBoneweaveHauberk:
      Result := _('Boneweave Hauberk');
    // Blade
    iRuneSword:
      Result := _('Rune Sword');
    iTrollSlayer:
      Result := _('Troll Slayer');
    // Axe
    iChopper:
      Result := _('Chopper');
    iDemonAxe:
      Result := _('Demon Axe');
    // Spear
    iSoulReaver:
      Result := _('Soul Reaver');
    iHonedSpear:
      Result := _('Honed Spear');
    // Mace
    iWarMaul:
      Result := _('War Maul');
    iDoomHammer:
      Result := _('Doom Hammer');
  end;
end;

function TItems.GetSlotName(const SlotType: TSlotType): string;
begin
      case SlotType of
        stHead:
          Result := _('head');
        stNeck:
          Result := _('neck');
        stFinger:
          Result := _('finger');
        stMainHand:
          Result := _('main hand');
        stOffHand:
          Result := _('off hand');
        stChest:
          Result := _('chest');
        stFeet:
          Result := _('feet');
      end;
  Result := Format('{%s}', [Result]);    
end;

function TItems.RenderInvItem(X, Y, I: Integer; AItem: Item;
  IsAdvInfo: Boolean = False; IsRender: Boolean = True;
  IsPrice: Boolean = False): string;
var
  S: string;
  D: TItemBase;
begin
  Result := '';
  D := ItemBase[TItemEnum(AItem.ItemID)];
  Terminal.Print(X - 4, Y + I, TScene.KeyStr(Chr(I + Ord('A'))));
  if IsRender then
  begin
    Terminal.ForegroundColor(D.Color);
    Terminal.Print(X, Y + I, D.Symbol);
  end
  else
    Result := Result + D.Symbol + ' ';
  Terminal.ForegroundColor(clGray);
  if IsAdvInfo then
  begin
    S := '';
    if (AItem.Equipment > 0) then
    begin
      S := GetSlotName(D.SlotType);
    end;
  end;
  if (S <> '') then
    S := Format(FC, [clAlarm, Items.GetItemInfo(AItem) + ' ' + S])
  else
    S := Trim(Items.GetItemInfo(AItem) + ' ' + S);
  if IsRender then
  begin
    Terminal.Print(X + 2, Y + I, S);
    if IsPrice then
    begin
      if ((D.Price > 1) and (AItem.Equipment = 0) and (AItem.Stack = 1)
        and (AItem.Amount = 1)) then S := Format(FC, ['lighter yellow',
        '$' + IntToStr(D.Price)]) else S := '------';
      Terminal.Print(Screen.Width - 7, Y + I, S);
    end;
  end else
    Result := Result + S;
end;

procedure TItems.AddItemToInv(Index: Integer; AFlag: Boolean = False);
var
  FItem: Item;
  MapID: Integer;
  The: string;
begin
  MapID := Ord(Map.Current);
  FItem := Items_Dungeon_GetMapItemXY(MapID, Index, Player.X, Player.Y);
  if (FItem.Stack > 1) and (FItem.Amount > 1) and not AFlag then
  begin
    Player.SetAmountScene(False, Index, FItem.Amount);
    Exit;
  end;
  if (Items_Dungeon_DeleteItemXY(MapID, Index, Player.X, Player.Y, FItem) > 0)
  then
  begin
    Items_Inventory_AppendItem(FItem);
    The := GetDescThe(Items.GetName(TItemEnum(FItem.ItemID)));
    if (FItem.Amount = 1) then
      MsgLog.Add(Format(_('You picked up %s.'), [The]))
    else
      MsgLog.Add(Format(_('You picked up %s (%dx).'), [The, FItem.Amount]));
    Player.Calc;
  end;
end;

function TItems.GetInventory: string;
var
  SL: TStringList;
  I, FCount: Integer;
  FItem: Item;
begin
  Result := '';
  SL := TStringList.Create;
  try
    FCount := EnsureRange(Items_Inventory_GetCount(), 0, ItemMax);
    for I := 0 to FCount - 1 do
    begin
      FItem := Items_Inventory_GetItem(I);
      SL.Append(Items.RenderInvItem(5, 2, I, FItem, True, False));
    end;
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

function TItems.GetItemEnum(AItemID: Integer): TItemEnum;
begin
  Result := TItemEnum(AItemID);
end;

procedure TItems.LootGold(const AX, AY: Byte);
var
  X, Y: Byte;
begin
  Loot(AX, AY, iGold);
  if (Math.RandomRange(0, 3) = 0) then
  begin
    X := Math.EnsureRange(AX + (Math.RandomRange(0, 3) - 1), 0, High(Byte));
    Y := Math.EnsureRange(AY + (Math.RandomRange(0, 3) - 1), 0, High(Byte));
    if (Map.GetTileEnum(X, Y, Map.Current) in SpawnTiles) then Loot(X, Y, iGold);
  end;
end;

procedure TItems.RenderInventory;
var
  I, C: Integer;
begin
  C := EnsureRange(Items_Inventory_GetCount(), 0, ItemMax);
  for I := 0 to C - 1 do
    Items.RenderInvItem(5, 2, I, Items_Inventory_GetItem(I), True);
end;

procedure TItems.RenderStore;
var
  I, C: Integer;
begin
  C := EnsureRange(Items_Inventory_GetCount(), 0, ItemMax);
  for I := 0 to C - 1 do
    Items.RenderInvItem(5, 2, I, Items_Inventory_GetItem(I), True, True, True);
end;

initialization

Items := TItems.Create;

finalization

FreeAndNil(Items);

end.
