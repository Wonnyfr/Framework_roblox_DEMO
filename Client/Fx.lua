--Note that "SkillReplicator" is the parent of this script

local BaseEffects = {}

local function fetchEffects(FXName)
	return BaseEffects[FXName]
end

local function load(Module)
	local Effects = require(Module)
	for i, v in pairs(Effects) do
		BaseEffects[i] = v
	end
	Effects.getfx = fetchEffects()
end

for i, v in pairs(script:GetChildren()) do
	if v:IsA("ModuleScript") then
		load(v)
	end
end

return BaseEffects
