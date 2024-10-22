/// Description: fixture_create(bind_id_list,density,friction,restitution,group,scale,type,v1,v2)
/// Function: fixture_create
/// Parameters:
/// - bind_id_list: List of IDs to bind the fixture to (single ID or array)
/// - density: Density value for the fixture
/// - friction: Friction coefficient
/// - restitution: Bounciness level
/// - group: Collision group identifier
/// - scale: Scale factor for shape dimensions
/// - type: Shape type (0 = box, 1 = circle, 2 = polygon, 3 = chain)
/// - v1: Shape parameter depending on type
/// - v2: Additional shape parameter based on type

function fixture_create() {
    var fixture = physics_fixture_create();
    var shape_type = argument[6];
    var scale_factor = argument[5];
    var v_list = argument[7];
    var param2 = argument[8];

    if (shape_type == 0) {
        physics_fixture_set_box_shape(fixture, v_list * scale_factor, param2 * scale_factor);
    } else if (shape_type == 1) {
        physics_fixture_set_circle_shape(fixture, v_list * scale_factor);
    } else if (shape_type == 2) {
        physics_fixture_set_polygon_shape(fixture);
        for (var index = 0; index < param2; index += 2) {
            physics_fixture_add_point(fixture, v_list[index] * scale_factor, v_list[index + 1] * scale_factor);
        }
    } else if (shape_type == 3) {
        physics_fixture_set_chain_shape(fixture, param2);
        var point_count = array_length_1d(v_list);
        for (var index = 0; index < point_count; index += 2) {
            physics_fixture_add_point(fixture, v_list[index] * scale_factor, v_list[index + 1] * scale_factor);
        }
    }

    physics_fixture_set_density(fixture, argument[1]);
    physics_fixture_set_friction(fixture, argument[2]);
    physics_fixture_set_restitution(fixture, argument[3]);
    physics_fixture_set_collision_group(fixture, argument[4]);

    var binding_id_list = argument[0];
    var bind_result = -1;

    if (is_array(binding_id_list)) {
        var total_bindings = array_length_1d(binding_id_list);
        for (var i = 0; i < total_bindings; ++i) {
            bind_result = physics_fixture_bind(fixture, binding_id_list[i]);
        }
    } else {
        bind_result = physics_fixture_bind(fixture, binding_id_list);
    }

    physics_fixture_delete(fixture);
    return bind_result;
}
