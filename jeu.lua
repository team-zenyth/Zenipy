while true do
  buttons.read()
  if statut == "generique" then  -- affiche le générique
    if gen.alpha < 255 then  -- affiche le fond quadrillé
      gen.alpha = gen.alpha + 5
    end
    if gen.x < 0 and gen.y < 0 then -- fait venir la mascotte et le logo
      gen.x = gen.x + 3
      gen.y = gen.y + 3
    else
      if gen.alphaf > 125 then -- petite animation sympa en fond
        gen.alphaf = gen.alphaf - 5
      else
        gen.alphaf = 255
      end    
    end
    draw.fillrect(0,0,480,272,color.new(255,255,255,gen.alphaf))
    image.blit(gen.fond,0,0,gen.alpha)
    image.blit(gen.mascotte,gen.x,0)
    image.blit(gen.titre,0,gen.y)
    if chrono:time() >= 28000 and chrono:time() < 33000 then -- transition pour passer au menu du jeu
      draw.fillrect(0,0,480,272,color.new(255,255,255,gen.alpha2))
      gen.alpha2 = gen.alpha2 + 1
    elseif chrono:time() >= 33000 or buttons.released.start then -- idem
      chrono:stop()
      chrono:reset()
      transtatut = 1
    end
    transition()
  elseif statut == "repos" then
    if mode == "horizontal" then
      image.blit(fond,0,0)
    else
      image.blit(fond2,0,0)
    end
    anim()
    menu()
    screen.print(police,10,255,"START : credits",1,blanc,blanc,__ALEFT)
    screen.print(police,470,255,"SELECT : aide/help",1,blanc,blanc,__ARIGHT)
    if buttons.released.r then
      if mode == "horizontal" then
        mode = "vertical"
      else
        mode = "horizontal"
      end
    elseif buttons.released.l then
      statutsave = "modeselect"
      transtatut = 1
    elseif buttons.released.select then
      statutsave = "aide"
      transtatut = 1
    elseif buttons.released.start then
      statutsave = "credits"
      transtatut = 1
    end
    transition()
  elseif statut == "jouer" then
    if mode == "horizontal" then
      image.blit(fond,0,0)
    else
      image.blit(fond2,0,0)
    end
    anim()
    if score > 0 then
      screen.print(police,240,30,score,2.0,blanc,blanc,__ACENTER)
    else
      screen.print(police,240,30,"0",2.0,blanc,blanc,__ACENTER)
    end
    image.blit(fenetre,126,text.y-20,text.alpha)
    gentuyau()
    arret()
  elseif statut == "modeselect" then
    image.blit(fond,0,0)
    screen.print(police,240,50,"Fonction indisponible pour le moment\n"..
                               "Cliquez sur Rond pour revenir au menu principal du jeu\n"..
                               "This function isn't available yet\n"..
                               "Please push the Circle button to return on the main menu",1.2,blanc,blanc,__ACENTER)
    if buttons.released.circle then
      statutsave = "repos"
      transtatut = 1
    end
    transition()
  elseif statut == "aide" then
    image.blit(screenshot,0,0)
    image.blit(controles[langue].img,0,0)
    if langue == 1 and buttons.released.r then
      langue = 2
    elseif langue == 2 and buttons.released.r then
      langue = 1
    end
    if buttons.released.circle then
      statutsave = "repos"
      transtatut = 1
    end
    transition()
  elseif statut == "credits" then
    dofile("credits.lua")
  end
  draw.fillrect(0,0,480,272,color.new(255,255,255,transalpha)) -- pour les transitions
  screen.flip()
end
