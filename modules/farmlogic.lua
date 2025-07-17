local FarmLogic = {}

function FarmLogic.GetEnemyInfo(player, enemyList)
	local stats = player:FindFirstChild("leaderstats")
	local level = stats and stats:FindFirstChild("Level")
	if not level then
		warn("[FarmLogic] Không tìm thấy Level!")
		return nil
	end

	local lv = level.Value
	for _, enemy in ipairs(enemyList) do
		if lv >= enemy.MinLevel and lv <= enemy.MaxLevel then
			return enemy
		end
	end

	return nil
end

function FarmLogic.FindEnemy(enemyName)
	for _, mob in ipairs(workspace.Enemies:GetChildren()) do
		if mob.Name == enemyName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
			return mob
		end
	end
	return nil
end

return FarmLogic
