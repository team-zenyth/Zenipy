sprite = image.load("ressources/images/sprite.png")  -- debut images 
fond = image.load("ressources/images/fond.png")
fond2 = image.load("ressources/images/fond2.png")
fenetre = image.load("ressources/images/fenetre.png")
gen = {x = -480, y = -480, alpha = 0, alpha2 = 0, alphaf = 255, titre = image.load("ressources/images/gentitre.png"), fond = image.load("ressources/images/genfond.png"), mascotte = image.load("ressources/images/genmascotte.png")}
screenshot = image.load("ressources/images/screenshot.png")
modes = image.load("ressources/images/modes.png")  -- fin images
blanc = color.new(255,255,255)  -- couleur
controles = {}  -- debut images plusieurs langues
for i = 1,2 do
  controles[i] = {img = image.load("ressources/images/controles"..i..".png")}
end -- images images plusieurs langues
tuyau = {}  -- debut variables
for i = 1,10 do
  tuyau[i] = {x = 480, y = 0, etat = 0, haut = 0}
end
zenipy = {x = 50, y = 133}  
text = {y = -50, alpha = 0}
hsc = io.open("hsc.akm","r")
highscore = tonumber(hsc:read())
hsc:close()
vitesse = 0
grav = 0
nombtuyau = 0
fin = 0
statut = "generique"
statutsave = ""
score = 0
statscreen = 0
alphascreen = 0
langue = 1
transtatut = 0
transalpha = 0
mode = "horizontal"  -- fin variables
generique = sound.load("ressources/musiques/Pearl.mp3")  -- debut musiques
ltbl = sound.load("ressources/musiques/LTBL.mp3")
theme = sound.load("ressources/musiques/Flapyncope.mp3")  -- fin musiques
chrono = timer.new()  -- debut chronos
chrono:start()
diff = timer.new()
diff:stop()  -- fin chronos
police = font.load("flash0:/font/ltn11.pgf")  -- polices
function menu()
  vitesse = 0
  grav = 0
  fin = 0
  score = -3
  nhc = 0
  if mode == "horizontal" then
    zenipy.x = 50
    zenipy.y = 133
  else
    zenipy.x = 226
    zenipy.y = 222
  end
  statscreen = 0
  for i = 1,10 do
    if mode == "horizontal" then
      tuyau[i].x = 480
      tuyau[i].y = 0
    else
      tuyau[i].x = 0
      tuyau[i].y = -34
    end
    tuyau[i].etat = 0
    tuyau[i].haut = 0
  end
  if mode == "horizontal" and (buttons.released.cross or buttons.released.up) then
    statut = "jouer"
    vitesse = 4  -- 
    grav = 0.25  -- plus la val est grande, plus l'oiseau tombe
  elseif mode == "vertical" and (buttons.released.cross or buttons.released.left) then
    statut = "jouer"
    vitesse = 4  -- 
    grav = 0.25  -- plus la val est grande, plus l'oiseau tombe
  end
