//// INITIALIZE PLAYER VARIABLES AND STATES ////////////////////////////////////////////////////
walkStep = 0;
walkJumpLeg1or2 = 0;
jump = 0;
jumpSpeed = 0;
jumpReady = false;
head_joint_oneTick = 0;
objectPhyOff = 0;
enum ragSt {
	idle,
	death,
}
g_ragStatus = ragSt.idle;
g_onGround = false;
g_onWall = false;
lerpTimer = 0;
debug_draw = phy_debug_render_shapes;

var scale;
scale = 32;

//// BODY PHYSICS FIXTURE SETUP ////////////////////////////////////////////////////////////////
var fix = physics_fixture_create();
physics_fixture_set_polygon_shape(fix);
physics_fixture_add_point(fix, 229.6543/2.5-51, 90.26283/2.5-80);
physics_fixture_add_point(fix, 231.4221/2.5-51, 218.4771/2.5-80);
physics_fixture_add_point(fix, 187.6275/2.5-51, 370.0932/2.5-80);
physics_fixture_add_point(fix, 66.58286/2.5-51, 370.2539/2.5-80);
physics_fixture_add_point(fix, 22.77036/2.5-51, 218.5575/2.5-80);
physics_fixture_add_point(fix, 24.74356/2.5-51, 90.18247/2.5-80);
physics_fixture_add_point(fix, 67.30606/2.5-51, 0.521759/2.5-80);
physics_fixture_add_point(fix, 185.9977/2.5-51, 0.05480957/2.5-80);
physics_fixture_set_density(fix,5);
physics_fixture_set_restitution(fix,1);
physics_fixture_set_collision_group(fix,0);
physics_fixture_set_linear_damping(fix,20);
physics_fixture_set_angular_damping(fix,20);
physics_fixture_set_friction(fix,0.1);
physics_fixture_bind(fix, id);
physics_fixture_delete(fix);

//// HEAD AND JOINT SETUP /////////////////////////////////////////////////////////////////////
head_joint = instance_create_depth(x-0.0000000001*scale, y-2.41*scale, 5, obj_PlayerBody);
fixture_create(head_joint, 35, 0, 0, 0, scale, 1, 0.45, 0.45);
physics_joint_weld_create(id, head_joint, head_joint.x, head_joint.y, 0,20,20,false);
physics_fixture_delete(head_joint);

head = instance_create_depth(x-0.3*scale, y-3.17*scale, 5, obj_PlayerBody);
fixture_create(head, 0.3, 0, 0, 0, scale, 1, 1.28, 1.28);
physics_joint_weld_create(head_joint, head, head.x, head.y, 0,0,0,false);
physics_fixture_delete(head);

head2 = instance_create_depth(x+0.3*scale, y-3.17*scale, 5, obj_PlayerBody);
fixture_create(head2, 0.3, 0, 0, 0, scale, 1, 1.28, 1.28);
physics_joint_weld_create(head_joint, head2, head2.x, head2.y, 0,0,0,false);
physics_fixture_delete(head2);
head2.phy_active = false;

headLight = instance_create_depth(x+0.5*scale, y-3.4*scale, 5, obj_PlayerBody);
fixture_create(headLight, 0.2, 0, 0, 0, scale, 1, 0.2, 0.2);
physics_joint_weld_create(head_joint, headLight, x, y, 0,0,0,false);
physics_fixture_delete(headLight);

headLight2 = instance_create_depth(x-0.5*scale, y-3.4*scale, 5, obj_PlayerBody);
fixture_create(headLight2, 0.2, 0, 0, 0, scale, 1, 0.2, 0.2);
physics_joint_weld_create(head_joint, headLight2, x, y, 0,0,0,false);
physics_fixture_delete(headLight2);
headLight2.phy_active = false;

//// LEG 1 SETUP AND JOINT CONFIGURATION ///////////////////////////////////////////////////////
leg1_1 = instance_create_depth(x-0.0000000001*scale, y+2.46*scale, 5, obj_PlayerBody);
fixture_create(leg1_1, 10, 0, 0, 0, scale, 0, 0.64, 0.6);
leg1_1_joint = physics_joint_revolute_create(id, leg1_1, id.x, id.y+57, -90,90,1,50000,0,1,0);
physics_fixture_delete(leg1_1);

leg1_1_down = instance_create_depth(x-0.0000000001*scale, y+3.35*scale, 5, obj_PlayerBody);
fixture_create(leg1_1_down, 1, 0, 0, 0, scale, 0, 0.5, 0.35);
physics_joint_weld_create(leg1_1, leg1_1_down, leg1_1.x, leg1_1.y, 0,0,0,false);
physics_fixture_delete(leg1_1_down);

