-- UI LIB 5 SAO CHUYÊN NGHIỆP BY CHATGPT x VIET2510

local CompLib = {}

local function createRound(instance, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = instance
end

local function createShadow(instance)
	local shadow = Instance.new("ImageLabel", instance)
	shadow.Name = "Shadow"
	shadow.BackgroundTransparency = 1
	shadow.Size = UDim2.new(1, 30, 1, 30)
	shadow.Position = UDim2.new(0, -15, 0, -15)
	shadow.ZIndex = instance.ZIndex - 1
	shadow.Image = "rbxassetid://1316045217"
	shadow.ImageTransparency = 0.6
end

function CompLib:CreateWindow(title)
	local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
	gui.Name = "NozaloUI"

	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0, 500, 0, 400)
	frame.Position = UDim2.new(0.5, -250, 0.5, -200)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.BorderSizePixel = 0
	frame.Active = true
	frame.Draggable = true
	frame.Name = "MainUI"
	createRound(frame, 12)
	createShadow(frame)

	local titleLabel = Instance.new("TextLabel", frame)
	titleLabel.Size = UDim2.new(1, 0, 0, 40)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title or "Nozalo UI"
	titleLabel.TextColor3 = Color3.new(1, 1, 1)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 24

	local tabFolder = Instance.new("Folder", frame)

	local layout = Instance.new("UIListLayout")
	layout.Parent = tabFolder
	layout.Padding = UDim.new(0, 8)

	local tabFuncs = {}

	function tabFuncs:CreateTab(tabName)
		local tab = Instance.new("Frame", tabFolder)
		tab.Size = UDim2.new(1, -20, 1, -60)
		tab.Position = UDim2.new(0, 10, 0, 50)
		tab.BackgroundTransparency = 1
		tab.Name = tabName

		local scroller = Instance.new("ScrollingFrame", tab)
		scroller.Size = UDim2.new(1, 0, 1, 0)
		scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
		scroller.BackgroundTransparency = 1
		scroller.ScrollBarThickness = 4
		scroller.AutomaticCanvasSize = Enum.AutomaticSize.Y

		local uiList = Instance.new("UIListLayout", scroller)
		uiList.Padding = UDim.new(0, 8)
		uiList.SortOrder = Enum.SortOrder.LayoutOrder

		local elements = {}

		function elements:AddButton(text, callback)
			local btn = Instance.new("TextButton", scroller)
			btn.Size = UDim2.new(1, -20, 0, 36)
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 16
			btn.Text = text
			btn.AutoButtonColor = true
			createRound(btn, 6)

			btn.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
		end

		function elements:AddToggle(text, default, callback)
			local btn = Instance.new("TextButton", scroller)
			btn.Size = UDim2.new(1, -20, 0, 36)
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 16
			btn.AutoButtonColor = true
			createRound(btn, 6)

			local state = default or false
			local function update()
				btn.Text = (state and "[ON] " or "[OFF] ") .. text
			end

			update()
			btn.MouseButton1Click:Connect(function()
				state = not state
				update()
				pcall(callback, state)
			end)
		end

		function elements:AddDropdown(title, list, callback)
			local index = 1
			local btn = Instance.new("TextButton", scroller)
			btn.Size = UDim2.new(1, -20, 0, 36)
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 16
			btn.Text = title .. ": " .. (list[index] or "None")
			createRound(btn, 6)

			btn.MouseButton1Click:Connect(function()
				index = (index % #list) + 1
				btn.Text = title .. ": " .. list[index]
				pcall(callback, list[index])
			end)
		end

		function elements:AddSlider(name, min, max, default, callback)
			local btn = Instance.new("TextButton", scroller)
			btn.Size = UDim2.new(1, -20, 0, 36)
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 16
			createRound(btn, 6)

			local value = default or min
			local function update()
				btn.Text = name .. ": " .. tostring(value)
			end
			update()

			btn.MouseButton1Click:Connect(function()
				value = value + 1
				if value > max then value = min end
				update()
				pcall(callback, value)
			end)
		end

		function elements:AddInputBox(name, placeholder, callback)
			local box = Instance.new("TextBox", scroller)
			box.Size = UDim2.new(1, -20, 0, 36)
			box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			box.PlaceholderText = placeholder or "Enter..."
			box.Text = ""
			box.TextColor3 = Color3.new(1, 1, 1)
			box.Font = Enum.Font.Gotham
			box.TextSize = 16
			createRound(box, 6)

			box.FocusLost:Connect(function(enter)
				if enter then
					pcall(callback, box.Text)
				end
			end)
		end

		return elements
	end

	return tabFuncs
end

return CompLib
