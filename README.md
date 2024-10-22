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

For everything to work properly, please ensure that both `Sequence.luau` and `Chapter.luau` are located at the same directory level (this is because Chapter assumes that Sequence exists at `..\Sequence`).

-----
### Chapters
A chapter is constructed using `Chapter.new()`. It takes no parameters and returns the results of its pcall.
```lua
type Chapter = typeof(setmetatable({}::{
    FirstSequence: Sequence.Sequence?
}, Chapter))
```

-----
### Sequence
A sequence is constructed using `Sequence.new()`.
```lua
-- Sequence type
type Sequence = typeof(setmetatable({}::{
    Content: (()->nil)?,
    Successor: Sequence?,
}, Sequence))
```
-----
### Example implementation for a small 'story game'.
The following is an example of implementing the chapter/sequence framework.
```lua
local Scenes = require(\scenesModuleLocation)
local MainChapter = Chapter.new()

local FormerScene = nil
for Scene in Scenes do
    -- Populate the chapter.

    if not FormerScene then
        FormerScene = Sequence.new()
        Sequence.Content = Scene
        MainChapter:RegisterFirstSequence(FormerScene)
        continue
    end

    local Temp = Sequence.new()
    Temp.Content = Scene
    FormerScene.Successor = Temp
    FormerScene = Temp
end

local _, ChapterError = Chapter:Play()
if not ChapterError then
    print('Story completed!')
end
```
-----
### Server-sided architecture recommendations.
Chapter is great for organizing successive sections of a game in a changeable and readable way. I tend to limit myself to things can actually be considered part of a deeply successive program, this is most useful for story games.

-----
### Client-sided architecture recommendations
Chapter can be used on the client side of your game as well - it is functional in the exact same way, so it could be used for cutscenes and other things. I would personally recommend related information (like has every player seen a cutscene) be applied through RemoteFunction, that way the server can proceed once everyone has completed or timed out their personal remote requests with no problem to the server itself.