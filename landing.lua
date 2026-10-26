-- 1. Betöltjük a Rayfield keretrendszert
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- 2. Létrehozzuk az ablakot a te egyedi beállításaiddal és kulcsoddal
local Window = Rayfield:CreateWindow({
   Name = "Solara Hub",
   LoadingTitle = "Solara Hub",
   LoadingSubtitle = "by Asvyx",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SolaraHubConfig",
      FileName = "BigHub"
   },
   KeySystem = true, -- Bekapcsolt kulcsrendszer
   KeySettings = {
      Title = "Security Verification",
      Subtitle = "Key System",
      Note = "-",
      FileName = "KeyTextFile", 
      SaveKey = true, -- Elmenti a jó kulcsot, legközelebb nem kéri újra
      GrabKeyFromSite = false,
      Key = {"hackersontop"} -- A te jelszavad
   }
})

-- ====================================================================
-- SIKERES KULCS ELLENŐRZÉS: Itt fut le automatikusan a te saját kódod!
-- ====================================================================

-- Bezárjuk a Rayfield üres háttérablakát, hogy ne zavarja a saját menüdet
Rayfield:Destroy()

-- Elindítjuk a GitHub-on tárolt Solara Multitool scriptedet
loadstring(game:HttpGet("https://raw.githubusercontent.com/asywx/main/refs/heads/main/main.lua"))()
