global.player = {
	max_hp: 20,
	hp: 20,
	lv: 1,
	gold: 0,
	name: "Chara",
	atk: 0,
	def: 0,
	exp: 10,
	next_exp: 0,
	weapon: ITEM.STICK,
	armor: ITEM.BANDAGE,
	invulnerability_time: 20,
	cell: true,
	cell_options: [CELL.CALL_GASTER, CELL.DIMENTIONAL_BOX_B, CELL.DIMENTIONAL_BOX_A, CELL.CALL_GASTER, CELL.SAVE_GAME],
	inventory: [ITEM.EDIBLE_DIRT, ITEM.INSTANT_NOODLES, ITEM.WILTED_VINE, ITEM.OLD_BRICK],
	inventory_size: 8,
	status_effect: {
		type: PLAYER_STATUS_EFFECT.KARMIC_RETRIBUTION,
		color: make_color_rgb(232, 0, 255),
		value: 0
	}
};

global.box = {
	inventory: [[ITEM.CHOCOLATE, ITEM.BANDAGE],[]], //For multiple box inventories, like multi-dimensional box B or more.
	inventory_size: [10,10]
};

global.minutes = 0;
global.seconds = 0;

global.save_data = {
	wall_1_moved: true,
	puzzle_1: true,
	cutscene_1: true
};

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

global.battle_enemies = [];
global.battle_serious_mode = false;

global.item_pool = [];
global.UI_texts = {};
global.last_save = {};