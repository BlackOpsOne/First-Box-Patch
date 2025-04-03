#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_audio;

init()
{
    level.first_box_weapons = get_map_weapons();
}

watermark()
{
    wait 1;
    IPrintLn("^2First Box Patch v1.0 ^7by ^6Evelyn");
    
    // perform the pluto checksums verification
    wait 5;
    IPrintLnBold("cg_drawChecksums");
    SetDvar("cg_drawChecksums", "1");
    wait 3;
    SetDvar("cg_drawChecksums", "0");
}

get_map_weapons()
{
    switch (level.script)
    {
        // Kino
        case "zombie_theater":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "ray_gun_zm" );
        
        // Five
        case "zombie_pentagon":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "crossbow_explosive_zm" );

        // Ascension
        case "zombie_cosmodrome":
            return array( "ray_gun_zm", "zombie_black_hole_bomb", "thundergun_zm" );

        // COTD
        case "zombie_coast":
            return array( "ray_gun_zm", "zombie_nesting_dolls", "sniper_explosive_zm" );

        // Shang
        case "zombie_temple":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "shrink_ray_zm" );

        // Moon
        case "zombie_moon":
            return array( "ray_gun_zm", "zombie_black_hole_bomb", "microwavegundw_zm" );

        // Nacht
        case "zombie_cod5_prototype":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "thundergun_zm" );
        
        // Verruckt
        case "zombie_cod5_asylum":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "cz75dw_zm" );

        // Shino
        case "zombie_cod5_sumpf":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "tesla_gun_zm", "cz75dw_zm" );

        // Riese
        case "zombie_cod5_factory":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "tesla_gun_zm" );

        default:
            return [];
    }
}

get_next_weapon()
{
    // pull the next weapon out
    weapon = level.first_box_weapons[0];

    // remove the weapon from the list
    level.first_box_weapons = array_remove(level.first_box_weapons, weapon);

    // print a nice message
    if (level.first_box_weapons.size == 0)
    {
        IPrintLn("^2First box setup complete!");
    }
    else
    {
        if (level.first_box_weapons.size == 1)
        {
            IPrintLn("^3There is ^7" + level.first_box_weapons.size + " ^3weapon left.");
        }
        else
        {
            IPrintLn("^3There are ^7" + level.first_box_weapons.size + " ^3weapons left.");
        }
    }

    // return the weapon
    return weapon;
}