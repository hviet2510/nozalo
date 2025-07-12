-- farmlogic.lua

local FarmLogic = {}

-- Tìm quái gần nhất trong danh sách
function FarmLogic.GetEnemy(player, enemyTable)
    if typeof(enemyTable) ~= "table" then
        warn("[FarmLogic] enemyTable không hợp lệ:", typeof(enemyTable))
        return nil
    end

    local nearest = nil
    local shortest = math.huge
    for _, enemyName in ipairs(enemyTable) do
        for _, v in ipairs(workspace.Enemies:GetChildren()) do
            if v.Name == enemyName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                local dist = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if dist < shortest then
                    nearest = v
                    shortest = dist
                end
            end
        end
    end
    return nearest
end

return FarmLogic
