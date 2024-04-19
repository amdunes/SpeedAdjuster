-- SpeedAdjuster v1.0.0
-- amdunes

log.info("Successfully loaded ".._ENV["!guid"]..".")
mods.on_all_mods_loaded(function() for k, v in pairs(mods) do if type(v) == "table" and v.hfuncs then Helper = v end end end)
mods.on_all_mods_loaded(function() for k, v in pairs(mods) do if type(v) == "table" and v.tomlfuncs then Toml = v end end 
    params = {
        increase_key = "KeypadAdd",
        decrease_key = "KeypadSubtract",
        reset_key = "KeypadMultiply",
        speed_adjuster_enabled = true
    }

    params = Toml.config_update(_ENV["!guid"], params)
end)

-- ========== Parameters ==========

local default_speed = 2.8
local default_friction = 0.3
local current_speed = default_speed
local current_friction = default_friction

-- ========== ImGui ==========

gui.add_to_menu_bar(function()
    local new_value, clicked = ImGui.Checkbox("Enable Speed Adjuster", params['speed_adjuster_enabled'])
    if clicked then
        params['speed_adjuster_enabled'] = new_value
        Toml.save_cfg(_ENV["!guid"], params)
    end
end)

gui.add_to_menu_bar(function()
    local new_value, isChanged = ImGui.InputText("##increase_key", params['increase_key'], 20)
    if isChanged then
        params['increase_key'] = new_value
        Toml.save_cfg(_ENV["!guid"], params)
    end
end)

gui.add_to_menu_bar(function()
    local new_value, isChanged = ImGui.InputText("##decrease_key", params['decrease_key'], 20)
    if isChanged then
        params['decrease_key'] = new_value
        Toml.save_cfg(_ENV["!guid"], params)
    end
end)

gui.add_to_menu_bar(function()
    local new_value, isChanged = ImGui.InputText("##reset_key", params['reset_key'], 20)
    if isChanged then
        params['reset_key'] = new_value
        Toml.save_cfg(_ENV["!guid"], params)-------------
    end
end)

-- ========== Utils ==========

function set_player_speed(speed, friction)
    local player = Helper.get_client_player()
    if not player then return end
    
    player.pHmax = speed
    player.pFriction = friction
end

function reset_player_speed()
    current_speed = default_speed
    current_friction = default_friction
    set_player_speed(default_speed, default_friction)
end

function increase_speed()
    current_speed = current_speed + 1
    current_friction=current_friction + 0.1
    set_player_speed(current_speed, current_friction)
end

function decrease_speed()
    current_speed = math.max(1, current_speed - 1)
   current_friction = math.max(0, current_friction - 0.1)
    set_player_speed(current_speed, current_friction)
end

-- ========== Main ==========

print(params['increase_key'])
gui.add_always_draw_imgui(function()
    if ImGui.IsKeyPressed(ImGuiKey[params['increase_key']]) then
        increase_speed()
    end

    if ImGui.IsKeyPressed(ImGuiKey[params['decrease_key']]) then
        decrease_speed()
    end

    if ImGui.IsKeyPressed(ImGuiKey[params['reset_key']]) then
        reset_player_speed()
    end
end)
