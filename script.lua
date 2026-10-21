-- ============================================================
-- YUSUF BABAPİRO | KEY SYSTEM EDITION
-- Developer: Onur & Yusuf
-- ============================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🚀 YUSUF BABAPİRO | Special Edition",
   LoadingTitle = "Bekleyiniz Hilemiz açılıyor Developer:Onur",
   LoadingSubtitle = "by: Yusuf & Onur",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = true,
      Invite = "FDnMjx6RQ",
      RememberJoins = false
   },
   KeySystem = true,
   KeySettings = {
      Title = "🔑 YUSUF BABAPİRO | Key Sistemi",
      Subtitle = "Discord'dan key alabilirsiniz",
      Note = "Key almak için Discord: https://discord.gg/FDnMjx6RQ",
      FileName = "YusufKey",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"onurveyusufhilesinehoşgeldiniz!?", "onurveyusufhilesinehosgeldiniz!?"}
   }
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Ses Efekti
local SoundService = game:GetService("SoundService")
local function PlayClickSound()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6895079853"
        sound.Volume = 0.5
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
end

-- Key Doğrulandığında Çıkacak Bildirim
Rayfield:Notify({
   Title = "Giriş Başarılı!",
   Content = "Bekleyiniz Hilemiz açılıyor Developer:Onur",
   Duration = 5,
   Image = 4483362458,
})

-- ============================================================
-- 🏡 BROOKHAVEN TAB
-- ============================================================
local BrookhavenTab = Window:CreateTab("🏡 Brookhaven", 4483362458)

BrookhavenTab:CreateSection("🔴⚪ RGB İsim & Kıyafet Kopyalama")

local RGBNameEnabled = false
local RGBLoop = nil

BrookhavenTab:CreateToggle({
   Name = "🌈 Brookhaven RGB İsim (Rengarenk)",
   CurrentValue = false,
   Flag = "RGBNameFlag",
   Callback = function(Value)
      PlayClickSound()
      RGBNameEnabled = Value
      
      if RGBNameEnabled then
         RGBLoop = task.spawn(function()
            local hue = 0
            while RGBNameEnabled do
               hue = (hue + 0.02) % 1
               local color = Color3.fromHSV(hue, 1, 1)
               local hexColor = color:ToHex()
               local colorTag = '<font color="#' .. hexColor .. '">🔴⚪ YUSUF BABAPİRO</font>'
               
               pcall(function()
                  local args = {
                     [1] = "RPName",
                     [2] = colorTag
                  }
                  ReplicatedStorage:FindFirstChild("RE"):FindFirstChild("1RPName1Color"):FireServer(unpack(args))
               end)
               
               task.wait(0.1)
            end
         end)
      else
         if RGBLoop then task.cancel(RGBLoop) end
      end
   end,
})

local TargetOutfitUser = ""

BrookhavenTab:CreateInput({
   Name = "👤 Kıyafeti Kopyalanacak Oyuncu",
   PlaceholderText = "Kullanıcı adı yazın...",
   RemoveTextOnFocus = false,
   Callback = function(Text)
      TargetOutfitUser = Text
   end,
})

BrookhavenTab:CreateButton({
   Name = "🎭 Brookhaven Kıyafetlerini Kopyala",
   Callback = function()
      PlayClickSound()
      local targetPlr = Players:FindFirstChild(TargetOutfitUser)
      if targetPlr and targetPlr.Character and LocalPlayer.Character then
         local myChar = LocalPlayer.Character
         local targetChar = targetPlr.Character
         
         for _, v in pairs(targetChar:GetChildren()) do
            if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
               for _, old in pairs(myChar:GetChildren()) do
                  if old:IsA(v.ClassName) then
                     old:Destroy()
                  end
               end
               v:Clone().Parent = myChar
            end
         end
         
         Rayfield:Notify({
            Title = "Kıyafet Kopyalandı!",
            Content = targetPlr.Name .. " adlı oyuncunun kıyafetleri giyildi.",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "Hata",
            Content = "Oyuncu bulunamadı!",
            Duration = 3,
         })
      end
   end,
})

-- ============================================================
-- 🚀 FLY V3 & OYUNCU TAB
-- ============================================================
local PlayerTab = Window:CreateTab("🚀 Fly V3 & Oyuncu", 4483362458)

PlayerTab:CreateSection("🛸 Fly V3 (Gelişmiş Uçuş)")

local FlyV3Active = false
local FlySpeed = 70

PlayerTab:CreateToggle({
   Name = "🛸 Fly V3 Aç / Kapat",
   CurrentValue = false,
   Flag = "FlyV3Flag",
   Callback = function(Value)
      PlayClickSound()
      FlyV3Active = Value
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      local hrp = char.HumanoidRootPart
      
      if FlyV3Active then
         local bg = Instance.new("BodyGyro", hrp)
         bg.Name = "YusufFlyBG"
         bg.P = 9e4
         bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
         
         local bv = Instance.new("BodyVelocity", hrp)
         bv.Name = "YusufFlyBV"
         bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
         
         task.spawn(function()
            while FlyV3Active and char and char:FindFirstChild("HumanoidRootPart") do
               bg.cframe = Camera.CFrame
               bv.velocity = Camera.CFrame.LookVector * FlySpeed
               RunService.RenderStepped:Wait()
            end
            if hrp:FindFirstChild("YusufFlyBG") then hrp.YusufFlyBG:Destroy() end
            if hrp:FindFirstChild("YusufFlyBV") then hrp.YusufFlyBV:Destroy() end
         end)
      else
         if hrp:FindFirstChild("YusufFlyBG") then hrp.YusufFlyBG:Destroy() end
         if hrp:FindFirstChild("YusufFlyBV") then hrp.YusufFlyBV:Destroy() end
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
      FlySpeed = Value
   end,
})

PlayerTab:CreateSection("👁️ Oyuncu İzleme & TP")

local TargetSpectate = ""

PlayerTab:CreateInput({
   Name = "👥 Hedef Oyuncu Adı",
   PlaceholderText = "Kullanıcı adı...",
   RemoveTextOnFocus = false,
   Callback = function(Text)
      TargetSpectate = Text
   end,
})

local Spectating = false
PlayerTab:CreateToggle({
   Name = "📹 Oyuncunun Ekranından İzle (Spectate)",
   CurrentValue = false,
   Flag = "SpectateFlag",
   Callback = function(Value)
      PlayClickSound()
      Spectating = Value
      local targetPlr = Players:FindFirstChild(TargetSpectate)
      
      if Spectating and targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("Humanoid") then
         Camera.CameraSubject = targetPlr.Character.Humanoid
      else
         if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
         end
      end
   end,
})

PlayerTab:CreateButton({
   Name = "🌀 Oyuncunun Yanına Işınlan (TP)",
   Callback = function()
      PlayClickSound()
      local targetPlr = Players:FindFirstChild(TargetSpectate)
      if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
         if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlr.Character.
               
