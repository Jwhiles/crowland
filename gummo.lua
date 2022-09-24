-- gummo

function egg(n) 
  ii.jf.play_note(n/12, 1.9)
end
function eggo(n) 
  ii.wsyn[1].play_note(n/12 + 1, 0.9)
end
function eggoo(n) 
  ii.wsyn[2].play_note(n/12 + 1, 0.9)
end

voices = sequins{egg,eggo,eggoo}
s = sequins{1,3,5,8,12,15,sequins{17,8,12,8,5}}
-- s = sequins{1,3,5,8,sequins{12,15,18}}
beats = sequins{
  sequins{2,1,1/4,3,1/4,1/2,1,sequins{1/4,2,4,8},1/4,1/3,1/3,1/3,1/3},
  sequins{1,1,1,2}:every(3)}


output[1].action = pulse(0.001, 5)
ii.jf.mode(1)
ii.wsyn[1].ar_mode(1)
ii.wsyn[2].ar_mode(1)

i = 0
function time() 
  while true do
    clock.sync(beats())
      -- print(ii.wsyn[2].get('fm_ratio'))
      -- print(ii.wsyn[2].get('fm_env'))
      -- print('index', ii.wsyn[2].get('fm_index'))
      alter(2)
      alter(1)
      voice = voices()
      voice(s())
      egg(s())
      output[1]()
      -- ii.jf.play_note(s()/12, 5)
      -- ii.wsyn[1].play_note(s()/12 + 1, 5)
      -- ii.wsyn[2].play_note(s()/12 + 1, 5)
    end
  end

denomin = sequins{1,4,8,sequins{12,13,2}}

function alter(voice)
  ii.wsyn[voice].curve(denomin())
  ii.wsyn[voice].ramp(denomin())
end
alter(1)
alter(2)
ii.wsyn[1].patch(2, 10)
ii.wsyn[2].patch(2, 10)


ii.wsyn[1].fm_index(1)
ii.wsyn[1].fm_env(0)
ii.wsyn[1].fm_ratio(1,2)
-- ii.wsyn[1].lpg_time(-4)
ii.wsyn[1].lpg_symmetry(-1)
ii.wsyn[1].voices(4)

ii.wsyn[2].fm_index(1)
ii.wsyn[2].fm_env(0)
ii.wsyn[2].fm_ratio(1,2)
-- ii.wsyn[voice].lpg_time(-4)
ii.wsyn[2].lpg_symmetry(-1)
ii.wsyn[2].voices(4)

-- reset the voices


clock.run(time)
