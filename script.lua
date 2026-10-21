-- ============================================================
-- YUSUFBABAHUBCREATOR | OFFICIAL EDITION (CLEAN RAYFIELD)
-- Developers: Onur - Yusuf
-- ============================================================

local Success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not Success or not Rayfield then
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Libraries/Rayfield/main/source.lua'))()
end

local Window = Rayfield:CreateWindow({
   Name = "YUSUFBABAHUBCREATOR",
   LoadingTitle = "Developers: Onur - Yusuf",
   LoadingSubtitle = "by: YusufbabaHUBCREATOR",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Ses Efekti Yardımcısı
local SoundService = game:GetService("SoundService")
local function PlayClickSound()
    pcall(function()
        local sound =
         
