#include maps\_utility; 
#include common_scripts\utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_audio;

init()
{
    // setup the weapons
    level.first_box_weapons = get_map_weapons();

    // some printing toggles
    level.watermark_shown = false;
    level.print_weapon_left = true;

    // the master control toggle for the patch itself
    level.first_box_enabled = true;

    // thread for displaying the watermark and pluto checksums
    level thread display_watermark();

    // thread for limiting the round at which the patch can give weapons
    level thread round_limit_watcher();
}

display_watermark()
{
    for (;;)
    {
        level waittill( "start_of_round" );

        // we only want to show this once
        if ( level.watermark_shown == true )
        {
            return;
        }

        get_players()[0].score = 1111111;

        // set this so we dont see it again
        level.watermark_shown = true;

        IPrintLn( "^2First Box Patch v1.0 ^7by ^6Evelyn" );
        
        if ( level.script == "zombie_cod5_factory" )
        {
            IPrintLn( "^3You will receive the ^7Ray Gun ^3once the box has moved." );
        }
        
        // perform the pluto checksums verification
        wait 5;
        SetDvar( "cg_drawChecksums", "1" );
        wait 3;
        SetDvar( "cg_drawChecksums", "0" );
    }
}

round_limit_watcher()
{
    for (;;)
    {
        level waittill( "between_round_over" );

        // let them know that the patch is disabled, its round 20
        if ( level.round_number == 20 && level.first_box_weapons.size != 0 )
        {
            IPrintLn( "^3Round ^720 ^3reached, first box patch disabled." );
            level.first_box_enabled = false;
        }
    }
}

get_map_weapons()
{
    switch ( level.script )
    {
        // Kino
        case "zombie_theater":
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "thundergun_zm" );
        
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
            return array( "ray_gun_zm", "zombie_cymbal_monkey", "tesla_gun_zm" );

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

    // make sure we dont get the ray from the first box on riese
    if ( level.script == "zombie_cod5_factory" && weapon == "ray_gun_zm" && level.chest_moves == 0 )
    {
        weapon = level.first_box_weapons[1];
    }

    // remove the weapon from the list
    level.first_box_weapons = array_remove( level.first_box_weapons, weapon );

    // print out the weapons left
    if ( level.first_box_weapons.size == 0 )
    {
        IPrintLn( "^3All weapons given, first box patch disabled." );
        level.first_box_enabled = false;
    }
    else
    {
        if ( level.first_box_weapons.size == 1 )
        {
            weapon_left_print( "^3There is ^7" + level.first_box_weapons.size + " ^3weapon left." );
        }
        else
        {
            IPrintLn( "^3There are ^7" + level.first_box_weapons.size + " ^3weapons left." );
        }
    }

    // return the weapon
    return weapon;
}

weapon_left_print( message )
{
    if ( level.print_weapon_left == false )
    {
        return;
    }

    IPrintLn( message );

    // stop printing this on riese
    if ( level.script == "zombie_cod5_factory" && level.chest_moves == 0 )
    {
        level.print_weapon_left = false;
    }
}