leg1_1_down2 = instance_create_depth(x-0.0000000001*scale, y+3.75*scale, 5, obj_PlayerBody);
fixture_create(leg1_1_down2, 0.3, 0, 0, 0, scale, 1, 0.4, 0.4);
physics_joint_weld_create(leg1_1, leg1_1_down2, leg1_1.x, leg1_1.y, 0,0,0,false);
physics_fixture_delete(leg1_1_down2);

leg1_1_HELP1 = instance_create_depth(x+0.07*scale, y+1.81*scale, 5, obj_PlayerBody);
fixture_create(leg1_1_HELP1, 0.3, 0, 0, 0, scale, 1, 0.91, 0.91);
physics_joint_weld_create(leg1_1, leg1_1_HELP1, leg1_1_HELP1.x, leg1_1_HELP1.y, 0,0,0,false);
physics_fixture_delete(leg1_1_HELP1);

leg1_1_HELP2 = instance_create_depth(x-0.07*scale, y+1.81*scale, 5, obj_PlayerBody);
fixture_create(leg1_1_HELP2, 0.3, 0, 0, 0, scale, 1, 0.91, 0.91);
physics_joint_weld_create(leg1_1, leg1_1_HELP2, leg1_1_HELP2.x, leg1_1_HELP2.y, 0,0,0,false);
physics_fixture_delete(leg1_1_HELP2);
leg1_1_HELP2.phy_active = false;

//// 2 Left
leg1_2 = instance_create_depth(x-0.0000000001*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg1_2, 20, 5, 0, 0, scale, 1, 0.4, 0.4);
leg1_2_joint = physics_joint_revolute_create(leg1_1, leg1_2, leg1_1.x+10, leg1_1.y+35, -90,0,1,50000,0,1,0);
physics_fixture_delete(leg1_2);

leg1_2_HELP0_1 = instance_create_depth(x+0.25*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg1_2_HELP0_1, 0.3, 0, 0, 0, scale, 1, 0.4, 0.4);
physics_joint_weld_create(leg1_2, leg1_2_HELP0_1, leg1_2.x, leg1_2.y, 0,0,0,false);
physics_fixture_delete(leg1_2_HELP0_1);

leg1_2_HELP1 = instance_create_depth(x+0.3*scale, y+4.62*scale, 5, obj_PlayerBody);
fixture_create(leg1_2_HELP1, 0.3, 0, 0, 0, scale, 1, 0.51, 0.51);
physics_joint_weld_create(leg1_2, leg1_2_HELP1, leg1_2.x, leg1_2.y, 0,0,0,false);
physics_fixture_delete(leg1_2_HELP1);

leg1_3_HELP1 = instance_create_depth(x+0.45*scale, y+5.22*scale, 5, obj_PlayerBody);
fixture_create(leg1_3_HELP1, 0.3, 0, 0, 0, scale, 1, 0.56, 0.56);
physics_joint_weld_create(leg1_2, leg1_3_HELP1, leg1_2.x, leg1_2.y, 0,0,0,false);
physics_fixture_delete(leg1_3_HELP1);

leg1_4_HELP1 = instance_create_depth(x+0.52*scale, y+6*scale, 5, obj_PlayerBody);
fixture_create(leg1_4_HELP1, 10, 0, 0, 0, scale, 0, 0.44, 0.6);
physics_joint_weld_create(leg1_2, leg1_4_HELP1, leg1_2.x, leg1_2.y, 0,0,0,false);
physics_fixture_delete(leg1_4_HELP1);

//// 2 Right
leg1_2_2 = instance_create_depth(x-0.0000000001*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg1_2_2, 20, 5, 0, 0, scale, 1, 0.4, 0.4);
leg1_2_joint2 = physics_joint_revolute_create(leg1_1, leg1_2_2, leg1_1.x-10, leg1_1.y+35, 0,90,1,50000,0,1,0);
physics_fixture_delete(leg1_2_2);
leg1_2_2.phy_active = false;

leg1_2_HELP0_2 = instance_create_depth(x-0.25*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg1_2_HELP0_2, 0.3, 0, 0, 0, scale, 1, 0.4, 0.4);
physics_joint_weld_create(leg1_2_2, leg1_2_HELP0_2, leg1_2_2.x, leg1_2_2.y, 0,0,0,false);
physics_fixture_delete(leg1_2_HELP0_2);
leg1_2_HELP0_2.phy_active = false;

