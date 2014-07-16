/* -------------------------------- 

      ... xCraft ...
    
       Version (1.0)
     => Scripted by
 (inv3rse) a.k.a (Inverse)

 Email: aqib398@gmail.com
 Personal Blog: inv3rse.cf
                
------------------------------------ */
#define FILTERSCRIPT
//-----------------------------------------------------------------------------------------------------------------------------

/* Preprocessor Directives 
----------------------------- */

//Includes
#include <a_samp>
#include <a_mysql>
#include <YSI\y_commands>
#include <YSI\y_master>

//Defines (Equipments)
#define SmallBomb 		1
#define NormalBomb 		2
#define HeavyBomb 		3
#define M4 				4
#define AK47 			5
#define RPG 			6
#define Grenade 		7
#define Hat 			8
#define Glasses 		9
#define Armour 			10

//Defines (Materials)
#define Dynamite 			1
#define ElectronicWire 		2
#define RemoteTrigger 		3
#define WoodenStock 		4
#define PlasticStock 		5
#define AK47Magazine 		6
#define M4Magazine 			7
#define GunReceiver 		8
#define GunBarrel 			9
#define RPGGrenade 			10
#define RPGLauncher 		11
#define SafetyPin 			12
#define MechanicalFuse 		13
#define TNT 				14
#define HatCloth 			15
#define Cardboard 			16
#define Plastic 			17
#define Lenses 				18
#define ArmourFabric 		19
#define MetalPlate 			20

//Defines (MySQL)
#define MySQL_HOST 		 localhost
#define MySQL_USER 		 root
#define MySQL_PASS 		 123
#define MySQL_DATABASE   inv3rse

//Defines (Dialog ID's)
#define DIALOG_BUYMATERIALS    7628147
#define DIALOG_CRAFT           7628148
#define DIALOG_INVENTORY       7628149

//Defines (Materials' Shop Coordinates)
#define ShopX   0.0
#define ShopY   0.0
#define ShopZ   0.0

//Defines (Materials' Prices)
#define DynamitePrice 			0
#define ElectronicWirePrice 	0
#define RemoteTriggerPrice 		0
#define WoodenStockPrice 		0
#define PlasticStockPrice 		0
#define AK47MagazinePrice 		0
#define M4MagazinePrice 		0
#define GunReceiverPrice 		0
#define GunBarrelPrice 			0
#define RPGGrenadePrice 		0
#define RPGLauncherPrice 		0
#define SafetyPinPrice 			0
#define MechanicalFusePrice 	0
#define TNTPrice 				0
#define HatClothPrice 			0
#define CardboardPrice 			0
#define PlasticPrice 			0
#define LensesPrice 			0
#define ArmourFabricPrice 		0
#define MetalPlatePrice 		0

//Defines (Colour Defines)
#define EmbedWhite		"{FFFFFF}"
#define EmbedRed		"{FF0000}"
#define EmbedOrange		"{FFA500}"
#define EmbedYellow		"{FFFF00}"
#define EmbedGreen		"{008000}"
#define EmbedBlue		"{42C0FB}"
#define EmbedTeal		"{008080}"


//-----------------------------------------------------------------------------------------------------------------------------

/*  Data Storage 
------------------ */

//Constants
enum xCraft
{
    ORM:ORM_ID,
    ID,
    Name[MAX_PLAYER_NAME+1],
    qSmallBomb, 
    qNormalBomb, 
    qHeavyBomb, 
    qM4, 
    qAK47, 
    qRPG,
    qGrenade, 
    qHat, 
    qGlasses, 
    qArmour, 
    qDynamite, 
    qElectronicWire, 
    qRemoteTrigger, 
    qWoodenStock, 
    qPlasticStock, 
    qAK47Magazine, 
    qM4Magazine,
    qGunReceiver, 
    qGunBarrel,
    qRPGGrenade, 
    qRPGLauncher, 
    qSafetyPin, 
    qMechanicalFuse, 
    qTNT, 
    qHatCloth, 
    qCardboard, 
    qPlastic, 
    qLenses, 
    qArmourFabric, 
    qMetalPlate
};
    
//Variables
new xInfo[MAX_PLAYERS][xCraft];
new PlayerHasPlantedBomb[MAX_PLAYERS];




//-----------------------------------------------------------------------------------------------------------------------------

/* Functions 
--------------- */

//Custom Functions 

