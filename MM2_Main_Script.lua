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

-- 3. FLOATING CIRCLE BUTTONS SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "ExodusFloatingUI"

local function CreateCircleBtn(name, position, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = name
    -- Ginawang pabilog ang Size (pantay na width at height)
    btn.Size = UDim2.new(0, 65, 0, 65) 
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BackgroundTransparency = 0.3
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = ScreenGui
    btn.Active = true
    btn.Draggable = true -- Pwede mong i-drag kahit saan

    -- Make it Circle
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(1, 0) -- Perfect circle

    -- Stroke Effect (Glow look)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(0, 255, 255) -- Cyan Blue border
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Create the Buttons (Naka-scatter muna para ikaw mag-posisyon)
local shootBtn = CreateCircleBtn("SHOOT", UDim2.new(0.8, 0, 0.4, 0), function()
    Rayfield:Notify({Title = "Auto Shoot", Content = "Locking on Murderer..."})
    -- Auto Shoot Logic
end)

local throwBtn = CreateCircleBtn("THROW", UDim2.new(0.8, 0, 0.55, 0), function()
    Rayfield:Notify({Title = "Auto Throw", Content = "Locking on Sheriff..."})
    -- Auto Throw Logic
end)

-- 4. SETTINGS TAB (Para sa Lock Feature)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

SettingsTab:CreateToggle({
   Name = "Lock Button Positions",
   CurrentValue = false,
   Callback = function(Value)
      shootBtn.Draggable = not Value
      throwBtn.Draggable = not Value
      
      local lockColor = Value and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 255)
      shootBtn.UIStroke.Color = lockColor
      throwBtn.UIStroke.Color = lockColor
      
      Rayfield:Notify({
          Title = Value and "UI Locked" or "UI Unlocked",
          Content = Value and "Hindi na sila mada-drag." or "Pwede mo na uli i-set ang pwesto."
      })
   end,
})

Rayfield:Notify({Title = "Update Complete", Content = "Circular Buttons Loaded!"})
