local player = game.Players.LocalPlayer
local character = player.Character

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Server = ReplicatedStorage.Remotes.Server
local EffectEvent = ReplicatedStorage.Remotes.Effects

local Cooldown = require(ReplicatedStorage.Replicated.Cooldown)
local Skillsets = require(ReplicatedStorage.Replicated.Skillsets)
local VFX = require(script:WaitForChild("Fx"))

local AvailableSets = {
	"Movement",
	"Combat"
}

-- using corounitine for error handling, i belive u shoudl follow tutorial until it ends

local InputBegan = coroutine.create(function()
	UserInputService.InputBegan:Connect(function(UserInput, GPE)
		if GPE then return end
		
		local Skill, Set, Info, Input = nil, nil, nil, nil
		if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
			Input = "M1"
			if Cooldown:CheckCooldown("M1", player) == false or character:GetAttribute("Attacking") == false then
				Info = {Data = "Test"}	
			end
		else
			Input = UserInput.KeyCode.Name 
		end
		
		for i, v in pairs(AvailableSets) do
			if Skillsets[v] then
				if Skillsets[v][Input] then
					Skill = Skillsets[v][Input]
					Set = v  
				end
			end
		end
		if Skill then
			if Cooldown:CheckCooldown(Skill.Name, player) == false or character:GetAttribute("Attacking") == false then
				character:SetAttribute("Attacking", false)

				if Info then
					print("Fire SKILL")
					local Fire = Server:InvokeServer("Skill", nil, {Info, Skill["Name"], Set})
					
					Cooldown:AddCooldown(Skill.Name, Skill.Cooldown, player)
				end
				character:SetAttribute("Attacking", false)
				
			end
		end
	end)
end)


local InputEnded = coroutine.create(function()
	UserInputService.InputBegan:Connect(function(Input, GPE)
		Server:InvokeServer("EndedInput", Input.KeyCode.Name)
	end)
end)

coroutine.resume(InputBegan)
coroutine.resume(InputEnded)

EffectEvent.OnClientEvent:Connect(function(...)
	local FXName, Params = unpack(...)
	print(FXName, Params)
	
	VFX[FXName](player, Params)
end)