leg1_2_HELP2 = instance_create_depth(x-0.3*scale, y+4.62*scale, 5, obj_PlayerBody);
fixture_create(leg1_2_HELP2, 0.3, 0, 0, 0, scale, 1, 0.51, 0.51);
physics_joint_weld_create(leg1_2_2, leg1_2_HELP2, leg1_2_2.x, leg1_2_2.y, 0,0,0,false);
physics_fixture_delete(leg1_2_HELP2);
leg1_2_HELP2.phy_active = false;

leg1_3_HELP2 = instance_create_depth(x-0.45*scale, y+5.22*scale, 5, obj_PlayerBody);
fixture_create(leg1_3_HELP2, 0.3, 0, 0, 0, scale, 1, 0.56, 0.56);
physics_joint_weld_create(leg1_2_2, leg1_3_HELP2, leg1_2_2.x, leg1_2_2.y, 0,0,0,false);
physics_fixture_delete(leg1_3_HELP2);
leg1_3_HELP2.phy_active = false;

leg1_4_HELP2 = instance_create_depth(x-0.52*scale, y+6*scale, 5, obj_PlayerBody);
fixture_create(leg1_4_HELP2, 10, 0, 0, 0, scale, 0, 0.44, 0.6);
physics_joint_weld_create(leg1_2_2, leg1_4_HELP2, leg1_2_2.x, leg1_2_2.y, 0,0,0,false);
physics_fixture_delete(leg1_4_HELP2);
leg1_4_HELP2.phy_active = false;

//// 3 Left
leg1_3 = instance_create_depth(x-0.0000000001*scale, y+6.8*scale, 5, obj_PlayerBody_2);
fixture_create(leg1_3, 600, 0, 0, 0, scale, 1, 0.2, 0.2);
legRotationJoin1 = physics_joint_revolute_create(leg1_4_HELP1, leg1_3, leg1_4_HELP1.x, leg1_4_HELP1.y+10, -25,0,1,70000,0,0,0);
physics_fixture_delete(leg1_3);
leg1_3.phy_linear_damping = 0.5;

leg1_HELP3_1 = instance_create_depth(x-0.0000000001*scale, y+6.78*scale, 5, obj_PlayerBody);
fixture_create(leg1_HELP3_1, 10, 0, 0, 0, scale, 0, 0.7, 0.23);
physics_joint_weld_create(leg1_3, leg1_HELP3_1, leg1_3.x, leg1_3.y, 0,0,0,false);
physics_fixture_delete(leg1_HELP3_1);

leg1_HELP3_1_1 = instance_create_depth(x-0.06*scale, y+6.78*scale, 5, obj_PlayerBodyLeg);
fixture_create(leg1_HELP3_1_1, 10, 5000000000000, 0.3, 0, scale, 0, 1.03, 0.23);
physics_joint_weld_create(leg1_HELP3_1, leg1_HELP3_1_1, leg1_HELP3_1.x, leg1_HELP3_1.y, 0,0,0,false);
physics_fixture_delete(leg1_HELP3_1_1);

leg1_HELP3_1_1_1 = instance_create_depth(x-0.05*scale, y+6.55*scale, 5, obj_PlayerBody);
fixture_create(leg1_HELP3_1_1_1, 10, 0, 0, 0, scale, 1, 0.35, 0.35);
physics_joint_weld_create(leg1_HELP3_1, leg1_HELP3_1_1_1, leg1_HELP3_1.x, leg1_HELP3_1.y, 0,0,0,false);
physics_fixture_delete(leg1_HELP3_1_1_1);

//// 3 Right
leg1_3_3 = instance_create_depth(x-0.0000000001*scale, y+6.8*scale, 5, obj_PlayerBody_2);
fixture_create(leg1_3_3, 600, 0, 0, 0, scale, 1, 0.2, 0.2);
legRotationJoin2 = physics_joint_revolute_create(leg1_4_HELP2, leg1_3_3, leg1_4_HELP2.x, leg1_4_HELP2.y+10, 0,25,1,70000,0,0,0);
physics_fixture_delete(leg1_3_3);
leg1_3_3.phy_linear_damping = 0.5;
leg1_3_3.phy_active = false;

leg1_HELP3_2 = instance_create_depth(x-0.0000000001*scale, y+6.78*scale, 5, obj_PlayerBody);
fixture_create(leg1_HELP3_2, 10, 0, 0, 0, scale, 0, 0.7, 0.23);
physics_joint_weld_create(leg1_3_3, leg1_HELP3_2, leg1_3_3.x, leg1_3_3.y, 0,0,0,false);
physics_fixture_delete(leg1_HELP3_2);
leg1_HELP3_2.phy_active = false;

