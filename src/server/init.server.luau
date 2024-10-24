-- This file is temporary and used exclusively for testing Chapter.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Chapter = require(ReplicatedStorage.Shared.Chapter)
local Sequence = require(ReplicatedStorage.Shared.Sequence)

local Sections = {
    -- Pseudo sections for testing

    function() 
        print('Game is starting!')
    end,
    function() 
        for _,Plr in Players:GetPlayers() do
            Plr.Character.HumanoidRootPart.Position = Vector3.new(0, 100, 0)
        end
    end,
    function() 
        print('Game is ending!')
    end,
}

local MainChapter = Chapter.new()
local FormerSection = nil
for _, Section in Sections do
    -- Populate the chapter.

    if not FormerSection then
        FormerSection = Sequence.new()
        Sequence.Content = Section
        MainChapter:RegisterFirstSequence(FormerSection)
        continue
    end

    local Temp = Sequence.new()
    Temp.Content = Section
    FormerSection.Successor = Temp
    FormerSection = Temp
end

task.wait(4)
print('playing main chapter')
MainChapter:Play()
