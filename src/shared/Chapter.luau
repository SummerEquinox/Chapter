--// SummerEquinox, 2024
--// "Chapter.luau"

--// A chapter is the largest story unit available inside of the Chapter framework.
--// It is responsible for housing the first sequence and embedding it into pcall statement.
--// The point is, all of the code below our 'Chapter' is sure to run once all of the sequences have completed.

--!strict

-- Require sequence module \
local Sequence = require(script.Parent.Sequence)

-- Chapter object \
local Chapter = {}
Chapter.__index = Chapter

-- Chapter type \
type Chapter = typeof(setmetatable({}::{
    FirstSequence: Sequence.Sequence?
}, Chapter))

-- Chapter constructor function \
function Chapter.new(): Chapter
    local self = {}
    setmetatable(self, Chapter)

    self.FirstSequence = nil

    return self
end

-- Methods \
function Chapter:RegisterFirstSequence(FirstSequence: Sequence.Sequence)
    if not FirstSequence then
        warn "Please submit a valid sequence as the first Chapter sequence."
        return
    end

    self.FirstSequence = FirstSequence
end

function Chapter:Play()
    if not self.FirstSequence then
        warn "Please register the first sequence before attempting to play the Chapter."
        return
    end

    local s,e = pcall(function()
        self.FirstSequence:Play()
    end)
    return s,e
end

-- Chapter return statement \
return Chapter