leg1_HELP3_1_2 = instance_create_depth(x+0.06*scale, y+6.78*scale, 5, obj_PlayerBodyLeg);
fixture_create(leg1_HELP3_1_2, 10, 5000000000000, 0.3, 0, scale, 0, 1.03, 0.23);
physics_joint_weld_create(leg1_HELP3_2, leg1_HELP3_1_2, leg1_HELP3_2.x, leg1_HELP3_2.y, 0,0,0,false);
physics_fixture_delete(leg1_HELP3_1_2);
leg1_HELP3_1_2.phy_active = false;

leg1_HELP3_1_1_2 = instance_create_depth(x+0.05*scale, y+6.55*scale, 5, obj_PlayerBody);
fixture_create(leg1_HELP3_1_1_2, 10, 0, 0, 0, scale, 1, 0.35, 0.35);
physics_joint_weld_create(leg1_HELP3_2, leg1_HELP3_1_1_2, leg1_HELP3_2.x, leg1_HELP3_2.y, 0,0,0,false);
physics_fixture_delete(leg1_HELP3_1_1_2);
leg1_HELP3_1_1_2.phy_active = false;

with (leg1_1) && (leg1_1_down) && (leg1_1_down2) && (leg1_1_HELP1) && (leg1_1_HELP2) &&
(leg1_2) && (leg1_2_HELP0_1) && (leg1_2_HELP1) && (leg1_3_HELP1) && (leg1_4_HELP1) && 
(leg1_2_2) && (leg1_2_HELP0_2) && (leg1_2_HELP2) && (leg1_3_HELP2) && (leg1_4_HELP2) {
	phy_linear_damping = 10;
	phy_angular_damping = 10;
}

//// LEG 2 SETUP AND JOINT CONFIGURATION ///////////////////////////////////////////////////////
leg2_1 = instance_create_depth(x-0.0000000001*scale, y+2.46*scale, 5, obj_PlayerBody);
fixture_create(leg2_1, 10, 0, 0, 0, scale, 0, 0.64, 0.6);
leg2_1_joint = physics_joint_revolute_create(id, leg2_1, id.x, id.y+57, -90,90,1,50000,0,1,0);
physics_fixture_delete(leg2_1);

leg2_1_down = instance_create_depth(x-0.0000000001*scale, y+3.35*scale, 5, obj_PlayerBody);
fixture_create(leg2_1_down, 1, 0, 0, 0, scale, 0, 0.5, 0.35);
physics_joint_weld_create(leg2_1, leg2_1_down, leg2_1.x, leg2_1.y, 0,0,0,false);
physics_fixture_delete(leg2_1_down);

leg2_1_down2 = instance_create_depth(x-0.0000000001*scale, y+3.75*scale, 5, obj_PlayerBody);
fixture_create(leg2_1_down2, 0.3, 0, 0, 0, scale, 1, 0.4, 0.4);
physics_joint_weld_create(leg2_1, leg2_1_down2, leg2_1.x, leg2_1.y, 0,0,0,false);
physics_fixture_delete(leg2_1_down2);

leg2_1_HELP1 = instance_create_depth(x+0.07*scale, y+1.81*scale, 5, obj_PlayerBody);
fixture_create(leg2_1_HELP1, 0.3, 0, 0, 0, scale, 1, 0.91, 0.91);
physics_joint_weld_create(leg2_1, leg2_1_HELP1, leg2_1_HELP1.x, leg2_1_HELP1.y, 0,0,0,false);
physics_fixture_delete(leg2_1_HELP1);

leg2_1_HELP2 = instance_create_depth(x-0.07*scale, y+1.81*scale, 5, obj_PlayerBody);
fixture_create(leg2_1_HELP2, 0.3, 0, 0, 0, scale, 1, 0.91, 0.91);
physics_joint_weld_create(leg2_1, leg2_1_HELP2, leg2_1_HELP2.x, leg2_1_HELP2.y, 0,0,0,false);
physics_fixture_delete(leg2_1_HELP2);
leg2_1_HELP2.phy_active = false;

//// 2 Left
leg2_2 = instance_create_depth(x-0.0000000001*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg2_2, 20, 5, 0, 0, scale, 1, 0.4, 0.4);
leg2_2_joint = physics_joint_revolute_create(leg2_1, leg2_2, leg2_1.x+10, leg2_1.y+35, -90,0,1,50000,0,1,0);
physics_fixture_delete(leg2_2);

