-- very bad code, very old script, do not judge lol, also might be outdated

repeat task.wait() until game:IsLoaded()

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

task.wait(.5)

if not Player.PlayerGui:FindFirstChild("HUD") then
    local HUD = game:GetService("ReplicatedStorage").Objects.HUD:Clone()
    HUD.Parent = Player.PlayerGui
end

pcall(function()
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end)

task.spawn(function()
    if _G.FixLag then
        task.wait(0.5)
        pcall(function()
            for i,v in pairs(game.ReplicatedStorage.Effects:GetDescendants()) do
                if v:IsA("ParticleEmitter") then
                    v:Destroy()
                end
            end
        end)
    end
end)

repeat task.wait() until game.Players.LocalPlayer
    print("loading ui #1")
	local library = {}

	library.__index = library

	if not _G.Settings then
		_G.Settings = {
			["HideName"] = false,
			["HidePicture"] = false
		}
	end

	function library:Tween(asset, info, thing)
		game:GetService("TweenService"):Create(asset, info, thing):Play()
	end

	function library:DropInfo(asset, info, tbl)
		if not tbl.debounce then
			tbl.debounce = true

			local newText = asset:FindFirstChild("Text"):Clone()
			newText.Parent = asset
			newText.Name = "Info"
			newText.TextTransparency = 1
			newText.TextSize = 24
			newText.Position = UDim2.new(asset:FindFirstChild("Text").Position.X.Scale, asset:FindFirstChild("Text").Position.X.Offset, ((asset:FindFirstChild("Text").Position.Y.Scale / 2) * 3), asset:FindFirstChild("Text").Position.Y.Offset)
			newText.Text = info

			local textAsset = asset:FindFirstChild("Text")

			library:Tween(asset, TweenInfo.new(0.5), {Size = UDim2.new(asset.Size.X.Scale, asset.Size.X.Offset, (asset.Size.Y.Scale * 2), asset.Size.Y.Offset)})
			library:Tween(textAsset, TweenInfo.new(0.5), {Position = UDim2.new(textAsset.Position.X.Scale, textAsset.Position.X.Offset, (textAsset.Position.Y.Scale / 2), textAsset.Position.Y.Offset), Size = UDim2.new(textAsset.Size.X.Scale, textAsset.Size.X.Offset, (textAsset.Size.Y.Scale / 2), textAsset.Size.Y.Offset)})
			library:Tween(asset["Down"], TweenInfo.new(0.3), {Rotation = 180, Position = UDim2.new(asset["Down"].Position.X.Scale, asset["Down"].Position.X.Offset, (asset["Down"].Position.Y.Scale / 2), asset["Down"].Position.Y.Offset)})
			wait(0.5)

			library:Tween(newText, TweenInfo.new(0.5), {TextTransparency = 0})

			wait(0.5)

			tbl.debounce = false
			tbl.showingInfo = true
		end
	end

	function library:RetractInfo(asset, tbl)
		if not tbl.debounce then
			tbl.debounce = true
			library:Tween(asset["Info"], TweenInfo.new(0.25), {TextTransparency = 1})
			library:Tween(asset["Down"], TweenInfo.new(0.3), {Rotation = 0, Position = UDim2.new(asset["Down"].Position.X.Scale, asset["Down"].Position.X.Offset, (asset["Down"].Position.Y.Scale * 2), asset["Down"].Position.Y.Offset)})
			library:Tween(asset, TweenInfo.new(0.5), {Size = UDim2.new(asset.Size.X.Scale, asset.Size.X.Offset, (asset.Size.Y.Scale / 2), asset.Size.Y.Offset)})	

			local textAsset = asset:FindFirstChild("Text")
			library:Tween(textAsset, TweenInfo.new(0.5), {Position = UDim2.new(textAsset.Position.X.Scale, textAsset.Position.X.Offset, (textAsset.Position.Y.Scale * 2), textAsset.Position.Y.Offset), Size = UDim2.new(textAsset.Size.X.Scale, textAsset.Size.X.Offset, (textAsset.Size.Y.Scale * 2), textAsset.Size.Y.Offset)})

			wait(0.5)
			asset["Info"]:Destroy()
			tbl.debounce = false
			tbl.showingInfo = false
		end
	end

	function library:RoundNumber(num, numDecimalPlaces)
		return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
	end

	function library:Ripple(ui, button, x, y, tbl)
		if x and y then
			spawn(function()
				local c = ui.Circle:Clone()
				c.Parent = button;

				c.ImageTransparency = 0.6

				local x, y = (x-button.AbsolutePosition.X), (y-button.AbsolutePosition.Y-36)
				c.Position = UDim2.new(0, x, 0, y)
				local len, size = 0.75, nil
				if button.AbsoluteSize.X >= button.AbsoluteSize.Y then
					size = (button.AbsoluteSize.X * 1.5)
				else
					size = (button.AbsoluteSize.Y * 1.5)
				end
				local tween = {}
				tween.Size = UDim2.new(0, size, 0, size)
				tween.Position = UDim2.new(0.5, (-size / 2), 0.5, (-size / 2))
				tween.ImageTransparency = 1

				local newTween = game:GetService("TweenService"):Create(c, TweenInfo.new(len, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tween)

				newTween:Play()

				newTween.Completed:Wait()

				c:Destroy()
			end)
		end
	end

	function library.Create(title, titleUnder)
		local lib = {}

        if _G.Theme == "UltraDark" then
		    lib.UI = game:GetObjects("rbxassetid://11380178041")[1]
        elseif _G.Theme == "Aqua" then
	        lib.UI = game:GetObjects("rbxassetid://11380877718")[1]
        elseif _G.Theme == "Blood" then
            lib.UI = game:GetObjects("rbxassetid://11399536932")[1]
        else
            lib.UI = game:GetObjects("rbxassetid://6849423853")[1]
        end
    
		lib.UI.Parent = game.CoreGui

		lib.Tabs = {}

		lib.UI.Main.Left.UIName.Text = title
		lib.UI.Main.Left.GameName.Text = titleUnder

		local content,isReady;

		spawn(function()
			content, isReady = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

			repeat wait() until content and isReady

			if _G.Settings.HidePicture == false then
				lib.UI.Main.Left.BottomLeft.Icon.Image = content
			else
				lib.UI.Main.Left.BottomLeft.Icon.Image = ""
			end
		end)


		if _G.Settings.HideName == false then
			lib.UI.Main.Left.BottomLeft.PlayerName.Text = game.Players.LocalPlayer.Name
		else
			lib.UI.Main.Left.BottomLeft.PlayerName.Text = "******"
		end

		lib.Notifications = {}
		lib.Notifications.Queue = {}
		lib.Notifications.Current = nil

		local MainFrame = lib.UI.Main

		--Dragging
		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			local delta = input.Position - dragStart
			game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
		end

		MainFrame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = MainFrame.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		MainFrame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)

		return setmetatable(lib, library)
	end

	function library:Tab(name, imageId)
		local tab = {}

		tab.Assets = {}

		tab.Lib = self
		tab.Tab = self.UI.Main.Left.Container.Template:Clone()
		tab.Tab.Name = name
		tab.Tab.TabName.Text = name
		tab.Tab.Parent = self.UI.Main.Left.Container

		if imageId then
			tab.Tab.TabIcon.Image = "rbxassetid://" .. imageId
		end

		table.insert(self.Tabs, tab)

		tab.Show = function()
			tab.Tab.Visible = true
		end

		tab.Hide = function()
			tab.Tab.Visible = false
		end
		
		self.UI.Main.Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            self.UI.Main.Container.CanvasSize = UDim2.new(0, self.UI.Main.Container.UIListLayout.AbsoluteContentSize.X, 0, self.UI.Main.Container.UIListLayout.AbsoluteContentSize.Y)
        end)

		local totalAssets = 0
		for i,v in pairs(self.Tabs) do
			totalAssets = totalAssets + 1
		end

		if totalAssets == 1 then
			-- first tab
			delay(0.3, function()
				for i,v in pairs(tab.Assets) do
					if v then
						v.Show()
					end
				end
				library:Tween(tab.Tab, TweenInfo.new(0.5), {BackgroundTransparency = 0})
			end)
		end

		tab.Tab.MouseButton1Down:Connect(function()
			for i,v in pairs(self.Tabs) do
				library:Tween(v.Tab, TweenInfo.new(0.5), {BackgroundTransparency = 1})
				for i,v in pairs(v.Assets) do
					v.Hide()
				end
			end

			for i,v in pairs(tab.Assets) do
				v.Show()
			end
			
			library:Tween(tab.Tab, TweenInfo.new(0.5), {BackgroundTransparency = 0.65})
		end)

		tab.Show()

		return setmetatable(tab, library)
	end

	function library:Button(text, info, callback)
		local button = {}

		button.callback = callback or function() end
		button.debounce = false
		button.showingInfo = false
		button.button = self.Lib.UI.Main.Container.Button:Clone()
		button.button.Parent = self.Lib.UI.Main.Container
		button.button:FindFirstChild("Text").Text = (text or "No Text")
		button.button.Name = (text or "No Text")

		button.Show = function()
			button.button.Visible = true
		end

		button.Hide = function()
			button.button.Visible = false
		end

		button.Click = function(x, y)
			if not button.debounce then
				if not x or not y then
					x = (button.button.AbsolutePosition.X/2)
					y = (button.button.AbsolutePosition.Y/2)
				end
				library:Ripple(self.Lib.UI, button.button, x, y, button)
				button.callback()
			end
		end

		button.button.Down.MouseButton1Down:Connect(function()
			if not button.showingInfo then
				library:DropInfo(button.button, info, button)
			else
				library:RetractInfo(button.button, button)
			end
		end)

		button.button.MouseButton1Down:Connect(function(x,y)
			button.Click(x, y)
		end)

		table.insert(self.Assets, button)

		return setmetatable(button, library)
	end

	function library:Toggle(text, info, state, callback, dont_run_on_start)
		local toggle = {}

		toggle.callback = callback or function() end
		toggle.debounce = false
		toggle.showingInfo = false
		toggle.state = state
		toggle.toggle = self.Lib.UI.Main.Container.Toggle:Clone()
		toggle.toggle.Parent = self.Lib.UI.Main.Container
		toggle.toggle:FindFirstChild("Text").Text = (text or "No Text")
		toggle.toggle.Name = (text or "No Text")

		toggle.Show = function()
			toggle.toggle.Visible = true
		end

		toggle.Hide = function()
			toggle.toggle.Visible = false
		end

		toggle.Refresh = function()
			if toggle.state then
				toggle.state = false
				toggle.debounce = true
				spawn(function()
					toggle.callback(toggle.state)
				end)
				local circle = toggle.toggle.Whole.Inner
				local newPosition = UDim2.new((circle.Position.X.Scale / 3), circle.Position.X.Offset, circle.Position.Y.Scale, circle.Position.Y.Offset)

				library:Tween(circle, TweenInfo.new(0.2), {Position = newPosition})
				library:Tween(circle.Parent, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)})

				wait(0.3)
				toggle.debounce = false
			else 
				toggle.state = true
				toggle.debounce = true
				spawn(function()
					toggle.callback(toggle.state)
				end)
				local circle = toggle.toggle.Whole.Inner
				local newPosition = UDim2.new((circle.Position.X.Scale * 3), circle.Position.X.Offset, circle.Position.Y.Scale, circle.Position.Y.Offset)

				library:Tween(circle, TweenInfo.new(0.2), {Position = newPosition})
				if _G.Theme == "Blood" then
				    library:Tween(circle.Parent, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 0, 0)})
				else
				    library:Tween(circle.Parent, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(112, 112, 112)})
				end

				wait(0.3)
				toggle.debounce = false
			end
		end

		spawn(function()
			if toggle.state then
				toggle.debounce = true
				local circle = toggle.toggle.Whole.Inner
				local newPosition = UDim2.new((circle.Position.X.Scale * 3), circle.Position.X.Offset, circle.Position.Y.Scale, circle.Position.Y.Offset)

				library:Tween(circle, TweenInfo.new(0.2), {Position = newPosition})
				if _G.Theme == "Blood" then
				    library:Tween(circle.Parent, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 0, 0)})
				else
				    library:Tween(circle.Parent, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(112, 112, 112)})
				end

				wait(0.3)
				toggle.debounce = false
			end
		end)

		toggle.toggle.Down.MouseButton1Down:Connect(function()
			if not toggle.showingInfo then
				library:DropInfo(toggle.toggle, info, toggle)
			else
				library:RetractInfo(toggle.toggle, toggle)
			end
		end)

		toggle.toggle.MouseButton1Down:Connect(function(x,y)
			if not toggle.debounce then
				library:Ripple(self.Lib.UI, toggle.toggle, x, y, toggle)
				toggle.Refresh()
			end
		end)

		if not dont_run_on_start then
			local ran, failed = pcall(function()
				toggle.callback(toggle.state)
			end)

			if ran then
				print("Ran sucessfully.")
			else
				print("Failed to run but no worries!", failed)
			end
		end

		table.insert(self.Assets, toggle)
		return setmetatable(toggle, library)
	end

	function library:Seperator()
		local seperator = {}

		seperator.asset = self.Lib.UI.Main.Container.Seperator:Clone()
		seperator.asset.Parent = self.Lib.UI.Main.Container

		seperator.Show = function()
			seperator.asset.Visible = true
		end

		seperator.Hide = function()
			seperator.asset.Visible = false
		end

		table.insert(self.Assets, seperator)
		return setmetatable(seperator, library)
	end

	function library:Slider(name, min, max, starting, callback)
		local slider = {}

		slider.callback = callback or function() end
		slider.min = min or 1
		slider.max = max or 100

		slider.asset = self.Lib.UI.Main.Container.Slider:Clone()
		slider.asset.Name = (name or "None")
		slider.asset:FindFirstChild("Slider").Text = (name or "None")
		slider.asset.Parent = self.Lib.UI.Main.Container
		slider.holdAsset = self.Lib.UI.Main.Container
		
		slider.dragging = false

		slider.holdAsset = slider.asset.Holder.Holder.Circle

		local mouse = game.Players.LocalPlayer:GetMouse()
		local uis = game:GetService("UserInputService")
		local Value;

		local bound = slider.holdAsset.Parent.Parent.AbsoluteSize.X
		
		--[[
		function slider.Refresh(new, bool)
			local pos = (bound * (new/slider.max))

			library:Tween(slider.holdAsset.Parent, TweenInfo.new(0.1), {Size = UDim2.new(0, pos, 1, 0)})

			slider.asset.Percentage.Text = new
			
			if bool then
				slider.callback(new)
			end
		end
		
		slider.Refresh(starting)

		slider.holdAsset.MouseButton1Down:Connect(function()
			local Num = (((tonumber(slider.max) - tonumber(slider.min)) / bound) * slider.holdAsset.Parent.AbsoluteSize.X) + tonumber(slider.min)
			local IsDecimal = select(2, math.modf(starting)) ~= 0
			Value = (not IsDecimal and math.ceil(Num)) or (IsDecimal and library:RoundNumber(Num, 1)) or 0
			pcall(function()
				slider.callback(Value)
			end)
			library:Tween(slider.holdAsset.Parent, TweenInfo.new(0.1), {Size = UDim2.new(0, math.clamp(mouse.X - slider.holdAsset.Parent.AbsolutePosition.X, 0, bound), 1, 0)})
			moveconnection = mouse.Move:Connect(function()
				slider.asset.Percentage.Text = Value
				local Num = (((tonumber(slider.max) - tonumber(slider.min)) / bound) * slider.holdAsset.Parent.AbsoluteSize.X) + tonumber(slider.min)
				local IsDecimal = select(2, math.modf(starting)) ~= 0
				Value = (not IsDecimal and math.ceil(Num)) or (IsDecimal and library:RoundNumber(Num, 1))
				pcall(function()
					slider.callback(Value)
				end)
				library:Tween(slider.holdAsset.Parent, TweenInfo.new(0.1), {Size = UDim2.new(0, math.clamp(mouse.X - slider.holdAsset.Parent.AbsolutePosition.X, 0, bound), 1, 0)})
			end)
			releaseconnection = uis.InputEnded:Connect(function(Mouse)
				if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
					local Num = (((tonumber(slider.max) - tonumber(slider.min)) / bound) * slider.holdAsset.Parent.AbsoluteSize.X) + tonumber(slider.min)
					local IsDecimal = select(2, math.modf(starting)) ~= 0
					Value = (not IsDecimal and math.ceil(Num)) or (IsDecimal and library:RoundNumber(Num, 1)) 
					pcall(function()	
						slider.callback(Value)
					end)
					library:Tween(slider.holdAsset.Parent, TweenInfo.new(0.1), {Size = UDim2.new(0, math.clamp(mouse.X - slider.holdAsset.Parent.AbsolutePosition.X, 0, bound), 1, 0)})
					moveconnection:Disconnect()
					releaseconnection:Disconnect()
					
					wait()
					slider.Refresh(Value, true)
				end
			end)
		end)--]]

		local IsDecimal = select(2, math.modf(starting)) ~= 0

		local function move(input)
			
			local pos1 =
				UDim2.new(
					math.clamp((input.Position.X - slider.holdAsset.Parent.AbsolutePosition.X) / bound, 0, 1),
					0,
					1,
					0
				)
			slider.holdAsset.Parent:TweenSize(pos1, "Out", "Sine", 0.1, true)
			local value = (IsDecimal and library:RoundNumber((((pos1.X.Scale * slider.max) / slider.max) * (slider.max - slider.min) + slider.min), 1) or math.floor((((pos1.X.Scale * slider.max) / slider.max) * (slider.max - slider.min) + slider.min)))
			
			if _G.Theme ~= "Aqua" then
			    slider.asset.Percentage.Text = tostring(value)
			else
			    slider.asset.Holder.Frame.Percentage.Text = tostring(value)
			end
			
			pcall(slider.callback, value)
		end	
		
		slider.holdAsset.InputBegan:Connect(
			function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slider.dragging = true
				end
			end
		)
		slider.holdAsset.InputEnded:Connect(
			function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					slider.dragging = false
				end
			end
		)

		game:GetService("UserInputService").InputChanged:Connect(
		function(input)
			if slider.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				move(input)
			end
		end
		)

		slider.Refresh = function(new, bool)

			slider.holdAsset.Parent:TweenSize(UDim2.new((new or 0) / slider.max, 0, 1, 0), "Out", "Sine", 0.1, true)
			if _G.Theme ~= "Aqua" then
			    slider.asset.Percentage.Text = tostring(new and (IsDecimal and library:RoundNumber(((new / slider.max) * (slider.max - slider.min) + slider.min), 1) or math.floor((new / slider.max) * (slider.max - slider.min) + slider.min) or 0))
			else
                slider.asset.Holder.Frame.Percentage.Text = tostring(new and (IsDecimal and library:RoundNumber(((new / slider.max) * (slider.max - slider.min) + slider.min), 1) or math.floor((new / slider.max) * (slider.max - slider.min) + slider.min) or 0))
			end
        
			if bool then
				pcall(slider.callback, new)
			end
		end

		slider.Refresh(starting, false)

		slider.Show = function()
			slider.asset.Visible = true
		end

		slider.Hide = function()
			slider.asset.Visible = false
		end

		table.insert(self.Assets, slider)
		return setmetatable(slider, library)
	end

	function library:Dropdown(name, list, callback)
		local dropdown = {}

		dropdown.table = list
		dropdown.callback = callback or function() end

		dropdown.debounce = false

		dropdown.asset = self.Lib.UI.Main.Container.Dropdown:Clone()
		dropdown.asset.Parent = self.Lib.UI.Main.Container

		dropdown.assets = {}
		dropdown.connections = {}

		dropdown.asset:FindFirstChild("Text").Text = dropdown.table[1]

		function dropdown.Refresh()
			if not table.find(dropdown.table, dropdown.asset:FindFirstChild("Text").Text) then
				dropdown.asset:FindFirstChild("Text").Text = dropdown.table[1]
			end
		end

		dropdown.showing = false

		dropdown.asset.MouseButton1Down:Connect(function(x, y)
			if not dropdown.debounce then
				library:Ripple(self.Lib.UI, dropdown.asset, x, y, {["showingInfo"] = false})
				if #dropdown.assets < 1 then
					dropdown.debounce = true
					local passed = false
					local num = 0
					local assets = {}
					for i,v in ipairs(dropdown.asset.Parent:GetChildren()) do
						if v.ClassName ~= "Folder" and v.ClassName ~= "UIListLayout" and v.ClassName ~= "UIAspectRatioConstraint"  and v.Visible and not passed and v == dropdown.asset then
							passed = true
						end

						if passed then
							if v ~= dropdown.asset then
								num = num + 1
								v.Parent = v.Parent.Hold
								table.insert(assets, v)
							end
						end
					end

					library:Tween(dropdown.asset["Down"], TweenInfo.new(0.3), {Rotation = 180})

					for i = 1, #dropdown.table do
						local newDrop = self.Lib.UI.Main.Container.DropdownDrop:Clone()
						newDrop.Parent = self.Lib.UI.Main.Container


						newDrop:FindFirstChild("Text").Text = dropdown.table[i]

						newDrop.Visible = true
						library:Tween(newDrop, TweenInfo.new(0.2), {BackgroundTransparency = 0})
						library:Tween(newDrop:FindFirstChild("Text"), TweenInfo.new(0.3), {TextTransparency = 0})

						local thing = {}

						thing.Asset = newDrop

						thing.Show = function()
							dropdown.assets[i].Visible = true
						end

						thing.Hide = function()
							dropdown.assets[i].Visible = false
						end

						table.insert(dropdown.assets, newDrop)
						table.insert(self.Assets, thing)

						local con;

						con = thing.Asset.MouseButton1Down:Connect(function(x, y)
							if dropdown.showing then
								table.insert(dropdown.connections, con)
								dropdown.debounce = true
								library:Tween(dropdown.asset["Down"], TweenInfo.new(0.3), {Rotation = 0})

								if dropdown.asset:FindFirstChild("Text").Text ~= dropdown.table[i] then
									dropdown.asset:FindFirstChild("Text").Text = dropdown.table[i]
									dropdown.callback(dropdown.table[i])
								end						

								for i,v in pairs(dropdown.connections) do
									v:Disconnect()
									table.remove(dropdown.connections, i)
								end

								for i = #dropdown.assets, 1, -1 do
									library:Tween(dropdown.assets[i], TweenInfo.new(0.2), {BackgroundTransparency = 1})
									library:Tween(dropdown.assets[i]:FindFirstChild("Text"), TweenInfo.new(0.3), {TextTransparency = 1})

									game:GetService("RunService").RenderStepped:Wait()

									dropdown.assets[i]:Destroy()

									for a,v in pairs(self.Assets) do
										if v.Asset == dropdown.assets[i] then
											table.remove(self.Assets, a)
										end
									end				
									table.remove(dropdown.assets, i)
								end

								dropdown.debounce = false
							end
						end)

						game:GetService("RunService").RenderStepped:Wait()
					end

					for i,v in ipairs(assets) do
						v.Parent = v.Parent.Parent
					end

					for i,v in pairs(assets) do
						table.remove(assets, i)
					end

					dropdown.showing = true
					dropdown.debounce = false
				else
					dropdown.debounce = true
					library:Tween(dropdown.asset["Down"], TweenInfo.new(0.3), {Rotation = 0})
					for i = #dropdown.assets, 1, -1 do
						library:Tween(dropdown.assets[i], TweenInfo.new(0.2), {BackgroundTransparency = 1})
						library:Tween(dropdown.assets[i]:FindFirstChild("Text"), TweenInfo.new(0.3), {TextTransparency = 1})

						game:GetService("RunService").RenderStepped:Wait()

						dropdown.assets[i]:Destroy()

						for a,v in pairs(self.Assets) do
							if v.Asset == dropdown.assets[i] then
								table.remove(self.Assets, a)
							end
						end				
						table.remove(dropdown.assets, i)
					end
					dropdown.showing = false
					dropdown.debounce = false
				end
			end
		end)

		dropdown.Hide = function()
			dropdown.asset.Visible = false
		end

		dropdown.Show = function()
			dropdown.asset.Visible = true
		end

		table.insert(self.Assets, dropdown)
		return setmetatable(dropdown, library)
	end

	function library:Label(text)
		local label = {}

		label.asset = self.Lib.UI.Main.Container.Label:Clone()
		label.asset.Parent = self.Lib.UI.Main.Container

		label.class = "label"

		function label.Refresh(newText)
			label.asset:FindFirstChild("Text").Text = newText
		end

		label.Refresh(text)

		label.Show = function()
			label.asset.Visible = true
		end

		label.Hide = function()
			label.asset.Visible = false
		end

		table.insert(self.Assets, label)
		return setmetatable(label, library)
	end

	function library:TextBox(text, callback)
		local textbox = {}
		
		textbox.Name = text
		textbox.callback = callback or function() end
		textbox.class = "textbox"
		textbox.debounce = false
		
		textbox.asset = self.Lib.UI.Main.Container.TextBox:Clone()
		textbox.asset.Parent = self.Lib.UI.Main.Container
		textbox.asset:FindFirstChild("Text").Text = text
		
		textbox.typing = false
		
		textbox.connections = {}
		
		textbox.asset.Outline.Box.Focused:Connect(function()
			if not textbox.typing then
				textbox.asset.Outline.Box:ReleaseFocus()
			end
		end)
		
		textbox.asset.MouseButton1Down:Connect(function(x,y)
			if not textbox.debounce then
				textbox.debounce = true
				textbox.typing = true
				library:Ripple(self.Lib.UI, textbox.asset, x, y, textbox)
				library:Tween(textbox.asset.Outline, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
					Size = UDim2.new((textbox.asset.Outline.Size.X.Scale + 0.225), textbox.asset.Outline.Size.X.Offset, textbox.asset.Outline.Size.Y.Scale, textbox.asset.Outline.Size.Y.Offset),
					Position = UDim2.new((textbox.asset.Outline.Position.X.Scale - 0.1125), textbox.asset.Outline.Position.X.Offset, textbox.asset.Outline.Position.Y.Scale, textbox.asset.Outline.Position.Y.Offset)
				})
				wait(0.35)
				textbox.asset.Outline.Box:CaptureFocus()
				textbox.asset.Outline.Box.FocusLost:Wait()
				textbox.typing = false
				library:Tween(textbox.asset.Outline, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
					Size = UDim2.new((textbox.asset.Outline.Size.X.Scale - 0.225), textbox.asset.Outline.Size.X.Offset, textbox.asset.Outline.Size.Y.Scale, textbox.asset.Outline.Size.Y.Offset),
					Position = UDim2.new((textbox.asset.Outline.Position.X.Scale + 0.1125), textbox.asset.Outline.Position.X.Offset, textbox.asset.Outline.Position.Y.Scale, textbox.asset.Outline.Position.Y.Offset),
				})
				
				textbox.callback(textbox.asset.Outline.Box.Text)
				
				wait(0.35)
				
				textbox.debounce = false
			end
		end)

		textbox.Refresh = function(NewText)
			textbox.asset.Outline.Box.Text = NewText
			pcall(textbox.callback, NewText)
		end
		
		textbox.Show = function()
			textbox.asset.Visible = true
		end
		
		textbox.Hide = function()
			textbox.asset.Visible = false
		end
		
		table.insert(self.Assets, textbox)
		return setmetatable(textbox, library)
	end

	function library:Keybind(name, key, blacklist, callback)
		local keybind = {}

		if (#blacklist) == 0 then
			blacklist = nil
		end

		keybind.key_blacklist = blacklist or {"W", "A", "S", "D"}

		keybind.ValidKey = function(key)
			return (typeof(key) == "EnumItem")
		end

		keybind.GetKeystringFromEnum = function(key)
			key = tostring(key)
			return ( string.sub( key,  14, #key ) )
		end

		keybind.IsNotMouse = function(key)
			return (key.UserInputType == Enum.UserInputType.MouseButton1 or key.UserInputType == Enum.UserInputType.MouseButton2)
		end

		keybind.callback = callback or function() end
		keybind.asset = self.Lib.UI.Main.Container.Keybind:Clone()
		keybind.asset.Parent = self.Lib.UI.Main.Container

		keybind.class = "keybind"
		keybind.debounce = false

		keybind.key = (keybind.ValidKey(key) and key) or Enum.KeyCode.E --// default key

		keybind.asset:FindFirstChild("Text").Text = name
		keybind.asset:FindFirstChild("RoundHolder").TextLabel.Text = keybind.GetKeystringFromEnum(keybind.key)

		keybind.in_change = false
		keybind.change_conn = nil

		keybind.KeyPress = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
			if gpe then return end

			if input.KeyCode == keybind.key and not keybind.in_change then
				pcall(keybind.callback)
			end
		end)

		keybind.asset.MouseButton1Down:Connect(function(x,y)
			if not keybind.debounce then
				keybind.debounce = true
				keybind.in_change = true
				library:Ripple(self.Lib.UI, keybind.asset, x, y, keybind)

				local contin = false

				local cache = {}
				cache.OldText = keybind.asset:FindFirstChild("Text").Text
				cache.OldKey = keybind.asset:FindFirstChild("RoundHolder").TextLabel.Text

				keybind.asset:FindFirstChild("Text").Text = (cache.OldText .. " [press enter to cancel]")
				keybind.asset:FindFirstChild("RoundHolder").TextLabel.Text = "..."

				keybind.change_conn = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
					if gpe then return end

					if keybind.IsNotMouse(input) then return end

					if input.KeyCode == Enum.KeyCode.Return then
						contin = true
						keybind.asset:FindFirstChild("RoundHolder").TextLabel.Text = cache.OldKey
						keybind.change_conn:Disconnect()
						return  
					end

					if not table.find(keybind.key_blacklist, keybind.GetKeystringFromEnum(input.KeyCode)) then
						keybind.key = input.KeyCode
						keybind.asset:FindFirstChild("RoundHolder").TextLabel.Text = keybind.GetKeystringFromEnum(keybind.key)
						contin = true

						pcall(keybind.callback, keybind.GetKeystringFromEnum(keybind.key))

						keybind.change_conn:Disconnect()
					end
				end)

				repeat wait() until contin

				keybind.asset:FindFirstChild("Text").Text = cache.OldText
				cache = nil
				keybind.in_change = false

				wait(0.5)
				keybind.debounce = false
			end
		end)

		keybind.Show = function()
			keybind.asset.Visible = true
		end 

		keybind.Hide = function()
			keybind.asset.Visible = false
		end 

		table.insert(self.Assets, keybind)
		return setmetatable(keybind, library)
	end

	function library:Notification(text)
		local notification = {}
		notification.NotifText = text
		notification.Bind = nil
		table.insert(self.Lib.Notifications.Queue, notification)
		
		spawn(function()

			for notif = 1, #self.Lib.Notifications.Queue do
				repeat wait() until not self.Lib.Notifications.Current
				self.Lib.Notifications.Current = self.Lib.Notifications.Queue[notif]
				
				local Cover = self.Lib.UI.Main.BackgroundCover
				Cover.Visible = true
				
				Cover.Notification.NotificationLabel.Text = (self.Lib.Notifications.Queue[notif].NotifText or "No text provided")
				
				local TweenData = {
					Transparency = 0.5
				}
				
				local CoverTween = game:GetService("TweenService"):Create(Cover, TweenInfo.new(0.5), TweenData)
				CoverTween:Play()
				CoverTween.Completed:Wait()
				
				local TweenData2 = {
					Position = UDim2.new(0.5, 0, 0.7, 0)
				}	
				
				local NotifTween = game:GetService("TweenService"):Create(Cover.Notification, TweenInfo.new(0.5), TweenData2)
				NotifTween:Play()
				NotifTween.Completed:Wait()
				
				self.Lib.Notifications.Queue[notif].Bind = Cover.Notification.Ok.MouseButton1Click:Connect(function()
					local TweenData3 = {
						Position = UDim2.new(0.5, 0, 1, 0)
					}	

					local NotifTween2 = game:GetService("TweenService"):Create(Cover.Notification, TweenInfo.new(0.5), TweenData3)
					NotifTween2:Play()
					NotifTween2.Completed:Wait()
					
					local TweenData4 = {
						Transparency = 1
					}

					local CoverTween2 = game:GetService("TweenService"):Create(Cover, TweenInfo.new(0.5), TweenData4)
					CoverTween2:Play()
					CoverTween2.Completed:Wait()
					Cover.Visible = false
					
					self.Lib.Notifications.Queue[notif].Bind:Disconnect()			
					table.remove(self.Lib.Notifications.Queue, notif)
					
					self.Lib.Notifications.Current = nil
				end)
			end

		end)
	end

	function library:Click()
		self.Click()
	end

	function library:Update(new, new2, new3)
		if self.table then
			self.table = new
			self.Refresh()
		elseif self.min and self.max then
			self.min = new
			self.max = new2
			self.Refresh(new3 or self.max/2, true)
		elseif self.toggle then
			if new ~= self.state then
				--self.state = (not new)
				self.Refresh()
			end
		elseif self.class == "label" then
			self.Refresh(new)
		elseif self.class == "textbox" then
			self.Refresh(new)
		end
	end

	function library:ToggleUI()
		self.UI.Enabled = not self.UI.Enabled 
	end
    print("ui loaded #2")
    
	local function SendMessage(webhook, msg, title, hidePicture)

		local webhookcheck =
			is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or
			secure_load and "Sentinel" or
			KRNL_LOADED and "Krnl" or
			SONA_LOADED and "Sona" or
			"Kid with shit exploit"

		local url = webhook

		local data;
		if hidePicture then
			data = {
				["embeds"] = {
					{
						["title"] = title,
						["description"] = msg,
						["type"] = "rich",
						["color"] = tonumber(0x7269da)
					}
				}
			}
			
		else
			data = {
				["embeds"] = {
					{
						["title"] = title,
						["description"] = msg,
						["type"] = "rich",
						["color"] = tonumber(0x7269da),
						["image"] = {
							["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" .. tostring(game:GetService("Players").LocalPlayer.Name)
						}
					}
				}
			}
		end

		repeat wait() until data
		local newdata = game:GetService("HttpService"):JSONEncode(data)

        
		local headers = {
			["Content-Type"] = "application/json"
		}
		request = http_request or request or HttpPost or syn.request or http.request
		local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
		request(abcdef)
	end

	local exploit = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse Z" or secure_load and "Sentinel" or KRNL_LOADED and "KRNL" or SONA_LOADED and "Sona" or isexecutorclosure and "Script-Ware" or "Some shitty exploit idk"
    
    local function click(button, manual)
		for i, v in pairs(getconnections(button.MouseButton1Click)) do
			if manual then
				v.Function()
			else
				v:Fire()
			end
		end
	end

	local neededFunctions = {getfenv, getsenv, hookfunction, getrawmetatable, getscriptclosure, getnamecallmethod, http_request, setclipboard}
	local missingSupport = ""

	for i,v in pairs(neededFunctions) do	
		if not v then
			if missingSupport == "" then
				missingSupport = missingSupport..tostring(v)
			else
				missingSupport = missingSupport .. " & ".. tostring(v)
			end
		end
	end

		local prompt = game:GetService("CoreGui"):FindFirstChild("promptOverlay", true)
		prompt.ChildAdded:Connect(function(child)
			if typeof(child) == "Instance" and child.Name == "ErrorPrompt" and child.ClassName == "Frame" then
				local Error = child:FindFirstChild("ErrorMessage", true)
				repeat wait() until Error.Text ~= "Label"
				print(Error.Text)
				if Error.Text:find("kick") or Error.Text:find("conn") or Error.Text:find("rejoin") then
					print("We were kicked/disconnected, rejoining")
					wait(1)
					game:GetService("TeleportService"):Teleport(2809202155, game.Players.LocalPlayer)
				end
			end
		end)

		local Data = { }
		local File = pcall(function()
			Data = game:GetService('HttpService'):JSONDecode(readfile("XenonCF-V1_05.json"))
		end)

		if not File then
			Data = {
			    ["Auto Turn-In Candy"] = false,
				["Auto Invis"] = true,
				["Auto Invis Speed"] = 0.285,
				["Collect Delay"] = 0.5,
				["Callback Delay"] = 0.5,
				["StandToggles"] = {},
				["ItemToggles"] = {},
				["Auto Hop"] = false,
				["Auto_SF"] = false,
				["All Shiny Farm"] = true,
				["Shiny Farm"] = false,
				["Safe Farm"] = true,
				["Webhook"] = "https://discord.com/api/webhooks/1311577446650220645/BAHvJx_AfJ6jdpD0KXHWnu8eQBFRvMq_cGnH_Pz4Xy6p2OA6MSUjvXTVwTLQUmrJsJi0",
				["Only_Webhook_Log"] = false,
				["UseRib"] = false
			}
			writefile("XenonCF-V1_05.json", game:GetService('HttpService'):JSONEncode(Data))
		end
		
		getgenv().IsAutohopping = Data["Auto Hop"]
        
		local TempData = {
			["ScriptVer"] = "1.69",

			["Bypass_Enx"] = false,
			["Hooks"] = {},
			["Auto Farm"] = true,
			["Auto Sell"] = true,
			["Item Farm"] = true,
			["ItemEsp"] = true,
			["Notify"] = true,
			["Attach_Victim"] = nil,
			["ItemUpdateSpeed"] = 0.5,
			["SellDelay"] = 0.5,
			["HopCount"] = 7,
			["RenderCONN"] = { },
			["StandToggles"] = { },
			["Item Toggles"] = {},
			["PickupItems"] = {},
			["WalkSpeed"] = 40,
			["JumpPower"] = 40,
			["SelectedStands"] = {},
			["Sell"] = {"Mysterious Arrow", "Pure Rokakaka", "Rokakaka", "Diamond", "Dio's Diary", "Steel Ball", "Rib Cage of The Saint's Corpse", "Stone Mask", "Gold Coin", "Quinton's Glove", "Ancient Scroll", "Zeppeli's Hat", "Lucky Stone Mask", "Clackers", "Caesar's Headband"},
			["AllItems"] = {"Mysterious Arrow", "Pure Rokakaka", "Rokakaka", "Diamond", "Lucky Arrow", "Dio's Diary", "Steel Ball", "Rib Cage of The Saint's Corpse", "Stone Mask", "Gold Coin", "Quinton's Glove", "Ancient Scroll", "Zeppeli's Hat", "Lucky Stone Mask", "Clackers", "Caesar's Headband", "Red Candy", "Blue Candy", "Green Candy", "Yellow Candy", },
			["AllStands"] = {"Whitesnake", "Stone Free", "Star Platinum", "The World", "Crazy Diamond", "Killer Queen", "Gold Experience", "King Crimson", "Silver Chariot", "Hermit Purple", "The Hand", "Purple Haze", "Cream", "Hierophant Green", "Magician's Red", "White Album", "Aerosmith", "Six Pistols", "Beach Boy", "Mr. President", "Sticky Fingers", "Anubis", "Red Hot Chili Pepper", "Scary Monsters", "The World Alternate Universe", "D4C", "Tusk ACT 1", "Soft & Wet"}
		}
		
		task.wait(4)
		
		local Func = {}
		
		local function Has_2X()
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId, 14597778) then
				return true
			end
			return false
		end

		local Max = {
			["Diamond"] = 30,
			["Gold Coin"] = 45,
			["Mysterious Arrow"] = 25,
			["Pure Rokakaka"] = 10,
			["Rokakaka"] = 25,
			["Stone Mask"] = 10,
			["Rib Cage of The Saint's Corpse"] = 10,
			["Steel Ball"] = 10,
			["Ancient Scroll"] = 10,
			["Dio's Diary"] = 10,
			["Zeppeli's Hat"] = 10,
			["Quinton's Glove"] = 10,
			["Lucky Arrow"] = 10,
			["Green Candy"] = 45,
			["Yellow Candy"] = 45,
			["Red Candy"] = 45,
			["Blue Candy"] = 45,
			["Christmas Present"] = 45,
                        ["Clackers"] = 10,
                        ["Caeser's Headband"] = 10

		}

		if Has_2X() then
			Max = {
				["Diamond"] = 60,
				["Gold Coin"] = 90,
				["Mysterious Arrow"] = 50,
				["Pure Rokakaka"] = 20,
				["Rokakaka"] = 50,
				["Stone Mask"] = 20,
				["Rib Cage of The Saint's Corpse"] = 20,
				["Steel Ball"] = 20,
				["Ancient Scroll"] = 20,
				["DEO's Diary"] = 20,
				["Zepellin's Headband"] = 20,
				["Quinton's Glove"] = 20,
				["Lucky Arrow"] = 20,
				["Green Candy"] = 90,
				["Yellow Candy"] = 90,
				["Red Candy"] = 90,
				["Blue Candy"] = 90,
			    ["Christmas Present"] = 90
			}
		end

        local repFirst = game.GetService(game, 'ReplicatedFirst');
        local itemSpawn = game.ReplicatedFirst.ItemSpawn;
    
        local OldIndex;
        OldIndex = hookmetamethod(Vector3.new(), "__index", newcclosure(function(self, key)
            if not checkcaller() and string.lower(key) == 'magnitude' and getcallingscript() == itemSpawn then
                return 0;
            end
        
            return OldIndex(self, key)
        end), false)

        local functionLibrary = require(game.ReplicatedStorage:WaitForChild('Modules').FunctionLibrary)
        local old = functionLibrary.pcall
        
        functionLibrary.pcall = function(...)
            local f = ...
        
            if type(f) == 'function' and #getupvalues(f) == 11 then 
                return
            end
            
            return old(...)
        end

		local Hook;
		Hook = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(self, ...)
			local args = {...}
			if getnamecallmethod() == "InvokeServer" then
				if args[1] == "idklolbrah2de" then
					return "  ___XP DE KEY"
				end
			elseif getnamecallmethod() == "FireServer" and args[1] == "Reset" and args[3] ~= "XENON_ON_TOP" then
				return wait(9e9)
			end
			
			if (getnamecallmethod() == "InvokeServer" or getnamecallmethod() == "InvokeClient") and args[1] == "Reset" and args[3] ~= "XENON_ON_TOP" then
				return wait(9e9) 
			end

			return Hook(self, ...)
		end))

		Player.CharacterAdded:Connect(function()
			if Player.PlayerScripts:FindFirstChild("ResetTimer") then
				Player.PlayerScripts.ResetTimer:Destroy()
			end

            local repFirst = game.GetService(game, 'ReplicatedFirst');
            local itemSpawn = game.ReplicatedFirst.ItemSpawn;    
        
            local OldIndex;
            OldIndex = hookmetamethod(Vector3.new(), "__index", newcclosure(function(self, key)
                if not checkcaller() and string.lower(key) == 'magnitude' and getcallingscript() == itemSpawn then
                    return 0;
                end
        
                return OldIndex(self, key)
            end), false)
			
			--// fix reset
			local NewEvent = Instance.new("BindableEvent")
			NewEvent.Event:Connect(function()
				local args = {
					[1] = "Reset",
					[2] = {
						["Anchored"] = false
					},
					[3] = "XENON_ON_TOP"
				}
		
				game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(unpack(args))
			end)

			game:GetService("StarterGui"):SetCore("ResetButtonCallback", NewEvent)
		end)
		
		print("Passed hooks!")
		
		Func.HasProperty = function(Part, Property)
            local Success = pcall(function() 
                local a = Part[Property]
            end)
            
            return (Success and true or false)
        end
        
        Func.Compare = function(A, B)
            local InsidesA, InsidesB = A:GetChildren(), B:GetChildren()
            local CompareableProperties = {"Color", "Reflectance", "MeshId", "TextureID", "Size", "Anchored", "CanCollide", "Transparency"}
        
            for i,v in pairs(InsidesB) do
                if v:IsA("ClickDetector") then
                    InsidesB[i] = nil
                elseif v:IsA("Model") then
                    for i,v in pairs(v:GetChildren()) do
                        table.insert(InsidesB, v)
                    end
                end
            end
            for i,v in pairs(InsidesA) do
                if v:IsA("ClickDetector") then
                    InsidesB[i] = nil
                elseif v:IsA("Model") then
                    for i,v in pairs(v:GetChildren()) do
                        table.insert(InsidesA, v)
                    end
                end
            end
            

                for _, CompareItem in pairs(InsidesA) do

                        for _, CompareItem2 in pairs(InsidesB) do
                            local GoodProps = 0
                            local TotalProps = 0
                            for _, Prop in pairs(CompareableProperties) do
                                if Func.HasProperty(CompareItem, Prop) and Func.HasProperty(CompareItem2, Prop) then
                                    if CompareItem[Prop] == CompareItem2[Prop] then
                                        GoodProps = GoodProps + 1
                                    end
                                    TotalProps = TotalProps + 1
                                end
                            end 
                            if TotalProps > 0 and GoodProps == TotalProps then
                                return true
                            end
                        end

                end
            return false
        end
        
        Func.Identify = function(Item)
             local ItemList = game.ReplicatedStorage.Tool_Replicas:GetChildren()
        
             for _, RItem in pairs(ItemList) do
                local IsSame = Func.Compare(RItem, Item)
                if IsSame then
                    return RItem.Name
                end
             end
        
             return "Invalid Item"
        end

		Func.IsSBR = function()
			return (game.PlaceId == 4643697430) 
		end
		
    	Func.ItemCount = function(item)
    	    repeat task.wait() until Player:FindFirstChild("Backpack")
    		local Count = 0
    	
    		for i, v in pairs(Player.Backpack:GetChildren()) do
    		    if v.Name == item then
    		        Count = Count + 1
    		    end
    		end
    	
    		return Count
    	end
    	
        task.wait(1.2)

		local function CheckModelForProp(model, prop, value)
			--assert(model or prop or value, "Didn't provide %s value")

			for i,v in pairs(model:GetChildren()) do
				if v:IsA("BasePart") then
					if v[prop] == value then
						return true
					end
				end
			end

			return false
		end
		
		Func.IsItem = function(name)
			for i,v in pairs(TempData.PickupItems) do
				if v == name then
					return true
				end
			end

			return false
		end
		local Queue = {}
		
		task.wait(3)
		
        local function ItemCheck(Child)
            local Item = Func.Identify(Child)
            
        	if Item ~= "Invalid Item" then
        	    repeat wait() until Child:FindFirstChildWhichIsA("ProximityPrompt")
        		local ItemData = {["CD"] = Child:FindFirstChildWhichIsA("ProximityPrompt"), ["CFrame"] = Child.PrimaryPart.CFrame, ["Replica"] = {Name = Item}}
        		Queue[ItemData.CD] = {CFR = ItemData.CFrame, ItemName = ItemData.Replica.Name}
        
        		local ESPPart = Instance.new("Part", workspace)
        		ESPPart.Name = ItemData.Replica.Name
        		ESPPart.Size = Vector3.new(1,1,1)
        		ESPPart.CFrame = ItemData.CFrame
        		ESPPart.Anchored = true
        		ESPPart.CanCollide = false
        		ESPPart.Transparency = 1
        		local Billboard = Instance.new("BillboardGui", ESPPart)
        		Billboard.AlwaysOnTop = true
        		Billboard.Size = UDim2.new(8, 0, 2, 0)
        		Billboard.StudsOffset = Vector3.new(0, 2, 0)
        		Billboard.ClipsDescendants = false
        		Billboard.Enabled = TempData.ItemEsp
        		Billboard.Name = "ESPBG"
        		local ESPLabel = Instance.new("TextLabel", Billboard)
        		ESPLabel.Size = UDim2.new(0, 100, 0, 100)
        		ESPLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        		ESPLabel.BackgroundTransparency = 1
        		ESPLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        		ESPLabel.Text = ItemData.Replica.Name
        		ESPLabel.TextColor3 = Color3.fromRGB(64, 163, 18)
        		if Func.IsItem(ItemData.Replica.Name) and Func.ItemCount(ItemData.Replica.Name) < Max[ItemData.Replica.Name] then
        			NewItem = true;
        		end
        
        		if TempData.Notify then
        
        			local Bindable = Instance.new("BindableFunction")
        			Bindable.OnInvoke = function()
        			    Character = Player.Character or Player.CharacterAdded:Wait()
        				if not Character then return end
        				Character.PrimaryPart.CFrame = (ItemData.CFrame + Vector3.new(0, 2, 0)) 
        			end
        
        			game.StarterGui:SetCore("SendNotification", {
        				Title = "Item Spawned";
        				Text = ItemData.Replica.Name;
        				Duration = 3;
        				Button1 = "Teleport";
        				Callback = Bindable;
        			})
        			delay(3, function()
        				Bindable:Destroy();
        			end)
        		end;
        
        		if ItemData.Replica.Name == "Lucky Arrow" then
        			local NewSound = Instance.new("Sound")
        			NewSound.Parent = game.Players.LocalPlayer.Character
        			NewSound.SoundId = "rbxassetid://9021481885"
        			NewSound.Volume = 10
        			NewSound:Play()
        			NewSound.Ended:Wait()
        			NewSound:Destroy()
        		end
        
				task.spawn(function()
					repeat task.wait(1) until not ItemData.CD:IsDescendantOf(game) 
					ESPPart:Destroy()
				end)
        	else
        		warn("XENON DEBUG - Invalid item: Most likely fake item.")
        	end
        end
        
        for i,v in pairs(workspace.Item_Spawns.Items:GetChildren()) do
        	print(i,v)
            ItemCheck(v)
        end
        print("Passed getchildren item check!")
        
        game.workspace.Item_Spawns.Items.ChildAdded:Connect(function(Item)
            pcall(function()
                ItemCheck(Item)
            end)
        end)
        print("Passed all item checks!")
        
        local ClientModule;

    	pcall(function()
        	   for i,v in pairs(getgc()) do
    		    if tostring(getfenv(v).script) == 'ClientFunctions' then
    			    ClientModule = require(getfenv(v).script)
    			    break
            	end
        	end
    	end)
    
		function srchTable(tbl, index)
			local newTBL = {}
			for i,v in pairs(tbl) do
				table.insert(newTBL, tostring(v))
			end

			if table.find(newTBL, index) then
				newTBL = nil
				return true
			end

			return false
		end
		
        print("got through whitelist, #3")
		--skip loading thing
		
        task.wait(1)
        
        task.spawn(function()
            if _G.UltraFPSBoost then
                pcall(function()
                    local a = tick()
                    if not game:IsLoaded() then
                        game.Loaded:Wait()
                    end
                    wait(.1)
                    sethiddenproperty(game.Lighting, "Technology", 2)
                    sethiddenproperty(workspace:FindFirstChildOfClass("Terrain"), "Decoration", false)
                    settings().Rendering.QualityLevel = 1
                    game.Lighting.GlobalShadows = false
                    game.Lighting.FogEnd = 9e9
                    workspace:FindFirstChildOfClass("Terrain").Elasticity = 0
                    for b, c in pairs(game:GetDescendants()) do
                        task.spawn(
                            function()
                                wait()
                                if c:IsA("DataModelMesh") then
                                    sethiddenproperty(c, "LODX", Enum.LevelOfDetailSetting.Low)
                                    sethiddenproperty(c, "LODY", Enum.LevelOfDetailSetting.Low)
                                elseif c:IsA("UnionOperation") then
                                elseif c:IsA("Model") then
                                    sethiddenproperty(c, "LevelOfDetail", 1)
                                elseif c:IsA("BasePart") then
                                    c.Reflectance = 0
                                    c.CastShadow = false
                                end
                            end
                        )
                    end
                    for d, e in pairs(game.Lighting:GetChildren()) do
                        if e:IsA("PostEffect") then
                            e.Enabled = false
                        end
                    end
                    warn("Low graphics loaded! (" .. math.floor(tick() - a) .. "s)")
                end)
            end
        end)
        
        Character:WaitForChild("RemoteEvent"):FireServer("PressedPlay")
        
        pcall(function()
            Player.PlayerGui:FindFirstChild("LoadingScreen1"):Destroy()
        end)
        
        task.wait(.5)
        
        print("skipped loading screen #4")
        
        pcall(function()
            Player.PlayerGui:FindFirstChild("LoadingScreen"):Destroy()
        end)
        
        local function SimIFButton()
            print("fired")
            task.wait(0.1)
            local screenGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
            local part = screenGui:WaitForChild("Part")
        
            for _, button in pairs(part:GetDescendants()) do
                if button:FindFirstChild("Part") then
                    if button:IsA("ImageButton") and button.Part.TextColor3 == Color3.new(0, 1, 0) then
                        pcall(function()
                            for i = 1,10,1 do
                                firesignal(button.MouseEnter)
                                firesignal(button.MouseButton1Up)
                                firesignal(button.MouseButton1Click)
                                firesignal(button.Activated)
                                task.wait(0.01)
                            end
                        end)
                    end
                end
            end
        end
        
        game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
            if child.Name == "ScreenGui" then
                SimIFButton()
            end
        end)
        
        
		local UI = library.Create("Xenon V1 (Open Sourced!)", "Your Bizarre Adventure")
		local Credits = UI:Tab("Credits & Info", 6026568227)
		local PlayerTab = UI:Tab("Player", 6023426915)
		local StandsTab = UI:Tab("Stands", 6034744057)
		local ItemFarmTab = UI:Tab("Items", 6031265970)
		local AutofarmTab = UI:Tab("Autofarm", 6031360365)
		local LocationsTab = UI:Tab("Teleports", 6035190846)
		local MiscTab = UI:Tab("Misc", 6022668951)
		local AnimationsTab = UI:Tab("Animations", 6031360365)
		
		for i,v in pairs(game.CoreGui:GetChildren()) do
		    if v:FindFirstChild("Circle") and v:FindFirstChild("Main") then
		        v.Name = math.random(9,65)
		    end
		end
    
		Func.RequestFunct = function(ToUnpack)
			if Player.Character and Player.Character:FindFirstChild("RemoteFunction") then
				Player.Character.RemoteFunction:InvokeServer("LearnSkill", {["NPC"] = tostring(Name), ["Option"] = "Option1", ["Dialogue"] = tostring(Dialogue)})
			end
		end

		Func.RequestEvent = function(Name, Dialogue)
			if Player.Character and Player.Character:FindFirstChild("RemoteEvent") then
				Player.Character.RemoteEvent:FireServer("EndDialogue", {["NPC"] = tostring(Name), ["Option"] = "Option1", ["Dialogue"] = tostring(Dialogue)})
			end
		end

        Func.Get_Stroke = function()
            StrokeDir = 180
            local Anim = "6926086304"
            
            if (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A)) then
                StrokeDir = 90
                Anim = "6926086567"
            end
            
            if (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D)) and StrokeDir == 180 then
                StrokeDir = -90
                Anim = "6926086883"
            end
            
            if (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W)) and StrokeDir == 180 then
                StrokeDir = 0
                Anim = "6926086032"
            end
            
            return StrokeDir, Anim
        end

		Func.ReturnData = function(DataPath)
			if DataPath == "Stand" then
				return Player:WaitForChild("PlayerStats").Stand.Value
			elseif DataPath == "HasStand" then
				if string.lower(Player:WaitForChild("PlayerStats").Stand.Value) == "none" then
					return false
				end
				return true
			elseif DataPath == "Pity" then
				return (Player.PlayerStats.PityCount.Value)
			end
		end

		Func.LearnSkills = function(Skills)
			for i,v in pairs(Skills) do
				local args = {
                    [1] = "LearnSkill",
                    [2] = {
                        ["Skill"] = v,
                        ["SkillTreeType"] = "Character"
                    }
                }
                game:GetService("Players").LocalPlayer.Character.RemoteFunction:InvokeServer(unpack(args))
			end
		end

		Func.IsShiny = function()
			local is = false
			
			repeat wait() until Func.ReturnData("HasStand")
			repeat wait() until Player.Character
			if not Player.Character:FindFirstChild("StandMorph") then
				repeat task.wait() 
    				Player.Character.RemoteFunction:InvokeServer("ToggleStand", "Toggle")
				until Player.Character:FindFirstChild("StandMorph")
			end
			
			repeat wait() until Player.Character:FindFirstChild("StandMorph"):FindFirstChild("StandSkin")
			
			if (Player.Character:FindFirstChild("StandMorph").StandSkin.Value == "") then
				is = false
			else
				is = true
			end

			return is
		end

		Func.GetShiny = function()
			local Is_A_Shiny = Func.IsShiny()

			if Is_A_Shiny then

				repeat wait() until Func.ReturnData("HasStand")
				repeat wait() until Player.Character
				if not Player.Character:FindFirstChild("StandMorph") then
    				repeat task.wait() 
        				Player.Character.RemoteFunction:InvokeServer("ToggleStand", "Toggle")
    				until Player.Character:FindFirstChild("StandMorph")
				end

				repeat wait() until Player.Character:FindFirstChild("StandMorph"):FindFirstChild("StandSkin")

				return Player.Character:FindFirstChild("StandMorph").StandSkin.Value
			else
				return nil;
			end
		end

		Func.Censor = function(string)
			local Censored = (string.sub(string, 1, 2))

			for i = 1, #string-2 do
				Censored = Censored.."*"
			end

			return Censored
		end

		local function SaveData()
			writefile("XenonCF-V1_05.json", game:GetService('HttpService'):JSONEncode(Data))
		end    

		local function RemoveTable(t, i)
			for a, b in pairs(t) do
				if b == i then
					table.remove(t, a)
				end
			end
		end

		local CollectDelay, CallbackDelay = 0, 0

		local ItemLabel = ItemFarmTab:Label("Items in server: "..#workspace.Item_Spawns.Items:GetChildren())

		spawn(function()
			while task.wait(2) do
				ItemLabel:Update("Items in server: "..#workspace.Item_Spawns.Items:GetChildren())
			end
		end)
		
		ItemFarmTab:Seperator()

		local AutoHopDone = false

		for i,v in pairs(Data.ItemToggles) do
			if v then
				table.insert(TempData.PickupItems, i)
			end
		end

		local IF = ItemFarmTab:Toggle("Item Farm", "Toggles Item Farm", false, function(BooleanVal)
			pcall(function()
    			if BooleanVal then
    				TempData["Item Farm"] = true
                
    		        task.wait(.5)
    		        
    		        pcall(function()
        		        if Data["Auto Invis"] then
        		            local oldPosi = Player.Character.HumanoidRootPart.CFrame
        		            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-77, -41, -987)
        		            task.wait(Data["Auto Invis Speed"])
        		            Player.Character.LowerTorso.Root:Destroy()
        		            task.wait(Data["Auto Invis Speed"])
        		            Player.Character.HumanoidRootPart.CFrame = oldPosi
        		        end
    		        end)
    		    
    				pcall(function()
        				while task.wait(0.1) do
        					if Player.Character and Player.Character:FindFirstChild("RemoteEvent") then
        						local oldPos = Player.Character.HumanoidRootPart.CFrame
        						
        						repeat wait() until Queue
    
        						for Clicker, Data in pairs(Queue) do
        							local Cfra = Data.CFR
        							local ItemName = Data.ItemName
        							Data = game:GetService('HttpService'):JSONDecode(readfile("XenonCF-V1_05.json"))
        							
        							if Clicker:IsDescendantOf(game) and Func.IsItem(ItemName) and Func.ItemCount(ItemName) < Max[ItemName] then
        								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Cfra
        								wait(Data["Collect Delay"])
        
        								repeat wait() until Clicker.Parent ~= workspace
        								local pass = true
        								if Clicker then
        								    
        								    if ItemName == "Mysterious Arrow" or ItemName == "Lucky Arrow" then
        								        for i,v in pairs(Clicker.Parent:GetChildren()) do
            										if v:IsA("BasePart") and v.Transparency == 1 and v.Size ~= Vector3.new(0.18199999630451, 6.2239999771118, 1.0099999904633) then
            											pass = false
            										end
            									end
        								    else
            									for i,v in pairs(Clicker.Parent:GetChildren()) do
            										if v:IsA("BasePart") and v.Transparency == 1 then
            											pass = false
            										end
            									end
            								end
        								end
        								
        								if pass then
        								    fireproximityprompt(Clicker.Parent.ProximityPrompt)
        									Queue[Clicker] = nil
        								else
        									Queue[Clicker] = nil
        								end
        								task.wait(.5)
        								wait(Data["Callback Delay"])
        								Player.Character.HumanoidRootPart.CFrame = oldPos
                        		        
        								if not TempData["Item Farm"] then
        									break
        								end
        							end                    
        						end
        						AutoHopDone = true
        					end
        					if not TempData["Item Farm"] then
        						break
        					end
        				end
        			end)
    			else
    				TempData["Item Farm"] = false
    			end
		    end)
		end)
		
		--[[local AK = ItemFarmTab:Toggle("Auto turn in Candy", "turns in candy automatically", false, function(t)
		    Data["Auto Turn-In Candy"] = t
		    SaveData()
		end)]]

		ItemFarmTab:Toggle("Item ESP", "Toggles Item ESP", false, function(state)
			TempData.ItemEsp = state
			if state then
				for i,v in pairs(workspace:GetChildren()) do
					if v:IsA("Part") and v:FindFirstChildWhichIsA("BillboardGui") and v:FindFirstChildWhichIsA("BillboardGui").Name == "ESPBG" then
						v:FindFirstChildWhichIsA("BillboardGui").Enabled = true
					end
				end
			else
				for i,v in pairs(workspace:GetChildren()) do
					if v:IsA("Part") and v:FindFirstChildWhichIsA("BillboardGui") and v:FindFirstChildWhichIsA("BillboardGui").Name == "ESPBG" then
						v:FindFirstChildWhichIsA("BillboardGui").Enabled = false
					end
				end
			end
		end)

		ItemFarmTab:Toggle("Spawn Notification", "Notifys you on item spawn", false, function(state)
			TempData.Notify = state
		end)
		
		--[[ItemFarmTab:Toggle("Auto-Invis", "go invis while item farming", Data["Auto Invis"], function(t)
		    Data["Auto Invis"] = t
		    SaveData()
		end)
		
		ItemFarmTab:Slider("Auto-Invis Speed", 0.05, 0.95, Data["Auto Invis Speed"], function(t)
		    Data["Auto Invis Speed"] = t
		end)]]
		
		local function TableStatus(tbl)
			for i,v in pairs(tbl) do
				return "Unempty"
			end
			
			return "Empty"
		end

		local FoundItem = false
		local HopButton;
		local SF;
		local WS;
		ItemFarmTab:Toggle("Auto Hop", "Hops servers for the selected items.", Data["Auto Hop"], function(state)
			Data["Auto Hop"] = state
			SaveData()
			if state then
			    if Data["Auto Hop"] then
			        game:GetService("RunService"):Set3dRenderingEnabled(false)
			    else
			        game:GetService("RunService"):Set3dRenderingEnabled(true)
			    end
				repeat task.wait() until Player.Character and Player.Backpack
					
				IF:Update(true)
				
				local StartingRoka = Func.ItemCount("Rokakaka")
				local StartingArrow = Func.ItemCount("Mysterious Arrow")

				coroutine.resume(coroutine.create(function()
					repeat wait() until (AutoHopDone and HopButton or not FoundItem)

					if Data["Auto_SF"] and StartingRoka == Max["Rokakaka"] and StartingArrow == Max["Mysterious Arrow"] then
						IF:Update(false)
						repeat wait() until Player.Character or Player.CharacterAdded:Wait()
						--Player.Character.PrimaryPart:Destroy()
						--Player.CharacterAdded:Wait()
						SF:Update(true)

						while task.wait(10) do
							SF:Update(false)
							task.wait()
							SF:Update(true)
							if (WS or Func.ItemCount("Rokakaka") == 0 or Func.ItemCount("Mysterious Arrow") == 0) then
								break
							end
						end
					end

					repeat wait() until HopButton
					wait(_G.Settings["Auto Hopping"]["Hop Time"])
					HopButton:Click()
				end))
			end
		end)

		ItemFarmTab:Toggle("Auto Stand Farm", "Automatically turns on stand farm when max roka and arrows.", Data["Auto_SF"], function(state)
			Data["Auto_SF"] = state
			SaveData()
		end)

		ItemFarmTab:Seperator()

		ItemFarmTab:Slider("Collection Delay", 0.3, 1.1, Data["Collect Delay"], function(IntVal)
			Data["Collect Delay"] = library:RoundNumber(IntVal, 1)

			SaveData()
		end)

		ItemFarmTab:Slider("Teleport Back Delay", 0.5, 1.3, Data["Callback Delay"], function(IntVal)
			Data["Callback Delay"] = library:RoundNumber(IntVal, 1)
			SaveData()
		end)

		ItemFarmTab:Seperator()

		for _, Item in pairs(TempData.AllItems) do
			local ItemToggle = ItemFarmTab:Toggle(Item, "Item", Data.ItemToggles[Item], function(BooleanVal)
				if BooleanVal then
					Data.ItemToggles[Item] = true
					if not table.find(TempData.PickupItems, Item) then
						table.insert(TempData.PickupItems, Item)
					end
					SaveData()
				else
					Data.ItemToggles[Item] = false
					if table.find(TempData.PickupItems, Item) then
						RemoveTable(Data.ItemToggles, Item)
					end
					RemoveTable(TempData.PickupItems, Item)
					SaveData()
				end
			end)
		end

		ItemFarmTab:Seperator()

		_G.RunSF = false
		local AteRoka = false
		local LastShiny = nil

		local SF_Data = {}

		SF_Data.Roka = function()
			if not AteRoka then
			    pcall(function()
    				AteRoka = true
    				LastShiny = nil
    
    				delay(2, function()
    					AteRoka = false
    				end)
    				
                    repeat wait() until Player.Character
                    repeat wait() until Player.Backpack:FindFirstChild("Rokakaka") or Player.Backpack:FindFirstChild("Redeemed Rokakaka")
                    
                    Player.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Rokakaka"))
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,8,0, true, nil, 1)
                    
                    repeat wait() until Player.PlayerGui:FindFirstChild("DialogueGui")
                    if Player.PlayerGui:FindFirstChild("DialogueGui") then
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,8,0, true, nil, 1)
                        repeat wait() until Player.PlayerGui:FindFirstChild("DialogueGui").Frame.Options:FindFirstChild("Option1")
                        local Eat = Player.PlayerGui:FindFirstChild("DialogueGui").Frame.Options:FindFirstChild("Option1")
                        repeat wait() until Eat.Visible
                            
                        local Dial = Player.PlayerGui:FindFirstChild("DialogueGui").Frame
                            
                        click(Eat.TextButton, true)
                            
                        repeat wait() until not Dial.Parent
                    end	
                    Player.CharacterAdded:Wait()
                end)
			end
		end

		SF_Data.Arrow = function()
		    pcall(function()
                repeat wait() until Player.Character
                repeat wait() until Player.Backpack:FindFirstChild("Mysterious Arrow") or Player.Backpack:FindFirstChild("Redeemed Mysterious Arrow")
                
                Player.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Mysterious Arrow"))
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,8,0, true, nil, 1)
                
                repeat wait() until Player.PlayerGui:FindFirstChild("DialogueGui")
                if Player.PlayerGui:FindFirstChild("DialogueGui") then
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,8,0, true, nil, 1)
                    repeat wait() until Player.PlayerGui:FindFirstChild("DialogueGui").Frame.Options:FindFirstChild("Option1")
                    local Eat = Player.PlayerGui:FindFirstChild("DialogueGui").Frame.Options:FindFirstChild("Option1")
                    repeat wait() until Eat.Visible
                        
                    local Dial = Player.PlayerGui:FindFirstChild("DialogueGui").Frame
                        
                    click(Eat.TextButton, true)
                        
                    repeat wait() until not Dial.Parent
                end	
    			AteRoka = false
    		end)
		end

		SF_Data.Stats = function()
			repeat wait() until Player.Character
			repeat wait() until Player.Character:FindFirstChild("RemoteEvent")
			local skills = {
				"Vitality I",
				"Vitality II",
				"Vitality III",
				"Worthiness I"
			}

			if Data["UseRib"] then
				table.insert(skills, #skills+1, "Worthiness II")
				table.insert(skills, #skills+1, "Worthiness III")
				table.insert(skills, #skills+1, "Worthiness IV")
				table.insert(skills, #skills+1, "Worthiness V")
			end


			Func.LearnSkills(skills)
		end

		SF_Data.ArrowSequence = function()
			SF_Data.Stats()
			SF_Data.Arrow()
		end
		
		local WS = false
        
		SF = StandsTab:Toggle("Stand Farm", "Uses rokas and arrows till wanted stand", false, function(BooleanVal)
			_G.RunSF = BooleanVal
			if _G.RunSF == true then
				Data = game:GetService('HttpService'):JSONDecode(readfile("XenonCF-V1_05.json")) --// re read data

				while _G.RunSF do
				    if _G.PityFarm == true and Player.PlayerStats.PityCount.Value == DesiredPity then
			            Player:Kick("Pity reached!")
				    end

				    repeat wait() until Player:FindFirstChild("Backpack")
				    wait(1.5)
            		local RokaCount = 0
                    table.foreach(Player.Backpack:GetChildren(), function(_, val)
                        if tostring(val) == 'Rokakaka' then
                             RokaCount = RokaCount + 1 
                        end
                    end)
                      
                    local ArrowCount = 0
                    table.foreach(Player.Backpack:GetChildren(), function(_, val)
                        if tostring(val) == 'Mysterious Arrow' then
                            ArrowCount = ArrowCount + 1 
                        end
                    end)
                    
                    print(RokaCount, "Rokas", ArrowCount, "Arrows #z")
                    
					repeat wait() until Player.Backpack
  
					if RokaCount <= 1 or ArrowCount <= 1 then
					    wait(1)
    				    IF:Update(true)
    				    _G.RunSF = false
    				    wait(6)
    				    IF:Update(false)
    				    wait(0.8)
    				    _G.RunSF = true
					end
			    
					local isStand = false

					for _, Stand in pairs(TempData.SelectedStands) do
						if not Func.ReturnData("HasStand") then
							break
						end --// break if they dont have a stand

						local IsShiny = Func.IsShiny()

						if IsShiny and Data["All Shiny Farm"] and not Data["Specific Shiny Farm"] then
							isStand = true
							WS = true
							break
						end

						if Func.ReturnData("Stand") == Stand and not Data["All Shiny Farm"] then
							isStand = true
							WS = true
							break
						end
					end --// check if objective stand has been reached

					if not _G.RunSF then break end

					if not isStand and not WS then
						--// use roka and arrow here
						local Has_Stand = Func.ReturnData("HasStand")

						if Data["Safe Farm"] then
							local SafeSpot = CFrame.new(-77, -41, -987)
							
							if Player.Character and Player.Character.PrimaryPart then
								Player.Character:SetPrimaryPartCFrame(SafeSpot)
							else
								repeat wait() until Player.Character.PrimaryPart
								local SafeSpot = CFrame.new(-77, -41, -987)
								Player.Character:WaitForChild("HumanoidRootPart").CFrame = SafeSpot
							end
						end

						if Has_Stand then
							if Func.IsShiny() and Data["All Shiny Farm"] then
								_G.RunSF = false
								break
							end

							SF_Data.Roka()
							WS = false
						else
							if Data["UseRib"] == false then
								SF_Data.ArrowSequence()
							else
							    repeat wait() until Player.Character
                    			repeat wait() until Player.Character:FindFirstChild("RemoteEvent")
                    			local skills = {
                    				"Vitality I",
                    				"Vitality II",
                    				"Vitality III",
                    				"Worthiness I",
                    				"Worthiness II",
                    				"Worthiness III",
                    				"Worthiness IV",
                    				"Worthiness V"
                    			}
                    
                    			Func.LearnSkills(skills)
                    			
							    repeat task.wait()
    				                local args = {
                                        [1] = "EndDialogue",
                                        [2] = {
                                            ["NPC"] = "Rib Cage of The Saint's Corpse",
                                            ["Option"] = "Option1",
                                            ["Dialogue"] = "Dialogue2"
                                        }
                                    }
                                    
                                    game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(unpack(args))
                                until (isStand and WS) or not _G.RunSF
		                	end
				            
				            PITYY = Player.PlayerStats.PityCount.Value
				            
							local ShinyStatus = Func.IsShiny()

							if ShinyStatus and (Data["All Shiny Farm"]) then
								local ShinySkin = Func.GetShiny()
								local Censored_Name = Func.Censor(Player.Name)
					
								if ShinySkin == LastShiny then return end
								LastShiny = ShinySkin
								
								local NewSound2 = Instance.new("Sound")
								NewSound2.Parent = game.Players.LocalPlayer.Character
								NewSound2.SoundId = "rbxassetid://9021481885"
								NewSound2.Volume = 20
							
								NewSound2:Play()
								NewSound2.Ended:Wait()
								NewSound2:Destroy()
					
								if Data["Webhook"] ~= "" then
									local Message = "Player: `".. Player.Name .."`\nGot a shiny stand using shiny farm: ".. ShinySkin .. " with " .. PITYY .. " Pity " .. " (".. PITYY * 0.04 + 1 .. " %)"
									SendMessage(Data["Webhook"], Message, "Xenon Logs", true)
					
									if not Data["Only_Webhook_Log"] then
										Message = "Player: `".. Censored_Name .."`\nGot a shiny stand using shiny farm: ".. ShinySkin .. " with " .. PITYY .. " Pity " .. " (".. PITYY * 0.04 + 1 .. " %)"
										SendMessage("https://discord.com/api/webhooks/1037109855602876457/WnnjsACe6fzBwdkVEvl3ErwXZhh8WlYFim3gDmfdEOEu-EAwLIXxtPG2gCydQosGUdB-", Message, "Xenon Logs", true)
									    SendMessage("https://discord.com/api/webhooks/1071416237244043314/KKBGfhpcDO8bpU3l1122Uulfy6BPxufrguKmcfTQMzrBUy-s61-21yfSAdbcHWxwNOym", Message, "Xenon Logs", true)
									end
								else
									local Message = "Player: `".. Censored_Name .."`\nGot a shiny stand using shiny farm: ".. ShinySkin .. " with " .. PITYY .. " Pity " .. " (".. PITYY * 0.04 + 1 .. " %)"
									SendMessage("https://discord.com/api/webhooks/1037109855602876457/WnnjsACe6fzBwdkVEvl3ErwXZhh8WlYFim3gDmfdEOEu-EAwLIXxtPG2gCydQosGUdB-", Message, "Xenon Logs", true)
									SendMessage("https://discord.com/api/webhooks/1071416237244043314/KKBGfhpcDO8bpU3l1122Uulfy6BPxufrguKmcfTQMzrBUy-s61-21yfSAdbcHWxwNOym", Message, "Xenon Logs", true)
								end
								_G.RunSF = false
							end
						end
					end
					game:GetService("RunService").RenderStepped:Wait()
				end
			else
			    _G.RunSF = false
			end
		end)
		
		StandsTab:Seperator()
		
		StandsTab:Toggle("Pity Farm", "farms until your desired pity", false, function(t)
            _G.PityFarm = t
        end)
        
        DesiredPity = 30
        
        StandsTab:Slider("Pity (1 Pity = 0.04%)", 0, 225, 10, function(t)
            DesiredPity = t
            print("Set pity to: ", t * 0.04 + 1," %")
        end)

		StandsTab:Seperator()

		Data = game:GetService('HttpService'):JSONDecode(readfile("XenonCF-V1_05.json"))

		local SH_FA;
		local SH_F;

		if Data["All Shiny Farm"] and Data["Shiny Farm"] then
			Data["Shiny Farm"] = false
			SaveData();
		end

		SH_FA = StandsTab:Toggle("Keep All Shinys", "Makes it stop on any shiny", Data["All Shiny Farm"], function(BooleanVal)
			Data["All Shiny Farm"] = BooleanVal
			SaveData();
		end, true)

		StandsTab:Toggle("Use Rib", "Changes it from arrows to ribs", Data["UseRib"], function(bool)
			Data["UseRib"] = bool
			SaveData();
		end)

		StandsTab:Toggle("Safe Farm", "Teleports you to a safe place while farming", Data["Safe Farm"], function(BooleanVal)
			Data["Safe Farm"] = BooleanVal
			SaveData();
		end)
		
		StandsTab:Seperator()

		StandsTab:Button("Add all", "Adds all stands from the list", function()
			StandsTab:Notification("Added all stands.")
			for i,v in pairs(TempData.StandToggles) do
				spawn(function()
					v:Update(true)
				end)
			end
			SaveData()
		end)

		StandsTab:Button("Remove all", "Removes all stands from the list", function()
			StandsTab:Notification("Removed all stands.")
			for i,v in pairs(TempData.StandToggles) do
				spawn(function()
					v:Update(false)
				end)
			end
			SaveData()
		end)

		StandsTab:Seperator()

		local PityLabel = StandsTab:Label("Pity: "..Player.PlayerStats.PityCount.Value * 0.04 + 1 .."% ("..(Player.PlayerStats.PityCount.Value)..")")

		spawn(function()
			while task.wait(2) do
				PityLabel:Update("Pity: "..Player.PlayerStats.PityCount.Value * 0.04 + 1 .."% ("..(Player.PlayerStats.PityCount.Value)..")")
			end
		end)

		StandsTab:Seperator()

		for _, Stand in pairs(TempData.AllStands) do
			local StandToggle = StandsTab:Toggle(Stand, "Stand", Data.StandToggles[Stand], function(BooleanVal)
				if BooleanVal then
					table.insert(TempData.SelectedStands, Stand)
					Data.StandToggles[Stand] = true
					SaveData()
				else
					RemoveTable(TempData.SelectedStands, Stand)
					RemoveTable(Data.StandToggles, Stand)
					Data.StandToggles[Stand] = false
					SaveData()
				end
			end)
			table.insert(TempData.StandToggles, StandToggle)
		end

		ItemFarmTab:Label("Item Counter")

		ItemFarmTab:Slider("Update speed", 0.1, 2.5, 1.5, function(IntVal)
			TempData["ItemUpdateSpeed"] = IntVal
		end)

		ItemFarmTab:Seperator()

		for i,v in pairs(TempData.AllItems) do
			local label = ItemFarmTab:Label(v..": 0")

			spawn(function()
				while wait(TempData["ItemUpdateSpeed"]) do
					local total = Func.ItemCount(v)
					label:Update(v..": "..tostring(total))
				end
			end)
		end

		MiscTab:Keybind("Toggle UI", Enum.KeyCode.RightControl, {"W", "A", "S", "D", "Up", "Down", "Left", "Right", "CapsLock", "Tab"}, function(key)
			if key then
				MiscTab:Notification("Changed Toggle key to: ", key)
			else
				UI:ToggleUI()
			end
		end)

		MiscTab:Seperator()
	
        local InfDash
        local InfTick = tick();
        local InfDelay = 1;
        local DP = 50

        MiscTab:Toggle("Infinite Dash", "Change Dash Power/Delay", nil, function(State)
            if State then
                InfDash = game:GetService("UserInputService").InputBegan:Connect(function(Input, GameProcessed)
                    if GameProcessed then return end
                    if Input.KeyCode == Enum.KeyCode[Player.PlayerStats.DashKey.Value] and (tick()-InfTick) >= InfDelay then
                        InfTick = tick()
                        if not Player.Character then return end
                        local Dir, Anim_ = Func.Get_Stroke();
                        local Anim = Instance.new("Animation", workspace) Anim.Name = "Dash_Xenon" Anim.AnimationId = "rbxassetid://"..Anim_
                        local Anim2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
                        Anim2:Play()
                        GAYPENIS = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
                        GAYPENIS.Velocity = (Player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(Dir), 0)).lookVector * DP
                        GAYPENIS.MaxForce = Vector3.new(55555,1000,55555)
                        game:GetService("Debris"):AddItem(GAYPENIS, 0.25)
                    end
                end)
            else
                InfDash:Disconnect()
            end
        end)

        MiscTab:Slider("Dash Power", 50, 1000, 50, function(Value)
            DP = Value;
        end)
        
        MiscTab:Slider("Dash Delay", 0.5, 3.5, 0.5, function(Value)
            InfDelay = Value;
        end)
        
        MiscTab:Seperator()
        		
		MiscTab:Label("Webhooks")

		Data = game:GetService('HttpService'):JSONDecode(readfile("XenonCF-V1_05.json"))

		local W_L = MiscTab:TextBox("Webhook Link", function(NewText)
			Data["Webhook"] = NewText
			SaveData();
		end)

		MiscTab:Toggle("Only log webhook", "Will log ONLY to your webhook and not xenons.", Data["Only_Webhook_Log"], function(state)
			Data["Only_Webhook_Log"] = state
			SaveData()
		end)

		W_L:Update(Data["Webhook"])
		
		MiscTab:Seperator()

		MiscTab:Button("No Fog", "Disables the fog in the game", function()
			StandsTab:Notification("Removed fog from the game.")
			if game.Lighting.FogEnd ~= 50000 then
				game.Lighting.FogEnd = 50000
				game.Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
					game.Lighting.FogEnd = 50000
				end)
			end
		end)

		MiscTab:Toggle("Auto Arcade", "Automatically rolls arcade.", false, function(BooleanVal)
			if BooleanVal then
				TempData["AutoArcade"] = true
				while TempData["AutoArcade"] do
                    local args = {
                        [1] = "EndDialogue",
                        [2] = {
                            ["NPC"] = "Item Machine",
                            ["Option"] = "Option1",
                            ["Dialogue"] = "Dialogue1"
                        }
                    }
                    Player.Character.RemoteEvent:FireServer(unpack(args))
                    Player.PlayerGui:WaitForChild("RollingItem"):WaitForChild("Frame").Visible = false
                    Player.PlayerGui:WaitForChild("RollingItem"):WaitForChild("ImageLabel").Visible = false
                    Player.PlayerGui.ChildAdded:Connect(function(roll)
                        if roll.Name == "RollingItem" then
                            Player.PlayerGui:WaitForChild("RollingItem"):WaitForChild("Frame").Visible = false
                            Player.PlayerGui:WaitForChild("RollingItem"):WaitForChild("ImageLabel").Visible = false
                        end
                    end)
					task.wait()
				end
			else
				TempData["AutoArcade"] = false
			end
		end)

		MiscTab:Button("Boobify", "Gives your stand kc boobs", function()
			local sides = {"Left", "Right", "Top", "Bottom", "Back", "Front"}

			local bub = Instance.new("Part", game.Players.LocalPlayer.Character.StandMorph.UpperTorso)
			bub.Size = Vector3.new(1.25, 1.25, 1.25)
			bub.Shape = "Ball"
			bub.Color = Color3.fromRGB(181, 58, 60)
			bub.CanCollide = false
			bub.Massless = true

			for i,v in pairs(sides) do
				local newTexture = Instance.new("Texture", bub)
				newTexture.Texture = "rbxassetid://2865272631"
				newTexture.Face = v
				newTexture.StudsPerTileU = 0.6
				newTexture.StudsPerTileV = 0.6
			end

			local bubWeld = Instance.new("Weld", bub)
			bubWeld.Part0 = bub
			bubWeld.Part1 = bub.Parent

			local bub2 = bub:Clone()
			bub2.Parent = bub.Parent

			bub.Weld.C0 = bub.Weld.C0 - Vector3.new(0.5, 0.25, -0.3)
			bub2.Weld.C0 = bub2.Weld.C0 - Vector3.new(-0.5, 0.25, -0.3)
		end)

		MiscTab:Button("Assify", "Gives your stand kc ass", function()
			--assify v1 by enxquity
			local sides = {"Left", "Right", "Top", "Bottom", "Back", "Front"}

			local as = Instance.new("Part", game.Players.LocalPlayer.Character.StandMorph.UpperTorso)
			as.Size = Vector3.new(1.6, 1.6, 1.6)
			as.Shape = "Ball"
			as.Color = Color3.fromRGB(181, 58, 60)
			as.CanCollide = false
			as.Massless = true

			for i,v in pairs(sides) do
				local newTexture = Instance.new("Texture", as)
				newTexture.Texture = "rbxassetid://2865272631"
				newTexture.Face = v
				newTexture.StudsPerTileU = 0.6
				newTexture.StudsPerTileV = 0.6
			end

			local asWeld = Instance.new("Weld", as)
			asWeld.Part0 = as
			asWeld.Part1 = as.Parent

			local as2 = as:Clone()
			as2.Parent = as.Parent

			as.Weld.C0 = as.Weld.C0 - Vector3.new(-0.35, -0.4, 0.5)
			as2.Weld.C0 = as2.Weld.C0 - Vector3.new(0.35, -0.4, 0.5)
		end)

		MiscTab:Button("Da Baby", "LES GO!", function()
			local NewSound = Instance.new("Sound")
			NewSound.Parent = game.Players.LocalPlayer.Character
			NewSound.SoundId = "rbxassetid://4569628201"
			NewSound.Volume = 10

			NewSound:Play()
			NewSound.Ended:Wait()
			NewSound:Destroy()
		end)

		--[[MiscTab:Toggle("Anti TS", "Avoids any time stop.", true, function(state)
			if state then
				TempData.RenderCONN["Anti_TS"] = game:GetService("RunService").RenderStepped:Connect(function()
					if Player.Character and Player.Character:FindFirstChild("InTimeStop") then
						Player.Character:FindFirstChild("InTimeStop"):Destroy()
					end
				end)
			else
				if TempData.RenderCONN["Anti_TS"] then
					TempData.RenderCONN["Anti_TS"]:Disconnect()
				end
			end
		end)]]
	
		MiscTab:Toggle("Anti Rock-Trap", "gets rid of CD rock trap", false, function(t)
		    while t do
                repeat task.wait() until workspace.IgnoreInstances:FindFirstChild("Rocks")
                
                for i,v in pairs(workspace.IgnoreInstances.Rocks:GetChildren()) do
                    if string.find(v.Name, "Rock") then
                        v.Size = Vector3.new(0,0,0)
                        game.Players.LocalPlayer.Character.UpperTorso.Anchored = false
                    end
                end
                task.wait()
            end
		end)
		
		MiscTab:Toggle("Anti Vamp-Burn", "", false, function(t)
		    while t do
                workspace.Weather.Value = "nil"
                task.wait(1)
            end
		end)

		MiscTab:TextBox("Victim", function(victim)
			TempData["Attach_Victim"] = victim
		end)

		MiscTab:Toggle("Stand Attach", "Attaches your stand to a victim", false, function(state)
			if state then
				TempData.RenderCONN["SA_"] = game:GetService("RunService").RenderStepped:Connect(function()
					if Player.Character and Player.Character:FindFirstChild("StandMorph") and Player.Character.PrimaryPart:FindFirstChild("StandAttach") and Player.Character.Humanoid.Health > 1 then
						Player.Character.PrimaryPart.StandAttach.WorldCFrame = workspace.Living[TempData["Attach_Victim"]].PrimaryPart.CFrame - workspace.Living[TempData["Attach_Victim"]].PrimaryPart.CFrame.LookVector * 1
					end
				end)
			else
				if TempData.RenderCONN["SA_"] then
					TempData.RenderCONN["SA_"]:Disconnect()
				end
			end
		end)

		MiscTab:Seperator()

		local OnRender_AS;
		MiscTab:Toggle("Auto Sell", "Will automatically sell all items on list", false, function(BooleanVal)
			if BooleanVal then
				OnRender_AS = game:GetService("RunService").RenderStepped:Connect(function()
					for i,v in pairs(TempData.Sell) do
						local item = Player.Backpack:FindFirstChild(v)
						if item then
							Player.Character.Humanoid:EquipTool(item);
							local args = {
								[1] = "EndDialogue",
								[2] = {
									["NPC"] = "Merchant",
									["Option"] = "Option1",
									["Dialogue"] = "Dialogue5"
								}
							}

							game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(unpack(args))
						end
					end
				end)
			else
				if OnRender_AS then
					OnRender_AS:Disconnect();
				end
			end
		end)

        MiscTab:Button("Sell 1 Item", "", function()
            for i,v in pairs(TempData.Sell) do
			    local item = Player.Backpack:FindFirstChild(v)
			    if item then
				    Player.Character.Humanoid:EquipTool(item);
				    local args = {
				    	[1] = "EndDialogue",
				    	[2] = {
				    		["NPC"] = "Merchant",
				    		["Option"] = "Option1",
				    		["Dialogue"] = "Dialogue5"
				    	}
				    }

				    game:GetService("Players").LocalPlayer.Character.RemoteEvent:FireServer(unpack(args))
			    end
		    end    
        end)
        
		MiscTab:Seperator()

		MiscTab:Button("Add all items", "Adds all items to list", function()
			StandsTab:Notification("Added all items.")
			for i,v in pairs(TempData["Item Toggles"]) do
				spawn(function()
					v:Update(true)
				end)
			end
		end)

		MiscTab:Button("Remove all items", "Removes all items from list", function()
			StandsTab:Notification("Removed all items.")
			for i,v in pairs(TempData["Item Toggles"]) do
				spawn(function()
					v:Update(false)
				end)
			end
		end)

		MiscTab:Seperator()

		for i,v in pairs(TempData.AllItems) do
			local iToggle = MiscTab:Toggle(v, "Item", false, function(state)
				if state then
					table.insert(TempData.Sell, v)
				else
					RemoveTable(TempData.Sell, v)
				end
			end)

			table.insert(TempData["Item Toggles"], iToggle)
		end

		MiscTab:Seperator()

		MiscTab:Slider("Player Count", 1, 15, 7, function(IntVal)
			getgenv().HopCount = IntVal
		end)

		if not getgenv().HopCount then
			getgenv().HopCount = 7
		end

		HopButton = MiscTab:Button("Hop Servers", "Hop Servers", function()
			MiscTab:Notification("Hopping to a server with ".. getgenv().HopCount .. " players.")
			local function Hop()
				local PlaceID = 2809202155
				local AllIDs = {}
				local foundAnything = ""
				local actualHour = os.date("!*t").hour
				local Deleted = false
				local File = pcall(function()
					AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
				end)
				if not File then
					table.insert(AllIDs, actualHour)
					writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
				end
				function TPReturner()
					local Site;
					if foundAnything == "" then
						Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
					else
						Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
					end
					local ID = ""
					if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
						foundAnything = Site.nextPageCursor
					end
					local num = 0;
					for i,v in pairs(Site.data) do
						local Possible = true
						ID = tostring(v.id)
						if getgenv().HopCount == tonumber(v.playing) then
							for _,Existing in pairs(AllIDs) do
								if num ~= 0 then
									if ID == tostring(Existing) then
										Possible = false
									end
								else
									if tonumber(actualHour) ~= tonumber(Existing) then
										local delFile = pcall(function()
											delfile("NotSameServers.json")
											AllIDs = {}
											table.insert(AllIDs, actualHour)
										end)
									end
								end
								num = num + 1
							end
							if Possible == true then
								table.insert(AllIDs, ID)
								wait()
								pcall(function()
									writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
									wait()
									game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
								end)
								wait(4)
							end
						end
					end
				end

				function Teleport()
					while wait() do
						pcall(function()
							TPReturner()
							if foundAnything ~= "" then
								TPReturner()
							end
						end)
					end
				end

				Teleport()
			end
			Hop()
		end)
		
		PlayerTab:Button("Hide Name", "Hides your name in list and esc menu", function()
            Player.PlayerGui.HUD.Playerlist[Player.Name].Name = "???"
            Player.Name = "???"
            Player.DisplayName = "???"
        end)
        
        PlayerTab:Toggle("Hide Player List", "Hides player list", false, function(t)
            getgenv().HPL = t
            
            if getgenv().HPL then
                Player.PlayerGui.HUD.Playerlist.Visible = false
                
                while getgenv().HPL do task.wait()
                    repeat task.wait() until game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame:FindFirstChild("Players")
                    game:GetService("CoreGui").RobloxGui.SettingsShield.SettingsShield.MenuContainer.PageViewClipper.PageView.PageViewInnerFrame.Players.Visible = false
                end
            else
                Player.PlayerGui.HUD.Playerlist.Visible = true
            end
        end)
        
        PlayerTab:Seperator()
        
        --[[PlayerTab:Button("Invisibility", "Invisibility", function(t)
            local oldpos = Player.Character.HumanoidRootPart.CFrame
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-77, -41, -987)
            task.wait(.2)
            Player.Character.LowerTorso.Root:Destroy()
            task.wait(.2)
            Player.Character.HumanoidRootPart.CFrame = oldpos
        end)]]

        PlayerTab:Toggle("Auto Panic!", "kicks u when a mod is spotted in the server", true, function(t)
            getgenv().Boob = nil
            if t then
                local Mods = loadstring(game:HttpGet("https://pastebin.com/raw/CMqzPE7C"))()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if game.Players.LocalPlayer.PlayerGui.HUD.Playerlist[v.Name].Name:find("#") then
                        game.Players.LocalPlayer:Kick("Leaderboard player spotted, leaving..")
                    end
                    
                    if table.find(Mods, v.Name) then
                        game.Players.LocalPlayer:Kick("Mod spotted, rejoining..")
                    end
                end
                
                getgenv().Boob = game.Players.ChildAdded:Connect(function(noob)
                    if game.Players.LocalPlayer.PlayerGui.HUD.Playerlist[noob.Name].Name:find("#") then
                        game.Players.LocalPlayer:Kick("Leaderboard player spotted, leaving..")
                    end
                    
                    if table.find(Mods, noob.Name) then
                        game.Players.LocalPlayer:Kick("Mod spotted, rejoining..")
                    end
                end)
            else
                pcall(function()
                    getgenv().Boob:Disconnect()
                end)
            end
        end)
		PlayerTab:Seperator()
		
		PlayerTab:Toggle("fucking aerosmith..", "anti aerosmith", false, function(t)
		    FuckAerosmith = t

            if FuckAerosmith then
                oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                
                while FuckAerosmith do task.wait(.13)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(500,3000), math.random(500,3000), math.random(500,3000))
                end
                
                if not FuckAerosmith then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                end
            end
        end)
		
		PlayerTab:Seperator()
		
		PlayerTab:Button("Reset Character", "", function(t)
		    Player.Character.Humanoid.Health = 0
		end)
		
		PlayerTab:Seperator()
		
		local Settings = {
            FlySpeed = 5,
            FlySpeed2 = 0.5,
        }
		
		PlayerTab:Toggle("Player Fly", "Q = Down, E = Up, Move = WASD", false, function(t)
            if t == true then
                local Keys_Pressed = {
                	["W"] = 0;
                	["A"] = 0;
                	["S"] = 0;
                	["D"] = 0;
                }
                local Key_Info = {
                	["W"] = {
                		["Operator"] = "+";
                		["Direction"] = "LookVector";
                	};
                	["A"] = {
                		["Operator"] = "-";
                		["Direction"] = "RightVector";
                	};
                	["S"] = {
                		["Operator"] = "-";
                		["Direction"] = "LookVector";
                	};
                	["D"] = {
                		["Operator"] = "+";
                		["Direction"] = "RightVector";
                	};
                }
                
                
                --// Begin fly script
                
                --// Variables
                local Players = game:GetService("Players")
                local UIS = game:GetService("UserInputService")
                local RunService = game:GetService("RunService")
                local TweenService = game:GetService("TweenService")
                
                --// Neat functions
                local function GetKeyFromEnum(enum)
                	return enum.KeyCode.Name
                end
                
                local function GetMass(Model)
                	local Mass = 0;
                	for i,v in pairs(Model:GetDescendants()) do
                		if v:IsA("BasePart") then Mass = Mass + v:GetMass() end
                	end
                	return Mass;
                end
                
                local function Math(Operator, A, B)
                	if Operator == "-" then return A-B elseif Operator == "+" then return A+B end
                end
                
                --// Key detection
                UIS.InputBegan:Connect(function(Key, Typing)
                	if Typing then return end
                	
                	local Key_String = GetKeyFromEnum(Key)
                	if Keys_Pressed[Key_String] then
                		Keys_Pressed[Key_String] = 1
                	end
                end)
                
                UIS.InputEnded:Connect(function(Key, Typing)
                	if Typing then return end
                	
                	local Key_String = GetKeyFromEnum(Key)
                	if Keys_Pressed[Key_String] then
                		Keys_Pressed[Key_String] = 0
                	end
                end)
                
                --// Fly loop
                
                _G.FlyLoop = RunService.RenderStepped:Connect(function()
                    Character = Player.Character or Player.CharacterAdded:Wait()
                	if not Character then return end
                	Character.Humanoid.WalkSpeed = 0; Character.Humanoid.JumpPower = 0;
                	
                	Character.PrimaryPart.CFrame = CFrame.new(Character.PrimaryPart.Position, Character.PrimaryPart.Position + workspace.CurrentCamera.CFrame.LookVector)
                	local CharacterMass = GetMass(Character)
                	--// Calculate new velocity
                	
                    local Velocity = Vector3.new(0, CharacterMass/workspace.Gravity, 0) --// Lets try not to decend
                    for i,v in pairs(Keys_Pressed) do
                        if v == 0 then else
                        Velocity = Math(Key_Info[i].Operator, Velocity, Character.PrimaryPart.CFrame[Key_Info[i].Direction] * Settings.FlySpeed * CharacterMass) end
                    end
                	
                	Character.PrimaryPart.Velocity = Velocity
                end)
            else
                _G.FlyLoop:Disconnect()
                Player.Character.Humanoid.WalkSpeed = 16
            end
        end)
        
        PlayerTab:Slider("Fly Speed", 1,15,2, function(t)
            Settings.FlySpeed = t
        end)
        
        PlayerTab:Seperator()
		
		--[[
		PlayerTab:Button("Infinite Stand-Pilot Range", "", function()
		    if Player.Character and Player.Character:FindFirstChild("StandMorph") and Player.Character.StandMorph:FindFirstChild("IsPiloting") then
		        Player.Character.StandMorph.IsPiloting.Value = 99999
		    end
		end)]]
		
		PlayerTab:Slider("Pilot Speed", 5,300,20, function(t)
		    if Player.Character.StandMorph.PilotSpeed.Value ~= 1 then
		        PilotHook()
		    end
		    
		    if Player.Character and Player.Character:FindFirstChild("StandMorph") and Player.Character.StandMorph:FindFirstChild("PilotSpeed") then
		        Player.Character.StandMorph.PilotSpeed.Value = t
		    end
		end)
		
		PlayerTab:Toggle("Pilot Fly", "Q = Down, E = Up, Move = WASD", false, function(t)
            if t == true then
                local Keys_Pressed = {
                	["W"] = 0;
                	["A"] = 0;
                	["S"] = 0;
                	["D"] = 0;
                }
                local Key_Info = {
                	["W"] = {
                		["Operator"] = "+";
                		["Direction"] = "LookVector";
                	};
                	["A"] = {
                		["Operator"] = "-";
                		["Direction"] = "RightVector";
                	};
                	["S"] = {
                		["Operator"] = "-";
                		["Direction"] = "LookVector";
                	};
                	["D"] = {
                		["Operator"] = "+";
                		["Direction"] = "RightVector";
                	};
                }
                
                
                --// Begin fly script
                
                --// Variables
                local Players = game:GetService("Players")
                local UIS = game:GetService("UserInputService")
                local RunService = game:GetService("RunService")
                local TweenService = game:GetService("TweenService")
                
                --// Neat functions
                local function GetKeyFromEnum(enum)
                	return enum.KeyCode.Name
                end
                
                local function GetMass(Model)
                	local Mass = 0;
                	for i,v in pairs(Model:GetDescendants()) do
                		if v:IsA("BasePart") then Mass = Mass + v:GetMass() end
                	end
                	return Mass;
                end
                
                local function Math(Operator, A, B)
                	if Operator == "-" then return A-B elseif Operator == "+" then return A+B end
                end
                
                --// Key detection
                UIS.InputBegan:Connect(function(Key, Typing)
                	if Typing then return end
                	
                	local Key_String = GetKeyFromEnum(Key)
                	if Keys_Pressed[Key_String] then
                		Keys_Pressed[Key_String] = 1
                	end
                end)
                
                UIS.InputEnded:Connect(function(Key, Typing)
                	if Typing then return end
                	
                	local Key_String = GetKeyFromEnum(Key)
                	if Keys_Pressed[Key_String] then
                		Keys_Pressed[Key_String] = 0
                	end
                end)
                
                --// Fly loop
                
                _G.FlyLoop = RunService.RenderStepped:Connect(function()
                	local Character2 = Player.Character.StandMorph
                	if not Character2 then return end
                	Player.Character.StandMorph.PilotSpeed.Value = 0;
                	
                	Character2.PrimaryPart.CFrame = CFrame.new(Character2.PrimaryPart.Position, Character2.PrimaryPart.Position + workspace.CurrentCamera.CFrame.LookVector)
                	local CharacterMass = GetMass(Character2)
                	--// Calculate new velocity
                	
                    local Velocity = Vector3.new(0, CharacterMass/workspace.Gravity, 0) --// Lets try not to decend
                    for i,v in pairs(Keys_Pressed) do
                        if v == 0 then else
                        Velocity = Math(Key_Info[i].Operator, Velocity, Character2.PrimaryPart.CFrame[Key_Info[i].Direction] * Settings.FlySpeed2 * CharacterMass) end
                    end
                	
                	Character2.PrimaryPart.Velocity = Velocity
                end)
            else
                _G.FlyLoop:Disconnect()
                Player.Character.StandMorph.PilotSpeed.Value = 22
            end
		end)
    
        PlayerTab:Slider("Pilot Fly Speed", 0.2,2,0.2, function(t)
            Settings.FlySpeed2 = t
        end)
        
        PlayerTab:Seperator()

        PlayerTab:Button("Jesus Dialogue", "", function()
            Player.Character.RemoteEvent:FireServer("PromptTriggered", game.ReplicatedStorage.NewDialogue.Jesus)
        end)
        
        PlayerTab:Seperator()
        
        pcall(function()
            local ESP = loadstring(game:HttpGet("https://pastebin.com/raw/1KPn58Z3"))()
            
            _G.PESP = nil
            PlayerTab:Toggle("Player ESP", "", false, function(t)
                _G.PESP = t
                if _G.PESP == true then
                    ESP:DrawBoxPlayers()
                else
                    ESP:CleanUp()
                end
            end)
            
        end)
		
		local AnimsList = {}
        local Poses = {}
        local AnimsBlacklist = {"StandAppear", "StandDisappear"}
        
        local CustomAnims = {
        	["Ice Skating"] = 5032241918;
        }
        for i,v in pairs(CustomAnims) do
        	local Anim = Instance.new'Animation'
        	Anim.Parent = game.ReplicatedStorage.Anims
        	Anim.AnimationId = "rbxassetid://" .. v
        	Anim.Name = i
        end
        
        for i,v in pairs(game.ReplicatedStorage.Anims:GetDescendants()) do
        	if v:IsA("Animation") and not table.find(AnimsBlacklist, v.Name) and v.Parent.Name ~= "Poses" then
        		table.insert(AnimsList, v.Name)
        	end
        end
        
        for i,v in pairs(game.ReplicatedStorage.Anims.Poses:GetChildren()) do
        	if v:IsA("Animation") then
        		table.insert(Poses, v.Name)
        	end
        end

		AnimationsTab:Dropdown("Stand & Spec Animations", AnimsList, function(SelectedAnimation)
        	local AnimID = 123456789
        	for i,v in pairs(game.ReplicatedStorage.Anims:GetDescendants()) do
        		if v:IsA("Animation") and v.Name == SelectedAnimation then
        			AnimID = v.AnimationId
        			break
        		end
        	end
        
        	local Anim = Instance.new("Animation", workspace) Anim.Name = "CSAnims_Xenon" Anim.AnimationId = AnimID
        	local Anim2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
        	Anim2:Play()
        end)
        
        AnimationsTab:Dropdown("Poses", Poses, function(SelectedAnimation)
        	local AnimID = 123456789
        	for i,v in pairs(game.ReplicatedStorage.Anims.Poses:GetChildren()) do
        		if v:IsA("Animation") and v.Name == SelectedAnimation then
        			AnimID = v.AnimationId
        			break
        		end
        	end
        
        	local Anim = Instance.new("Animation", workspace) Anim.Name = "CSAnims_Xenon" Anim.AnimationId = AnimID
        	local Anim2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
        	Anim2:Play()
        end)
        
        AnimationsTab:Button("Stop Animations", "Stop Animations", function()
        	for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
        		v:Stop()
        	end
        	for i,v in pairs(workspace:GetChildren()) do
        		if v.Name == "CSAnims_Xenon" then
        			v:Destroy()
        		end
        	end
        end)
        
    	local Place1 = CFrame.new(-590.408935546875, -25.678024291992188, -587.6380004882812)
        local Place2 = CFrame.new(-270.59918212890625, -30.621177673339844, -310.017578125)
        local Place3 = CFrame.new(-275.6389465332031, -30.62117576599121, -594.7325439453125)
        local Place4 = CFrame.new(515.2348022460938, 0.9475895166397095, 1.1217936277389526)
        local Place5 = CFrame.new(-524.5589599609375, -25.486597061157227, -177.84661865234375)
        local Place6 = CFrame.new(1063.1826171875, 116.8250503540039, -55.28919219970703)
        local Place7 = CFrame.new(-40.63917922973633, 0.16472691297531128, -959.8817749023438)
        local Place8 = CFrame.new(143.09442138671875, -25.847843170166016, 562.724365234375)
        local Place9 = CFrame.new(782.618408203125, -42.322540283203125, 125.82281494140625)
        local Place10 = CFrame.new(249.03945922851562, 5.2477827072143555, -223.98190307617188)
        local Place11 = CFrame.new(-433.21868896484375, 0.1509326994419098, -5.936071872711182)
        local Place12 = CFrame.new(398.05389404296875, -31.309097290039062, -175.54795837402344)
        local Place13 = CFrame.new(8465.818359375, -478.971923828125, 8154.32958984375)
        local Place14 = CFrame.new(-6.118023872375488, 0.584891140460968, -704.0423583984375)
		
        function SearchPlayer(Name)
            local ClosestMatch = nil
            local ClosestLetters = 0
            for i,v in pairs(workspace.Living:GetChildren()) do
                local matched_letters = 0
                for i = 1, #Name do
                    if string.sub(Name:lower(), 1, i) == string.sub(v.Name:lower(), 1, i) then
                        matched_letters = i
                    end
                end
                if matched_letters > ClosestLetters then
                    ClosestLetters = matched_letters
                    ClosestMatch = v
                end
            end
            return ClosestMatch
        end
        
        local TextB;
        TextB = LocationsTab:TextBox("TP to NPC", function(text)
            local Selecteda = ""
            pcall(function()
                local PossiblePlayer = SearchPlayer(text)
              
                if PossiblePlayer then
                    Selecteda = PossiblePlayer.Name
                    TextB:Update(PossiblePlayer.Name)
                end
            end)
            
            for i,v in pairs(workspace.Living:GetChildren()) do
                if v.Name == Selecteda then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 4, 0)
                end
            end
        end)
        
        NPCList = {}
        
        local function NPCNIGGA()
            for i,v in pairs(workspace.Living:GetChildren()) do
        	   if v:IsA("Model") and v:FindFirstChild("AIHandler") then
        	       table.insert(NPCList, v.Name)
        	   end
            end
        end
        
        NPCNIGGA()
	
    	LocationsTab:Dropdown("TP to NPC", NPCList, function(t)
    	    pcall(function()
                Player.Character.HumanoidRootPart.CFrame = workspace.Living:FindFirstChild(t).HumanoidRootPart.CFrame
    	    end)
        end)
    	
    	LocationsTab:Seperator()    
        
		LocationsTab:Button("Park", "Teleports you to the park", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place1
			end
		end)

		LocationsTab:Seperator()

		LocationsTab:Button("Pesci", "Teleports you to Pesci Boss", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place2
			end
		end)

		LocationsTab:Seperator()

		LocationsTab:Button("Ice Cube", "Teleports you to Ice Cube", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place3
			end
		end)

		LocationsTab:Seperator()

		LocationsTab:Button("Giorno #1", "Teleports you to the Start of Storyline", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place14
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("Cosmetics Shop", "Teleports you to the Cosmetics Shop", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place4
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("The Cafe", "Teleports you to The Cafe", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place5
			end
		end)
		
		LocationsTab:Seperator()

		LocationsTab:Button("Diavolo", "Teleports you to Diavolo", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place6
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("Dio", "Teleports you to Dio P3", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place7
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("Joe P3", "Teleports you to Joe P3", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place8
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("Joe P6", "Joe P6", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place9
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("Arcade", "Teleports you to the Arcade", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place10
			end
		end)      

		LocationsTab:Seperator()

		LocationsTab:Button("Prestige Master", "Teleports you to the Prestige Master", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place11
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("Vampire Room", "Teleports you to the Vampire Room", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place12
			end
		end)   

		LocationsTab:Seperator()

		LocationsTab:Button("Heaven Ascended DIO", "Teleports you to Heaven DIO", function()
			if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = Place13
			end
		end)
		
		Credits:Seperator()

		Credits:Button("Copy Discord Invite", "Copy the discord link to clipboard.", function()
			setclipboard("discord.gg/cmxMjbTa2r")

			Credits:Notification("Copied invite!")
		end)

		Credits:Label(
			"Owner: enxquity"
		)

		Credits:Label(
			"Co-Owner & Developer: _vez0"
		)
		
		Credits:Label(
			"Version: v".. TempData["ScriptVer"]
		)

		Credits:Label(
			"Exploit: ".. exploit
		)

		Credits:Label(
			"Missing Functions: " .. (missingSupport == "" and "None" or missingSupport)
		)

		local status = game:HttpGet("https://raw.githubusercontent.com/xenonhubs/xenon-premium-hub/main/status")

		if status then
			Credits:Label(
				"Status: " .. status
			)
		end
		
		Credits:Seperator()

		--auto farm down here cuz im not sorted :(
				
		TempData.Moves = {
			["UseMove"] = function(key)
				local args = {
					[1] = "InputBegan",
					[2] = {
						["Input"] = Enum.KeyCode[key:upper()]
					}
				}
			
				Player.Character.RemoteEvent:FireServer(unpack(args))
			end,
			["Punch"] = function()
				local args = {
					[1] = "Attack",
					[2] = "m1"
				}
		
				Player.Character.RemoteFunction:InvokeServer(unpack(args))
			end,
			["PowerPunch"] = function()
				local args = {
					[1] = "Attack",
					[2] = "m2"
				}
		
				Player.Character.RemoteFunction:InvokeServer(unpack(args))
			end,

			["All"] = function()
				if Func.ReturnData("HasStand") then
					for i,v in pairs(Player.Character.StandSkills:GetChildren()) do
						local key = string.sub(v.Name, 14, #v.Name):upper()
						if table.find(TempData.AutofarmSettings.UsedMoves, key) then
							TempData.Moves.UseMove(key)
						end
					end
				end
				TempData.Moves.Punch()
			end
		} --// this is needed for autofarm srry its messy

		TempData.AutofarmSettings = {
			["Distance"] = 10,
			["Height"] = 10,
			["FarmMethod"] = "Above",
			["Auto Spawn Stand"] = true,
			["UsedMoves"] = {},
			["NPC_Table"] = {},
			["SelectedNPC"] = nil,
			["Farming"] = false,
			["FixThread"] = nil
		}	
		
		TempData.Completed = false
        
		TempData.Kill = function(npc)
			assert(npc, "No NPC provided")

			if not TempData.Target then
				TempData.Target = npc
			end

			TempData.AutofarmThread = game:GetService("RunService").RenderStepped:Connect(function()
			    task.wait()
				if TempData.Target:FindFirstChild("HumanoidRootPart") and (TempData.Target:FindFirstChild("Humanoid") and TempData.Target:FindFirstChild("Humanoid").Health > 0.11) and not TempData.Completed and TempData.Farming then
				    if TempData.AutofarmSettings.FarmMethod == "Above" then
    					Player.Character.StandMorph.HumanoidRootPart.CFrame = (TempData.Target:FindFirstChild("HumanoidRootPart").CFrame - TempData.Target:FindFirstChild("HumanoidRootPart").CFrame.lookVector * TempData.AutofarmSettings.Distance)
                        Player.Character.HumanoidRootPart.CFrame = TempData.Target:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,TempData.AutofarmSettings.Height,0)
                    else
    					Player.Character.StandMorph.HumanoidRootPart.CFrame = (TempData.Target:FindFirstChild("HumanoidRootPart").CFrame - TempData.Target:FindFirstChild("HumanoidRootPart").CFrame.lookVector * TempData.AutofarmSettings.Distance)
                        Player.Character.HumanoidRootPart.CFrame = TempData.Target:FindFirstChild("HumanoidRootPart").CFrame - Vector3.new(0,TempData.AutofarmSettings.Height,0)
				    end
                
					if Func.ReturnData("HasStand") and not game.Players.LocalPlayer.Character.SummonedStand.Value and TempData.AutofarmSettings["Auto Spawn Stand"] then
    				    Player.Character.RemoteFunction:InvokeServer("ToggleStand", "Toggle")
					end
                
					coroutine.resume(coroutine.create(function()
						TempData.Moves["All"]()
					end))

				else
					TempData.Stop()
				end
			end)
		end

		TempData.Stop = function()
			if TempData.AutofarmThread then
				TempData.AutofarmThread:Disconnect();
				TempData.Target = nil
				TempData.Completed = true
				TempData.AutofarmSettings.FixThread:Disconnect();
			end
		end

		TempData.UpdateList = function()
			TempData.AutofarmSettings["NPC_Table"] = {} --//clear the table

			for i,v in pairs(workspace.Living:GetChildren()) do
				if not table.find(TempData.AutofarmSettings["NPC_Table"], v.Name) then
					table.insert(TempData.AutofarmSettings["NPC_Table"], v.Name)
				end
			end
		end
		
		AutofarmTab:Dropdown("Farm Method", {"Above", "Below"}, function(t)
		    TempData.AutofarmSettings.FarmMethod = t
		end)

		AF = AutofarmTab:Toggle("Autofarm NPC", "Farms the selected NPC", false, function(state)
			TempData.Farming = state
			TempData.AutofarmSettings.FixThread = Player.CharacterAdded:Connect(function()
				TempData.Stop()
			end)
			if state then
			    
				while TempData.Farming do
					wait()				
					for _, npc in pairs(workspace.Living:GetChildren()) do
						if npc.Name == TempData.AutofarmSettings.SelectedNPC then
							TempData.Kill(npc)

							repeat task.wait() until TempData.Completed or not TempData.Farming
							task.wait(0.98)
							TempData.Completed = false
						end
					end

					if not TempData.Farming then
						break
					end
				end
			else
				TempData.Stop()
			end
		end)	

		AutofarmTab:Slider("Distance from NPC", 2, 5, 2.35, function(new)
			TempData.AutofarmSettings.Distance = new
		end)
		
		AutofarmTab:Slider("Height from NPC", 5, 50, 5, function(new)
			TempData.AutofarmSettings.Height = new
		end)

		AutofarmTab:Toggle("Auto use stand", "Automatically uses stand when farming", true, function(state)
			TempData.AutofarmSettings["Auto Spawn Stand"] = state
		end)
		
		AutofarmTab:Seperator()
        
		TempData.UpdateList()
		
        function SearchPlayer2(Name)
            local ClosestMatch = nil
            local ClosestLetters = 0
            for i,v in pairs(workspace.Living:GetChildren()) do
                local matched_letters = 0
                for i = 1, #Name do
                    if string.sub(Name:lower(), 1, i) == string.sub(v.Name:lower(), 1, i) then
                        matched_letters = i
                    end
                end
                if matched_letters > ClosestLetters then
                    ClosestLetters = matched_letters
                    ClosestMatch = v
                end
            end
            return ClosestMatch
        end
        
        local TextC;
        TextC = AutofarmTab:TextBox("Choose", function(text)
            pcall(function()
                local PossiblePlayer = SearchPlayer2(text)
              
                if PossiblePlayer then
                    TempData.AutofarmSettings.SelectedNPC = PossiblePlayer.Name
                    TextC:Update(PossiblePlayer.Name)
                end
            end)
        end)
        
		local NPCSelection = AutofarmTab:Dropdown("NPC Selection", TempData.AutofarmSettings["NPC_Table"], function(selected)
			TempData.AutofarmSettings.SelectedNPC = selected
		end)
        
		game.Players.PlayerAdded:Connect(function()
			TempData.UpdateList()
			NPCSelection:Update(TempData.AutofarmSettings["NPC_Table"])
		end)

		game.Players.PlayerRemoving:Connect(function()
			TempData.UpdateList()
			NPCSelection:Update(TempData.AutofarmSettings["NPC_Table"])
		end)
    
    	AutofarmTab:Seperator()
		
		AutofarmTab:Label("Moves")

		if Func.ReturnData("HasStand") then
			for i,v in pairs(Player.Character.StandSkills:GetChildren()) do
				local key = string.sub(v.Name, 14, #v.Name):upper()
				AutofarmTab:Toggle(key, "Use move while farming", false, function(state)
					if state then
						table.insert(TempData.AutofarmSettings.UsedMoves, key)
					else
						RemoveTable(TempData.AutofarmSettings.UsedMoves, key)
					end
				end)
			end
		end
		
		AutofarmTab:Seperator()
		
        local Quests = {}
        for i,v in pairs(workspace.Dialogues:GetChildren()) do
            if v.Name:find("Lvl") then
               table.insert(Quests, v.Name)
            end
        end
        
		AutofarmTab:Dropdown("Quest NPCs", Quests, function(new)
            if new then
                fireproximityprompt(workspace.Dialogues:FindFirstChild(new).ProximityPrompt)
            end
		end)