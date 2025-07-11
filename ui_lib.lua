local CompLib = {}

function CompLib:CreateWindow(title)
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	ScreenGui.Name = "CompKillerUI"

	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.Size = UDim2.new(0, 400, 0, 300)
	MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
	MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	MainFrame.BorderSizePixel = 0
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.Name = "MainFrame"
	MainFrame.Active = true
	MainFrame.Draggable = true

	local Title = Instance.new("TextLabel", MainFrame)
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.BackgroundTransparency = 1
	Title.Text = title or "UI Window"
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.Font = Enum.Font.SourceSansBold
	Title.TextSize = 24

	local TabFolder = Instance.new("Folder", MainFrame)
	TabFolder.Name = "Tabs"

	local tabFunctions = {}

	function tabFunctions:CreateTab(tabName)
		local TabFrame = Instance.new("ScrollingFrame", TabFolder)
		TabFrame.Name = tabName
		TabFrame.Size = UDim2.new(1, 0, 1, -40)
		TabFrame.Position = UDim2.new(0, 0, 0, 40)
		TabFrame.BackgroundTransparency = 1
		TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabFrame.ScrollBarThickness = 4

		local UIList = Instance.new("UIListLayout", TabFrame)
		UIList.Padding = UDim.new(0, 5)

		local tabContent = {}

		function tabContent:AddButton(text, callback)
			local Button = Instance.new("TextButton", TabFrame)
			Button.Size = UDim2.new(1, -10, 0, 30)
			Button.Position = UDim2.new(0, 5, 0, 0)
			Button.Text = text
			Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Button.TextColor3 = Color3.new(1, 1, 1)
			Button.Font = Enum.Font.SourceSans
			Button.TextSize = 18
			Button.AutoButtonColor = true

			Button.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
		end

		function tabContent:AddToggle(text, default, callback)
			local Toggle = Instance.new("TextButton", TabFrame)
			Toggle.Size = UDim2.new(1, -10, 0, 30)
			Toggle.Position = UDim2.new(0, 5, 0, 0)
			Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Toggle.TextColor3 = Color3.new(1, 1, 1)
			Toggle.Font = Enum.Font.SourceSans
			Toggle.TextSize = 18
			Toggle.AutoButtonColor = true

			local state = default or false
			local function updateText()
				Toggle.Text = "[" .. (state and "ON" or "OFF") .. "] " .. text
			end
			updateText()

			Toggle.MouseButton1Click:Connect(function()
				state = not state
				updateText()
				pcall(callback, state)
			end)
		end

		return tabContent
	end

	return tabFunctions
end

return CompLib