leg2_2_HELP0_1 = instance_create_depth(x+0.25*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg2_2_HELP0_1, 0.3, 0, 0, 0, scale, 1, 0.4, 0.4);
physics_joint_weld_create(leg2_2, leg2_2_HELP0_1, leg2_2.x, leg2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_2_HELP0_1);

leg2_2_HELP1 = instance_create_depth(x+0.3*scale, y+4.62*scale, 5, obj_PlayerBody);
fixture_create(leg2_2_HELP1, 0.3, 0, 0, 0, scale, 1, 0.51, 0.51);
physics_joint_weld_create(leg2_2, leg2_2_HELP1, leg2_2.x, leg2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_2_HELP1);

leg2_3_HELP1 = instance_create_depth(x+0.45*scale, y+5.22*scale, 5, obj_PlayerBody);
fixture_create(leg2_3_HELP1, 0.3, 0, 0, 0, scale, 1, 0.56, 0.56);
physics_joint_weld_create(leg2_2, leg2_3_HELP1, leg2_2.x, leg2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_3_HELP1);

leg2_4_HELP1 = instance_create_depth(x+0.52*scale, y+6*scale, 5, obj_PlayerBody);
fixture_create(leg2_4_HELP1, 10, 0, 0, 0, scale, 0, 0.44, 0.6);
physics_joint_weld_create(leg2_2, leg2_4_HELP1, leg2_2.x, leg2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_4_HELP1);

//// 2 Right
leg2_2_2 = instance_create_depth(x-0.0000000001*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg2_2_2, 20, 5, 0, 0, scale, 1, 0.4, 0.4);
leg2_2_joint2 = physics_joint_revolute_create(leg2_1, leg2_2_2, leg2_1.x-10, leg2_1.y+35, 0,90,1,50000,0,1,0);
physics_fixture_delete(leg2_2_2);
leg2_2_2.phy_active = false;

leg2_2_HELP0_2 = instance_create_depth(x-0.25*scale, y+3.92*scale, 5, obj_PlayerBody);
fixture_create(leg2_2_HELP0_2, 0.3, 0, 0, 0, scale, 1, 0.4, 0.4);
physics_joint_weld_create(leg2_2_2, leg2_2_HELP0_2, leg2_2_2.x, leg2_2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_2_HELP0_2);
leg2_2_HELP0_2.phy_active = false;

leg2_2_HELP2 = instance_create_depth(x-0.3*scale, y+4.62*scale, 5, obj_PlayerBody);
fixture_create(leg2_2_HELP2, 0.3, 0, 0, 0, scale, 1, 0.51, 0.51);
physics_joint_weld_create(leg2_2_2, leg2_2_HELP2, leg2_2_2.x, leg2_2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_2_HELP2);
leg2_2_HELP2.phy_active = false;

leg2_3_HELP2 = instance_create_depth(x-0.45*scale, y+5.22*scale, 5, obj_PlayerBody);
fixture_create(leg2_3_HELP2, 0.3, 0, 0, 0, scale, 1, 0.56, 0.56);
physics_joint_weld_create(leg2_2_2, leg2_3_HELP2, leg2_2_2.x, leg2_2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_3_HELP2);
leg2_3_HELP2.phy_active = false;

leg2_4_HELP2 = instance_create_depth(x-0.52*scale, y+6*scale, 5, obj_PlayerBody);
fixture_create(leg2_4_HELP2, 10, 0, 0, 0, scale, 0, 0.44, 0.6);
physics_joint_weld_create(leg2_2_2, leg2_4_HELP2, leg2_2_2.x, leg2_2_2.y, 0,0,0,false);
physics_fixture_delete(leg2_4_HELP2);
leg2_4_HELP2.phy_active = false;

//// 3 Left
leg2_3 = instance_create_depth(x-0.0000000001*scale, y+6.8*scale, 5, obj_PlayerBody_2);
fixture_create(leg2_3, 600, 0, 0, 0, scale, 1, 0.2, 0.2);
legRotationJoin12 = physics_joint_revolute_create(leg2_4_HELP1, leg2_3, leg2_4_HELP1.x, leg2_4_HELP1.y+10, -25,0,1,70000,0,0,0);
physics_fixture_delete(leg2_3);
leg2_3.phy_linear_damping = 0.5;

leg2_HELP3_1 = instance_create_depth(x-0.0000000001*scale, y+6.78*scale, 5, obj_PlayerBody);
fixture_create(leg2_HELP3_1, 10, 0, 0, 0, scale, 0, 0.7, 0.23);
physics_joint_weld_create(leg2_3, leg2_HELP3_1, leg2_3.x, leg2_3.y, 0,0,0,false);
physics_fixture_delete(leg2_HELP3_1);

