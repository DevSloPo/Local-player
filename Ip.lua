local repo = 'https://raw.githubusercontent.com/DevSloPo/obsidian_UI/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local function ShowScriptLoadedNotification(scriptName, loadTime)
	Library:Notify({
		Title = "XoneScriptK Hub丨警告",
		Description = scriptName .. "加载完成丨共耗时: " .. string.format("%.2f", loadTime) .. "秒",
		Time = 6
	})
	local s = Instance.new("Sound", game.SoundService)
	s.SoundId = "rbxassetid://4590662766"
	s.Volume = 5
	s:Play()
	s.Ended:Wait()
	s:Destroy()
end

local function LoadScript(scriptName, url)
	local startTime = tick()
	loadstring(game:HttpGet(url))()
	ShowScriptLoadedNotification(scriptName, tick() - startTime)
end

local function httpget(nm, url)
	local t0 = tick()
	local ok, src = pcall(function() return game:HttpGet(url) end)
	if not ok or not src or src == "" then
		Library:Notify({Title = "XoneScriptK Hub丨错误", Description = nm .. " 获取失败，请检查网络", Time = 6})
		return false
	end
	local f, ce = loadstring(src)
	if not f then
		Library:Notify({Title = "XoneScriptK Hub丨错误", Description = nm .. " 编译失败: " .. tostring(ce), Time = 6})
		return false
	end
	local ok2, re = pcall(f)
	local dt = tick() - t0
	if ok2 then
		Library:Notify({Title = "XoneScriptK Hub丨通用", Description = nm .. " 加载完成丨共耗时: " .. string.format("%.2f", dt) .. "秒", Time = 6})
		task.spawn(function()
			pcall(function()
				local s = Instance.new("Sound", game.SoundService)
				s.SoundId = "rbxassetid://4590662766"
				s.Volume = 5
				s:Play()
				s.Ended:Wait()
				s:Destroy()
			end)
		end)
		return true
	end
	Library:Notify({Title = "XoneScriptK Hub丨错误", Description = nm .. " 运行失败: " .. tostring(re), Time = 6})
	return false
end

