local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. WINDOW SETUP
local Window = Rayfield:CreateWindow({
   Name = "MM2 EXODUS MENU",
   LoadingTitle = "Applying UI Update...",
   LoadingSubtitle = "by Gemini",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false 
})

-- 2. VARIABLES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function para sa Aim
local function GetTarget(toolName)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if v.Backpack:FindFirstChild(toolName) or v.Character:FindFirstChild(toolName) then
                return v.Character.HumanoidRootPart
            end
        end
    end
    return nil
end

-- 3. FLOATING CIRCLE BUTTONS SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "ExodusFloatingUI"

local function CreateCircleBtn(name, position, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = name
    btn.Size = UDim2.new(0, 65, 0, 65)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = ScreenGui
    btn.Active = true
    btn.Draggable = true 
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim2.new(1, 0)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(0, 255, 255)
    stroke.Thickness = 2
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- SHOOT Button (Sheriff)
local shootBtn = CreateCircleBtn("SHOOT", UDim2.new(0.8, 0, 0.4, 0), function()
    local target = GetTarget("Knife")
    if target then
        game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, target.Position)
        Rayfield:Notify({Title = "Locking", Content = "Murderer Targeted!"})
    end
end)

-- THROW Button (Murderer)
local throwBtn = CreateCircleBtn("THROW", UDim2.new(0.8, 0, 0.55, 0), function()
    local target = GetTarget("Gun")
    if target then
        game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, target.Position)
        Rayfield:Notify({Title = "Locking", Content = "Sheriff Targeted!"})
    end
end)

-- 4. SETTINGS
local SettingsTab = Window:CreateTab("Settings", 4483362458)
SettingsTab:CreateToggle({
   Name = "Lock Buttons",
   CurrentValue = false,
   Callback = function(Value)
      shootBtn.Draggable = not Value
      throwBtn.Draggable = not Value
      shootBtn.UIStroke.Color = Value and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 255)
      throwBtn.UIStroke.Color = Value and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 255)
   end,
})
