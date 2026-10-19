-- ============================================================
-- YUSUF BABAPİRO | UNIVERSAL & MM2 SCRIPT
-- ============================================================

-- UI Kütüphanesini Yükleme (Koyu Uzay Temalı)
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

-- ============================================================
-- SES EFEKTİ SİSTEMİ
-- ============================================================
local SoundService = game:GetService("SoundService")
local function PlayClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853" -- Kısa tıklama sesi
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- ============================================================
-- DEĞİŞKENLER & AYARLAR
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Hile Durumları
local Flying = false
local FlySpeed = 50
local HitboxEnabled = false
local HitboxSize = 10
local ESPEnabled = false
local SilentAimEnabled = false

-- ============================================================
-- SEKME 1: GENEL & UÇMA (UNIVERSAL)
-- ============================================================
local GeneralTab = Window:CreateTab("🌌 Genel & Uçma", 4483362458)

GeneralTab:CreateSection("Karakter Hareketleri")

-- Uçma (Fly) Toggle
local FlyToggle = GeneralTab:CreateToggle({
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

-- Uçma Hızı Slider
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

-- Hız (WalkSpeed)
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

-- ============================================================
-- SEKME 2: MURDER MYSTERY 2 (MM2)
-- ============================================================
local MM2Tab = Window:CreateTab("🔪 Murder Mystery 2", 4483362458)

MM2Tab:CreateSection("Rol Tabanlı ESP (Katil/Şerif/Masum)")

-- Rol Bulma Fonksiyonu
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

-- ESP Rengi
local function GetRoleColor(role)
   if role == "Katil" then
      return Color3.fromRGB(255, 0, 0) -- Kırmızı
   elseif role == "Şerif" then
      return Color3.fromRGB(0, 150, 255) -- Mavi
   else
      return Color3.fromRGB(0, 255, 0) -- Yeşil (Masum)
   end
end

-- ESP Döngüsü
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

-- Hitbox Genişletici
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

-- Silent Aim (Sessiz Nişan)
MM2Tab:CreateToggle({
   Name = "🔫 Silent Aim (Otomatik İsabet)",
   CurrentValue = false,
   Flag = "SilentAimFlag",
   Callback = function(Value)
      PlayClickSound()
      SilentAimEnabled = Value
   end,
})

-- Silent Aim Raycast Hooking Logic
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall

gmt.__namecall = newcclosure(function(self, ...)
   local args = {...}
   local method = getnamecallmethod()
   
   if SilentAimEnabled and (method == "FindPartOnRayWithIgnoreList" or method == "Raycast") then
      for _, plr in pairs(Players:GetPlayers()) do
         if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetMM2Role(plr)
            if role == "Katil" or GetMM2Role(LocalPlayer) == "Katil" then
               if method == "FindPartOnRayWithIgnoreList" then
                  args[1] = Ray.new(Camera.CFrame.Position, (plr.Character.HumanoidRootPart.Position - Camera.CFrame.Position).Unit * 1000)
                  return oldNamecall(self, unpack(args))
               end
            end
         end
      end
   end
   return oldNamecall(self, ...)
end)

Rayfield:Notify({
   Title = "YUSUF BABAPİRO Yüklendi!",
   Content = "Hile paneli başarıyla aktif edildi. İyi oyunlar!",
   Duration = 5,
   Image = 4483362458,
})