local LP = game.Players.LocalPlayer
local MS = game:GetService("MarketplaceService")
local Win = Library:CreateWindow({
	Title = "XK脚本 (zh-cn🇨🇳)",
	Footer = LP.Name .. " | " .. MS:GetProductInfo(game.PlaceId).Name,
	Icon = 136469174415866,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

local Tabs = {
	A = Win:AddTab({Name = "首页", Description = "[主要群聊:915207093]", Icon = "layout-dashboard"}),
	B = Win:AddTab({Name = "基本功能", Description = "基本功能", Icon = "bug"}),
	["UI Settings"] = Win:AddTab({Name = "界面设置", Description = "配置与界面设置", Icon = "settings"}),
	D = Win:AddTab({Name = "全部人员", Description = "感谢人员与制作者展示", Icon = "handshake"}),
	C = Win:AddTab({Name = "插件", Description = "XK Hub的插件功能", Icon = "boxes"})
}

local C = Tabs.B:AddLeftGroupbox("服务器", "globe")
local A = Tabs.B:AddLeftGroupbox("加载服务器", "download")
local H = Tabs.B:AddLeftGroupbox("工具", "tool")
local I = Tabs.B:AddLeftGroupbox("远程事件", "zap")
local D = Tabs.B:AddRightGroupbox("部分功能", "sliders")
local E = Tabs.B:AddRightGroupbox("其余", "more-horizontal")
local F = Tabs.B:AddRightGroupbox("用户界面", "monitor")

Tabs.D:UpdateWarningBox({Title = '<font color="rgb(0,255,0)">更新公告</font>', Text = '1.主页UI更换\n2.CHAIN全面翻新\n3.更新新版通用 全面与简版已废弃 子弹追踪已废弃', IsNormal = true, Visible = true, LockSize = true})

local P = Tabs.D:AddLeftGroupbox("主要开发者", "wrench")

P:AddLabel("OwnerLabel", {Text = "[<font color='#00E600'>小玄</font>] 所有者/创始人丨Founde & Owner", DoesWrap = true})
P:AddLabel("OwnerLabel", {Text = "[<font color='#00E600'>古明地恋</font>] 现任开发丨Owner", DoesWrap = true})
P:AddLabel("Helper2", {Text = "[<font color='#00E600'>YirdeX</font>] 英文版作者兼第三任开发 l Develop", DoesWrap = true})
P:AddLabel("DevLabel", {Text = "[<font color='#00FF00'>XK Hub</font>] 开发商丨Developer", DoesWrap = true})

local W = Tabs.D:AddLeftGroupbox("开发者&帮助者", "handshake")
W:AddLabel("Helper4", {Text = "[<font color='#00E600'>伊斯兰·Red eyes</font>] 制作 内脏与黑火药 服务器", DoesWrap = true})
W:AddLabel("Helper4", {Text = "[<font color='#00E600'>JackEyeKL</font>] 制作 插件 功能", DoesWrap = true})
W:AddLabel("Helper1", {Text = "[<font color='#00E600'>Yuxingchen</font>] 协助Forsaken & Violent 功能", DoesWrap = true})
W:AddLabel("Helper2", {Text = "[<font color='#00E600'>Kanl</font>] 协助 Chain 功能", DoesWrap = true})
W:AddLabel("Helper3", {Text = "[<font color='#00E600'>du8</font>] 协助 Flick 功能", DoesWrap = true})
W:AddLabel("Helper4", {Text = "[<font color='#00E600'>江砚辰</font>] 协助 亡命速递 服务器", DoesWrap = true})

local R = Tabs.D:AddRightGroupbox("感谢名单", "wrench")
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>YirdeX</font>] 海外宣传者", DoesWrap = true})
R:AddDivider()
R:AddLabel('以下皆为快手平台宣传')
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>Bleda</font>] 协助 宣传 脚本", DoesWrap = true})
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>小玄蛋</font>] 协助 宣传 脚本", DoesWrap = true})
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>雾化</font>] 协助 宣传 闪光", DoesWrap = true})
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>小橙</font>] 协助 宣传 闪光", DoesWrap = true})
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>杨间</font>] 协助 宣传 Forsaken", DoesWrap = true})
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>谢白</font>] 协助 脚本 宣传", DoesWrap = true})
R:AddLabel("Helper2", {Text = "以下为哔哩哔哩宣传", DoesWrap = true})
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>Roblox_周瑜</font>] 协助 脚本宣传", DoesWrap = true})
R:AddLabel("Helper2", {Text = "[<font color='#00E600'>Seekdam大跌</font>] 协助 脚本宣传", DoesWrap = true})

local HomeGroup = Tabs.A:AddLeftGroupbox("信息", "users")
local L = Tabs.A:AddRightGroupbox("官方", "box")
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarThumbnail"
avatarImage.Size = UDim2.new(0, 220, 0, 220)
avatarImage.Position = UDim2.new(0.5, -90, 0, 10)
avatarImage.Image = "rbxassetid://0"
avatarImage.BackgroundTransparency = 1
avatarImage.BorderSizePixel = 0
avatarImage.ScaleType = Enum.ScaleType.Fit
if HomeGroup.Container then avatarImage.Parent = HomeGroup.Container elseif HomeGroup.Frame then avatarImage.Parent = HomeGroup.Frame else avatarImage.Parent = HomeGroup end

spawn(function()
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	if not player then repeat task.wait(0.1) player = Players.LocalPlayer until player end
	task.wait(1)
	local success, thumbnail = pcall(function() return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420) end)
	if success and thumbnail then
		avatarImage.Image = thumbnail
	else
		for _, t in ipairs({Enum.ThumbnailType.AvatarBust, Enum.ThumbnailType.Avatar, Enum.ThumbnailType.HeadShot}) do
			local ok, img = pcall(function() return Players:GetUserThumbnailAsync(player.UserId, t, Enum.ThumbnailSize.Size420x420) end)
			if ok and img then avatarImage.Image = img break end
		end
	end
end)

