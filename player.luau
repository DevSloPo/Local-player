loadstring(game:HttpGet(('https://raw.githubusercontent.com/DevSloPo/Local-player/refs/heads/main/DongHua')))()
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
    Title = 'XK Hub 服务器选择',
    Footer = "作者:小玄奘",
    Icon = 97837015726495,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowCustomCursor = true,
    NotifySide = "Right",
    TabPadding = 8,
    MenuFadeTime = 0
})
local Tabs = {
    A = Window:AddTab("选择服务器", "house"),
    ["UI Settings"] = Window:AddTab("界面设置", "settings"),
}

local A = Tabs.A:AddLeftGroupbox('服务器')
local T = Tabs.A:AddRightGroupbox('通用')

A:AddButton({
    Text = "压力",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/pressure')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "被遗弃",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Forsaken')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "Chain",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Chain')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "战争大亨",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Wartycoon')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "黑暗欺骗",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Darkdeception')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "在森林中生存99夜",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/99day')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "Aut通用时间",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Aut')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "最强战场",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Tsb')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "俄亥俄州",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Ohio')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "Outdoors 户外",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/OutDoors')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "Nico nextbots",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Nico')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

A:AddButton({
    Text = "死亡之死",
    Func = function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Death%20of%20death')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})  

A:AddButton({
    Text = "种植花园",
    Func = function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/PlantingGarden')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

T:AddButton({
    Text = "通用",
    Func = function()
    loadstring(game:HttpGet(('https://github.com/DevSloPo/Main/raw/main/Universalfunction')))()
    Library:Unload()
    end,
    DoubleClick = false, 
})

local I = Tabs.A:AddRightGroupbox('脚本制作')

I:AddLabel("脚本所有者 - 小玄")

local H = Tabs.A:AddRightGroupbox('控制台')

H:AddButton({
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
    DoubleClick = true
})

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("调试功能")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "快捷菜单",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
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
