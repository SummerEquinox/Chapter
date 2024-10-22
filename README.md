# Chapter is a simple framework to ease story-game implementations.

The primary goal of chapter is to provide two 'units' to a story-game. The primary unit is called a 'Chapter', and the secondary unit is called a 'Sequence'.

```lua
local Main = Chapter.new()
local SpawnPlayers = Sequence.new()
local FirstCutscene = Sequence.new()
local GameplayLoop = Sequence.new()

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

The largest unit of Chapter is a 'Chapter' which is responsible for wrapping the sequences in a pcall and holding the initial sequence.

The smaller unit is known as a 'Sequence'. A sequence is responsible for executing its personal 'Content' and then calling its 'Successor' - so, the obvious limitation is the call-stack, keep that in mind when programming with this framework.

-----
### Chapters
A chapter is constructed using `Chapter.new()`. It takes no parameters and returns the results of its pcall.
```lua
...
```

-----
### Sequence
A sequence is constructed using `Sequence.new()`.
```lua
-- Sequence type
export type Sequence = typeof(setmetatable({}::{
    Content: (()->nil)?,
    Successor: Sequence?,
}, Sequence))
```
----
### Example implementation for a small 'story game'.
The following is an example of implementing the chapter/sequence framework.
```lua
...
```