HomeGroup:AddDivider()
HomeGroup:AddLabel('用户名: ' .. game.Players.LocalPlayer.Name)
HomeGroup:AddLabel('HWID: ' .. game:GetService("RbxAnalyticsService"):GetClientId())
local startTime = os.time()
local usageLabel = HomeGroup:AddLabel('使用时间 <font color="rgb(255,0,0)">0</font> 分钟')
spawn(function()
	while task.wait(60) do
		usageLabel:SetText('使用时间  <font color="rgb(0,255,0)">' .. math.floor((os.time() - startTime) / 60) .. '</font> 分钟')
	end
end)

local function getTimeGreeting()
	local hour = os.date("*t").hour
	if hour >= 5 and hour < 12 then return "上午" elseif hour >= 12 and hour < 18 then return "下午" else return "晚上" end
end

L:AddLabel('欢迎 <font color="rgb(0,255,0)">' .. game.Players.LocalPlayer.Name .. '</font> ' .. getTimeGreeting() .. '好')
local timeLabel = L:AddLabel('<font color="rgb(0,255,0)">' .. os.date("%Y-%m-%d %H:%M:%S") .. '</font>')
spawn(function()
	while task.wait(1) do
		timeLabel:SetText('<font color="rgb(0,255,0)">' .. os.date("%Y-%m-%d %H:%M:%S") .. '</font>')
	end
end)

L:AddDivider()
local MyButton = L:AddButton({Text = "QQ群聊", Func = function() setclipboard("QQ群:915207093") end})
local MyButton2 = MyButton:AddButton({Text = "Discord", Func = function() setclipboard("https://discord.gg/8pZRpKHtzA") end})

local TabBoxA = Tabs.A:AddRightTabbox()
local N = TabBoxA:AddTab("信息")
local K = TabBoxA:AddTab("服务器状态")
K:AddLabel('🟢监狱人生'); K:AddLabel('🟢Forsaken'); K:AddLabel('🟢死亡之死'); K:AddLabel('🟢CHAIN'); K:AddLabel('🟢DOORS'); K:AddLabel('🟢暴力区'); K:AddLabel('🟢压力'); K:AddLabel('🟢闪光'); K:AddLabel('🟡在森林中生存99夜'); K:AddLabel('🟡最坚强的战场'); K:AddLabel('🟡🔴命运的毁灭'); K:AddLabel('⚪破坏者谜团2'); K:AddLabel('⚪菜鸟必须死'); K:AddLabel('⚪刀刃球'); K:AddLabel('⚪Criminality')
N:AddLabel('🟢正常运行'); N:AddLabel('🟡存在bug/预计更新'); N:AddLabel('🔴停止使用/维护中'); N:AddLabel('⚪停止更新')

