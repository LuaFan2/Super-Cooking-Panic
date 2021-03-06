--[[---------------------------------------------------------
		Super Cooking Panic for Garry's Mod
				by Xperidia (2020)
-----------------------------------------------------------]]

AddCSLuaFile()

-- Default teams
GM.team_list = {
	{
		name = "Blue Team",
		color = Color(52, 152, 219),
	},
	{
		name = "Orange Team",
		color = Color(230, 126, 34),
	},
}

-- Constants
GM.combo_time_length = 5
GM.max_combo = 5

TEAM_INGREDIENT = 1009

--[[---------------------------------------------------------
	Name: gamemode:IsValidPlayingTeam( number id )
	Desc: Checks if the team is playable
-----------------------------------------------------------]]
function GM:IsValidPlayingTeam(id)
	return	id ~= TEAM_SPECTATOR
		and id ~= TEAM_UNASSIGNED
		and id ~= TEAM_CONNECTING
		and team.Joinable(id)
end

--[[---------------------------------------------------------
	Name: gamemode:RemoveTeam( number index )
	Desc: Removes a team at the given index
-----------------------------------------------------------]]
function GM:RemoveTeam(index)
	table.remove(self.team_list, index)
	table.remove(team:GetAllTeams(), index)
end

--[[---------------------------------------------------------
	Name: gamemode:AddTeam( string name , table color )
	Desc: Creates a new team and sets it up
-----------------------------------------------------------]]
function GM:AddTeam(name, color)
	table.insert(self.team_list, #self.team_list + 1, {
		name = name,
		color = color,
	})
	team.SetUp(#self.team_list, name, color)
	team.SetClass(#self.team_list, {"player_cook"})
end

--[[---------------------------------------------------------
	Name: gamemode:CreateTeams()
	Desc: Creates and sets up teams parameters
-----------------------------------------------------------]]
function GM:CreateTeams()
	for k, v in pairs(self.team_list) do
		team.SetUp(k, v.name, v.color)
		team.SetClass(k, {"player_cook"})
	end
	team.SetUp(TEAM_INGREDIENT, "#scookp_ingredient", Color(255, 255, 255), false)
end

--[[---------------------------------------------------------
	Name: gamemode.GetPlayingTeams()
	Desc: Return playing teams table
-----------------------------------------------------------]]
function GM:GetPlayingTeams()

	local p_teams = {}

	for i, tm in pairs(team.GetAllTeams()) do

		if self:IsValidPlayingTeam(i) then

			tm.Score = team.GetScore(i)

			p_teams[i] = tm

		end

	end

	return p_teams

end

--[[---------------------------------------------------------
	Name: gamemode.GetWinningTeams()
	Desc: Return winning teams
-----------------------------------------------------------]]
function GM:GetWinningTeams()

	local win_teams = {}
	local last_team_score = 0

	for _, tm in SortedPairsByMemberValue(self:GetPlayingTeams(), "Score", true) do

		if tm.Score >= last_team_score then

			table.insert(win_teams, tm)

			last_team_score = tm.Score

		else

			break

		end

	end

	return win_teams

end
