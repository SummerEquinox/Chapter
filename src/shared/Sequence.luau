--// SummerEquinox, 2024
--// "Sequence.luau"

--// A sequence is the smallest story unit available inside of the Chapter framework.
--// It will execute its contents, then execute its 'successor'.

--!strict

-- Sequence object \
local Sequence = {}
Sequence.__index = Sequence

-- Sequence type \
export type Sequence = typeof(setmetatable({}::{
    Content: (()->nil)?,
    Successor: Sequence?,
}, Sequence))

-- Sequence constructor function \
function Sequence.new(Content: (()->nil)?): Sequence
    local self = {}
    setmetatable(self, Sequence)

    self.Content = Content or nil
    self.Successor = nil

    return self
end

-- Methods \
function Sequence:Play()
    if not self.Content then
        -- We can use 'error' as Chapters explicitely return pcall results.
        error "ERR: Sequence does not contain Content."
    end

    self.Content()
    if self.Successor then
        self.Successor:Play()
    end
end

-- Sequence return statement \
return Sequence