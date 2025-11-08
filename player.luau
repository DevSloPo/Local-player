loadstring(game:HttpGet(('https://raw.githubusercontent.com/DevSloPo/Local-player/refs/heads/main/DongHua')))()
local XKHub = loadstring(game:HttpGet(('https://raw.githubusercontent.com/DevSloPo/Notification/refs/heads/main/Source.lua')))()

local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true 
Library.ShowCustomCursor = true
Library.NotifySide = "Right"

local Window = Library:CreateWindow({
    Title = '服务器选择     ',
    Footer = "XK Hub",
    Icon = 130580192237985,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    NotifySide = "Right",
    TabPadding = 8,
    MenuFadeTime = 0
})
local Tabs = {
    B = Window:AddTab("玩家", "users"),
    I = Window:AddTab("主要", "house"),
    ["UI Settings"] = Window:AddTab("界面设置", "palette")
}
local J = Tabs.I:AddLeftGroupbox('选择执行服务器')

local HomeGroup = Tabs.B:AddLeftGroupbox("欢迎")
local TY = Tabs.I:AddLeftGroupbox('通用')
local K = Tabs.I:AddLeftGroupbox('其他')
local LOL = Tabs.I:AddRightGroupbox('聊天功能')
local FWQ = Tabs.I:AddRightGroupbox('支持服务器')

LOL:AddToggle('秒互动', {
    Text = '显示聊天框',
    Default = false,
    Callback = function(state)
     if state then
    game.TextChatService.ChatWindowConfiguration.Enabled = true
    else
    game.TextChatService.ChatWindowConfiguration.Enabled = false    
    end
    end
})
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarThumbnail"
avatarImage.Size = UDim2.new(0, 220, 0, 220)
avatarImage.Position = UDim2.new(0.5, -90, 0, 10)
avatarImage.Image = "rbxassetid://0" 
avatarImage.BackgroundTransparency = 1
avatarImage.BorderSizePixel = 0
avatarImage.ScaleType = Enum.ScaleType.Fit
if HomeGroup.Container then
    avatarImage.Parent = HomeGroup.Container
elseif HomeGroup.Frame then
    avatarImage.Parent = HomeGroup.Frame
else
    avatarImage.Parent = HomeGroup 
end

spawn(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    if not player then
        repeat 
            task.wait(0.1) 
            player = Players.LocalPlayer
        until player
    end
    
    task.wait(1)
    
    local success, thumbnail = pcall(function()
        return Players:GetUserThumbnailAsync(
            player.UserId, 
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size180x180
        )
    end)
    
    if success and thumbnail then
        print("Successfully loaded avatar thumbnail")
        avatarImage.Image = thumbnail
    else
        warn("Failed to load avatar thumbnail: " .. tostring(thumbnail))
        
        local alternatives = {
            Enum.ThumbnailType.AvatarThumbnail,
            Enum.ThumbnailType.AvatarBust,
            Enum.ThumbnailType.Avatar
        }
        
        for i, thumbnailType in ipairs(alternatives) do
            local altSuccess, altThumbnail = pcall(function()
                return Players:GetUserThumbnailAsync(
                    player.UserId, 
                    thumbnailType,
                    Enum.ThumbnailSize.Size180x180
                )
            end)
            
            if altSuccess and altThumbnail then
                print("Loaded alternative thumbnail type: " .. tostring(thumbnailType))
                avatarImage.Image = altThumbnail
                break
            else
                warn("Alternative " .. i .. " failed: " .. tostring(altThumbnail))
            end
        end
    end
end)
HomeGroup:AddButton("", function()

end)


local ChangelogsGroup = Tabs.B:AddRightGroupbox("关于")
ChangelogsGroup:AddLabel('<font color="rgb(255,215,0)">制作者: Dev 小玄</font>')
ChangelogsGroup:AddLabel('<font color="rgb(255,0,0)">🔥XK Hub🔥</font>')
ChangelogsGroup:AddLabel('<font color="rgb(255,100,100)">脚本暂时只有我一个人制作，并且bug较多💔</font>')
ChangelogsGroup:AddLabel('<font color="rgb(100,255,100)">功能也有很多缺陷，我会努力的✨</font>')
ChangelogsGroup:AddLabel('<font color="rgb(100,200,255)">将来我可能会结识一些人制作脚本🎉</font>')
ChangelogsGroup:AddLabel('<font color="rgb(200,100,255)">感谢你一直以来的支持😒</font>')



local AH = Tabs.B:AddRightGroupbox('群组💬')

AH:AddButton({
	Text = "复制QQ群聊[主群]",
	Func = function()
		setclipboard("915207093")
	end,
})

AH:AddButton({
	Text = "复制群聊[二群]",
	Func = function()
		setclipboard("685243242")
	end,
})

AH:AddButton({
	Text = "复制群聊[三群]",
	Func = function()
		setclipboard("1063263540")
	end,
})

AH:AddButton({
	Text = "复制群聊[解卡]",
	Func = function()
		setclipboard("1033392207")
	end,
})


