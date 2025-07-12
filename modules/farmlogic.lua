local FarmLogic = {}

function FarmLogic.GetEnemy(player, enemyList)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		warn("[FarmLogic] Không tìm thấy leaderstats!")
		return nil
	end

	local level = leaderstats:FindFirstChild("Level")
	if not level then
		warn("[FarmLogic] Không tìm thấy Level trong leaderstats!")
		return nil
	end

	local lv = level.Value
	if not lv then
		warn("[FarmLogic] Level không hợp lệ!")
		return nil
	end

	for _, enemy in pairs(enemyList) do
		if lv >= enemy.MinLevel and lv <= enemy.MaxLevel then
			for _, mob in pairs(workspace.Enemies:GetChildren()) do
				if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
					if mob.Name:find(enemy.Name) and mob.Humanoid.Health > 0 then
						return mob
					end
				end
			end
		end
	end

	warn("[FarmLogic] Không tìm thấy quái phù hợp level: " .. lv)
	return nil
end

return FarmLogic
