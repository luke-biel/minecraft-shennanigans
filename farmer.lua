WHEAT_MATURE_AGE=7

--[[
# Pick up fuel
    c 
  c<t o o o o o o o 
    o o o o o o o o 
    o o o o o o o o 
    o o o o o o o o 
    o o o o o o o o 
    o o o o o o o o 
    o o o o o o o o 
    o o o o o o o o 
]] 
turtle.suck(64) 
turtle.refuel()

function harvest()
  isBlock, block = turtle.inspectDown()
  if not isBlock then return end
  if not block.name == "minecraft:wheat" then return end
  if not block.state.age == WHEAT_MATURE_AGE then return end
  -- block is a mature wheat
  turtle.digDown()
end

--[[
# Start moving and harvesting
]]
turtle.turnLeft()
for i=0,3,1 do
  for j=0,7,1 do
    harvest()
    turtle.forward()
  end
  turtle.turnLeft()
  turtle.forward()
  turtle.turnLeft()
  for j=0,7,1 do
    harvest()
    turtle.forward()
  end
  turtle.turnRight()
  turtle.forward()
  turtle.turnRight()
end

--[[
  return to base station
]]
turtle.turnLeft()
for i = 0,7,1 do
  turtle.forward()
end