end
function anim()
  chrono:start()
  if mode == "horizontal" then
    if chrono:time() < 100 then  -- animation oiseau
      image.blit(sprite,zenipy.x,zenipy.y,0,10,18,13)
    elseif chrono:time() >= 100 and chrono:time() < 200 then
      image.blit(sprite,zenipy.x,zenipy.y,0,30,18,13)
    elseif chrono:time() >= 200 and chrono:time() < 300 then
      image.blit(sprite,zenipy.x,zenipy.y,0,50,18,13)
    elseif chrono:time() >= 300 and chrono:time() < 400 then
      image.blit(sprite,zenipy.x,zenipy.y,0,30,18,13)
    elseif chrono:time() >= 400 then
      image.blit(sprite,zenipy.x,zenipy.y,0,10,18,13)
      chrono:reset()
    end
    for i = 1,5 do  -- afficher tuyaux haut
      if tuyau[i].etat == 1 then
        image.blit(sprite,tuyau[i].x,0,30,18,34,tuyau[i].haut)
        image.blit(sprite,tuyau[i].x,tuyau[i].haut,30,0,34,17)
      end
    end
    for i = 6,10 do  -- afficher tuyaux bas
      if tuyau[i].etat == 1 then
        image.blit(sprite,tuyau[i].x,241-tuyau[i].haut,64,0,34,tuyau[i].haut)
        image.blit(sprite,tuyau[i].x,241-tuyau[i].haut-13,64,143,34,17)
      end
    end
    for i = 0,1 do  -- afficher sol
      image.blit(sprite,i*256,241,0,162,256,31)
    end
    zenipy.y = zenipy.y - vitesse
  else
    if chrono:time() < 100 then  -- animation oiseau
      image.blit(sprite,zenipy.x,zenipy.y,2,67,13,18)
    elseif chrono:time() >= 100 and chrono:time() < 200 then
      image.blit(sprite,zenipy.x,zenipy.y,2,87,13,18)
    elseif chrono:time() >= 200 and chrono:time() < 300 then
      image.blit(sprite,zenipy.x,zenipy.y,2,107,13,18)
    elseif chrono:time() >= 300 and chrono:time() < 400 then
      image.blit(sprite,zenipy.x,zenipy.y,2,87,13,18)
    elseif chrono:time() >= 400 then
      image.blit(sprite,zenipy.x,zenipy.y,2,67,13,18)
      chrono:reset()
    end
    for i = 1,5 do  -- afficher tuyaux haut
      if tuyau[i].etat == 1 then
        image.blit(sprite,0,tuyau[i].y,202,0,tuyau[i].haut,34)
        image.blit(sprite,tuyau[i].haut,tuyau[i].y,202,34,17,34)
      end
    end
    for i = 6,10 do  -- afficher tuyaux bas
      if tuyau[i].etat == 1 then
        image.blit(sprite,451-tuyau[i].haut,tuyau[i].y,219,34,tuyau[i].haut,34)
        image.blit(sprite,451-tuyau[i].haut-17,tuyau[i].y,202,34,17,34)
      end
    end
    for i = 0,2 do  -- afficher sol
      sprite:blit(451,i*111,135,50,31,111)
    end
    zenipy.x = zenipy.x - vitesse
  end
  for i = 1,10 do  -- animation tuyaux
    if fin == 0 then
      if mode == "horizontal" then
        tuyau[i].x = tuyau[i].x - 2
      else
        tuyau[i].y = tuyau[i].y + 2
      end
    end
  end
  image.blit(fenetre,126,text.y-20,text.alpha)  -- afficher score
  if score > 0 then
    screen.print(police,240,text.y,"Score : "..score,1,color.new(255,255,255,text.alpha),color.new(255,255,255,text.alpha),__ACENTER)
  else
    screen.print(police,240,text.y,"Score : 0",1,color.new(255,255,255,text.alpha),color.new(255,255,255,text.alpha),__ACENTER)
  end
  screen.print(police,240,text.y+15,"High Score : "..highscore,1,color.new(255,255,255,text.alpha),color.new(255,255,255,text.alpha),__ACENTER)
  if nhsc == 1 then
    screen.print(police,240,text.y+30,"Nouveau/New High Score !",1,color.new(255,0,0,text.alpha),color.new(255,0,0,text.alpha),__ACENTER)
  end
  vitesse = vitesse - grav  -- loi de Newton
  if mode == "horizontal" and (buttons.released.cross or buttons.released.up) and statut == "jouer" and fin == 0 then  -- faire voler l'oiseau
    vitesse = 4
  elseif mode == "vertical" and (buttons.released.cross or buttons.released.left) and statut == "jouer" and fin == 0 then
    vitesse = 4
  end
