--[[---------------------------------------------------------
		Super Cooking Panic for Garry's Mod
				by Xperidia (2020)
-----------------------------------------------------------]]

-- Constants
local ingredient_entities = {
	["prop_physics"] = true,
	["prop_ragdoll"] = true,
}

--[[---------------------------------------------------------
	Name: gamemode:RemoveCookingPots()
	Desc: Removes all the spawned 'cooking pot' entities
-----------------------------------------------------------]]
function GM:RemoveCookingPots()
	for _, v in pairs(ents.FindByClass("scookp_cooking_pot")) do
		v:Remove()
	end
end

--[[---------------------------------------------------------
	Name: gamemode:SpawnCookingPots()
	Desc: Prepares and spawns a 'cooking pot' entity for all teams
-----------------------------------------------------------]]
function GM:SpawnCookingPots()
	for k, _ in pairs(self.team_list) do
		self:SpawnCookingPot(k)
	end
end

--[[---------------------------------------------------------
	Name: gamemode:SpawnCookingPot( number team )
	Desc: Prepares and spawns a 'cooking pot' entity linked to a team
-----------------------------------------------------------]]
function GM:SpawnCookingPot(team)

	local ent = ents.Create("scookp_cooking_pot")

	ent:SetPos(Vector(0, 100 * (team or 0), 0))
	ent:SetTeam(team or 0)
	ent:Spawn()

end

--[[---------------------------------------------------------
	Name: gamemode.TagEntityAsIngredient( entity ent )
	Desc: Tags selected entities to be an 'ingredient'
-----------------------------------------------------------]]
function GM.TagEntityAsIngredient(ent)

	if IsValid(ent) and ingredient_entities[ent:GetClass()] then
		ent.ingredient = true
	end

end
hook.Add("OnEntityCreated", "scookp_hook_TagEntityAsIngredient", GM.TagEntityAsIngredient)