local default_speed = 10
local current_speed = default_speed
local increase_key = "Numpad +"
local decrease_key = "Numpad -"
local reset_key = "Numpad *"

function set_player_speed(speed)
    local player = get_client_player()
    if player then
        player.speed = speed
    end
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

function draw_speed_tab()
    if ImGui.BeginTabItem("Speed Settings") then
        ImGui.Text("Increase Speed Keybind:")
        _, increase_key = ImGui.InputText("##increase_key", increase_key, 20)

        ImGui.Text("Decrease Speed Keybind:")
        _, decrease_key = ImGui.InputText("##decrease_key", decrease_key, 20)

        ImGui.Text("Reset Speed Keybind:")
        _, reset_key = ImGui.InputText("##reset_key", reset_key, 20)

        ImGui.EndTabItem()
    end
end

-- Keybinds
input.register_hotkey("increase_speed", "Increase Player Speed", increase_speed, increase_key)
input.register_hotkey("decrease_speed", "Decrease Player Speed", decrease_speed, decrease_key)
input.register_hotkey("reset_speed", "Reset Player Speed", reset_player_speed, reset_key)

function draw()
    if ImGui.Begin("Speed Mod") then
        if ImGui.BeginTabBar("SpeedModTabs") then
            draw_speed_tab()
            ImGui.EndTabBar()
        end
        ImGui.End()
    end
end
