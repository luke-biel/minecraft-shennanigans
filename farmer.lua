WHEAT_MATURE_AGE=7

--[[
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
function refuel()
  turtle.suck(8) 
  turtle.refuel()
end

--[[
  This method finds seeds in the inventory, moves them to slot one and selects that slot
]]
function moveSeedsToSlot1() 
  -- Find slot with seeds
  seeds = -1
  for i=1,16,1 do
    local detail = turtle.getItemDetail(i)
    if detail ~= nil and detail.name == "minecraft:wheat_seeds" then
      seeds = i
    end
  end

  if seeds >= 0 then
    -- Move seeds to slot one
    turtle.select(seeds)
    turtle.transforTo(1)
  else
    -- Empty out the slot 1, so no item placement happens
    print("Error, No seeds")

    empty = -1
    for i=1,16,1 do
      local detail = turtle.getItemDetail(i)
      if detail ~= nil then empty = i end
    end
    if empty >= 0 then
      turtle.select(1)
      turtle.transforTo(empty)
    else
      print("Error, Inventory full!")
    end
  end

  -- Select slot one
  turtle.select(1)
end

--[[
  Check if the block is harvestable wheat, harvest it, find seeds in inventory, and plant them
]]
function harvest()
  isBlock, block = turtle.inspectDown()
  if not isBlock then return end
  if not block.name == "minecraft:wheat" then return end
  if not block.state.age == WHEAT_MATURE_AGE then return end
  -- block is a mature wheat
  turtle.digDown()
  moveSeedsToSlot1()
  turtle.placeDown()
end

--[[
  Drops off wheat into inventory in front
]]
function dropOffWheat() 
  for i=1,16,1 do
    detail = turtle.getItemDetail(i)
    if detail ~= nil and detail.name == "minecraft:wheat_seeds" or detail.name == "minecraft:wheat" then
      turtle.select(i)
      turtle.drop()
    end
  end
  turtle.select(1)
end

refuel()
--[[
# Start moving and harvesting
]]
turtle.turnLeft()
-- Repeat 4 times
for i=0,3,1 do
  -- Move to the end in first row
  for j=0,6,1 do
    harvest()
    turtle.forward()
  end
  turtle.turnLeft()
  turtle.forward()
  turtle.turnLeft()

  -- Move to the end in second row
  for j=0,6,1 do
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
turtle.turnRight()
for i = 0,7,1 do
  turtle.forward()
end

turtle.turnRight()
dropOffWheat()
turtle.turnLeft()