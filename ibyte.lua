-- image byte storage lib
local ibyte = { }

function ibyte.read(imgFile)
  local start = love.timer.getTime()
  local imgData = love.image.newImageData(imgFile)
  local w, h = imgData:getDimensions()
  local edat = { }
  for i = 0, h - 1 do
    for j = 0, w - 1 do
      local pr, pg, pb, pa = imgData:getPixel(j, i)
      if pb == 255 then
        table.insert(edat, pa)
      end
    end
  end
  local stop = love.timer.getTime() - start
  print("[ibyte.lua] Read prep took "..stop.." seconds")
  return ibyte.decode(edat)
end

function ibyte.write(data, fileOut)
  local start = love.timer.getTime()
  local edat = ibyte.encode(data)
  local size = math.ceil(math.sqrt(#edat))
  local imgData = love.image.newImageData(size, size)
  for i = 0, size - 1 do
    for j = 0, size - 1 do
      imgData:setPixel(i, j, 0, 0, 0, 255)
    end
  end
  local pix, px, py = 0, -1, 0
  for i, b in pairs(edat) do
    pix = b
    px = px + 1
    if px == size then
      px = 0
      py = py + 1
    end
    imgData:setPixel(px, py, 255, 255, 255, pix)
  end
  if fileOut ~= nil then
    if love.filesystem.exists(fileOut) then
      love.filesystem.remove(fileOut)
    end
    imgData:encode("png", fileOut)
  end
  local stop = love.timer.getTime() - start
  print("[ibyte.lua] Write took "..stop.." seconds")
  return imgData
end

function ibyte.encode(data)
  local start = love.timer.getTime()
  local encodedData = { }
  for i = 1, #data do
    table.insert(encodedData, string.byte(data:sub(i, i)))
  end
  local stop = love.timer.getTime() - start
  print("[ibyte.lua] Encode took "..stop.." seconds")
  return encodedData
end

function ibyte.decode(data)
  local start = love.timer.getTime()
  local decodedData = { }
  for i, b in pairs(data) do
    table.insert(decodedData, string.char(b))
  end
  local stop = love.timer.getTime() - start
  print("[ibyte.lua] Decode took "..stop.." seconds")
  return table.concat(decodedData)
end

return ibyte