print([[
██╗  ██╗██╗  ██╗  ██╗  ██╗██╗   ██╗██████╗ 
╚██╗██╔╝██║ ██╔╝  ██║  ██║██║   ██║██╔══██╗
 ╚███╔╝ █████╔╝   ███████║██║   ██║██████╔╝
 ██╔██╗ ██╔═██╗   ██╔══██║██║   ██║██╔══██╗
██╔╝ ██╗██║  ██╗  ██║  ██║╚██████╔╝██████╔╝
╚═╝  ╚═╝╚═╝  ╚═╝  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
]])

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Name = "XKHubBlur"
BlurEffect.Parent = Lighting
BlurEffect.Size = 0

local function QuantumStringGenerator()
    local states = {
        {0xE6, 0xAC, 0xA2, 0xE8, 0xBF, 0x8E, 0xE4, 0xBD, 0xBF, 0xE7, 0x94, 0xA8, 0x58, 0x4B, 0x20, 0x48, 0x75, 0x62},
        {0xE4, 0xBD, 0x9C, 0xE8, 0x80, 0x85},
        {0xE5, 0xB0, 0x8F, 0xE7, 0x8E, 0x84},
        {0xE6, 0x94, 0xAF, 0xE6, 0x8C, 0x81, 0xE6, 0x9C, 0x8D, 0xE5, 0x8A, 0xA1, 0xE5, 0x99, 0xA8},
        {0xE5, 0x8E, 0x8B, 0xE5, 0x8A, 0x9B, 0xEF, 0xBC, 0x8C, 0xE8, 0xA2, 0xAB, 0xE9, 0x81, 0x97, 0xE5, 0xBC, 0x83},
        {0xE2, 0x9C, 0x85, 0x45, 0x53, 0x50, 0xE5, 0x88, 0xB6, 0xE4, 0xBD, 0x9C},
        {0xE8, 0x84, 0x9A, 0xE6, 0x9C, 0xAC, 0xE5, 0xB8, 0xAE, 0xE5, 0x8A, 0xA9, 0xE8, 0x80, 0x85}
    }
    local str = ""
    for _, bytes in ipairs(states) do
        for _, b in ipairs(bytes) do
            str ..= string.char(b)
        end
        str ..= "\n"
    end
    return str
end

local function PhasedPrint()
    local text = QuantumStringGenerator()
    for line in text:gmatch("[^\r\n]+") do
        print(line)
        task.wait(0.5)
    end
end

PhasedPrint()

local function ShowImage()
    local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "XKHubImageOnly"

    local logo = Instance.new("ImageLabel", gui)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    logo.Position = UDim2.new(0.5, 0, 0.5, 0)
    logo.Size = UDim2.new(0, 250, 0, 200)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://97837015726495"
    logo.ImageTransparency = 1

    TweenService:Create(BlurEffect, TweenInfo.new(1), {Size = 24}):Play()
    TweenService:Create(logo, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    task.wait(2)
    TweenService:Create(logo, TweenInfo.new(1), {ImageTransparency = 1}):Play()
    TweenService:Create(BlurEffect, TweenInfo.new(1), {Size = 0}):Play()
    task.wait(1)
    gui:Destroy()
end

ShowImage()

local function AnimateWelcome()
    local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "XKHubWelcome"

local label = Instance.new("TextLabel", gui)
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.new(0.5, 0, 0.5, 0)
label.Size = UDim2.new(0.8, 0, 0, 100)
label.Text = "XK Hub\n支持服务器: \n被遗弃 | Chain | 压力\n墨水游戏 | 战争大亨 | 黑暗欺骗丨在森林生存99天丨Nico'NextBots丨Ohio\n官方QQ:915207093"
label.BackgroundTransparency = 1
label.TextTransparency = 0  
label.TextWrapped = true
label.Font = Enum.Font.GothamSemibold
label.TextSize = 20

local rainbowColors = {
    Color3.fromRGB(255, 0, 0),   
    Color3.fromRGB(255, 165, 0),  
    Color3.fromRGB(255, 255, 0),   
    Color3.fromRGB(0, 255, 0),    
    Color3.fromRGB(0, 0, 255),  
    Color3.fromRGB(75, 0, 130),    
    Color3.fromRGB(238, 130, 238)  
}

task.spawn(function()
    while true do
        for i = 1, #rainbowColors do
            TweenService:Create(
                label,
                TweenInfo.new(0.5, Enum.EasingStyle.Linear),
                { TextColor3 = rainbowColors[i] }
            ):Play()
            task.wait(0.5)
        end
    end
end)

    TweenService:Create(BlurEffect, TweenInfo.new(1), {Size = 16}):Play()
    TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(3)
    TweenService:Create(BlurEffect, TweenInfo.new(1), {Size = 0}):Play()
    TweenService:Create(label, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(2)
    gui:Destroy()
end

AnimateWelcome()

task.defer(function()
    print("Author: Xiao Xuan Zhang")
end)

local function ShowMessage(msg, duration)
    local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = "XKHubTextUI"

    local label = Instance.new("TextLabel", gui)
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Position = UDim2.new(0.5, 0, 0.5, 0)
    label.Size = UDim2.new(0.8, 0, 0, 100)
    label.Text = msg
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.TextTransparency = 1
    label.TextWrapped = true
    label.Font = Enum.Font.RobotoCondensed
    label.TextSize = 30

    TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(duration)
    TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(0.5)
    gui:Destroy()
end

local function LoadGameScript()
    local id = game.PlaceId
    local job = game.JobId
    TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 24}):Play()
    ShowMessage("服务器检测中...\nServer: "..job, 1)

    local scripts = {
        [18687417158] = "Forsaken",
        [915207093] = "Ohio",
        [12411473842] = "pressure",
        [12552538292] = "pressure",
        [126509999114328] = "99day",
        [102181577519757] = "Darkdeception",
        [4639625707] = "Wartycoon",
        [13977939077] = "Chain", 
        [10118559731] = "Nico"
    }

    local scriptName = scripts[id] or "Universalfunction"
    ShowMessage("加载:\n"..scriptName, 3)

    local success, err = pcall(function()
        loadstring(game:HttpGet("https://github.com/DevSloPo/Main/raw/main/" .. scriptName))()
    end)
    if not success then
        
    end

    TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0}):Play()
    task.wait(0.5)
    BlurEffect:Destroy()
end

LoadGameScript()