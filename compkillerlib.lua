-- compkillerlib.lua | Nozalo UI Pro | By hviet2510 x ChatGPT

local CompLib = {}

function CompLib:CreateWindow(titleText)
	local CoreGui = game:GetService("CoreGui")
	local gui = Instance.new("ScreenGui", CoreGui)
	gui.Name = "NozaloUI"
	gui.ResetOnSpawn = false

	-- Toggle visibility API
	local api = {}

	local frame = Instance.new("Frame", gui)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 420, 0, 360)
	frame.Position = UDim2.new(0.5, -210, 0.5, -180)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true
	frame.AnchorPoint = Vector2.new(0.5, 0.5)

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
	container.Position = UDim2.new(0, 10, 0, 50)
	container.Size = UDim2.new(1, -20, 1, -60)
	container.CanvasSize = UDim2.new(0, 0, 0, 0)
	container.ScrollBarThickness = 5
	container.BackgroundTransparency = 1
	container.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local list = Instance.new("UIListLayout", container)
	list.Padding = UDim.new(0, 8)
	list.SortOrder = Enum.SortOrder.LayoutOrder

	local function createBase(height)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, height or 36)
		f.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		f.BorderSizePixel = 0
		local c = Instance.new("UICorner", f)
		c.CornerRadius = UDim.new(0, 6)
		return f
	end

	local function createTextButton(text)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.BackgroundTransparency = 1
		btn.Text = text
		btn.TextColor3 = Color3.new(1, 1, 1)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 18
		btn.TextXAlignment = Enum.TextXAlignment.Left
		return btn
	end

	local ui = {}

	function ui:AddButton(text, callback)
		local frame = createBase()
		frame.Parent = container

		local btn = createTextButton("  " .. text)
		btn.Parent = frame

		btn.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
	end

	function ui:AddToggle(text, default, callback)
		local state = default or false
		local frame = createBase()
		frame.Parent = container

		local btn = createTextButton("")
		btn.Parent = frame

		local function update()
			btn.Text = "  [" .. (state and "✓" or "✗") .. "] " .. text
		end
		update()

		btn.MouseButton1Click:Connect(function()
			state = not state
			update()
			pcall(callback, state)
		end)
	end

	function ui:AddDropdown(name, list, callback)
		local index = 1
		local frame = createBase()
		frame.Parent = container

		local btn = createTextButton("  " .. name .. ": " .. (list[1] or "None"))
		btn.Parent = frame

		btn.MouseButton1Click:Connect(function()
			index = (index % #list) + 1
			btn.Text = "  " .. name .. ": " .. list[index]
			pcall(callback, list[index])
		end)
	end

	function ui:AddSlider(name, min, max, default, callback)
		local val = default or min
		local frame = createBase()
		frame.Parent = container

		local btn = createTextButton("")
		btn.Parent = frame

		local function update()
			btn.Text = "  " .. name .. ": " .. tostring(val)
		end
		update()

		btn.MouseButton1Click:Connect(function()
			val = val + 1
			if val > max then val = min end
			update()
			pcall(callback, val)
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
		box.Text = ""

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