end
function gentuyau()  -- ma fonction vraiment foireuse pour generer les tuyaux
  diff:start()
  if diff:time() >= 1500 and fin == 0 then  -- plus la val est grande, plus l'ecart entre 2 tuyaux est grand
    diff:reset()
    if mode == "horizontal" then
      if nombtuyau ~= 5 then
        nombtuyau = nombtuyau + 1
      else
        nombtuyau = 1
      end
      tuyau[nombtuyau].etat = 1
      tuyau[nombtuyau].x = 480
      tuyau[nombtuyau+5].etat = 1
      tuyau[nombtuyau+5].x = 480
      if tuyau[nombtuyau].haut == 0 then
        tuyau[nombtuyau].haut = math.random(10,143)
        tuyau[nombtuyau+5].haut = 242-100-tuyau[nombtuyau].haut
      end
    else
      if nombtuyau ~= 2 then
        nombtuyau = nombtuyau + 1
      else
        nombtuyau = 1
      end
      tuyau[nombtuyau].etat = 1
      tuyau[nombtuyau].y = -34
      tuyau[nombtuyau+5].etat = 1
      tuyau[nombtuyau+5].y = -34
      if tuyau[nombtuyau].haut == 0 then
        tuyau[nombtuyau].haut = math.random(10,330)
        tuyau[nombtuyau+5].haut = 451-112-tuyau[nombtuyau].haut
      end
    end
  end
end
function arret()
  if mode == "horizontal" then
    for i = 1,5 do
      if zenipy.x == tuyau[i].x then
        score = score + 1
      end
    end
    for i = 1,5 do
      if zenipy.x + 18 >= tuyau[i].x and zenipy.x <= tuyau[i].x + 34 and zenipy.y <= tuyau[i].haut+17 then
        fin = 1
      end
    end
    for i = 6,10 do
      if zenipy.x + 18 >= tuyau[i].x and zenipy.x <= tuyau[i].x + 34 and zenipy.y+13 >= 242-17-tuyau[i].haut then
        fin = 1
      end
    end
    if zenipy.y+13 >= 242 then
      fin = 1
    end
  else
    for i = 1,5 do
      if zenipy.y == tuyau[i].y then
        score = score + 1
      end
    end
    for i = 1,5 do
      if zenipy.y + 15 >= tuyau[i].y and zenipy.y <= tuyau[i].y + 34 and zenipy.x <= tuyau[i].haut+17 then
        fin = 1
      end
    end
    for i = 6,10 do
      if zenipy.y + 15 >= tuyau[i].y and zenipy.y <= tuyau[i].y + 34 and zenipy.x+13 >= 451-17-tuyau[i].haut then
        fin = 1
      end
    end
    if zenipy.x+13 >= 451 then
      fin = 1
    elseif zenipy.x <= -20 then
      zenipy.x = -20
    end
  end
  if fin == 1 then
    if mode == "horizontal" then  -- faire tomber l'oiseau
      zenipy.y = zenipy.y + 3
      if zenipy.y >= 234 then
        zenipy.y = 234
      end
    else
      zenipy.x = zenipy.x + 3
      if zenipy.x >= 434 then
        zenipy.y = 434
      end
    end
    text.y = text.y + 1  -- faire venir le score
    text.alpha = text.alpha + 1
    if score > highscore then
      nhsc = 1
      hsc = io.open("hsc.akm","w")
      hsc:write(score)
      hsc:close()
      hsc = io.open("hsc.akm","r")
      highscore = tonumber(hsc:read())
      hsc:close()
    end
    if text.y >= 90 then
      text.y = 90
    end
    if text.alpha >= 255 then
      text.alpha = 255
    end
    if buttons.released.cross then  
      statscreen = 1
    end
    if statscreen == 1 then  -- revenir a l'accueil
      draw.fillrect(0,0,480,272,color.new(0,0,0,alphascreen))
      alphascreen = alphascreen + 5
      if alphascreen >= 255 then
        text.y = -50
        text.alpha = 0
        statut = "repos"
        alphascreen = 0
      end
    end
  end
end
function transition()  -- fonction de transition entre les differentes parties du jeu
  if transtatut == 1 then
    if transalpha < 300 then
      transalpha = transalpha + 2
    else
      if statutsave == "credits" then
        chrono:stop()
        chrono:reset()
        grav = 0.5
        sound.stop(theme)
        transtatut = 0
        transalpha = 0
    statut = statutsave
        sound.play(ltbl)
      elseif statut == "generique" then
        sound.stop(generique)
        statut = "repos"
        transalpha = 0
        transtatut = 0
        sound.loop(theme)
      else
        statut = statutsave
        transtatut = 0
        transalpha = 0
      end
    end
  end
end
