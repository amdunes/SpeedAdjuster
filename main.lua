local default_speed = 10
local current_speed = default_speed

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

-- Keybinds
input.register_hotkey("increase_speed", "Increase Player Speed", increase_speed, "Numpad +")
input.register_hotkey("decrease_speed", "Decrease Player Speed", decrease_speed, "Numpad -")
input.register_hotkey("reset_speed", "Reset Player Speed", reset_player_speed, "Numpad *")
