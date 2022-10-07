-- renzo

clock.tempo=128
s = sequins{1,3,5,8,12,15,sequins{17,8,12,8,sequins{5,7}}}
beats = sequins{
  sequins{2,1,1/4,3,1/4,1/2,1,sequins{1/4,2,4,8},1/4,1/3,1/3,1/3,1/3},
  sequins{1,1,1,2}:every(3)}

ss = sequins{1,3,5,8,12,15,sequins{17,8,12,8,sequins{5,7}}}

output[4].action = pulse(0.001, 8)
output[3].action = pulse(0.001, 8)

function timetwo() 
  while true do
    clock.sync(1/2)
    output[3]()
    end
  end

function time() 
  while true do
    clock.sync(beats())
    output[1].volts = s() / 12
    output[2].volts = s() / 12
    output[4]()
    end
  end

clock.run(time)
clock.run(timetwo)

