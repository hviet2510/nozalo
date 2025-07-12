local module = {}

function module.GetEnemy(player, enemyList)
    local level = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Level")
    if not level then return nil end

    for _, e in ipairs(enemyList) do
        if level.Value >= e.MinLevel and level.Value <= e.MaxLevel then
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob.Name == e.Name and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    return mob
                end
            end
        end
    end

    return nil
end

return module
