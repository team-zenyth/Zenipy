-- le code qui suit est une horreur, n'y pretez pas attention sous peine de mals de crâne

crdts = {un = image.load("ressources/images/credits1.png"), deux = image.load("ressources/images/credits2.png"), fond = image.load("ressources/images/crfond.png"), alpha = 0, alpha2 = 0, alpha3 = 0}

credits = {}
ysave = {}

for i = 1,15 do
  credits[i] = {x = 480, y = math.random(1,4)*50, x2 = 0, y2 = 37*(i-1), w = 0, h = 0, vitesse = 0}
end

for i = 1,15 do
  ysave[i] = {val = credits[i].y}
end

credits[1].w = 332
credits[1].h = 37
credits[2].w = 196
credits[2].h = 34
credits[3].y2 = 71
credits[3].w = 346
credits[3].h = 37
credits[4].y2 = 108
credits[4].w = 348
credits[4].h = 37
credits[5].y2 = 145
credits[5].w = 243
credits[5].h = 25
credits[6].y2 = 170
credits[6].w = 271
credits[6].h = 25
credits[7].x2 = 288
credits[7].y2 = 170
credits[7].w = 105
credits[7].h = 25
credits[8].y2 = 195
credits[8].w = 357
credits[8].h = 23
credits[9].y2 = 220
credits[9].w = 272
credits[9].h = 25
credits[10].x2 = 288
credits[10].y2 = 220
credits[10].w = 168
credits[10].h = 25
credits[11].y2 = 245
credits[11].w = 410
credits[11].h = 21
credits[12].x2 = 365
credits[12].y2 = 51
credits[12].w = 95
credits[12].h = 23
credits[13].x2 = 365
credits[13].y2 = 79
credits[13].w = 51
credits[13].h = 22
credits[14].x2 = 365
credits[14].y2 = 112
credits[14].w = 57
credits[14].h = 20
credits[15].x2 = 365
credits[15].y2 = 148
credits[15].w = 91
credits[15].h = 20

while true do
  draw.fillrect(0,0,480,272,color.new(255,255,255,crdts.alpha))
  image.blit(crdts.fond,0,0)
  image.blit(crdts.deux,0,0,crdts.alpha2)
  draw.fillrect(0,0,480,272,color.new(255,255,255,crdts.alpha3))
  
  if crdts.alpha < 125 then
    if chrono:time() < 15100 or chrono:time() >= 18700 then
      crdts.alpha = crdts.alpha + 5
    elseif chrono:time() >= 15100 and chrono:time() < 16500 then
      crdts.alpha = crdts.alpha + 10
    elseif chrono:time() >= 16500 and chrono:time() < 18200 then
      crdts.alpha = crdts.alpha + 25
    end
  else
    crdts.alpha = 0
  end  

  for i = 1,15 do
    if i == 1 or credits[i-1].x+credits[i-1].w+30 < 480 then
      image.blit(crdts.un,credits[i].x,credits[i].y,credits[i].x2,credits[i].y2,credits[i].w,credits[i].h)
      credits[i].y = credits[i].y - credits[i].vitesse
      credits[i].vitesse = credits[i].vitesse - grav
      if credits[i].y > ysave[i].val+4 then
        credits[i].vitesse = 4
      end
      credits[i].x = credits[i].x - 1.5
    end
  end
  
  if credits[15].x < 0 and crdts.alpha2 < 600 then
    crdts.alpha2 = crdts.alpha2 + 2
  elseif credits[15].x < 0 and crdts.alpha2 >= 600 then
    crdts.alpha3 = crdts.alpha3 + 2
  end

  if crdts.alpha3 >= 400 then
    chrono:stop()
    chrono:reset()
    grav = 0
    statut = "repos"
    sound.stop(ltbl)
    sound.loop(theme)
    dofile("jeu.lua")
  end

  screen:flip()
end
