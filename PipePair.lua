PipePair=Class{}

--modifying the gap height for it not to be a constant number but a random value between 20 and 100
gap_height= math.random(20,100)

function PipePair:init(y)
--initialize pipes passed the end of the screen
self.x= VIRTUAL_WIDTH + 32

--y for the top pipe
self.y=y

self.pipes={
['upper']= Pipe('top', self.y),
['lower']= Pipe('bottom', self.y + PIPE_HEIGHT + gap_height)
}
--draw the lower pipe with respect to the upper pipe.

self.remove = false
self.scored = false
end

function PipePair:update(dt)

if self.x > -PIPE_WIDTH then
--initializing pipe pairs when entering the screen and moving them till they'r completely out
self.x = self.x - PIPE_SPEED*dt
self.pipes['lower'].x = self.x
self.pipes['upper'].x = self.x
else
--removing pipes when passed the left side of the screen
self.remove=true
end
end

function PipePair:render()
for k, pipe in pairs(self.pipes) do
pipe:render()
end
end