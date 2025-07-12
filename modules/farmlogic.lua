local FarmLogic = {}

local function GetLevelFromGui()
	local gui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
	if gui and gui:FindFirstChild("Main") and gui.Main:FindFirstChild("Level") then
		return tonumber(string.match(gui.Main.Level.Text, "%d+"))
	end
	return nil
end

function FarmLogic.GetEnemy(enemyList)
	local lv = GetLevelFromGui()
	if not lv then
		warn("[FarmLogic] ❌ Không lấy được Level từ GUI.")
		return nil
	end

	if not workspace:FindFirstChild("Enemies") then
		warn("[FarmLogic] ❌ Không tìm thấy folder 'Enemies' trong workspace.")
		return nil
	end

	for _, e in ipairs(enemyList) do
		if lv >= e.MinLevel and lv <= e.MaxLevel then
			for _, mob in ipairs(workspace.Enemies:GetChildren()) do
				if mob:IsA("Model") and mob.Name:find(e.Name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
					return mob
				end
			end
		end
	end

	return nil
end

return FarmLogic
