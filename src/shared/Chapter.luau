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

-- Chapter return statement
return Chapter