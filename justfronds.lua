-- just fronds
-- output 1 cv for rings
-- output 2 clock source

function frond(n) 
  ii.jf.play_note(n/12, 1.9)
end

ringsActive = false
ringsCount = 0
switch = false

sOne = sequins{1,3,5,8,7,5}
sTwo = sequins{8,3,7,8,7,8,12,-12}
s = sOne

ringsSeqOne = sequins{1,8,7,5}
ringsSeqTwo = sequins{sequins{1,8,7,5},12,24}
ringsSeq = ringsSeqTwo
beats = sequins{1,1,1/2,1/2,1}
beatsForRings = sequins{1,1/4,1/4,1,1/2,1,1/2,1/2,1}


ii.jf.mode(1)

i = 0
function time() 
  while true do
      clock.sync(beats())
      frond(s())

      ringsCount = ringsCount+1
      if ringsCount > 40 then
        ringsActive = not ringsActive
        ringsCount = 0
        if switch then
          ringsSeq = ringsSeqTwo
        else
          ringsSeq = ringsSeq
        end
        switch = not switch
      end
    end
  end

function ringsTime()
  while true do
      clock.sync(beatsForRings())
      if ringsActive then
        output[1].volts = ringsSeq() / 12
      end
      if ringsCount > 30 and not ringsActive then
        s=sTwo
      end
      if ringsCount == 10 and ringsActive then
        s=sOne
      end
    end
end

output[2].action = pulse(0.001, 5)
function clockIt()
  while true do
    clock.sync(4)
    output[2]()
  end
end

clock.run(time)
clock.run(ringsTime)
clock.run(clockIt)

