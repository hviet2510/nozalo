-- compkillerlib.lua | Nozalo UI v2.0 | Mobile-ready + Beautiful Toggles

local CompLib = {}

function CompLib:CreateWindow(titleText)
	local CoreGui = game:GetService("CoreGui")
	local gui = Instance.new("ScreenGui", CoreGui)
	gui.Name = "NozaloUI"
	gui.ResetOnSpawn = false

	-- Toggle API
	local api = {}

	local frame = Instance.new("Frame", gui)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0.85, 0, 0.6, 0) -- Mobile co giãn
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 10)

	local title = Instance.new("TextLabel", frame)
	title.Size = UDim2.new(1, 0, 0, 40)
	title.BackgroundTransparency = 1
	title.Text = titleText or "Nozalo UI"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 22

	local container = Instance.new("ScrollingFrame", frame)
	container.Position = UDim2.new(0, 0, 0, 40)
	container.Size = UDim2.new(1, 0, 1, -40)
	container.CanvasSize = UDim2.new(0, 0, 0, 0)
	container.ScrollBarThickness = 5
	container.BackgroundTransparency = 1
	container.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local layout = Instance.new("UIListLayout", container)
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder

	local padding = Instance.new("UIPadding", container)
	padding.PaddingLeft = UDim.new(0, 10)
	padding.PaddingRight = UDim.new(0, 10)
	padding.PaddingTop = UDim.new(0, 8)

	local function createBase(height)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, height or 36)
		f.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		f.BorderSizePixel = 0
		local c = Instance.new("UICorner", f)
		c.CornerRadius = UDim.new(0, 6)
		return f
	end

	local function createTextLabel()
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.BackgroundTransparency = 1
		lbl.TextColor3 = Color3.new(1, 1, 1)
		lbl.Font = Enum.Font.Gotham
		lbl.TextSize = 18
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Text = ""
		return lbl
	end

	local ui = {}

	function ui:AddButton(text, callback)
		local frame = createBase()
		frame.Parent = container

		local btn = Instance.new("TextButton", frame)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.BackgroundTransparency = 1
		btn.Text = "  " .. text
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 18
		btn.TextXAlignment = Enum.TextXAlignment.Left

		btn.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
	end

	function ui:AddToggle(text, default, callback)
		local state = default or false
		local frame = createBase()
		frame.Parent = container

		local label = createTextLabel()
		label.Parent = frame

		local function update()
			local icon = state and "🟢" or "⚫️"
			local box = state and "⬛" or "◻️"
			label.Text = string.format("  %s %s %s", icon, box, text)
		end
		update()

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				state = not state
				update()
				pcall(callback, state)
			end
		end)
	end

	function ui:AddDropdown(name, list, callback)
		local index = 1
		local frame = createBase()
		frame.Parent = container

		local label = createTextLabel()
		label.Parent = frame
		label.Text = "  " .. name .. ": " .. (list[1] or "None")

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				index = (index % #list) + 1
				label.Text = "  " .. name .. ": " .. list[index]
				pcall(callback, list[index])
			end
		end)
	end

	function ui:AddSlider(name, min, max, default, callback)
		local val = default or min
		local frame = createBase()
		frame.Parent = container

		local label = createTextLabel()
		label.Parent = frame
		label.Text = string.format("  %s: %d", name, val)

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				val = val + 1
				if val > max then val = min end
				label.Text = string.format("  %s: %d", name, val)
				pcall(callback, val)
			end
		end)
	end

	function ui:AddInputBox(name, placeholder, callback)
		local frame = createBase(36)
		frame.Parent = container

		local box = Instance.new("TextBox", frame)
		box.Size = UDim2.new(1, 0, 1, 0)
		box.BackgroundTransparency = 1
		box.PlaceholderText = placeholder or "..."
		box.Text = ""
		box.TextColor3 = Color3.new(1, 1, 1)
		box.Font = Enum.Font.Gotham
		box.TextSize = 18
		box.ClearTextOnFocus = false
		box.TextXAlignment = Enum.TextXAlignment.Left

		box.FocusLost:Connect(function(enter)
			if enter and box.Text ~= "" then
				pcall(callback, box.Text)
			end
		end)
	end

	-- Public API
	function api:SetVisible(state)
		gui.Enabled = state
	end

	api._gui = gui
	api._frame = frame

	setmetatable(ui, {
		__index = api
	})

	return ui
end

return CompLib
