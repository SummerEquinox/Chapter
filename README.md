# Chapter is a simple framework to ease story-game implementations.

The primary goal of chapter is to provide two 'units' to a story-game. The primary unit is called a 'Chapter', and the secondary unit is called a 'Sequence'.

```lua
local Chapter = Chapter.new("Main")

local Sequence1 = Sequence.new("SpawnPlayers")
local Sequence2 = Sequence.new("FirstCutscene")
local Sequence3 = Sequence.new("GameplayLoop")

Sequence1.Content = function() end
Sequence2.Content = function() end
Sequence3.Content = function() end

Chapter:RegisterFirstSequence(Sequence1)
Sequence1.Successor = Sequence2
Sequence2.Successor = Sequence3

local Succeeded, Problem = Chapter:Play() -- yielding method.
if not Succeeded then
    warn(Problem)
end
```
-----

Chapter was created during a story project I worked on, and I figured I may use it again in the future - so it might be nice to host it as well.

...ETC