ShowMaterialsToPlayer(playerid)
{
    new str1[500], str2[250];
    format(str1, sizeof(str1), ""EmbedWhite"Dynamite (%i)\nElectronic Wire (%i)\nRemote Trigger (%i)\nWooden Stock (%i)\nPlastic Stock (%i)\nAK-47 Magazine (%i)\nM4 Magazine (%i)\nGun Receiver (%i)\nGun Barrel (%i)\nRPG Grenade (%i)", xInfo[playerid][qDynamite], xInfo[playerid][qElectronicWire], xInfo[playerid][qRemoteTrigger], xInfo[playerid][qWoodenStock], xInfo[playerid][qPlasticStock], xInfo[playerid][qAK47Magazine], xInfo[playerid][qM4Magazine], xInfo[playerid][qGunReceiver], xInfo[playerid][qGunBarrel], xInfo[playerid][qRPGGrenade]);  
    format(str2, sizeof(str2), "\nRPG Launcher (%i)\nSafety Pin (%i)\nMechanical Fuse (%i)\nTNT (%i)\nHat Cloth (%i)\nCardboard (%i)\nPlastic (%i)\nLenses (%i)\nArmour Fabric (%i)\nMetal Plate (%i)", xInfo[playerid][qRPGLauncher], xInfo[playerid][qSafetyPin], xInfo[playerid][qMechanicalFuse], xInfo[playerid][qTNT], xInfo[playerid][qHatCloth], xInfo[playerid][qCardboard], xInfo[playerid][qPlastic], xInfo[playerid][qLenses], xInfo[playerid][qArmourFabric], xInfo[playerid][qMetalPlate]);
    strcat(str1, str2, sizeof(str1));
    ShowPlayerDialog(playerid, DIALOG_BUYMATERIALS, DIALOG_STYLE_LIST, ""EmbedTeal"Materials Shop!", str1, "Buy!", "Cancel");
    PlayerPlaySound(playerid, 4203, 0, 0, 0);
}


forward OnPlayerDataLoad(playerid);
public OnPlayerDataLoad(playerid)
{
    orm_setkey(xInfo[playerid][ORM_ID], "ID"); 
    
    switch(orm_errno(xInfo[playerid][ORM_ID])) {
        case ERROR_NO_DATA: {
            orm_insert(xInfo[playerid][ORM_ID]);
        }
    }
    return true;
}






//-----------------------------------------------------------------------------------------------------------------------------

//Callbacks


public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print("    |xCraft (v1.0) by inv3rse loaded!|     ");
    print("--------------------------------------\n");
    
    mysql_connect(MySQL_HOST, MySQL_USER, MySQL_DATABASE, MySQL_PASS);
    
    Command_AddAltNamed("inventory", "inv");
    
    return true;
}

public OnPlayerConnect(playerid)
{
    GetPlayerName(playerid, xInfo[playerid][Name], MAX_PLAYER_NAME);
    new ORM:ormid = xInfo[playerid][ORM_ID] = orm_create("xInfo");
    
    orm_addvar_int(ormid, xInfo[playerid][ID], "ID");
    orm_addvar_string(ormid, xInfo[playerid][Name], MAX_PLAYER_NAME+1, "Name");
    
    //Equipments
    orm_addvar_int(ormid, xInfo[playerid][qSmallBomb], "Small Bombs");
    orm_addvar_int(ormid, xInfo[playerid][qNormalBomb], "Normal Bombs");
    orm_addvar_int(ormid, xInfo[playerid][qHeavyBomb], "Heavy Bombs");
    orm_addvar_int(ormid, xInfo[playerid][qM4], "M4");
    orm_addvar_int(ormid, xInfo[playerid][qAK47], "AK-47");
    orm_addvar_int(ormid, xInfo[playerid][qRPG], "RPG");
    orm_addvar_int(ormid, xInfo[playerid][qGrenade], "Grenades");
    orm_addvar_int(ormid, xInfo[playerid][qHat], "Hats");
    orm_addvar_int(ormid, xInfo[playerid][qGlasses], "Glasses");
    orm_addvar_int(ormid, xInfo[playerid][qArmour], "Armours");
    
    //Materials
    orm_addvar_int(ormid, xInfo[playerid][qDynamite], "Dynamites");
    orm_addvar_int(ormid, xInfo[playerid][qElectronicWire], "Electronic Wires");
    orm_addvar_int(ormid, xInfo[playerid][qRemoteTrigger], "Remote Triggers");
    orm_addvar_int(ormid, xInfo[playerid][qWoodenStock], "Wooden Stocks");
    orm_addvar_int(ormid, xInfo[playerid][qPlasticStock], "Plastic Stocks");
    orm_addvar_int(ormid, xInfo[playerid][qAK47Magazine], "AK-47 Magazines");
    orm_addvar_int(ormid, xInfo[playerid][qM4Magazine], "M4 Magazines");
    orm_addvar_int(ormid, xInfo[playerid][qGunReceiver], "Gun Receivers");
    orm_addvar_int(ormid, xInfo[playerid][qGunBarrel], "Gun Barrels");
    orm_addvar_int(ormid, xInfo[playerid][qRPGGrenade], "RPG Grenades");
    orm_addvar_int(ormid, xInfo[playerid][qRPGLauncher], "RPG Launchers");
    orm_addvar_int(ormid, xInfo[playerid][qSafetyPin], "Safety Pins");
    orm_addvar_int(ormid, xInfo[playerid][qMechanicalFuse], "Mechanical Fuses");
    orm_addvar_int(ormid, xInfo[playerid][qTNT], "TNT");
    orm_addvar_int(ormid, xInfo[playerid][qHatCloth], "Hat Cloths");
    orm_addvar_int(ormid, xInfo[playerid][qCardboard], "Cardboards");
    orm_addvar_int(ormid, xInfo[playerid][qPlastic], "Plastics");
    orm_addvar_int(ormid, xInfo[playerid][qLenses], "Lenses");
    orm_addvar_int(ormid, xInfo[playerid][qArmourFabric], "Armour Fabrics");
    orm_addvar_int(ormid, xInfo[playerid][qMetalPlate], "Metal Plates");
    
    orm_setkey(ormid, "Name");
    orm_select(ormid, "OnPlayerDataLoad", "d", playerid);
    return true;
}

