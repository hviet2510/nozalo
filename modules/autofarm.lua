local AutoFarm = {
	Active = false,
	Range = 10,
	ToolName = nil
}

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Load sub-modules
local EnemyList = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/enemylist.lua"))()
local FarmLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/farmlogic.lua"))()
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/hviet2510/nozalo/main/modules/functions.lua"))()

function AutoFarm.SetRange(range)
	AutoFarm.Range = tonumber(range) or 10
end

function AutoFarm.SetTool(tool)
	AutoFarm.ToolName = tool
end

function AutoFarm.Toggle(state)
	AutoFarm.Active = state
	if not state then return end

	task.spawn(function()
		while AutoFarm.Active do
			local mob = FarmLogic.GetEnemy(lp, EnemyList)
			if mob then
				Functions.EquipTool(lp, AutoFarm.ToolName)
				Functions.AutoQuest(lp, mob.Name)
				Functions.TweenTo(lp, mob.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))

				while AutoFarm.Active and mob.Parent and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
					local tool = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
					if tool then tool:Activate() end
					task.wait(0.2)
				end
			else
				task.wait(0.5)
			end
		end
	end)
end

return AutoFarm