local NB = Tabs.I:AddLeftGroupbox('脚本信息:')

NB:AddLabel('<font color="rgb(255,100,0)">🔥此脚本创立于2024年6月份🔥</font>')
NB:AddLabel('<font color="rgb(100,255,100)">如果你想一起和我制作XK Hub😳</font>')
NB:AddLabel('<font color="rgb(100,200,255)">我们很欢迎你来找我👍🏻</font>')
NB:AddLabel('<font color="rgb(200,100,255)">或者帮助/支持我们Doors👁️</font>')
J:AddDropdown("ScriptSelector", {
    Values = {
        "压力",
        "被遗弃", 
        "Chain",
        "战争大亨",
        "黑暗欺骗",
        "在森林中生存99夜",
        "Aut通用时间",
        "最强战场",
        "俄亥俄州",
        "Nico nextbots",
        "死亡之死",
        "种植花园",
        "暴力区",
        "植物VS大脑机器人",
        "破坏者谜团2",
        "DOORS",
        "死铁轨",
        "Fisch",
        "菜鸟必须死",
        "恶魔学",
        "Garden Tower Defense",
        "刀刃球"
    },
    Default = 1,
    Multi = false,
    Text = "选择脚本",
    Tooltip = "选择要执行的脚本",
    Callback = function(Value)
        _G.SelectedScript = Value
    end
})