leg2_HELP3_1_1 = instance_create_depth(x-0.06*scale, y+6.78*scale, 5, obj_PlayerBodyLeg);
fixture_create(leg2_HELP3_1_1, 10, 5000000000000, 0.3, 0, scale, 0, 1.03, 0.23);
physics_joint_weld_create(leg2_HELP3_1, leg2_HELP3_1_1, leg2_HELP3_1.x, leg2_HELP3_1.y, 0,0,0,false);
physics_fixture_delete(leg2_HELP3_1_1);

leg2_HELP3_1_1_1 = instance_create_depth(x-0.05*scale, y+6.55*scale, 5, obj_PlayerBody);
fixture_create(leg2_HELP3_1_1_1, 10, 0, 0, 0, scale, 1, 0.35, 0.35);
physics_joint_weld_create(leg2_HELP3_1, leg2_HELP3_1_1_1, leg2_HELP3_1.x, leg2_HELP3_1.y, 0,0,0,false);
physics_fixture_delete(leg2_HELP3_1_1_1);

//// 3 Right
leg2_3_3 = instance_create_depth(x-0.0000000001*scale, y+6.8*scale, 5, obj_PlayerBody_2);
fixture_create(leg2_3_3, 600, 0, 0, 0, scale, 1, 0.2, 0.2);
legRotationJoin22 = physics_joint_revolute_create(leg2_4_HELP2, leg2_3_3, leg2_4_HELP2.x, leg2_4_HELP2.y+10, 0,25,1,70000,0,0,0);
physics_fixture_delete(leg2_3_3);
leg2_3_3.phy_linear_damping = 0.5;
leg2_3_3.phy_active = false;

leg2_HELP3_2 = instance_create_depth(x-0.0000000001*scale, y+6.78*scale, 5, obj_PlayerBody);
fixture_create(leg2_HELP3_2, 10, 0, 0, 0, scale, 0, 0.7, 0.23);
physics_joint_weld_create(leg2_3_3, leg2_HELP3_2, leg2_3_3.x, leg2_3_3.y, 0,0,0,false);
physics_fixture_delete(leg2_HELP3_2);
leg2_HELP3_2.phy_active = false;

leg2_HELP3_1_2 = instance_create_depth(x+0.06*scale, y+6.78*scale, 5, obj_PlayerBodyLeg);
fixture_create(leg2_HELP3_1_2, 10, 5000000000000, 0.3, 0, scale, 0, 1.03, 0.23);
physics_joint_weld_create(leg2_HELP3_2, leg2_HELP3_1_2, leg2_HELP3_2.x, leg2_HELP3_2.y, 0,0,0,false);
physics_fixture_delete(leg2_HELP3_1_2);
leg2_HELP3_1_2.phy_active = false;

leg2_HELP3_1_1_2 = instance_create_depth(x+0.05*scale, y+6.55*scale, 5, obj_PlayerBody);
fixture_create(leg2_HELP3_1_1_2, 10, 0, 0, 0, scale, 1, 0.35, 0.35);
physics_joint_weld_create(leg2_HELP3_2, leg2_HELP3_1_1_2, leg2_HELP3_2.x, leg2_HELP3_2.y, 0,0,0,false);
physics_fixture_delete(leg2_HELP3_1_1_1);
leg2_HELP3_1_1_2.phy_active = false;

with (leg2_1) && (leg2_1_down) && (leg2_1_down2) && (leg2_1_HELP1) && (leg2_1_HELP2) && 
(leg2_2) && (leg2_2_HELP0_1) && (leg2_2_HELP1) && (leg2_3_HELP1) && (leg2_4_HELP1) && 
(leg2_2_2) && (leg2_2_HELP0_2) && (leg2_2_HELP2) && (leg2_3_HELP2) && (leg2_4_HELP2) {
	phy_linear_damping = 10;
	phy_angular_damping = 10;
}

//// ARM 1 SETUP AND JOINT CONFIGURATION /////////////////////////////////////////////////////////
arm1_1 = instance_create_depth(x-0.0000000001*scale, y-1.6*scale, 5, obj_PlayerBody);
fixture_create(arm1_1, 5, 0, 0, 0, scale, 1, 0.6, 0.6);
arm1_1_joint = physics_joint_revolute_create(id, arm1_1, arm1_1.x, arm1_1.y, -180,180,1,70000,0,1,0);
physics_fixture_delete(arm1_1);

