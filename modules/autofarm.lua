local AutoFarm = {
	Active = false,
	Range = 10,
	ToolName = nil,
	EnemyList = {}
}

local lp = game:GetService("Players").LocalPlayer
local FarmLogic = require(nil) -- placeholder
local Functions = require(nil) -- placeholder

function AutoFarm.SetEnemyList(list)
	AutoFarm.EnemyList = list
end

function AutoFarm.SetRange(r)
	AutoFarm.Range = tonumber(r) or 10
end

function AutoFarm.SetTool(toolName)
	AutoFarm.ToolName = toolName
end

function AutoFarm.Toggle(state)
	AutoFarm.Active = state
	if not state then return end

	task.spawn(function()
		while AutoFarm.Active do
			local mob = FarmLogic.GetEnemy(AutoFarm.EnemyList)
			if mob and mob:FindFirstChild("HumanoidRootPart") then
				Functions.EquipTool(lp, AutoFarm.ToolName)
				Functions.TweenTo(lp, mob.HumanoidRootPart.Position + Vector3.new(0, 0, AutoFarm.Range))
				Functions.AutoQuest(lp, mob.Name)

				while AutoFarm.Active and mob.Parent and mob.Humanoid.Health > 0 do
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
