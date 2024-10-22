//////////// WALKING AND JOINT MOTOR CONTROL DURING MOVEMENT ////////////////////////////////////
alarm[1]=34;

if leg1_3.phy_active == true {
	if (jump != 500) {
		physics_joint_set_value(leg1_1_joint, phy_joint_motor_speed, 3);
		physics_joint_set_value(leg1_2_joint, phy_joint_motor_speed, -3);
		physics_joint_set_value(leg2_1_joint, phy_joint_motor_speed, 3);
		physics_joint_set_value(leg2_2_joint, phy_joint_motor_speed, -3);
	}else{
		physics_joint_set_value(leg1_1_joint, phy_joint_motor_speed, 5);
		physics_joint_set_value(leg1_2_joint, phy_joint_motor_speed, -5);
		physics_joint_set_value(leg2_1_joint, phy_joint_motor_speed, 5);
		physics_joint_set_value(leg2_2_joint, phy_joint_motor_speed, -5);
	}
	if keyboard_check(ord("D")) {
		phy_speed_x -= 1;
		phy_speed_y += 1;
		with (leg1_2) {
			phy_speed_x += 5;
		}
		with (leg2_2) {
			phy_speed_x += 5;
		}
	}
	if keyboard_check(ord("A")) {
		phy_speed_x += 1;
		phy_speed_y += 1;
		with (leg1_2) {
			phy_speed_x -= 5;
		}
		with (leg2_2) {
			phy_speed_x -= 5;
		}
	}
}

if leg1_3_3.phy_active == true {
	if (jump != 500) {
		physics_joint_set_value(leg1_1_joint, phy_joint_motor_speed, -3);
		physics_joint_set_value(leg1_2_joint2, phy_joint_motor_speed, 3);
		physics_joint_set_value(leg2_1_joint, phy_joint_motor_speed, -3);
		physics_joint_set_value(leg2_2_joint2, phy_joint_motor_speed, 3);
	}else{
		physics_joint_set_value(leg1_1_joint, phy_joint_motor_speed, -5);
		physics_joint_set_value(leg1_2_joint2, phy_joint_motor_speed, 5);
		physics_joint_set_value(leg2_1_joint, phy_joint_motor_speed, -5);
		physics_joint_set_value(leg2_2_joint2, phy_joint_motor_speed, 5);	
	}
	if keyboard_check(ord("D")) {
		phy_speed_x -= 1;
		phy_speed_y += 1;
		with (leg1_2_2) {
			phy_speed_x += 5;
		}
		with (leg2_2_2) {
			phy_speed_x += 5;
		}
	}
	if keyboard_check(ord("A")) {
		phy_speed_x += 1;
		phy_speed_y += 1;
		with (leg1_2_2) {
			phy_speed_x -= 5;
		}
		with (leg2_2_2) {
			phy_speed_x -= 5;
		}
	}
}

switch (walkJumpLeg1or2) {
	case 0:
		walkJumpLeg1or2 = 1;
	break;
	case 1:
		walkJumpLeg1or2 = 0;
	break;
}