arm1_2 = instance_create_depth(x+0.17*scale, y-0.56*scale, 5, obj_PlayerBody);
fixture_create(arm1_2, 5, 0, 0, 0, scale, 1, 0.5, 0.5);
physics_joint_weld_create(arm1_1, arm1_2, arm1_1.x, arm1_1.y, 0,0,0,false);
physics_fixture_delete(arm1_2);

arm1_2_2 = instance_create_depth(x-0.17*scale, y-0.56*scale, 5, obj_PlayerBody);
fixture_create(arm1_2_2, 5, 0, 0, 0, scale, 1, 0.5, 0.5);
physics_joint_weld_create(arm1_1, arm1_2_2, arm1_1.x, arm1_1.y, 0,0,0,false);
physics_fixture_delete(arm1_2_2);
arm1_2_2.phy_active = false;

arm1_3 = instance_create_depth(x+0.24*scale, y+0.05*scale, 5, obj_PlayerBody);
fixture_create(arm1_3, 5, 0, 0, 0, scale, 1, 0.35, 0.35);
arm1_2_joint1 = physics_joint_revolute_create(arm1_1, arm1_3, arm1_1.x+8.5, arm1_1.y+54, 0,100,1,70000,0,1,0);
physics_fixture_delete(arm1_3);

arm1_3_3 = instance_create_depth(x+0.24*scale, y+1.15*scale, 5, obj_PlayerBody);
fixture_create(arm1_3_3, 1, 0, 0, 0, scale, 0, 0.35, 1.15);
physics_joint_weld_create(arm1_3, arm1_3_3, arm1_3.x, arm1_3.y, 0,0,0,false);
physics_fixture_delete(arm1_3_3);

arm1_4 = instance_create_depth(x+0.24*scale, y+2.55*scale, 5, obj_PlayerBody);
fixture_create(arm1_4, 10, 0, 0, 0, scale, 1, 0.4, 0.4);
arm1_3_joint1 = physics_joint_revolute_create(arm1_4, arm1_3_3, arm1_3_3.x, arm1_3_3.y+25, -10,10,1,70000,0,1,0);
physics_fixture_delete(arm1_4);

// Right
arm1_3_2 = instance_create_depth(x-0.24*scale, y+0.05*scale, 5, obj_PlayerBody);
fixture_create(arm1_3_2, 5, 0, 0, 0, scale, 1, 0.35, 0.35);
arm1_2_joint2 = physics_joint_revolute_create(arm1_1, arm1_3_2, arm1_1.x-8.5, arm1_1.y+54, -100,0,1,70000,0,1,0);
physics_fixture_delete(arm1_3_2);
arm1_3_2.phy_active = false;

arm1_3_3_2 = instance_create_depth(x-0.24*scale, y+1.15*scale, 5, obj_PlayerBody);
fixture_create(arm1_3_3_2, 1, 0, 0, 0, scale, 0, 0.35, 1.15);
physics_joint_weld_create(arm1_3_2, arm1_3_3_2, arm1_3_2.x, arm1_3_2.y, 0,0,0,false);
physics_fixture_delete(arm1_3_3_2);
arm1_3_3_2.phy_active = false;

arm1_4_2 = instance_create_depth(x-0.24*scale, y+2.55*scale, 5, obj_PlayerBody);
fixture_create(arm1_4_2, 10, 0, 0, 0, scale, 1, 0.4, 0.4);
arm1_3_joint2 = physics_joint_revolute_create(arm1_4_2, arm1_3_3_2, arm1_3_3_2.x, arm1_3_3_2.y+25, -10,10,1,70000,0,1,0);
physics_fixture_delete(arm1_4_2);
arm1_4_2.phy_active = false;

with (arm1_1) && (arm1_2) && (arm1_2_2) && (arm1_3) && (arm1_3_3) && (arm1_4) && 
(arm1_3_2) && (arm1_3_3_2) && (arm1_4_2) {
	phy_linear_damping = 10;
	phy_angular_damping = 10;
}

//// ARM 2 SETUP AND JOINT CONFIGURATION /////////////////////////////////////////////////////////
arm2_1 = instance_create_depth(x-0.0000000001*scale, y-1.6*scale, 5, obj_PlayerBody);
fixture_create(arm2_1, 5, 0, 0, 0, scale, 1, 0.6, 0.6);
arm2_1_joint = physics_joint_revolute_create(id, arm2_1, arm2_1.x, arm2_1.y, -180,180,1,70000,0,1,0);
physics_fixture_delete(arm2_1);

arm2_2 = instance_create_depth(x+0.17*scale, y-0.56*scale, 5, obj_PlayerBody);
fixture_create(arm2_2, 5, 0, 0, 0, scale, 1, 0.5, 0.5);
physics_joint_weld_create(arm2_1, arm2_2, arm2_1.x, arm2_1.y, 0,0,0,false);
physics_fixture_delete(arm2_2);

