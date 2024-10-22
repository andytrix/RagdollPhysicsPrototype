//////////// STABILIZE CHARACTER ORIENTATION TO KEEP UPRIGHT ////////////////////////////////////
if (jumpReady == false) {
	var bPow = (g_ragStatus=ragSt.idle?4:0);
	with (id) {
		phy_angular_velocity += -phy_rotation*bPow;
	}
	with (leg1_1) {
		phy_angular_velocity += -phy_rotation*bPow;
	}
	with (leg2_1) {
		phy_angular_velocity += -phy_rotation*bPow;
	}
}

//////////// WALKING ///////////////////////////////////////////////////////////////////////////
var lr = -keyboard_check(ord("A")) + keyboard_check(ord("D"));
if (lr != 0) && (jump != 500) && (jump != 700) && (jumpReady == false) {
	//Walk DirShift
	if (mouse_x > x-1) {
		if (dirShift1 == 0) {
			dirShift1 = 1;
		}
	}
	if (mouse_x < x+1) {
		if (dirShift2 == 0) {
			dirShift2 = 1;
		}
	}
	if (dirShift1 == 1) && (mouse_x < x-11) {
		dirShiftTimer1 ++;
		if dirShiftTimer1 >= 15 {
			dirShift1 = 0;
			dirShiftTimer1 = 0;
		}
		with (leg1_2) {
			phy_speed_x = 0;
		}
		with (leg2_2) {
			phy_speed_x = 0;
		}
		with (leg1_2_2) {
			phy_speed_x = 0;
		}
		with (leg2_2_2) {
			phy_speed_x = 0;
		}
		phy_speed_x = 0;
		phy_speed_y = 0;
		arm1_4.phy_position_y = arm1_4.phy_position_y;
		arm2_4.phy_position_y = arm2_4.phy_position_y;
		physics_joint_set_value(leg1_2_joint, phy_joint_motor_speed, 0);
		physics_joint_set_value(leg2_2_joint, phy_joint_motor_speed, 0);
		physics_joint_set_value(leg1_2_joint2, phy_joint_motor_speed, 0);
		physics_joint_set_value(leg2_2_joint2, phy_joint_motor_speed, 0);
		arm1_4.phy_position_x = phy_position_x;
		arm1_3.phy_position_x = phy_position_x+20;
		arm1_3_3.phy_position_x = phy_position_x;
		arm2_4.phy_position_x = phy_position_x;
		arm2_3.phy_position_x = phy_position_x+20;
		arm2_3_3.phy_position_x = phy_position_x;
	}
	if (dirShift2 == 1) && (mouse_x > x+11) {
		dirShiftTimer2 ++;
		if dirShiftTimer2 >= 15 {
			dirShift2 = 0;
			dirShiftTimer2 = 0;
		}
		with (leg1_2) {
			phy_speed_x = 0;
		}
		with (leg2_2) {
			phy_speed_x = 0;
		}
		with (leg1_2_2) {
			phy_speed_x = 0;
		}
		with (leg2_2_2) {
			phy_speed_x = 0;
		}
		phy_speed_x = 0;
		phy_speed_y = 0;
		arm1_4_2.phy_position_y = arm1_4_2.phy_position_y;
		arm2_4_2.phy_position_y = arm2_4_2.phy_position_y;
		physics_joint_set_value(leg1_2_joint, phy_joint_motor_speed, 0);
		physics_joint_set_value(leg2_2_joint, phy_joint_motor_speed, 0);
		physics_joint_set_value(leg1_2_joint2, phy_joint_motor_speed, 0);
		physics_joint_set_value(leg2_2_joint2, phy_joint_motor_speed, 0);
		arm1_4_2.phy_position_x = phy_position_x;
		arm1_3_2.phy_position_x = phy_position_x-20;
		arm1_3_3_2.phy_position_x = phy_position_x;
		arm2_4_2.phy_position_x = phy_position_x;
		arm2_3_2.phy_position_x = phy_position_x-20;
		arm2_3_3_2.phy_position_x = phy_position_x;
	}
	//Walk DirShift
	phy_linear_damping = 10;
	if (walkStep == 0) && (g_onGround == true) {
		alarm[0] = 1;
		walkStep = 1;
	}
	if (walkStep == 2) && (g_onGround == true) {
		alarm[3] = 1;
		walkStep = 3;
	}
	if (leg1_3.phy_active == true) {
		if keyboard_check(ord("D")) {
			/// LEG
			if (walkStep == 2) || (walkStep == 3) {
				if (g_onWall == false) {
					phy_speed_x += 1.7;
				}
				if (jump != 500) {
					if (dirShift1 == 0) {
						phy_speed_y -= 2.2+jumpSpeed;
					}else{
						phy_speed_y -= 2.2;
					}
				}
				leg1_3.phy_speed_y += 0.1;
				leg2_3.phy_speed_y += 0.1;
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x-5, 0.3);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x-30, 0.3);
					}else{
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x-30, 0.3);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x-5, 0.3);
					}
				}
			}
			if (walkStep == 0) || (walkStep == 1) {
				if (walkStep == 1) {
					phy_angular_velocity -= 60;
				}
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_2.phy_position_x = lerp(leg1_2.phy_position_x, phy_position_x-5, 0.1);
						leg2_2.phy_position_x = lerp(leg2_2.phy_position_x, phy_position_x-50, 0.1);
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x-5, 0.1);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x-50, 0.1);
					}else{
						leg1_2.phy_position_x = lerp(leg1_2.phy_position_x, phy_position_x-50, 0.1);
						leg2_2.phy_position_x = lerp(leg2_2.phy_position_x, phy_position_x-5, 0.1);
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x-50, 0.1);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x-5, 0.1);
					}
				}
				leg1_3.phy_speed_y += 0.05;
				leg2_3.phy_speed_y += 0.05;
			}
			/// ARM
			arm1_4.phy_position_x = lerp(arm1_4.phy_position_x, leg2_2.phy_position_x, 0.5);
			arm2_4.phy_position_x = lerp(arm2_4.phy_position_x, leg1_2.phy_position_x, 0.5);
			arm1_3.phy_position_x = lerp(arm1_3.phy_position_x, phy_position_x+5, 0.5);
			arm2_3.phy_position_x = lerp(arm2_3.phy_position_x, phy_position_x+5, 0.5);
			arm1_4.phy_position_y = lerp(arm1_4.phy_position_y, phy_position_y+70, 0.5);
			arm2_4.phy_position_y = lerp(arm2_4.phy_position_y, phy_position_y+70, 0.5);
			physics_joint_set_value(arm1_2_joint1, phy_joint_upper_angle_limit, 25);
			physics_joint_set_value(arm1_2_joint1, phy_joint_lower_angle_limit, 25);
			physics_joint_set_value(arm2_2_joint1, phy_joint_upper_angle_limit, 25);
			physics_joint_set_value(arm2_2_joint1, phy_joint_lower_angle_limit, 25);
			physics_joint_set_value(arm1_3_joint1, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm1_3_joint1, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint1, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint1, phy_joint_upper_angle_limit, 0);
		}
		if keyboard_check(ord("A")) {
			/// LEG
			if (walkStep == 2) || (walkStep == 3) {
				if (g_onWall == false) {
					phy_speed_x -= 1.7;
				}
				if (jump != 500) {
					if (dirShift1 == 0) {
						phy_speed_y -= 2.2+jumpSpeed;
					}else{
						phy_speed_y -= 2.2;
					}
				}
				leg1_3.phy_speed_y += 0.1;
				leg2_3.phy_speed_y += 0.1;
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x+5, 0.3);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x+30, 0.3);
					}else{
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x+30, 0.3);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x+5, 0.3);
					}
				}
			}
			if (walkStep == 0) || (walkStep == 1) {
				if (walkStep == 1) {
					phy_angular_velocity -= 60;
				}
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_2.phy_position_x = lerp(leg1_2.phy_position_x, phy_position_x-5, 0.1);
						leg2_2.phy_position_x = lerp(leg2_2.phy_position_x, phy_position_x-50, 0.1);
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x-5, 0.1);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x-50, 0.1);
					}else{
						leg1_2.phy_position_x = lerp(leg1_2.phy_position_x, phy_position_x-50, 0.1);
						leg2_2.phy_position_x = lerp(leg2_2.phy_position_x, phy_position_x-5, 0.1);
						leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x-50, 0.1);
						leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x-5, 0.1);
					}
					phy_speed_x -= 0.5;
				}
				leg1_3.phy_speed_y += 0.05;
				leg2_3.phy_speed_y += 0.05;
			}
			/// ARM
			arm1_4.phy_position_x = lerp(arm1_4.phy_position_x, leg2_2.phy_position_x, 0.5);
			arm2_4.phy_position_x = lerp(arm2_4.phy_position_x, leg1_2.phy_position_x, 0.5);
			arm1_3.phy_position_x = lerp(arm1_3.phy_position_x, phy_position_x+5, 0.5);
			arm2_3.phy_position_x = lerp(arm2_3.phy_position_x, phy_position_x+5, 0.5);
			arm1_4.phy_position_y = lerp(arm1_4.phy_position_y, phy_position_y+70, 0.5);
			arm2_4.phy_position_y = lerp(arm2_4.phy_position_y, phy_position_y+70, 0.5);
			physics_joint_set_value(arm1_2_joint1, phy_joint_lower_angle_limit, 25);
			physics_joint_set_value(arm1_2_joint1, phy_joint_upper_angle_limit, 25);
			physics_joint_set_value(arm2_2_joint1, phy_joint_lower_angle_limit, 25);
			physics_joint_set_value(arm2_2_joint1, phy_joint_upper_angle_limit, 25);
			physics_joint_set_value(arm1_3_joint1, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm1_3_joint1, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint1, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint1, phy_joint_upper_angle_limit, 0);
		}
	}
	if (leg1_3_3.phy_active == true) {
		if keyboard_check(ord("A")) {
			/// LEG
			if (walkStep == 2) || (walkStep == 3) {
				if (g_onWall == false) {
					phy_speed_x -= 1.7;
				}
				if (jump != 500) {
					if (dirShift2 == 0) {
						phy_speed_y -= 2.2+jumpSpeed;
					}else{
						phy_speed_y -= 2.2;
					}
				}
				leg1_3_3.phy_speed_y += 0.1;
				leg2_3_3.phy_speed_y += 0.1;
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x+5, 0.3);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x+30, 0.3);
					}else{
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x+30, 0.3);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x+5, 0.3);
					}
				}
			}
			if (walkStep == 0) || (walkStep == 1) {
				if (walkStep == 1) {
					phy_angular_velocity += 60;
				}
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_2_2.phy_position_x = lerp(leg1_2_2.phy_position_x, phy_position_x+5, 0.1);
						leg2_2_2.phy_position_x = lerp(leg2_2_2.phy_position_x, phy_position_x+50, 0.1);
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x+5, 0.1);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x+50, 0.1);
					}else{
						leg1_2_2.phy_position_x = lerp(leg1_2_2.phy_position_x, phy_position_x+50, 0.1);
						leg2_2_2.phy_position_x = lerp(leg2_2_2.phy_position_x, phy_position_x+5, 0.1);
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x+50, 0.1);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x+5, 0.1);
					}
				}
				leg1_3_3.phy_speed_y += 0.05;
				leg2_3_3.phy_speed_y += 0.05;
			}
			/// ARM
			arm1_4_2.phy_position_x = lerp(arm1_4_2.phy_position_x, leg2_2_2.phy_position_x, 0.5);
			arm2_4_2.phy_position_x = lerp(arm2_4_2.phy_position_x, leg1_2_2.phy_position_x, 0.5);
			arm1_3_2.phy_position_x = lerp(arm1_3_2.phy_position_x, phy_position_x-5, 0.5);
			arm2_3_2.phy_position_x = lerp(arm2_3_2.phy_position_x, phy_position_x-5, 0.5);
			arm1_4_2.phy_position_y = lerp(arm1_4_2.phy_position_y, phy_position_y+70, 0.5);
			arm2_4_2.phy_position_y = lerp(arm2_4_2.phy_position_y, phy_position_y+70, 0.5);
			physics_joint_set_value(arm1_2_joint2, phy_joint_lower_angle_limit, -25);
			physics_joint_set_value(arm1_2_joint2, phy_joint_upper_angle_limit, -25);
			physics_joint_set_value(arm2_2_joint2, phy_joint_lower_angle_limit, -25);
			physics_joint_set_value(arm2_2_joint2, phy_joint_upper_angle_limit, -25);
			physics_joint_set_value(arm1_3_joint2, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm1_3_joint2, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint2, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint2, phy_joint_upper_angle_limit, 0);
		}
		if keyboard_check(ord("D")) {
			/// LEG
			if (walkStep == 2) || (walkStep == 3) {
				if (g_onWall == false) {
					phy_speed_x += 1.7;
				}
				if (jump != 500) {
					if (dirShift2 == 0) {
						phy_speed_y -= 2.2+jumpSpeed;
					}else{
						phy_speed_y -= 2.2;
					}
				}
				leg1_3_3.phy_speed_y += 0.1;
				leg2_3_3.phy_speed_y += 0.1;
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x-5, 0.3);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x-30, 0.3);
					}else{
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x-30, 0.3);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x-5, 0.3);
					}
				}
			}
			if (walkStep == 0) || (walkStep == 1) {
				if (walkStep == 1) {
					phy_angular_velocity += 60;
				}
				if (g_onWall == false) {
					if walkJumpLeg1or2 == 0 {
						leg1_2_2.phy_position_x = lerp(leg1_2_2.phy_position_x, phy_position_x+5, 0.1);
						leg2_2_2.phy_position_x = lerp(leg2_2_2.phy_position_x, phy_position_x+50, 0.1);
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x+5, 0.1);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x+50, 0.1);
					}else{
						leg1_2_2.phy_position_x = lerp(leg1_2_2.phy_position_x, phy_position_x+50, 0.1);
						leg2_2_2.phy_position_x = lerp(leg2_2_2.phy_position_x, phy_position_x+5, 0.1);
						leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x+50, 0.1);
						leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x+5, 0.1);
					}
					phy_speed_x += 0.5;
				}
				leg1_3_3.phy_speed_y += 0.05;
				leg2_3_3.phy_speed_y += 0.05;
			}
			/// ARM
			arm1_4_2.phy_position_x = lerp(arm1_4_2.phy_position_x, leg2_2_2.phy_position_x, 0.5);
			arm2_4_2.phy_position_x = lerp(arm2_4_2.phy_position_x, leg1_2_2.phy_position_x, 0.5);
			arm1_3_2.phy_position_x = lerp(arm1_3_2.phy_position_x, phy_position_x-5, 0.5);
			arm2_3_2.phy_position_x = lerp(arm2_3_2.phy_position_x, phy_position_x-5, 0.5);
			arm1_4_2.phy_position_y = lerp(arm1_4_2.phy_position_y, phy_position_y+70, 0.5);
			arm2_4_2.phy_position_y = lerp(arm2_4_2.phy_position_y, phy_position_y+70, 0.5);
			physics_joint_set_value(arm1_2_joint2, phy_joint_lower_angle_limit, -25);
			physics_joint_set_value(arm1_2_joint2, phy_joint_upper_angle_limit, -25);
			physics_joint_set_value(arm2_2_joint2, phy_joint_lower_angle_limit, -25);
			physics_joint_set_value(arm2_2_joint2, phy_joint_upper_angle_limit, -25);
			physics_joint_set_value(arm1_3_joint2, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm1_3_joint2, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint2, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm2_3_joint2, phy_joint_upper_angle_limit, 0);
		}
	}
	lerpTimer = 0;
}else{
	if (jump != 500) && (jump != 700) && (jumpReady == false) {
		phy_linear_damping = 20;
		legSpriteOffset1 = 0;
		legSpriteOffset2 = 0;
		/// LEG
		if (lerpTimer < 150) {
			lerpTimer ++;
			if (leg1_3.phy_active == true) {
				leg1_3.phy_position_x = lerp(leg1_3.phy_position_x, phy_position_x, 0.1);
				leg2_3.phy_position_x = lerp(leg2_3.phy_position_x, phy_position_x, 0.1);
				phy_speed_y -= 0.2;
				phy_speed_y -= 0.2;
				leg1_3.phy_speed_y += 0.2;
				leg2_3.phy_speed_y += 0.2;
			}
			if (leg1_3_3.phy_active == true) {
				leg1_3_3.phy_position_x = lerp(leg1_3_3.phy_position_x, phy_position_x, 0.1);
				leg2_3_3.phy_position_x = lerp(leg2_3_3.phy_position_x, phy_position_x, 0.1);
				phy_speed_y -= 0.2;
				phy_speed_y -= 0.2;
				leg1_3_3.phy_speed_y += 0.2;
				leg2_3_3.phy_speed_y += 0.2;
			}
			with (leg1_2) {
				phy_speed_x = 0;
			}
			with (leg2_2) {
				phy_speed_x = 0;
			}
			with (leg1_2_2) {
				phy_speed_x = 0;
			}
			with (leg2_2_2) {
				phy_speed_x = 0;
			}
			phy_speed_x = 0;
		}else{
			physics_joint_set_value(legRotationJoin1, phy_joint_lower_angle_limit, -25);
			physics_joint_set_value(legRotationJoin1, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(legRotationJoin12, phy_joint_lower_angle_limit, -25);
			physics_joint_set_value(legRotationJoin12, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(legRotationJoin2, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(legRotationJoin2, phy_joint_upper_angle_limit, 25);
			physics_joint_set_value(legRotationJoin22, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(legRotationJoin22, phy_joint_upper_angle_limit, 25);
		}
		/// ARM
		if (leg1_3.phy_active == true) {
			arm1_4.phy_position_x = lerp(arm1_4.phy_position_x, phy_position_x-5, 0.4);
			arm1_3.phy_position_x = lerp(arm1_3.phy_position_x, phy_position_x+5, 0.4);
			arm1_3_3.phy_position_x = lerp(arm1_3_3.phy_position_x, phy_position_x, 0.4);
			arm2_4.phy_position_x = lerp(arm2_4.phy_position_x, phy_position_x-5, 0.4);
			arm2_3.phy_position_x = lerp(arm2_3.phy_position_x, phy_position_x+5, 0.4);
			arm2_3_3.phy_position_x = lerp(arm2_3_3.phy_position_x, phy_position_x, 0.4);
			arm1_4.phy_position_y = lerp(arm1_4.phy_position_y, arm1_4.phy_position_y, 0.4);
			arm2_4.phy_position_y = lerp(arm2_4.phy_position_y, arm2_4.phy_position_y, 0.4);
			physics_joint_set_value(arm1_2_joint1, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm1_2_joint1, phy_joint_upper_angle_limit, 100);
			physics_joint_set_value(arm2_2_joint1, phy_joint_lower_angle_limit, 0);
			physics_joint_set_value(arm2_2_joint1, phy_joint_upper_angle_limit, 100);
			physics_joint_set_value(arm1_3_joint1, phy_joint_lower_angle_limit, -10);
			physics_joint_set_value(arm1_3_joint1, phy_joint_upper_angle_limit, 10);
			physics_joint_set_value(arm2_3_joint1, phy_joint_lower_angle_limit, -10);
			physics_joint_set_value(arm2_3_joint1, phy_joint_upper_angle_limit, 10);
		}
		if (leg1_3_3.phy_active == true) {
			arm1_4_2.phy_position_x = lerp(arm1_4_2.phy_position_x, phy_position_x+5, 0.4);
			arm1_3_2.phy_position_x = lerp(arm1_3_2.phy_position_x, phy_position_x-5, 0.4);
			arm1_3_3_2.phy_position_x = lerp(arm1_3_3_2.phy_position_x, phy_position_x, 0.4);
			arm2_4_2.phy_position_x = lerp(arm2_4_2.phy_position_x, phy_position_x+5, 0.4);
			arm2_3_2.phy_position_x = lerp(arm2_3_2.phy_position_x, phy_position_x-5, 0.4);
			arm2_3_3_2.phy_position_x = lerp(arm2_3_3_2.phy_position_x, phy_position_x, 0.4);
			arm1_4_2.phy_position_y = lerp(arm1_4_2.phy_position_y, arm1_4_2.phy_position_y, 0.4);
			arm2_4_2.phy_position_y = lerp(arm2_4_2.phy_position_y, arm2_4_2.phy_position_y, 0.4);
			physics_joint_set_value(arm1_2_joint2, phy_joint_lower_angle_limit, -100);
			physics_joint_set_value(arm1_2_joint2, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(arm2_2_joint2, phy_joint_lower_angle_limit, -100);
			physics_joint_set_value(arm2_2_joint2, phy_joint_upper_angle_limit, 0);
			physics_joint_set_value(arm1_3_joint2, phy_joint_lower_angle_limit, -10);
			physics_joint_set_value(arm1_3_joint2, phy_joint_upper_angle_limit, 10);
			physics_joint_set_value(arm2_3_joint2, phy_joint_lower_angle_limit, -10);
			physics_joint_set_value(arm2_3_joint2, phy_joint_upper_angle_limit, 10);
		}
		walkStep = 0;
		dirShift1 = 0;
		dirShiftTimer1 = 0;
		dirShift2 = 0;
		dirShiftTimer2 = 0;
	}
}

/// JUMP
if (keyboard_check(ord("W"))) && (g_onGround == true) && (jump == 0) && (lr != 0) {
	jump = 100;
	jumpSpeed = 3;
	alarm[6] = 50;
}

if (keyboard_check(ord("W"))) && (g_onGround == true) && (lr == 0) {
	jump = 500;
	jumpSpeed = 0;
	jumpReady = false;
	lerpTimer = 0;
}

if (jump == 500) {
	phy_linear_damping = 10;
	if (walkStep == 0) && (g_onGround == true) {
		alarm[0] = 1;
		walkStep = 1
	}
	if ((walkStep == 2) || (walkStep == 3)) {
		if jumpSpeed == 0 {
			alarm[6] = 50;
		}
		phy_speed_y -= 3;
		jumpSpeed = 0.1;
	}
	/// ARM
	if (leg1_3.phy_active == true) {
		arm1_4.phy_position_x = lerp(arm1_4.phy_position_x, leg1_2.phy_position_x, 0.1);
		arm1_4.phy_position_y = lerp(arm1_4.phy_position_y, leg1_2.phy_position_y, 0.1);
		arm1_3.phy_position_x = lerp(arm1_3.phy_position_x+10, leg1_2.phy_position_x, 0.1);
		arm1_3.phy_position_y = lerp(arm1_3.phy_position_y, leg1_2.phy_position_y, 0.1);
		arm2_4.phy_position_x = lerp(arm2_4.phy_position_x, leg2_2.phy_position_x, 0.1);
		arm2_4.phy_position_y = lerp(arm2_4.phy_position_y, leg2_2.phy_position_y, 0.1);
		arm2_3.phy_position_x = lerp(arm2_3.phy_position_x+10, leg2_2.phy_position_x, 0.1);
		arm2_3.phy_position_y = lerp(arm2_3.phy_position_y, leg2_2.phy_position_y, 0.1);
	}
	if (leg1_3_3.phy_active == true) {
		arm1_4_2.phy_position_x = lerp(arm1_4_2.phy_position_x, leg1_2_2.phy_position_x, 0.1);
		arm1_4_2.phy_position_y = lerp(arm1_4_2.phy_position_y, leg1_2_2.phy_position_y, 0.1);
		arm1_3_2.phy_position_x = lerp(arm1_3_2.phy_position_x-10, leg1_2_2.phy_position_x, 0.1);
		arm1_3_2.phy_position_y = lerp(arm1_3_2.phy_position_y, leg1_2_2.phy_position_y, 0.1);
		arm2_4_2.phy_position_x = lerp(arm2_4_2.phy_position_x, leg2_2_2.phy_position_x, 0.1);
		arm2_4_2.phy_position_y = lerp(arm2_4_2.phy_position_y, leg2_2_2.phy_position_y, 0.1);
		arm2_3_2.phy_position_x = lerp(arm2_3_2.phy_position_x-10, leg2_2_2.phy_position_x, 0.1);
		arm2_3_2.phy_position_y = lerp(arm2_3_2.phy_position_y, leg2_2_2.phy_position_y, 0.1);
	}
}

//////////// RESET GROUND AND WALL STATES FOR NEXT TICK ///////////////////////////////////////////
if g_onGround == true {
	g_onGround = false;
}
if g_onWall == true {
	g_onWall = false;
}
//////////// SET PHY_ACTIVE TRUE/FALSE BASED ON PLAYER DIRECTION //////////////////////////////////
if objectPhyOff == 0 {
	if mouse_x > x+1 {
		xscale = -image_xscale;
		if head_joint_oneTick == 0 {
			head.phy_active = false;
			head2.phy_active = true;
			light_body.phy_active = false;
			light_body2.phy_active = true;
			headLight.phy_active = false;
			headLight2.phy_active = true;
			// LEG 1
			leg1_2.phy_active = false;
			leg1_2_2.phy_active = true;
			leg1_2_HELP0_1.phy_active = false;
			leg1_2_HELP0_2.phy_active = true;
			leg1_1_HELP1.phy_active = false;
			leg1_1_HELP2.phy_active = true;
			leg1_2_HELP1.phy_active = false;
			leg1_2_HELP2.phy_active = true;
			leg1_3_HELP1.phy_active = false;
			leg1_3_HELP2.phy_active = true;
			leg1_4_HELP1.phy_active = false;
			leg1_4_HELP2.phy_active = true;
			leg1_3.phy_active = false;
			leg1_3_3.phy_active = true;
			leg1_HELP3_1.phy_active = false;
			leg1_HELP3_2.phy_active = true;
			leg1_HELP3_1_1.phy_active = false;
			leg1_HELP3_1_2.phy_active = true;
			leg1_HELP3_1_1_1.phy_active = false;
			leg1_HELP3_1_1_2.phy_active = true;
			// LEG 2
			leg2_2.phy_active = false;
			leg2_2_2.phy_active = true;
			leg2_2_HELP0_1.phy_active = false;
			leg2_2_HELP0_2.phy_active = true;
			leg2_1_HELP1.phy_active = false;
			leg2_1_HELP2.phy_active = true;
			leg2_2_HELP1.phy_active = false;
			leg2_2_HELP2.phy_active = true;
			leg2_3_HELP1.phy_active = false;
			leg2_3_HELP2.phy_active = true;
			leg2_4_HELP1.phy_active = false;
			leg2_4_HELP2.phy_active = true;
			leg2_3.phy_active = false;
			leg2_3_3.phy_active = true;
			leg2_HELP3_1.phy_active = false;
			leg2_HELP3_2.phy_active = true;
			leg2_HELP3_1_1.phy_active = false;
			leg2_HELP3_1_2.phy_active = true;
			leg2_HELP3_1_1_1.phy_active = false;
			leg2_HELP3_1_1_2.phy_active = true;
			// ARM 1
			arm1_2.phy_active = false;
			arm1_2_2.phy_active = true;
			arm1_3.phy_active = false;
			arm1_3_2.phy_active = true;
			arm1_3_3.phy_active = false;
			arm1_3_3_2.phy_active = true;
			arm1_4.phy_active = false;
			arm1_4_2.phy_active = true;
			// ARM 2
			arm2_2.phy_active = false;
			arm2_2_2.phy_active = true;
			arm2_3.phy_active = false;
			arm2_3_2.phy_active = true;
			arm2_3_3.phy_active = false;
			arm2_3_3_2.phy_active = true;
			arm2_4.phy_active = false;
			arm2_4_2.phy_active = true;
			head_joint_oneTick = 1;
		}
		head.phy_position_x = head2.phy_position_x;
		head.phy_position_y = head2.phy_position_y;
		light_body.phy_position_x = light_body2.phy_position_x;
		light_body.phy_position_y = light_body2.phy_position_y;
		headLight.phy_position_x = headLight2.phy_position_x;
		headLight.phy_position_y = headLight2.phy_position_y;
		// LEG 1
		leg1_2.phy_position_x = leg1_2_2.phy_position_x;
		leg1_2.phy_position_y = leg1_2_2.phy_position_y;
		leg1_2_HELP0_1.phy_position_x = leg1_2_HELP0_2.phy_position_x;
		leg1_2_HELP0_1.phy_position_y = leg1_2_HELP0_2.phy_position_y;
		leg1_1_HELP1.phy_position_x = leg1_1_HELP2.phy_position_x;
		leg1_1_HELP1.phy_position_y = leg1_1_HELP2.phy_position_y;
		leg1_2_HELP1.phy_position_x = leg1_2_HELP2.phy_position_x;
		leg1_2_HELP1.phy_position_y = leg1_2_HELP2.phy_position_y;
		leg1_3_HELP1.phy_position_x = leg1_3_HELP2.phy_position_x;
		leg1_3_HELP1.phy_position_y = leg1_3_HELP2.phy_position_y;
		leg1_4_HELP1.phy_position_x = leg1_4_HELP2.phy_position_x;
		leg1_4_HELP1.phy_position_y = leg1_4_HELP2.phy_position_y;
		leg1_4_HELP1.phy_rotation = leg1_4_HELP2.phy_rotation;
		leg1_3.phy_position_x = leg1_3_3.phy_position_x;
		leg1_3.phy_position_y = leg1_3_3.phy_position_y;
		leg1_3.phy_rotation = leg1_3_3.phy_rotation;
		leg1_HELP3_1.phy_position_x = leg1_HELP3_2.phy_position_x;
		leg1_HELP3_1.phy_position_y = leg1_HELP3_2.phy_position_y;
		leg1_HELP3_1.phy_rotation = leg1_HELP3_2.phy_rotation;
		leg1_HELP3_1_1.phy_position_x = leg1_HELP3_1_2.phy_position_x;
		leg1_HELP3_1_1.phy_position_y = leg1_HELP3_1_2.phy_position_y;
		leg1_HELP3_1_1.phy_rotation = leg1_HELP3_1_2.phy_rotation;
		leg1_HELP3_1_1_1.phy_position_x = leg1_HELP3_1_1_2.phy_position_x;
		leg1_HELP3_1_1_1.phy_position_y = leg1_HELP3_1_1_2.phy_position_y;
		// LEG 2
		leg2_2.phy_position_x = leg2_2_2.phy_position_x;
		leg2_2.phy_position_y = leg2_2_2.phy_position_y;
		leg2_2_HELP0_1.phy_position_x = leg2_2_HELP0_2.phy_position_x;
		leg2_2_HELP0_1.phy_position_y = leg2_2_HELP0_2.phy_position_y;
		leg2_1_HELP1.phy_position_x = leg2_1_HELP2.phy_position_x;
		leg2_1_HELP1.phy_position_y = leg2_1_HELP2.phy_position_y;
		leg2_2_HELP1.phy_position_x = leg2_2_HELP2.phy_position_x;
		leg2_2_HELP1.phy_position_y = leg2_2_HELP2.phy_position_y;
		leg2_3_HELP1.phy_position_x = leg2_3_HELP2.phy_position_x;
		leg2_3_HELP1.phy_position_y = leg2_3_HELP2.phy_position_y;
		leg2_4_HELP1.phy_position_x = leg2_4_HELP2.phy_position_x;
		leg2_4_HELP1.phy_position_y = leg2_4_HELP2.phy_position_y;
		leg2_4_HELP1.phy_rotation = leg2_4_HELP2.phy_rotation;
		leg2_3.phy_position_x = leg2_3_3.phy_position_x;
		leg2_3.phy_position_y = leg2_3_3.phy_position_y;
		leg2_3.phy_rotation = leg2_3_3.phy_rotation;
		leg2_HELP3_1.phy_position_x = leg2_HELP3_2.phy_position_x;
		leg2_HELP3_1.phy_position_y = leg2_HELP3_2.phy_position_y;
		leg2_HELP3_1.phy_rotation = leg2_HELP3_2.phy_rotation;
		leg2_HELP3_1_1.phy_position_x = leg2_HELP3_1_2.phy_position_x;
		leg2_HELP3_1_1.phy_position_y = leg2_HELP3_1_2.phy_position_y;
		leg2_HELP3_1_1.phy_rotation = leg2_HELP3_1_2.phy_rotation;
		leg2_HELP3_1_1_1.phy_position_x = leg2_HELP3_1_1_2.phy_position_x;
		leg2_HELP3_1_1_1.phy_position_y = leg2_HELP3_1_1_2.phy_position_y;
		// ARM 1
		arm1_2.phy_position_x = arm1_2_2.phy_position_x;
		arm1_2.phy_position_y = arm1_2_2.phy_position_y;
		arm1_3.phy_position_x = arm1_3_2.phy_position_x;
		arm1_3.phy_position_y = arm1_3_2.phy_position_y;
		arm1_3_3.phy_position_x = arm1_3_3_2.phy_position_x;
		arm1_3_3.phy_position_y = arm1_3_3_2.phy_position_y;
		arm1_3_3.phy_rotation = arm1_3_3_2.phy_rotation;
		arm1_4.phy_position_x = arm1_4_2.phy_position_x;
		arm1_4.phy_position_y = arm1_4_2.phy_position_y;
		arm1_4.phy_rotation = arm1_4_2.phy_rotation;
		// ARM 2
		arm2_2.phy_position_x = arm2_2_2.phy_position_x;
		arm2_2.phy_position_y = arm2_2_2.phy_position_y;
		arm2_3.phy_position_x = arm2_3_2.phy_position_x;
		arm2_3.phy_position_y = arm2_3_2.phy_position_y;
		arm2_3_3.phy_position_x = arm2_3_3_2.phy_position_x;
		arm2_3_3.phy_position_y = arm2_3_3_2.phy_position_y;
		arm2_3_3.phy_rotation = arm2_3_3_2.phy_rotation;
		arm2_4.phy_position_x = arm2_4_2.phy_position_x;
		arm2_4.phy_position_y = arm2_4_2.phy_position_y;
		arm2_4.phy_rotation = arm2_4_2.phy_rotation;
	}

	if mouse_x < x-1 { 
		xscale = image_xscale;
		if head_joint_oneTick == 1 {
			head.phy_active = true;
			head2.phy_active = false;
			light_body.phy_active = true;
			light_body2.phy_active = false;
			headLight.phy_active = true;
			headLight2.phy_active = false;
			// LEG 1
			leg1_2.phy_active = true;
			leg1_2_2.phy_active = false;
			leg1_2_HELP0_1.phy_active = true;
			leg1_2_HELP0_2.phy_active = false;
			leg1_1_HELP1.phy_active = true;
			leg1_1_HELP2.phy_active = false;
			leg1_2_HELP1.phy_active = true;
			leg1_2_HELP2.phy_active = false;
			leg1_3_HELP1.phy_active = true;
			leg1_3_HELP2.phy_active = false;
			leg1_4_HELP1.phy_active = true;
			leg1_4_HELP2.phy_active = false;
			leg1_3.phy_active = true;
			leg1_3_3.phy_active = false;
			leg1_HELP3_1.phy_active = true;
			leg1_HELP3_2.phy_active = false;
			leg1_HELP3_1_1.phy_active = true;
			leg1_HELP3_1_2.phy_active = false;
			leg1_HELP3_1_1_1.phy_active = true;
			leg1_HELP3_1_1_2.phy_active = false;
			// LEG 2
			leg2_2.phy_active = true;
			leg2_2_2.phy_active = false;
			leg2_2_HELP0_1.phy_active = true;
			leg2_2_HELP0_2.phy_active = false;
			leg2_1_HELP1.phy_active = true;
			leg2_1_HELP2.phy_active = false;
			leg2_2_HELP1.phy_active = true;
			leg2_2_HELP2.phy_active = false;
			leg2_3_HELP1.phy_active = true;
			leg2_3_HELP2.phy_active = false;
			leg2_4_HELP1.phy_active = true;
			leg2_4_HELP2.phy_active = false;
			leg2_3.phy_active = true;
			leg2_3_3.phy_active = false;
			leg2_HELP3_1.phy_active = true;
			leg2_HELP3_2.phy_active = false;
			leg2_HELP3_1_1.phy_active = true;
			leg2_HELP3_1_2.phy_active = false;
			leg2_HELP3_1_1_1.phy_active = true;
			leg2_HELP3_1_1_2.phy_active = false;
			// ARM 1
			arm1_2.phy_active = true;
			arm1_2_2.phy_active = false;
			arm1_3.phy_active = true;
			arm1_3_2.phy_active = false;
			arm1_3_3.phy_active = true;
			arm1_3_3_2.phy_active = false;
			arm1_4.phy_active = true;
			arm1_4_2.phy_active = false;
			// ARM 2
			arm2_2.phy_active = true;
			arm2_2_2.phy_active = false;
			arm2_3.phy_active = true;
			arm2_3_2.phy_active = false;
			arm2_3_3.phy_active = true;
			arm2_3_3_2.phy_active = false;
			arm2_4.phy_active = true;
			arm2_4_2.phy_active = false;
			head_joint_oneTick = 0;
		}
		head2.phy_position_x = head.phy_position_x;
		head2.phy_position_y = head.phy_position_y;
		light_body2.phy_position_x = light_body.phy_position_x;
		light_body2.phy_position_y = light_body.phy_position_y;
		headLight2.phy_position_x = headLight.phy_position_x;
		headLight2.phy_position_y = headLight.phy_position_y;
		// LEG 1
		leg1_2_2.phy_position_x = leg1_2.phy_position_x;
		leg1_2_2.phy_position_y = leg1_2.phy_position_y;
		leg1_2_HELP0_2.phy_position_x = leg1_2_HELP0_1.phy_position_x;
		leg1_2_HELP0_2.phy_position_y = leg1_2_HELP0_1.phy_position_y;
		leg1_1_HELP2.phy_position_x = leg1_1_HELP1.phy_position_x;
		leg1_1_HELP2.phy_position_y = leg1_1_HELP1.phy_position_y;
		leg1_2_HELP2.phy_position_x = leg1_2_HELP1.phy_position_x;
		leg1_2_HELP2.phy_position_y = leg1_2_HELP1.phy_position_y;
		leg1_3_HELP2.phy_position_x = leg1_3_HELP1.phy_position_x;
		leg1_3_HELP2.phy_position_y = leg1_3_HELP1.phy_position_y;
		leg1_4_HELP2.phy_position_x = leg1_4_HELP1.phy_position_x;
		leg1_4_HELP2.phy_position_y = leg1_4_HELP1.phy_position_y;
		leg1_4_HELP2.phy_rotation = leg1_4_HELP1.phy_rotation;
		leg1_3_3.phy_position_x = leg1_3.phy_position_x;
		leg1_3_3.phy_position_y = leg1_3.phy_position_y;
		leg1_3_3.phy_rotation = leg1_3.phy_rotation;
		leg1_HELP3_2.phy_position_x = leg1_HELP3_1.phy_position_x;
		leg1_HELP3_2.phy_position_y = leg1_HELP3_1.phy_position_y;
		leg1_HELP3_2.phy_rotation = leg1_HELP3_1.phy_rotation;
		leg1_HELP3_1_2.phy_position_x = leg1_HELP3_1_1.phy_position_x;
		leg1_HELP3_1_2.phy_position_y = leg1_HELP3_1_1.phy_position_y;
		leg1_HELP3_1_2.phy_rotation = leg1_HELP3_1_1.phy_rotation;
		leg1_HELP3_1_1_2.phy_position_x = leg1_HELP3_1_1_1.phy_position_x;
		leg1_HELP3_1_1_2.phy_position_y = leg1_HELP3_1_1_1.phy_position_y;
		// LEG 2
		leg2_2_2.phy_position_x = leg2_2.phy_position_x;
		leg2_2_2.phy_position_y = leg2_2.phy_position_y;
		leg2_2_HELP0_2.phy_position_x = leg2_2_HELP0_1.phy_position_x;
		leg2_2_HELP0_2.phy_position_y = leg2_2_HELP0_1.phy_position_y;
		leg2_1_HELP2.phy_position_x = leg2_1_HELP1.phy_position_x;
		leg2_1_HELP2.phy_position_y = leg2_1_HELP1.phy_position_y;
		leg2_2_HELP2.phy_position_x = leg2_2_HELP1.phy_position_x;
		leg2_2_HELP2.phy_position_y = leg2_2_HELP1.phy_position_y;
		leg2_3_HELP2.phy_position_x = leg2_3_HELP1.phy_position_x;
		leg2_3_HELP2.phy_position_y = leg2_3_HELP1.phy_position_y;
		leg2_4_HELP2.phy_position_x = leg2_4_HELP1.phy_position_x;
		leg2_4_HELP2.phy_position_y = leg2_4_HELP1.phy_position_y;
		leg2_4_HELP2.phy_rotation = leg2_4_HELP1.phy_rotation;
		leg2_3_3.phy_position_x = leg2_3.phy_position_x;
		leg2_3_3.phy_position_y = leg2_3.phy_position_y;
		leg2_3_3.phy_rotation = leg2_3.phy_rotation;
		leg2_HELP3_2.phy_position_x = leg2_HELP3_1.phy_position_x;
		leg2_HELP3_2.phy_position_y = leg2_HELP3_1.phy_position_y;
		leg2_HELP3_2.phy_rotation = leg2_HELP3_1.phy_rotation;
		leg2_HELP3_1_2.phy_position_x = leg2_HELP3_1_1.phy_position_x;
		leg2_HELP3_1_2.phy_position_y = leg2_HELP3_1_1.phy_position_y;
		leg2_HELP3_1_2.phy_rotation = leg2_HELP3_1_1.phy_rotation;
		leg2_HELP3_1_1_2.phy_position_x = leg2_HELP3_1_1_1.phy_position_x;
		leg2_HELP3_1_1_2.phy_position_y = leg2_HELP3_1_1_1.phy_position_y;
		// ARM 1
		arm1_2_2.phy_position_x = arm1_2.phy_position_x;
		arm1_2_2.phy_position_y = arm1_2.phy_position_y;
		arm1_3_2.phy_position_x = arm1_3.phy_position_x;
		arm1_3_2.phy_position_y = arm1_3.phy_position_y;
		arm1_3_3_2.phy_position_x = arm1_3_3.phy_position_x;
		arm1_3_3_2.phy_position_y = arm1_3_3.phy_position_y;
		arm1_3_3_2.phy_rotation = arm1_3_3.phy_rotation;
		arm1_4_2.phy_position_x = arm1_4.phy_position_x;
		arm1_4_2.phy_position_y = arm1_4.phy_position_y;
		arm1_4_2.phy_rotation = arm1_4.phy_rotation;
		// ARM 2
		arm2_2_2.phy_position_x = arm2_2.phy_position_x;
		arm2_2_2.phy_position_y = arm2_2.phy_position_y;
		arm2_3_2.phy_position_x = arm2_3.phy_position_x;
		arm2_3_2.phy_position_y = arm2_3.phy_position_y;
		arm2_3_3_2.phy_position_x = arm2_3_3.phy_position_x;
		arm2_3_3_2.phy_position_y = arm2_3_3.phy_position_y;
		arm2_3_3_2.phy_rotation = arm2_3_3.phy_rotation;
		arm2_4_2.phy_position_x = arm2_4.phy_position_x;
		arm2_4_2.phy_position_y = arm2_4.phy_position_y;
		arm2_4_2.phy_rotation = arm2_4.phy_rotation;
	}
}
