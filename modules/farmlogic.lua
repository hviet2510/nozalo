local FarmLogic = {}

function FarmLogic.GetEnemy(player, enemyList)
    local leaderstats = player:FindFirstChild("leaderstats")
    local level = leaderstats and leaderstats:FindFirstChild("Level")
    if not level then
        warn("[FarmLogic] ❌ Không tìm thấy Level!")
        return nil
    end
    local lv = level.Value

    for _, enemy in pairs(enemyList) do
        if lv >= enemy.MinLevel and lv <= enemy.MaxLevel then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == enemy.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob
                end
            end
        end
    end
    return nil
end

return FarmLogic