H:AddButton({Text = "InfiniteYield[旧版]", Func = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end})
H:AddButton({Text = "Dex[旧版]", Func = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DevSloPo/DVES/refs/heads/main/Moon-dex.lua"))() end})
H:AddButton({Text = "动画管理器[旧版]", Func = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Tool/AnimationSpy"))() end})
H:AddButton({Text = "模型工具", Func = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Tool/Model-Tool"))() end})

I:AddButton({Text = "Cobalt[旧版]", Func = function() loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))() end})
I:AddButton({Text = "Remote Spy[旧版]", Func = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/spy%E6%B1%89%E5%8C%96%20(1).txt"))() end})

D:AddToggle('秒互动', {Text = '显示聊天框', Default = false, Callback = function(state) if state then game.TextChatService.ChatWindowConfiguration.Enabled = true else game.TextChatService.ChatWindowConfiguration.Enabled = false end end})

local stepPlatform = nil
local deathConnection = nil

D:AddToggle("MyToggle1", {Text = "踏空 [请搭配快捷菜单使用]", Default = false, Callback = function(Value)
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	if Value then
		if stepPlatform then stepPlatform:Destroy() end
		stepPlatform = Instance.new("Part")
		stepPlatform.Name = "StepPlatform"
		stepPlatform.Size = Vector3.new(10000, 1, 10000)
		stepPlatform.Position = character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
		stepPlatform.Anchored = true
		stepPlatform.CanCollide = true
		stepPlatform.Material = Enum.Material.SmoothPlastic
		stepPlatform.Transparency = 1
		stepPlatform.BrickColor = BrickColor.new("Medium stone grey")
		stepPlatform.TopSurface = Enum.SurfaceType.Smooth
		stepPlatform.BottomSurface = Enum.SurfaceType.Smooth
		stepPlatform.Parent = workspace
		if deathConnection then deathConnection:Disconnect() end
		deathConnection = character.Humanoid.Died:Connect(function()
			if stepPlatform then stepPlatform:Destroy() stepPlatform = nil end
			if deathConnection then deathConnection:Disconnect() deathConnection = nil end
		end)
	else
		if stepPlatform then stepPlatform:Destroy() stepPlatform = nil end
		if deathConnection then deathConnection:Disconnect() deathConnection = nil end
	end
end}):AddKeyPicker("FlyKeyPicker", {Text = "踏空", Default = "Y", Mode = "Toggle", SyncToggleState = true})

D:AddToggle("KeybindMenuOpen", {Default = Library.KeybindFrame.Visible, Text = "快捷菜单", Callback = function(value) Library.KeybindFrame.Visible = value end})

D:AddToggle('Instant Interaction', {Text = '无限体力', Default = false, Callback = function(state)
	local env = getgenv()
	if state then
		env.XK_StaminaTables = {}
		env.XK_StaminaFunctions = {}
		env.XK_StaminaValues = {}
		for _, obj in pairs(getgc(true)) do
			if type(obj) == "table" and rawget(obj, "Stamina") then
				table.insert(env.XK_StaminaValues, {table = obj, value = rawget(obj, "Stamina")})
				obj.Stamina = 100
				local mt = getrawmetatable(obj)
				if mt then
					table.insert(env.XK_StaminaTables, {table = obj, metatable = mt, original = {__newindex = mt.__newindex, __index = mt.__index}})
					setreadonly(mt, false)
					mt.__newindex = newcclosure(function(t, k, val) if k ~= "Stamina" then rawset(t, k, val) end end)
					mt.__index = newcclosure(function(t, k) return k == "Stamina" and 100 or rawget(t, k) end)
					setreadonly(mt, true)
				end
			end
		end
		for _, func in pairs(getgc(true)) do
			if type(func) == "function" then
				local info = debug.getinfo(func)
				if info and info.name and info.name:find("[Ss]tamina") then
					table.insert(env.XK_StaminaFunctions, func)
					local original = hookfunction(func, function() return 100 end)
					if original then
						env.XK_StaminaOriginals = env.XK_StaminaOriginals or {}
						env.XK_StaminaOriginals[func] = original
					end
				end
			end
		end
	else
		if env.XK_StaminaTables then
			for _, data in ipairs(env.XK_StaminaTables) do
				if data.metatable then
					setreadonly(data.metatable, false)
					data.metatable.__newindex = data.original.__newindex
					data.metatable.__index = data.original.__index
					setreadonly(data.metatable, true)
				end
			end
		end
		if env.XK_StaminaValues then
			for _, data in ipairs(env.XK_StaminaValues) do
				if data.table then rawset(data.table, "Stamina", data.value) end
			end
		end
		if env.XK_StaminaFunctions and env.XK_StaminaOriginals then
			for _, func in ipairs(env.XK_StaminaFunctions) do
				local original = env.XK_StaminaOriginals[func]
				if original and hookfunction then hookfunction(func, original) end
			end
		end
		env.XK_StaminaTables = nil
		env.XK_StaminaFunctions = nil
		env.XK_StaminaValues = nil
		env.XK_StaminaOriginals = nil
	end
end})

local netOn = false
local netThread = nil
local netThreshold = 400
local netLabel = nil

local function getPing()
	local ok, v = pcall(function()
		return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
	end)
	if ok and type(v) == "number" then return v end
	return nil
end

E:AddToggle("NetworkDetector", {
	Text = "网络 检测器",
	Default = false,
	Tooltip = "每 5 秒检测一次延迟，超过阈值时弹窗提醒",
	Callback = function(Value)
		netOn = Value
		if Value then
			if netThread then return end
			netThread = task.spawn(function()
				while netOn do
					local ping = getPing()
					if ping then
						local txt = "当前延迟: " .. math.floor(ping) .. " ms"
						if netLabel then pcall(function() netLabel:SetText(txt) end) end
						if ping >= 1000 then
							Library:Notify({Title = "XoneScriptK Hub丨网络警告", Description = "延迟 " .. math.floor(ping) .. "ms，连接可能已断开", Time = 6})
						elseif ping >= netThreshold then
							Library:Notify({Title = "XoneScriptK Hub丨网络延迟", Description = "延迟过高: " .. math.floor(ping) .. "ms", Time = 6})
						end
					else
						if netLabel then pcall(function() netLabel:SetText("无法读取延迟") end) end
					end
					task.wait(5)
				end
				netThread = nil
			end)
			Library:Notify({Title = "XoneScriptK Hub丨网络", Description = "网络检测已开启", Time = 4})
		else
			if netLabel then pcall(function() netLabel:SetText("未开启") end) end
		end
	end,
})

E:AddSlider("NetThreshold", {
	Text = "延迟阈值",
	Default = 400, Min = 50, Max = 2000, Rounding = 0,
	Tooltip = "超过该值才提醒，单位 ms",
	Callback = function(v) netThreshold = v end,
})

netLabel = E:AddLabel("未开启")

E:AddDivider()

local isTranslating = false
local translationSpeed = 0.1
local translationThread
local translationCache = {}

local function translateText(text)
	if not text or text == "" or #text < 2 then return text end
	if translationCache[text] then return translationCache[text] end
	local success, result = pcall(function()
		local encodedText = string.gsub(text, " ", "%%20")
		local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=zh-CN&dt=t&q=" .. encodedText
		local response = game:HttpGet(url)
		local data = game:GetService("HttpService"):JSONDecode(response)
		local translatedText = ""
		if data and type(data) == "table" then
			for i, item in ipairs(data[1] or {}) do
				if item[1] then translatedText = translatedText .. item[1] end
			end
		end
		return translatedText ~= "" and translatedText or text
	end)
	local finalResult = success and result or text
	translationCache[text] = finalResult
	return finalResult
end

local function translateAllUI()
	local elementsToTranslate = {}
	local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	for _, element in ipairs(playerGui:GetDescendants()) do
		if (element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox")) and element.Text and #element.Text > 1 then
			table.insert(elementsToTranslate, {element = element, text = element.Text})
		end
	end
	local coreGui = game:GetService("CoreGui")
	for _, element in ipairs(coreGui:GetDescendants()) do
		if (element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox")) and element.Text and #element.Text > 1 then
			table.insert(elementsToTranslate, {element = element, text = element.Text})
		end
	end
	for _, item in ipairs(elementsToTranslate) do
		task.spawn(function()
			local translated = translateText(item.text)
			if translated and translated ~= item.text then
				pcall(function() item.element.Text = translated end)
			end
		end)
		task.wait(0.01)
	end
end

local function startFastTranslation()
	if translationThread then task.cancel(translationThread) end
	translationThread = task.spawn(function()
		while isTranslating do
			translateAllUI()
			task.wait(translationSpeed)
		end
	end)
end

E:AddToggle("TranslationToggle", {Text = "自动翻译", Default = false, Callback = function(Value)
	isTranslating = Value
	if Value then
		Library:Notify({Title = "XoneScriptK Hub丨警告", Description = "你正在尝试自动翻译功能，此功能是按照你的网络速度来进行翻译的，建议网络环境优越的地方使用。正在翻译，请等待", Time = 6})
		local Sound = Instance.new("Sound")
		Sound.SoundId = "rbxassetid://4590662766"
		Sound.Parent = game:GetService("SoundService")
		Sound.Volume = 5
		Sound:Play()
		task.wait(0.5)
		task.spawn(function() translateAllUI() startFastTranslation() end)
	else
		if translationThread then task.cancel(translationThread) translationThread = nil end
	end
end})

E:AddSlider("TranslationSpeed", {Text = "翻译速度", Default = 0.1, Min = 0.05, Max = 2, Rounding = 2, Compact = false, Callback = function(Value)
	translationSpeed = Value
	if isTranslating then
		if translationThread then task.cancel(translationThread) startFastTranslation() end
	end
end})

F:AddButton({Text = '<font color="rgb(255, 0, 0)">移除 用户界面</font>', Func = function() Library:Unload() end, DoubleClick = false})

F:AddButton({Text = "显示控制台", Func = function()
	local function GetChatService()
		if game:GetService("TextChatService"):FindFirstChild("TextChannels") then
			return game:GetService("TextChatService").TextChannels.RBXGeneral
		elseif game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then
			return game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
		end
		return nil
	end
	local chatService = GetChatService()
	if chatService then
		pcall(function()
			if chatService:IsA("TextChannel") then chatService:SendAsync("/console") else chatService:FireServer("/console", "All") end
		end)
	end
end, DoubleClick = false})

local Tool = Tabs.B:AddRightGroupbox("新版工具", "wrench")
Tool:AddButton({Text = "dex++", Func = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Dex-PlusPlus-Decompiler-Fix-206651"))() end})
Tool:AddButton({Text = "模型工具", Func = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Action-spy-76803"))() end})
Tool:AddButton({Text = "IY", Func = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-IY-InfiniteYield-137097"))() end})

C:AddButton({Text = "新版通用", Func = function()
	local cTime = tick()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Universal%20_1/XKHUB.lua'))()
	local loadTime = string.format("%.2f", tick() - cTime)
	Library:Notify({Title = "XoneScriptK Hub丨新版通用", Description = "All general functions have been fully loaded 丨 共耗时: " .. loadTime .. "秒", Time = 6})
end})

C:AddButton({Text = "简版通用[旧版]", Func = function()
	local startTime = tick()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Universal%20_1/New-Un'))()
	local loadTime = string.format("%.2f", tick() - startTime)
	Library:Notify({Title = "XoneScriptK Hub丨通用", Description = "All general functions have been fully loaded 丨 共耗时: " .. loadTime .. "秒", Time = 6})
end})


A:AddButton({Text = '<font color="rgb(0, 255, 0)">内脏与黑火药</font>', Func = function() LoadScript("内脏与黑火药", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/GB') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">决斗场</font>', Func = function() LoadScript("决斗场", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/DuelArena') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">监狱人生</font>', Func = function() LoadScript("监狱人生", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/PrisonLife') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">被遗弃</font>', Func = function() LoadScript("被遗弃", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Forsaken') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">死亡之死</font>', Func = function() LoadScript("死亡之死", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Death%20of%20death') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">DOORS</font>', Func = function() LoadScript("DOORS", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/DOORS') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">Chain[内容已删除]</font>', Func = function() LoadScript("Chain", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Chain') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">暴力区</font>', Func = function() LoadScript("暴力区", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Violent') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">压力</font>', Func = function() LoadScript("压力", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/pressure') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(0, 255, 0)">闪光</font>', Func = function() LoadScript("闪光", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Flick') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(255, 255, 0)">在森林中生存99夜</font>', Func = function() LoadScript("在森林中生存99夜", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/99Nights') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(255, 255, 0)">最坚强的战场</font>', Func = function() LoadScript("最强战场", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Tsb') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(255, 0, 0)">命运的毁灭</font>', Func = function() LoadScript("命运的毁灭", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/DoomByfate') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(255, 255, 255)">破坏者谜团2</font>', Func = function() LoadScript("破坏者谜团2", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/MM2') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(255, 255, 255)">菜鸟必须死</font>', Func = function() LoadScript("菜鸟必须死", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/NoobMostdie') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(255, 255, 255)">刀刃球</font>', Func = function() LoadScript("刀刃球", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Bladeball') Library:Unload() end})
A:AddButton({Text = '<font color="rgb(255, 255, 255)">Criminality</font>', Func = function() LoadScript("Criminality", 'https://raw.githubusercontent.com/DevSloPo/Main/refs/heads/main/Game/Criminality') Library:Unload() end})

local Addons = Tabs.C:AddLeftGroupbox("插件管理")
Tabs.C:UpdateWarningBox({Title = "警告！", Text = "小心！您放入XK-Hub-插件/Addons目录的任何脚本都会被执行器执行，我们建议您仅使用来自可信来源或开源的插件。对于插件造成的任何损害，我们概不负责，特此警告！", IsNormal = false, Visible = true, LockSize = true})
local HubFolder = "XK-Hub-插件"
local addonFolder = HubFolder.."/Addons"
if not isfolder(HubFolder) then makefolder(HubFolder) end
if not isfolder(addonFolder) then makefolder(addonFolder) end
AddonsFolder = AddonsFolder or {}
AddonsFolder.Addons = {}
for _, file in ipairs(listfiles(addonFolder)) do
	if file:sub(-4) == ".lua" or file:sub(-4) == ".txt" then
		local success, addon = pcall(function() return loadstring(readfile(file))() end)
		if success and type(addon) == "table" then
			table.insert(AddonsFolder.Addons, addon)
			if addon.Text then
				if addon.Callback then
					Addons:AddToggle(addon.Text, {Text = addon.Text, Default = addon.Default or false, Tooltip = addon.Tooltip or "", Callback = addon.Callback})
				elseif addon.Func then
					Addons:AddButton({Text = addon.Text, Tooltip = addon.Tooltip or "", Func = addon.Func})
				elseif addon.Default and addon.Min and addon.Max and addon.Rounding then
					Addons:AddSlider(addon.Text, {Text = addon.Text, Default = addon.Default, Min = addon.Min, Max = addon.Max, Rounding = addon.Rounding, Tooltip = addon.Tooltip or "", Callback = addon.Callback})
				elseif addon.Values then
					Addons:AddDropdown(addon.Text, {Values = addon.Values, Default = addon.Default or 1, Multi = addon.Multi or false, Text = addon.Text, Tooltip = addon.Tooltip or "", Searchable = addon.Searchable or false, Callback = addon.Callback})
				elseif addon.Numeric ~= nil then
					Addons:AddInput(addon.Text, {Default = addon.Default or "", Numeric = addon.Numeric, Finished = addon.Finished or false, ClearTextOnFocus = addon.ClearTextOnFocus or false, Text = addon.Text, Tooltip = addon.Tooltip or "", Placeholder = addon.Placeholder or "", Callback = addon.Callback})
				else
					Addons:AddLabel(addon.Text)
				end
			end
		end
	end
end

local MenuGroup = Tabs["UI Settings"]:AddRightGroupbox("界面设置")
MenuGroup:AddToggle("KeybindMenuOpen", {Default = Library.KeybindFrame.Visible, Text = "快捷菜单", Callback = function(value) Library.KeybindFrame.Visible = value end})
MenuGroup:AddToggle("MyToggle1", {Text = "解锁FPS", Default = true, Callback = function(Value)
	local function setfpscap(fps)
		if setfpscap then setfpscap(fps) else game:GetService("RunService"):SetRenderFPS(fps) end
	end
	setfpscap(Value and 1000000 or 60)
end})
MenuGroup:AddToggle("ShowCustomCursor", {Text = "自定义光标", Default = true, Callback = function(Value) Library.ShowCustomCursor = Value end})
MenuGroup:AddDropdown("NotificationSide", {Values = {"左", "右"}, Default = "右", Text = "通知位置", Callback = function(Value) Library:SetNotifySide(Value) end})
MenuGroup:AddDropdown("DPIDropdown", {Values = {"25%","50%","75%","100%","125%","150%","175%","200%"}, Default = "100%", Text = "UI大小", Callback = function(Value) Library:SetDPIScale(tonumber(Value:gsub("%%",""))) end})
MenuGroup:AddDivider()
MenuGroup:AddLabel("菜单"):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = "快捷菜单"})
MenuGroup:AddButton("删除 用户界面", function() Library:Unload() end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:SetSubFolder("specific-place")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()
