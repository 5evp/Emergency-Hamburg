local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Skids Scripts",
	Icon = 0,
	LoadingTitle = "Skids Scripts",
	LoadingSubtitle = "by Skids Scripts",
	ShowText = "Rayfield",
	Theme = "Amethyst",
	ToggleUIKeybind = "K",
	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
		FileName = "Big Hub"
	},
	Discord = {
		Enabled = false,
		Invite = "https://discord.gg/pd97RWYZAm",
		RememberJoins = true
	},
	KeySystem = false,
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided",
		FileName = "Key",
		SaveKey = true,
		GrabKeyFromSite = false,
		Key = {"Hello"}
	}
})

local Tab = Window:CreateTab("MAIN", 4483362458) -- Title, Image

local Toggle = Tab:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
	local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local ESP_SETTINGS = {
	Enabled = true,
	MaxDistance = math.huge,
	HealthColorHigh = Color3.fromRGB(80, 220, 100),
	HealthColorMid = Color3.fromRGB(255, 200, 0),
	HealthColorLow = Color3.fromRGB(220, 50, 50),
}

local espObjects = {}

local function getHealthColor(percent)
	if percent > 0.5 then
		return ESP_SETTINGS.HealthColorHigh:Lerp(ESP_SETTINGS.HealthColorMid, (1 - percent) * 2)
	else
		return ESP_SETTINGS.HealthColorMid:Lerp(ESP_SETTINGS.HealthColorLow, (0.5 - percent) * 2)
	end
end

local function getRootPart(character)
	return character:FindFirstChild("HumanoidRootPart")
		or character:FindFirstChildWhichIsA("BasePart")
end

local function buildBillboard(player)
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESP_Billboard"
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0, 150, 0, 75)
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.MaxDistance = 0
	billboard.ClipsDescendants = false
	billboard.Enabled = false

	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 1, 0)
	container.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	container.BackgroundTransparency = 0.45
	container.BorderSizePixel = 0
	container.Parent = billboard

	local containerCorner = Instance.new("UICorner")
	containerCorner.CornerRadius = UDim.new(0, 6)
	containerCorner.Parent = container

	local containerStroke = Instance.new("UIStroke")
	containerStroke.Color = Color3.fromRGB(255, 255, 255)
	containerStroke.Transparency = 0.7
	containerStroke.Thickness = 1
	containerStroke.Parent = container

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 6)
	padding.PaddingRight = UDim.new(0, 6)
	padding.PaddingTop = UDim.new(0, 5)
	padding.PaddingBottom = UDim.new(0, 5)
	padding.Parent = container

	local layout = Instance.new("UIListLayout")
	layout.FillDirection = Enum.FillDirection.Vertical
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Top
	layout.Padding = UDim.new(0, 3)
	layout.Parent = container

	local displayNameLabel = Instance.new("TextLabel")
	displayNameLabel.Size = UDim2.new(1, 0, 0, 18)
	displayNameLabel.BackgroundTransparency = 1
	displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	displayNameLabel.TextStrokeTransparency = 0.4
	displayNameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	displayNameLabel.TextScaled = true
	displayNameLabel.Font = Enum.Font.GothamBold
	displayNameLabel.Text = player.DisplayName
	displayNameLabel.TextXAlignment = Enum.TextXAlignment.Center
	displayNameLabel.Parent = container

	local usernameLabel = Instance.new("TextLabel")
	usernameLabel.Size = UDim2.new(1, 0, 0, 12)
	usernameLabel.BackgroundTransparency = 1
	usernameLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
	usernameLabel.TextStrokeTransparency = 0.5
	usernameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	usernameLabel.TextScaled = true
	usernameLabel.Font = Enum.Font.Gotham
	usernameLabel.Text = "@" .. player.Name
	usernameLabel.TextXAlignment = Enum.TextXAlignment.Center
	usernameLabel.Parent = container

	local divider = Instance.new("Frame")
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	divider.BackgroundTransparency = 0.75
	divider.BorderSizePixel = 0
	divider.Parent = container

	local hpRow = Instance.new("Frame")
	hpRow.Size = UDim2.new(1, 0, 0, 13)
	hpRow.BackgroundTransparency = 1
	hpRow.Parent = container

	local hpIcon = Instance.new("TextLabel")
	hpIcon.Size = UDim2.new(0, 16, 1, 0)
	hpIcon.Position = UDim2.new(0, 0, 0, 0)
	hpIcon.BackgroundTransparency = 1
	hpIcon.TextColor3 = Color3.fromRGB(80, 220, 100)
	hpIcon.TextScaled = true
	hpIcon.Font = Enum.Font.GothamBold
	hpIcon.Text = "♥"
	hpIcon.TextXAlignment = Enum.TextXAlignment.Left
	hpIcon.Parent = hpRow

	local hpText = Instance.new("TextLabel")
	hpText.Size = UDim2.new(1, -18, 1, 0)
	hpText.Position = UDim2.new(0, 18, 0, 0)
	hpText.BackgroundTransparency = 1
	hpText.TextColor3 = Color3.fromRGB(200, 200, 200)
	hpText.TextStrokeTransparency = 0.5
	hpText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	hpText.TextScaled = true
	hpText.Font = Enum.Font.Gotham
	hpText.Text = "100 / 100"
	hpText.TextXAlignment = Enum.TextXAlignment.Left
	hpText.Parent = hpRow

	local barTrack = Instance.new("Frame")
	barTrack.Size = UDim2.new(1, 0, 0, 6)
	barTrack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	barTrack.BackgroundTransparency = 0.2
	barTrack.BorderSizePixel = 0
	barTrack.Parent = container

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(1, 0)
	trackCorner.Parent = barTrack

	local trackStroke = Instance.new("UIStroke")
	trackStroke.Color = Color3.fromRGB(0, 0, 0)
	trackStroke.Transparency = 0.6
	trackStroke.Thickness = 1
	trackStroke.Parent = barTrack

	local barFill = Instance.new("Frame")
	barFill.Size = UDim2.new(1, 0, 1, 0)
	barFill.BackgroundColor3 = ESP_SETTINGS.HealthColorHigh
	barFill.BorderSizePixel = 0
	barFill.Parent = barTrack

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = barFill

	local sheen = Instance.new("Frame")
	sheen.Size = UDim2.new(1, 0, 0.5, 0)
	sheen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sheen.BackgroundTransparency = 0.82
	sheen.BorderSizePixel = 0
	sheen.ZIndex = 2
	sheen.Parent = barFill

	local sheenCorner = Instance.new("UICorner")
	sheenCorner.CornerRadius = UDim.new(1, 0)
	sheenCorner.Parent = sheen

	return {
		billboard = billboard,
		displayNameLabel = displayNameLabel,
		usernameLabel = usernameLabel,
		hpText = hpText,
		hpIcon = hpIcon,
		barFill = barFill,
	}
