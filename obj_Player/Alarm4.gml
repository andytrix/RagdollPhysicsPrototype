//////////// WALKING AND JOINT MOTOR CONTROL DURING MOVEMENT ///////////////////////////////////
walkStep = 0;
legSpriteOffset1 = 0;
legSpriteOffset2 = 0;

physics_joint_set_value(leg1_1_joint, phy_joint_motor_speed, 0);
physics_joint_set_value(leg1_2_joint, phy_joint_motor_speed, 0);
physics_joint_set_value(leg2_1_joint, phy_joint_motor_speed, 0);
physics_joint_set_value(leg2_2_joint, phy_joint_motor_speed, 0);
physics_joint_set_value(leg1_2_joint2, phy_joint_motor_speed, 0);
physics_joint_set_value(leg2_2_joint2, phy_joint_motor_speed, 0);
