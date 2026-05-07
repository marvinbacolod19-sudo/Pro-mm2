local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 1. WINDOW SETUP
local Window = Rayfield:CreateWindow({
   Name = "MM2 EXODUS MENU V2",
   LoadingTitle = "Loading Ultimate Features...",
   LoadingSubtitle = "by Gemini",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false 
})

-- 2. VARIABLES & SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function GetTarget(toolName)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            -- Kahit nasa Backpack (tago) o Character (labas), made-detect nito
            if v.Character:FindFirstChild(toolName) or v.Backpack:FindFirstChild(toolName) then
                return v.Character.HumanoidRootPart
            end
        end
    end
    return nil
end

-- 3. FLOATING UI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "ExodusUltimateUI"

local function CreateCircleBtn(name, position, color, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = name
    btn.Size = UDim2.new(0, 65, 0, 65)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.BackgroundTransparency = 0.2
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = ScreenGui
    btn.Active = true
    btn.Draggable = true 
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim2.new(1, 0)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = color
    stroke.Thickness = 3
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 4. BUTTON FUNCTIONS

-- SHOOT BUTTON (Auto Lock to Murderer)
local shootBtn = CreateCircleBtn("SHOOT", UDim2.new(0.8, 0, 0.3, 0), Color3.fromRGB(255, 0, 0), function()
    local target = GetTarget("Knife")
    if target then
        Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, target.Position)
        Rayfield:Notify({Title = "Aimlock", Content = "Locked on Murderer!", Duration = 2})
    else
        Rayfield:Notify({Title = "Error", Content = "Murderer not found!", Duration = 2})
    end
end)

-- FLING MURDERER
local flingMBtn = CreateCircleBtn("FLING M", UDim2.new(0.8, 0, 0.45, 0), Color3.fromRGB(255, 165, 0), function()
    local target = GetTarget("Knife")
    if target and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 0, 1)
        local velocity = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart)
        velocity.Velocity = Vector3.new(0, 1000, 0) -- Simple fling logic
        wait(0.1)
        velocity:Destroy()
    end
end)

-- FLING SHERIFF
local flingSBtn = CreateCircleBtn("FLING S", UDim2.new(0.8, 0, 0.6, 0), Color3.fromRGB(0, 0, 255), function()
    local target = GetTarget("Gun")
    if target and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 0, 1)
        -- Fling logic dito
    end
end)

-- 5. MAIN FEATURES TAB
local MainTab = Window:CreateTab("Main Features", 4483362458)

-- Anti-Fling
MainTab:CreateToggle({
   Name = "Anti-Fling",
   CurrentValue = false,
   Callback = function(Value)
      if Value then
          RunService.Stepped:Connect(function()
              if LocalPlayer.Character then
                  for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                      if v:IsA("BasePart") then v.CanCollide = false end
                  end
              end
          end)
      end
   end,
})

-- Prank Jump (Bomb Prank)
MainTab:CreateToggle({
   Name = "Prank Jump (Bomb)",
   CurrentValue = false,
   Callback = function(Value)
      LocalPlayer.Character.Humanoid.Jumping:Connect(function()
          if Value then
              local bomb = Instance.new("Part", Workspace)
              bomb.Shape = Enum.PartType.Ball
              bomb.Size = Vector3.new(2,2,2)
              bomb.BrickColor = BrickColor.new("Really Black")
              bomb.Position = LocalPlayer.Character.HumanoidRootPart.Position
              Rayfield:Notify({Title = "Prank", Content = "Jump Bomb Planted!"})
              wait(2)
              bomb:Destroy()
          end
      end)
   end,
})

-- 6. SETTINGS TAB (Lock UI)
local SettingsTab = Window:CreateTab("Settings", 4483362458)
SettingsTab:CreateToggle({
   Name = "Lock Button Positions",
   CurrentValue = false,
   Callback = function(Value)
      shootBtn.Draggable = not Value
      flingMBtn.Draggable = not Value
      flingSBtn.Draggable = not Value
      shootBtn.UIStroke.Color = Value and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(255, 0, 0)
   end,
})

Rayfield:Notify({Title = "Loaded!", Content = "Exodus V2 is ready for MM2."})
