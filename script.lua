-- ============================================================
-- YUSUF BABAPİRO | ÖZEL PANEL (RED & WHITE THEME)
-- by: Yusuf
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Varolan Eski Paneli Temizle
if game:GetService("CoreGui"):FindFirstChild("YusufBabapiroGui") then
    game:GetService("CoreGui").YusufBabapiroGui:Destroy()
end

-- ============================================================
-- GUI OLUŞTURMA (Rayfield Yok - Kendi Özel Panelimiz)
-- ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YusufBabapiroGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Açma / Kapama Butonu (Ekranın Sol Üstünde)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60) -- Kırmızı
ToggleBtn.Position = UDim2.new(0, 10, 0.3, 0)
ToggleBtn.Size = UDim2.new(0, 110, 0, 35)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "🔴 MENÜ"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 16
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- Ana Çerçeve (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 480, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(220, 20, 60) -- Kırmızı Dekor Çizgisi
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Başlık Çubuğu
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TopBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Text = "🚀 YUSUF BABAPİRO  |  by: Yusuf"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Kapat Butonu (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(0.9, 0, 0, 0)
CloseBtn.Size = UDim2.new(0.1, 0, 1, 0)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleBtn.MouseButton1Click
-- ============================================================
-- YUSUF BABAPİRO | UNIVERSAL & MM2 SCRIPT
-- ============================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🚀 YUSUF BABAPİRO | Universal & MM2",
   LoadingTitle = "YUSUF BABAPİRO Yükleniyor...",
   LoadingSubtitle = "by Yusuf",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "YusufBabapiroConfig",
      FileName = "SpaceScript"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

local SoundService = game:GetService("SoundService")
local function PlayClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853"
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Flying = false
local FlySpeed = 50
local HitboxEnabled = false
local HitboxSize = 10
local ESPEnabled = false
local SilentAimEnabled = false

local GeneralTab = Window:CreateTab("🌌 Genel & Uçma", 4483362458)

GeneralTab:CreateSection("Karakter Hareketleri")

GeneralTab:CreateToggle({
   Name = "🛸 Uçma (Fly)",
   CurrentValue = false,
   Flag = "FlyFlag",
   Callback = function(Value)
      PlayClickSound()
      Flying = Value
      local Char = LocalPlayer.Character
      if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
      
      if Flying then
         local BodyVelocity = Instance.new("BodyVelocity")
         BodyVelocity.Name = "SpaceFlyBV"
         BodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
         BodyVelocity.Velocity = Vector3.zero
         BodyVelocity.Parent = Char.HumanoidRootPart

         local BodyGyro = Instance.new("BodyGyro")
         BodyGyro.Name = "SpaceFlyBG"
         BodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
         BodyGyro.CFrame = Char.HumanoidRootPart.CFrame
         BodyGyro.Parent = Char.HumanoidRootPart

         task.spawn(function()
            while Flying and Char:FindFirstChild("HumanoidRootPart") do
               local MoveDir = Char.Humanoid.MoveDirection
               BodyVelocity.Velocity = (Camera.CFrame.LookVector * (MoveDir.Z * -1) + Camera.CFrame.RightVector * MoveDir.X) * FlySpeed
               BodyGyro.CFrame = Camera.CFrame
               RunService.RenderStepped:Wait()
            end
            if Char.HumanoidRootPart:FindFirstChild("SpaceFlyBV") then Char.HumanoidRootPart.SpaceFlyBV:Destroy() end
            if Char.HumanoidRootPart:FindFirstChild("SpaceFlyBG") then Char.HumanoidRootPart.SpaceFlyBG:Destroy() end
         end)
      else
         if Char.HumanoidRootPart:FindFirstChild("SpaceFlyBV") then Char.HumanoidRootPart.SpaceFlyBV:Destroy() end
         if Char.HumanoidRootPart:FindFirstChild("SpaceFlyBG") then Char.HumanoidRootPart.SpaceFlyBG:Destroy() end
      end
   end,
})

GeneralTab:CreateSlider({
   Name = "⚡ Uçma Hızı",
   Range = {10, 200},
   Increment = 5,
   Suffix = " Hız",
   CurrentValue = 50,
   Flag = "FlySpeedFlag",
   Callback = function(Value)
      FlySpeed = Value
   end,
})

GeneralTab:CreateSlider({
   Name = "🏃 Yürüme Hızı",
   Range = {16, 150},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedFlag",
   Callback = function(Value)
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local MM2Tab = Window:CreateTab("🔪 Murder Mystery 2", 4483362458)

MM2Tab:CreateSection("Rol Tabanlı ESP")

local function GetMM2Role(player)
   if not player.Character then return "Masum" end
   local backpack = player:FindFirstChild("Backpack")
   local char = player.Character

   if (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) then
      return "Katil"
   elseif (backpack and backpack:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun")) then
      return "Şerif"
   end
   return "Masum"
end

local function GetRoleColor(role)
   if role == "Katil" then
      return Color3.fromRGB(255, 0, 0)
   elseif role == "Şerif" then
      return Color3.fromRGB(0, 150, 255)
   else
      return Color3.fromRGB(0, 255, 0)
   end
end

MM2Tab:CreateToggle({
   Name = "👁️ Rol ESP (Kırmızı/Mavi/Yeşil)",
   CurrentValue = false,
   Flag = "ESPFlag",
   Callback = function(Value)
      PlayClickSound()
      ESPEnabled = Value
      
      task.spawn(function()
         while ESPEnabled do
            for _, plr in pairs(Players:GetPlayers()) do
               if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                  local highlight = plr.Character:FindFirstChild("SpaceESP")
                  if not highlight then
                     highlight = Instance.new("Highlight")
                     highlight.Name = "SpaceESP"
                     highlight.FillTransparency = 0.5
                     highlight.OutlineTransparency = 0
                     highlight.Parent = plr.Character
                  end
                  
                  local role = GetMM2Role(plr)
                  local color = GetRoleColor(role)
                  highlight.FillColor = color
                  highlight.OutlineColor = color
               end
            end
            task.wait(1)
         end
         
         for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("SpaceESP") then
               plr.Character.SpaceESP:Destroy()
            end
         end
      end)
   end,
})

MM2Tab:CreateSection("Combat & Hitbox")

MM2Tab:CreateToggle({
   Name = "🎯 Hitbox Büyütücü",
   CurrentValue = false,
   Flag = "HitboxFlag",
   Callback = function(Value)
      PlayClickSound()
      HitboxEnabled = Value
      
      task.spawn(function()
         while HitboxEnabled do
            for _, plr in pairs(Players:GetPlayers()) do
               if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                  local hrp = plr.Character.HumanoidRootPart
                  hrp.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                  hrp.Transparency = 0.7
                  hrp.BrickColor = BrickColor.new("Really red")
                  hrp.Material = Enum.Material.Neon
                  hrp.CanCollide = false
               end
            end
            task.wait(0.5)
         end
         
         for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
               local hrp = plr.Character.HumanoidRootPart
               hrp.Size = Vector3.new(2, 2, 1)
               hrp.Transparency = 1
            end
         end
      end)
   end,
})

MM2Tab:CreateSlider({
   Name = "📏 Hitbox Boyutu",
   Range = {2, 30},
   Increment = 1,
   Suffix = " Studs",
   CurrentValue = 10,
   Flag = "HitboxSizeFlag",
   Callback = function(Value)
      HitboxSize = Value
   end,
})

Rayfield:Notify({
   Title = "YUSUF BABAPİRO Yüklendi!",
   Content = "Hile paneli başarıyla aktif edildi. İyi oyunlar!",
   Duration = 5,
   Image = 4483362458,
})