arm2_2_2 = instance_create_depth(x-0.17*scale, y-0.56*scale, 5, obj_PlayerBody);
fixture_create(arm2_2_2, 5, 0, 0, 0, scale, 1, 0.5, 0.5);
physics_joint_weld_create(arm2_1, arm2_2_2, arm2_1.x, arm2_1.y, 0,0,0,false);
physics_fixture_delete(arm2_2_2);
arm2_2_2.phy_active = false;

arm2_3 = instance_create_depth(x+0.24*scale, y+0.05*scale, 5, obj_PlayerBody);
fixture_create(arm2_3, 5, 0, 0, 0, scale, 1, 0.35, 0.35);
arm2_2_joint1 = physics_joint_revolute_create(arm2_1, arm2_3, arm2_1.x+8.5, arm2_1.y+54, 0,100,1,70000,0,1,0);
physics_fixture_delete(arm2_3);

arm2_3_3 = instance_create_depth(x+0.24*scale, y+1.15*scale, 5, obj_PlayerBody);
fixture_create(arm2_3_3, 1, 0, 0, 0, scale, 0, 0.35, 1.15);
physics_joint_weld_create(arm2_3, arm2_3_3, arm2_3.x, arm2_3.y, 0,0,0,false);
physics_fixture_delete(arm2_3_3);

arm2_4 = instance_create_depth(x+0.24*scale, y+2.55*scale, 5, obj_PlayerBody);
fixture_create(arm2_4, 10, 0, 0, 0, scale, 1, 0.4, 0.4);
arm2_3_joint1 = physics_joint_revolute_create(arm2_4, arm2_3_3, arm2_3_3.x, arm2_3_3.y+25, -10,10,1,70000,0,1,0);
physics_fixture_delete(arm2_4);

// Right
arm2_3_2 = instance_create_depth(x-0.24*scale, y+0.05*scale, 5, obj_PlayerBody);
fixture_create(arm2_3_2, 5, 0, 0, 0, scale, 1, 0.35, 0.35);
arm2_2_joint2 = physics_joint_revolute_create(arm2_1, arm2_3_2, arm2_1.x-8.5, arm2_1.y+54, -100,0,1,70000,0,1,0);
physics_fixture_delete(arm2_3_2);
arm2_3_2.phy_active = false;

arm2_3_3_2 = instance_create_depth(x-0.24*scale, y+1.15*scale, 5, obj_PlayerBody);
fixture_create(arm2_3_3_2, 1, 0, 0, 0, scale, 0, 0.35, 1.15);
physics_joint_weld_create(arm2_3_2, arm2_3_3_2, arm2_3_2.x, arm2_3_2.y, 0,0,0,false);
physics_fixture_delete(arm2_3_3_2);
arm2_3_3_2.phy_active = false;

arm2_4_2 = instance_create_depth(x-0.24*scale, y+2.55*scale, 5, obj_PlayerBody);
fixture_create(arm2_4_2, 10, 0, 0, 0, scale, 1, 0.4, 0.4);
arm2_3_joint2 = physics_joint_revolute_create(arm2_4_2, arm2_3_3_2, arm2_3_3_2.x, arm2_3_3_2.y+25, -10,10,1,70000,0,1,0);
physics_fixture_delete(arm2_4_2);
arm2_4_2.phy_active = false;

with (arm2_1) && (arm2_2) && (arm2_2_2) && (arm2_3) && (arm2_3_3) && (arm2_4) && 
(arm2_3_2) && (arm2_3_3_2) && (arm2_4_2) {
	phy_linear_damping = 10;
	phy_angular_damping = 10;
}

//// BODY LIGHT FIXTURE AND ATTACHMENT ///////////////////////////////////////////////////////////////
light_body = instance_create_depth(x-0.8*scale, y-1.14*scale, 5, obj_PlayerBody);
fixture_create(light_body, 1, 0, 0, 0, scale, 1, 0.75, 0.75);
physics_joint_weld_create(id, light_body, light_body.x, light_body.y, 0,0,0,false);
physics_fixture_delete(light_body);
light_body2 = instance_create_depth(x+0.8*scale, y-1.14*scale, 5, obj_PlayerBody);
fixture_create(light_body2, 1, 0, 0, 0, scale, 1, 0.75, 0.75);
physics_joint_weld_create(id, light_body2, light_body2.x, light_body2.y, 0,0,0,false);
physics_fixture_delete(light_body2);
light_body2.phy_active = false;
