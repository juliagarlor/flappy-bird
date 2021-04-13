Pipe=Class{}

local PIPE_IMAGE = love.graphics.newImage('pipe.png')

function Pipe:init(orientation, y)
--pipes appear just passed the right side of the screen 
self.x=VIRTUAL_WIDTH
self.y= y
self.width= PIPE_WIDTH
self.height = PIPE_HEIGHT
self.orientation = orientation
end

function Pipe:update(dt)
--movement defined in PipePairs
end

function Pipe:render()
love.graphics.draw(PIPE_IMAGE, self.x, 
--y component of the image. if orientation is 'top', we should draw the pipe in its y coordinate plus its height,
--and from there, it will be inverted. Otherwise ('bottom'), the pipe should be drawn from its y, as taken from the original image
(self.orientation == 'top' and self.y + self.height or self.y),
0, --no rotation
1, --same X scale
self.orientation == 'top' and -1 or 1)--Y scale. if orientation is 'top', y component should be inverted(-1),
--otherwise ('bottom'), y component of the image should remain the same (1) 
end