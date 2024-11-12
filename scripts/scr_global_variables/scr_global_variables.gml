global.player_max_hp = 20;
global.player_hp = 20;
global.player_lv = 1;
global.player_gold = 0;
global.player_name = "Chara";
global.player_atk = 0;
global.player_def = 0;
global.player_exp = 10;
global.player_next_exp = 0;
global.player_weapon = ITEM.STICK;
global.player_armor = ITEM.BANDAGE; //Yeah a consumable can be equipped as armor, even weapon.
global.player_invulnerability_time = 20;
global.player_cell = true;

global.player_inventory = [ITEM.EDIBLE_DIRT, ITEM.INSTANT_NOODLES, ITEM.WILTED_VINE, ITEM.OLD_BRICK];
global.player_inventory_size = 8;

global.cell_options = [CELL.CALL_GASTER, CELL.DIMENTIONAL_BOX_B, CELL.DIMENTIONAL_BOX_A, CELL.CALL_GASTER, CELL.SAVE_GAME];

global.box_inventory = [[ITEM.CHOCOLATE, ITEM.BANDAGE],[]]; //For multiple box inventories, like multi-dimensional box B or more.
global.box_inventory_size = [10,10];

global.minutes = 0;
global.seconds = 0;

global.save_data = {wall_1_moved: true, puzzle_1: true, cutscene_1: true};

global.confirm_button = 0;
global.cancel_button = 0;
global.menu_button = 0;
global.up_button = 0;
global.down_button = 0;
global.left_button = 0;
global.right_button = 0;
global.escape_button = 0;

global.confirm_hold_button = 0;
global.cancel_hold_button = 0;
global.menu_hold_button = 0;
global.up_hold_button = 0;
global.down_hold_button = 0;
global.left_hold_button = 0;
global.right_hold_button = 0;
global.escape_hold_button = 0;

global.encounter_enemies = {};
global.encounter_serious_mode = false;

global.item_pool = [];
global.UI_texts = {};
global.last_save = {};