J:AddButton({
    Text = "执行脚本",
    Func = function()
        if _G.SelectedScript then
            local scriptUrls = {
                ["压力"] = 'https://github.com/DevSloPo/Main/raw/main/pressure',
                ["被遗弃"] = 'https://github.com/DevSloPo/Main/raw/main/Forsaken',
                ["Chain"] = 'https://github.com/DevSloPo/Main/raw/main/Chain',
                ["战争大亨"] = 'https://github.com/DevSloPo/Main/raw/main/Wartycoon',
                ["黑暗欺骗"] = 'https://github.com/DevSloPo/Main/raw/main/Darkdeception',
                ["在森林中生存99夜"] = 'https://github.com/DevSloPo/Main/raw/main/99day',
                ["Aut通用时间"] = 'https://github.com/DevSloPo/Main/raw/main/Aut',
                ["最强战场"] = 'https://github.com/DevSloPo/Main/raw/main/Tsb',
                ["俄亥俄州"] = 'https://github.com/DevSloPo/Main/raw/main/Ohio',
                ["Nico nextbots"] = 'https://github.com/DevSloPo/Main/raw/main/Nico',
                ["死亡之死"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Death%20of%20death',
                ["种植花园"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/PlantingGarden',
                ["暴力区"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Violent',
                ["植物VS大脑机器人"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/BrainRobot',
                ["破坏者谜团2"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/MM2',
                ["DOORS"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/DOORS',
                ["死铁轨"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/DeadRail',
                ["Fisch"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Fisch',
                ["菜鸟必须死"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/NoobMostdie',
                ["恶魔学"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Demonology',
                ["Garden Tower Defense"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/GardenTowerDefense',
                ["刀刃球"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Bladeball'
            }
            
            local url = scriptUrls[_G.SelectedScript]
            if url then
                local startTime = tick()
                XKHub:Notification("脚本启动", "正在加载: " .. _G.SelectedScript, 3)
                loadstring(game:HttpGet(url))()
                local endTime = tick()
                local loadTime = string.format("%.2f", endTime - startTime)
                XKHub:Notification("加载完成", _G.SelectedScript .. " 执行成功! 耗时: " .. loadTime .. "秒", 5)
            else
                XKHub:Notification("错误", "未找到脚本URL: " .. _G.SelectedScript, 3)
            end
        else
            XKHub:Notification("提示", "请先选择一个脚本", 3)
        end
    end,
    DoubleClick = false,
    Tooltip = "执行选中的脚本"
})

J:AddButton({
    Text = "复制加载代码",
    Func = function()
        if _G.SelectedScript then
            local scriptUrls = {
                ["压力"] = 'https://github.com/DevSloPo/Main/raw/main/pressure',
                ["被遗弃"] = 'https://github.com/DevSloPo/Main/raw/main/Forsaken',
                ["Chain"] = 'https://github.com/DevSloPo/Main/raw/main/Chain',
                ["战争大亨"] = 'https://github.com/DevSloPo/Main/raw/main/Wartycoon',
                ["黑暗欺骗"] = 'https://github.com/DevSloPo/Main/raw/main/Darkdeception',
                ["在森林中生存99夜"] = 'https://github.com/DevSloPo/Main/raw/main/99day',
                ["Aut通用时间"] = 'https://github.com/DevSloPo/Main/raw/main/Aut',
                ["最强战场"] = 'https://github.com/DevSloPo/Main/raw/main/Tsb',
                ["俄亥俄州"] = 'https://github.com/DevSloPo/Main/raw/main/Ohio',
                ["Nico nextbots"] = 'https://github.com/DevSloPo/Main/raw/main/Nico',
                ["死亡之死"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Death%20of%20death',
                ["种植花园"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/PlantingGarden',
                ["暴力区"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Violent',
                ["植物VS大脑机器人"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/BrainRobot',
                ["破坏者谜团2"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/MM2',
                ["DOORS"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/DOORS',
                ["死铁轨"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/DeadRail',
                ["Fisch"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Fisch',
                ["菜鸟必须死"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/NoobMostdie',
                ["恶魔学"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Demonology',
                ["Garden Tower Defense"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/GardenTowerDefense',
                ["刀刃球"] = 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Bladeball'
            }
            
            local url = scriptUrls[_G.SelectedScript]
            if url then
                local loadCode = 'loadstring(game:HttpGet("' .. url .. '"))()'
                if setclipboard then
                    setclipboard(loadCode)
                    XKHub:Notification("复制成功", "已复制 " .. _G.SelectedScript .. " 的加载代码", 3)
                else
                    XKHub:Notification("错误", "复制功能不可用", 3)
                end
            else
                XKHub:Notification("错误", "未找到脚本URL: " .. _G.SelectedScript, 3)
            end
        else
            XKHub:Notification("提示", "请先选择一个脚本", 3)
        end
    end,
    DoubleClick = false,
    Tooltip = "复制选中脚本的完整加载代码"
})
TY:AddLabel('<font color="rgb(255,0,0)">子追版会被部分服务器踢出</font>')
TY:AddButton({
    Text = "子追版 通用",
    Func = function()
        local startTime = tick()
        XKHub:Notification("脚本加载", "正在加载通用脚本...", 3)
        loadstring(game:HttpGet('https://github.com/DevSloPo/Main/raw/main/UNT'))()
        local endTime = tick()
        local loadTime = string.format("%.2f", endTime - startTime)
        XKHub:Notification("加载成功", "通用脚本加载完成！耗时: " .. loadTime .. "秒", 5)
    end,
    DoubleClick = false, 
})
TY:AddButton({
    Text = "无子追版 通用",
    Func = function()
        local startTime = tick()
        XKHub:Notification("脚本加载", "正在加载通用脚本...", 3)
        loadstring(game:HttpGet('https://github.com/DevSloPo/Main/raw/main/Universalfunction2'))()
        local endTime = tick()
        local loadTime = string.format("%.2f", endTime - startTime)
        XKHub:Notification("加载成功", "通用脚本加载完成！耗时: " .. loadTime .. "秒", 5)
    end,
    DoubleClick = false, 
})
K:AddButton({
    Text = "删除 用户界面",
    Func = function()
    Library:Unload()
    end,
    DoubleClick = false, 
})

K:AddButton({
    Text = "控制台命令",
    Func = function()
        local function GetChatService()
            if game:GetService("TextChatService"):FindFirstChild("TextChannels") then
                return game:GetService("TextChatService").TextChannels.RBXGeneral
            elseif game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then
                return game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
            end
            return nil
        end

        local function SafeSendMessage(message)
            local chatService = GetChatService()
            if not chatService then return false end
            
            if not message or #message < 1 then
                return false
            end

            local success, result = pcall(function()
                if chatService:IsA("TextChannel") then
                    return chatService:SendAsync(message)
                else
                    chatService:FireServer(message, "All")
                    return true
                end
            end)
            
            return success and result
        end

        SafeSendMessage("/console")
    end,
    DoubleClick = false
})
FWQ:AddLabel('<font color="rgb(0,255,0)">压力</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">被遗弃</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">Chain</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">战争大亨</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">黑暗欺骗</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">在森林中生存99夜</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">Aut通用时间</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">最强战场</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">俄亥俄州</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">Nico nextbots</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">死亡之死</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">种植花园</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">暴力区</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">植物VS大脑机器人</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">破坏者谜团2</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">DOORS</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">死铁轨</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">Fisch</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">菜鸟必须死</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">恶魔学</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">Garden Tower Defense</font>')
FWQ:AddLabel('<font color="rgb(0,255,0)">刀刃球</font>')
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("调试功能")

MenuGroup:AddCheckbox("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "快捷菜单",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddCheckbox("ShowCustomCursor", {
    Text = "自定义光标",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = { "左", "右" },
    Default = "右",
    Text = "通知位置",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "25%", "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "UI大小",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddDivider()  
MenuGroup:AddLabel("Menu bind")  
    :AddKeyPicker("MenuKeybind", { 
        Default = "RightShift",  
        NoUI = true,            
        Text = "Menu keybind"    
    })

MenuGroup:AddButton("删除UI", function()
    Library:Unload()  
end)

ThemeManager:SetLibrary(Library)  
SaveManager:SetLibrary(Library)   
SaveManager:IgnoreThemeSettings() 

SaveManager:SetIgnoreIndexes({ "MenuKeybind" })  
ThemeManager:SetFolder("MyScriptHub")            
SaveManager:SetFolder("MyScriptHub/specific-game")  
SaveManager:SetSubFolder("specific-place")       
SaveManager:BuildConfigSection(Tabs["UI Settings"])  

ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()