end

local function attachESPToCharacter(esp, character)
	local hrp = character:WaitForChild("HumanoidRootPart", 3)
		or character:FindFirstChildWhichIsA("BasePart")
	if hrp then
		esp.billboard.Adornee = hrp
		esp.billboard.Parent = game.CoreGui
	end
end

local function setupPlayer(player)
	if player == LocalPlayer then return end

	if espObjects[player] then
		if espObjects[player].billboard then
			espObjects[player].billboard:Destroy()
		end
		espObjects[player] = nil
	end

	local esp = buildBillboard(player)
	espObjects[player] = esp

	if player.Character then
		attachESPToCharacter(esp, player.Character)
	end

	player.CharacterAdded:Connect(function(character)
		if espObjects[player] then
			if espObjects[player].billboard then
				espObjects[player].billboard:Destroy()
			end
		end
		local newEsp = buildBillboard(player)
		espObjects[player] = newEsp
		attachESPToCharacter(newEsp, character)
	end)
end

local function removeESP(player)
	if espObjects[player] then
		if espObjects[player].billboard then
			espObjects[player].billboard:Destroy()
		end
		espObjects[player] = nil
	end
end

RunService.RenderStepped:Connect(function()
	if not ESP_SETTINGS.Enabled then return end

	for _, player in ipairs(Players:GetPlayers()) do
		if player == LocalPlayer then continue end

		local esp = espObjects[player]
		if not esp or not esp.billboard then continue end

		local character = player.Character
		if not character or not character.Parent then
			esp.billboard.Enabled = false
			continue
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		local hrp = getRootPart(character)

		if not hrp then
			esp.billboard.Enabled = false
			continue
		end

		if humanoid and humanoid.Health <= 0 then
			esp.billboard.Enabled = false
			continue
		end

		esp.billboard.Adornee = hrp
		esp.billboard.Enabled = true

		if humanoid then
			local health = math.floor(humanoid.Health)
			local maxHealth = math.floor(humanoid.MaxHealth)
			local percent = maxHealth > 0 and (health / maxHealth) or 0
			local hpColor = getHealthColor(percent)
			esp.hpText.Text = health .. " / " .. maxHealth
			esp.hpIcon.TextColor3 = hpColor
			esp.barFill.BackgroundColor3 = hpColor
			esp.barFill.Size = UDim2.new(math.clamp(percent, 0, 1), 0, 1, 0)
		else
			esp.hpText.Text = "In Vehicle"
			esp.hpIcon.TextColor3 = Color3.fromRGB(100, 180, 255)
			esp.barFill.Size = UDim2.new(1, 0, 1, 0)
			esp.barFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
		end

		esp.displayNameLabel.Text = player.DisplayName
		esp.usernameLabel.Text = "@" .. player.Name
	end
end)

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)
Players.PlayerRemoving:Connect(removeESP)
   end,
})

