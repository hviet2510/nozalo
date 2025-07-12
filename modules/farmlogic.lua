-- 📁 farmlogic.lua | Chọn enemy phù hợp với level người chơi (Sea 1)

local module = {}

function module.GetTargetEnemy()
	local Level = game.Players.LocalPlayer.Data.Level.Value

	if Level >= 0 and Level < 15 then
		return {
			Name = "Bandit",
			QuestName = "BanditQuest1",
			QuestMob = "Bandit",
			QuestPos = CFrame.new(1060, 17, 1547),
			MobPos = CFrame.new(1150, 17, 1600)
		}
	elseif Level >= 15 and Level < 30 then
		return {
			Name = "Monkey",
			QuestName = "JungleQuest",
			QuestMob = "Monkey",
			QuestPos = CFrame.new(-1600, 35, 145),
			MobPos = CFrame.new(-1650, 30, 250)
		}
	elseif Level >= 30 and Level < 60 then
		return {
			Name = "Gorilla",
			QuestName = "JungleQuest",
			QuestMob = "Gorilla",
			QuestPos = CFrame.new(-1235, 10, -480),
			MobPos = CFrame.new(-1230, 10, -450)
		}
	elseif Level >= 60 and Level < 100 then
		return {
			Name = "Pirate",
			QuestName = "BuggyQuest1",
			QuestMob = "Pirate",
			QuestPos = CFrame.new(-1140, 5, 3825),
			MobPos = CFrame.new(-1210, 4, 4100)
		}
	end

	-- Nếu chưa hỗ trợ level này
	return nil
end

return module