public OnPlayerDisconnect(playerid, reason)
{
    PlayerHasPlantedBomb[playerid] = false;
    
    if(xInfo[playerid][ID] != 0) orm_update(xInfo[playerid][ORM_ID]);   
    orm_destroy(xInfo[playerid][ORM_ID]);

    for(new xCraft:e; e < xCraft; ++e) {
        xInfo[playerid][e] = 0;
    }
    return true;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid) {
    	case DIALOG_BUYMATERIALS: {
            if(!response) return false;
            switch (listitem) {
                case 0: {
                    if(GetPlayerMoney(playerid) >= DynamitePrice)
                    {
                        GivePlayerMoney(playerid, -(DynamitePrice));
                        xInfo[playerid][qDynamite] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Dynamite!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 1: {
                    if(GetPlayerMoney(playerid) >= ElectronicWirePrice)
                    {
                        GivePlayerMoney(playerid, -(ElectronicWirePrice));
                        xInfo[playerid][qElectronicWire] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased an "EmbedTeal"Electronic Wire!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 2: {
                    if(GetPlayerMoney(playerid) >= RemoteTriggerPrice)
                    {
                        GivePlayerMoney(playerid, -(RemoteTriggerPrice));
                        xInfo[playerid][qRemoteTrigger] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Remote Trigger!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                    
                }
                case 3: {
                    if(GetPlayerMoney(playerid) >= WoodenStockPrice)
                    {
                        GivePlayerMoney(playerid, -(WoodenStockPrice));
                        xInfo[playerid][qWoodenStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Wooden Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 4: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                    
                }
                case 5: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 6: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 7: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 8: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 9: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 10: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 11: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 12: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 13: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 14: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 15: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 16: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 17: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 18: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
                case 19: {
                    if(GetPlayerMoney(playerid) >= PlasticStockPrice)
                    {
                        GivePlayerMoney(playerid, -(PlasticStockPrice));
                        xInfo[playerid][qPlasticStock] += 1;
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You have successfully purchased a "EmbedTeal"Plastic Stock!");
                        ShowMaterialsToPlayer(playerid);
                    }
                    else
                    {
                        SendClientMessage(playerid, -1, ""EmbedTeal"Materials Shop: "EmbedWhite"You don't have enough money to purchase that material.");
                        ShowMaterialsToPlayer(playerid);
                    }
                }
            }
            return true;
        }	    
    }
	return false;
}


//-----------------------------------------------------------------------------------------------------------------------------

//Commands


YCMD:buymaterials(playerid, params[]) {
	if(!IsPlayerInRangeOfPoint(playerid, 4.0, ShopX, ShopY, ShopZ)) return SendClientMessage(playerid, -1, ""EmbedTeal"ERROR: "EmbedWhite"You are not near a materials shop!");
    ShowMaterialsToPlayer(playerid);
	return true;
}


YCMD:price(playerid, params[]) {
    if(!IsPlayerInRangeOfPoint(playerid, 4.0, ShopX, ShopY, ShopZ)) return SendClientMessage(playerid, -1, ""EmbedTeal"ERROR: "EmbedWhite"You are not near a materials shop!");
    return true;
}


YCMD:craft(playerid, params[]) {
	return true;
}


YCMD:inventory(playerid, params[]) {
	return true;
}
