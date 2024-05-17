function centerText(monitor, y, text, color)
    local width, _ = monitor.getSize()
    local x = math.floor((width - #text) / 2)
    monitor.setCursorPos(x, y)
    if color then
        monitor.setTextColor(color)
    end
    monitor.write(text)
end

function print_inventory_on_monitor(chest, monitor)
    monitor.clear()

    local items = chest.list()

    local _, height = monitor.getSize()
    local startY = math.floor((height - #items * 2) / 2)

    for _, item in pairs(items) do
        local name = string.gsub(item.name, "minecraft:", "")
        local count = item.count

        centerText(monitor, startY, name, colors.white)

        centerText(monitor, startY + 1, count .. "x", colors.gray)

        startY = startY + 3
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("chest")

    if monitor and chest then
        print_inventory_on_monitor(chest, monitor)
    else
        print("Monitor or chest not found!")
    end

    sleep(10)
end