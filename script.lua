-- ============================================================
-- YUSUF BABAPİRO | BROOKHAVEN & GELİŞMİŞ PLAYER EKLENTİSİ
-- ============================================================

-- Kırmızı & Beyaz Temalı Bildirim
Rayfield:Notify({
   Title = "🔴⚪ YUSUF BABAPİRO V3",
   Content = "Brookhaven & Gelişmiş Oyuncu Modülleri Yüklendi!",
   Duration = 4,
   Image = 4483362458,
})

-- 🏡 BROOKHAVEN SEKMESİ
local BrookhavenTab = Window:CreateTab("🏡 Brookhaven", 4483362458)

BrookhavenTab:CreateSection("🔴⚪ Avatar & RGB Özellikleri")

-- 1. Avatar Kopyalama (Outfit Stealer)
local TargetOutfitUser = ""

BrookhavenTab:CreateInput({
   Name = "👤 Hedef Oyuncu Adı",
   PlaceholderText = "Kullanıcı adı yazın...",
   RemoveTextOnFocus = false,
   Callback = function(Text)
      TargetOutfitUser = Text
   end,
})

BrookhavenTab:CreateButton({
   Name = "🎭 Avatarı Kopyala",
   Callback = function()
      PlayClickSound()
      local targetPlr = Players:FindFirstChild(TargetOutfitUser)
      if targetPlr and targetPlr.Character and LocalPlayer.Character then
         local localChar = LocalPlayer.Character
         local targetChar = targetPlr.Character
         
         -- Kıyafet ve Aksesuarları Kopyala
         local humanoid = localChar:FindFirstChildOfClass("Humanoid")
         if humanoid then
            local description = Players:GetHumanoidDescriptionFromUserId(targetPlr.UserId)
            humanoid:ApplyDescription(description)
         end
         
         Rayfield:Notify({
            Title = "YUSUF BABAPİRO",
            Content = targetPlr.Name .. " isimli oyuncunun avatarı kopyalandı!",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "Hata!",
            Content = "Oyuncu bulunamadı!",
            Duration = 3,
         })
      end
   end,
})

-- 2. RGB İsim Yapma
local RGBNameEnabled = false

BrookhavenTab:CreateToggle({
   Name = "🌈 RGB İsim (Rengarenk)",
   CurrentValue = false,
   Flag = "RGBNameFlag",
   Callback = function(Value)
      PlayClickSound()
      RGBNameEnabled = Value
      
      task.spawn(function()
         local hue = 0
         while RGBNameEnabled do
            hue = (hue + 0.01) % 1
            local rgbColor = Color3.fromHSV(hue, 1, 1)
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
               -- Oyuncu NameTag/Display ayarı
               char.Humanoid.DisplayName = "🔴⚪ [YUSUF BABAPİRO] " .. LocalPlayer.Name
            end
            task.wait(0.05)
         end
      end)
   end,
})

-- 🚀 FLY V3 & OYUNCU İZLEME SEKMESİ
local PlayerTab = Window:CreateTab("👥 Oyuncu & Fly V3", 4483362458)

PlayerTab:CreateSection("🛸 Fly V3 (Gelişmiş Uçuş)")

local FlyV3Enabled = false
local FlyV3Speed = 70

PlayerTab:CreateToggle({
   Name = "🔴 Fly V3 (Yumuşak & Hızlı Uçuş)",
   CurrentValue = false,
   Flag = "FlyV3Flag",
   Callback = function(Value)
      PlayClickSound()
      FlyV3Enabled = Value
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      
      if FlyV3Enabled then
         local hrp = char.HumanoidRootPart
         local bg = Instance.new("BodyGyro", hrp)
         local bv = Instance.new("BodyVelocity", hrp)
         bg.Name = "FlyV3BG"
         bv.Name = "FlyV3BV"
         bg.P = 9e4
         bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
         bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
         
         task.spawn(function()
            while FlyV3Enabled and char and char:FindFirstChild("HumanoidRootPart") do
               bg.cframe = Camera.CFrame
               bv.velocity = Camera.CFrame.LookVector * FlyV3Speed
               RunService.RenderStepped:Wait()
            end
            if hrp:FindFirstChild("FlyV3BG") then hrp.FlyV3BG:Destroy() end
            if hrp:FindFirstChild("FlyV3BV") then hrp.FlyV3BV:Destroy() end
         end)
      else
         if char.HumanoidRootPart:FindFirstChild("FlyV3BG") then char.HumanoidRootPart.FlyV3BG:Destroy() end
         if char.HumanoidRootPart:FindFirstChild("FlyV3BV") then char.HumanoidRootPart.FlyV3BV:Destroy() end
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "⚡ Fly V3 Hızı",
   Range = {20, 300},
   Increment = 10,
   Suffix = " Speed",
   CurrentValue = 70,
   Flag = "FlyV3SpeedFlag",
   Callback = function(Value)
      FlyV3Speed = Value
   end,
})

PlayerTab:CreateSection("👁️ Oyuncu İzleme & Işınlanma")

local SelectedPlayerName = ""
local Spectating = false

-- Sunucudaki oyuncuların listesi
local function GetPlayerList()
   local list = {}
   for _, p in pairs(Players:GetPlayers()) do
      if p ~= LocalPlayer then
         table.insert(list, p.Name)
      end
   end
   return list
end

local PlayerDropdown = PlayerTab:CreateDropdown({
   Name = "👤 Oyuncu Seç",
   Options = GetPlayerList(),
   CurrentOption = "",
   Flag = "PlayerSelectFlag",
   Callback = function(Option)
      if type(Option) == "table" then
         SelectedPlayerName = Option[1]
      else
         SelectedPlayerName = Option
      end
   end,
})

-- Oyuncunun ekranından izleme (Spectate)
PlayerTab:CreateToggle({
   Name = "📹 Oyuncuyu Ekranından İzle (Spectate)",
   CurrentValue = false,
   Flag = "SpectateFlag",
   Callback = function(Value)
      PlayClickSound()
      Spectating = Value
      local targetPlr = Players:FindFirstChild(SelectedPlayerName)
      
      if Spectating and targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("Humanoid") then
         Camera.CameraSubject = targetPlr.Character.Humanoid
      else
         if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
         end
      end
   end,
})

-- Seçilen Oyuncuya Işınlanma (TP)
PlayerTab:CreateButton({
   Name = "🌀 Seçilen Oyuncuya Işınlan (TP)",
   Callback = function()
      PlayClickSound()
      local targetPlr = Players:FindFirstChild(SelectedPlayerName)
      if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
         if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
            Rayfield:Notify({
               Title = "Işınlanma Başarılı!",
               Content = targetPlr.Name .. " yanına ışınlandın.",
               Duration = 3,
            })
         end
      end
   end,
})
