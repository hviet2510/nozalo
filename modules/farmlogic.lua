local FarmLogic = {}

-- Lấy level từ GUI trong Blox Fruits (Delta compatible)
local function GetLevelFromGui()
	local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
	if gui then
		local main = gui:FindFirstChild("Main")
		if main and main:FindFirstChild("Level") then
			local text = main.Level.Text
			return tonumber(string.match(text, "%d+"))
		end
	end
	return nil
end

function FarmLogic.GetEnemy(player, enemyList)
	local lv = GetLevelFromGui()
	if not lv then
		warn("[FarmLogic] ❌ Không lấy được level từ GUI.")
		return nil
	end

	for _, e in ipairs(enemyList) do
		if lv >= e.MinLevel and lv <= e.MaxLevel then
			for _, mob in ipairs(workspace.Enemies:GetChildren()) do
				if mob.Name:find(e.Name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
					return mob
				end
			end
		end
	end

	return nil
end

return FarmLogic
