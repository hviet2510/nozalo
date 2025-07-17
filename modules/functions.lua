local AutoFarm = {
	Active = false,
	Range = 10,
	ToolName = "Combat"
}

local Player = game.Players.LocalPlayer
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/farmlogic.lua"))()
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/functions.lua"))()

function AutoFarm.SetTool(tool)
	AutoFarm.ToolName = tool
end

function AutoFarm.SetRange(r)
	AutoFarm.Range = tonumber(r) or 10
end

function AutoFarm.Toggle(state)
	AutoFarm.Active = state
	if not state then return end

	task.spawn(function()
		while AutoFarm.Active do
			local enemyInfo = FarmLogic.GetEnemyInfo(Player, EnemyList)
			if enemyInfo then
				local mob = FarmLogic.FindEnemy(enemyInfo.Name)
				if mob then
					Functions.EquipTool(Player, AutoFarm.ToolName)
					Functions.StartQuest(enemyInfo.QuestNPC, enemyInfo.QuestLevel)

					local pos = mob.HumanoidRootPart.Position - (mob.HumanoidRootPart.CFrame.LookVector * AutoFarm.Range)
					Functions.TweenTo(pos)

					while AutoFarm.Active and mob and mob.Humanoid.Health > 0 do
						local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
						if tool then tool:Activate() end
						task.wait(0.2)
					end
				else
					task.wait(1)
				end
			else
				warn("[AutoFarm] Không tìm thấy enemy phù hợp level")
				task.wait(2)
			end
		end
	end)
end

return AutoFarm
