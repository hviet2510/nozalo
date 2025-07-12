local FarmLogic = {}

function FarmLogic.GetEnemy(player, enemyList)
    -- Lấy leaderstats và Level
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        warn("[FarmLogic] Không tìm thấy leaderstats!")
        return nil
    end

    local levelValue = leaderstats:FindFirstChild("Level")
    if not levelValue then
        warn("[FarmLogic] Không tìm thấy Level trong leaderstats!")
        return nil
    end

    local level = levelValue.Value

    -- Tìm enemy phù hợp với level
    for _, enemy in ipairs(enemyList) do
        if level >= enemy.MinLevel and level <= enemy.MaxLevel then
            -- Tìm mob còn sống trùng tên
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
