-- SpeedAdjuster v1.0.0
-- amdunes

log.info("Successfully loaded ".._ENV["!guid"]..".")
mods.on_all_mods_loaded(function() for k, v in pairs(mods) do if type(v) == "table" and v.hfuncs then Helper = v end end end)
mods.on_all_mods_loaded(function() for k, v in pairs(mods) do if type(v) == "table" and v.tomlfuncs then Toml = v end end 
    params = {
        increase_key = "Numpad +",
        decrease_key = "Numpad -",
        reset_key = "Numpad *",
        speed_adjuster_enabled = true
    }

    params = Toml.config_update(_ENV["!guid"], params)
end)

-- ========== Parameters ==========

local default_speed = 2.8
local current_speed = default_speed
local increase_key = "KeypadAdd"
local decrease_key = "KeypadSubtract"
local reset_key = "KeypadMultiply"

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
    set_player_speed(default_speed)
end

function increase_speed()
    current_speed = current_speed + 1
    set_player_speed(current_speed)
end

function decrease_speed()
    current_speed = math.max(1, current_speed - 1)
    set_player_speed(current_speed)
end

-- ========== Main ==========

gui.add_always_draw_imgui(function()
    if ImGui.IsKeyPressed(ImGuiKey[increase_key]) then
        increase_speed()
    end

    if ImGui.IsKeyPressed(ImGuiKey[decrease_key]) then
        decrease_speed()
    end

    if ImGui.IsKeyPressed(ImGuiKey[reset_key]) then
        reset_player_speed()
    end
end)