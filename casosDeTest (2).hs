{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}

module TestDeMisFunciones where

import Test.HUnit
import Solucion


runCatedra = runTestTT testcatedra

testcatedra = test [
    " nombresDeUsuarios 1" ~: (nombresDeUsuarios redA) ~?= ["Juan","Natalia","Pedro","Mariela"],

    " amigosDe 1" ~: (amigosDe redA usuario1) ~?= [usuario2, usuario4],

    " cantidadDeAmigos 1" ~: (cantidadDeAmigos redA usuario1) ~?= 2,

    " usuarioConMasAmigos 1" ~: expectAny (usuarioConMasAmigos redA) [usuario2, usuario4],

    " estaRobertoCarlos 1" ~: (estaRobertoCarlos redA) ~?= False,

    " publicacionesDe 1" ~: (publicacionesDe redA usuario2) ~?= [publicacion2_1, publicacion2_2],

    " publicacionesQueLeGustanA 1" ~: (publicacionesQueLeGustanA redA usuario1) ~?= [publicacion2_2, publicacion4_1],

    " lesGustanLasMismasPublicaciones 2" ~: (lesGustanLasMismasPublicaciones redB usuario1 usuario3) ~?= True,

    " tieneUnSeguidorFiel 1" ~: (tieneUnSeguidorFiel redA usuario1) ~?= True,

    " existeSecuenciaDeAmigos 1" ~: (existeSecuenciaDeAmigos redA usuario1 usuario3) ~?= True,

    " existeSecuenciaDeAmigos 2" ~: (existeSecuenciaDeAmigos redC usuario1 usuario8) ~?= True
    ]

run1= runTestTT testdeListadeNombresdeUsuarios
testdeListadeNombresdeUsuarios = test [   
    "Caso 1: Con un usuario" ~: (nombresDeUsuarios redD) ~?= ["Pedro"], 
    "Caso 2: Con más de un usuario" ~: (nombresDeUsuarios redC) ~?= ["Juan","Natalia","Pedro","Mariela","Ricardo"],
    "Caso 3: Sin usuarios" ~: (nombresDeUsuarios redVacia) ~?= []
    ]

run2= runTestTT testdeamigosDe
testdeamigosDe = test [
    "Caso 1: Usuario con ningun amigo" ~: (amigosDe redE (6, "Ricardo") ) ~?= [], 
    "Caso 2: Usuario sin amigos en una red con solo un usuario" ~: (amigosDe redD (3, "Pedro") ) ~?= [],
    "Caso 3 :Usuario con un amigo" ~: (amigosDe redB (3, "Pedro")) ~?= [(2, "Natalia")],
    "Caso 4: Usuario con más de un amigo" ~: (amigosDe redA (1, "Juan")) ~?= [(2, "Natalia"),(4, "Mariela")],
    "Caso 5: Amigo con el mismo nombre" ~: (amigosDe redC (5, "Natalia")) ~?= [(2, "Natalia")],
    "Caso 6: Amigos con el mismo nombre" ~: (amigosDe redF (5, "Natalia")) ~?= [(2, "Natalia"),(11, "Natalia")]
    ]

run3= runTestTT testcantidadDeAmigos
testcantidadDeAmigos = test [
    "Caso 1: Sin amigos" ~: (cantidadDeAmigos redE (6, "Ricardo") ) ~?= 0,
    "Caso 2: Sin amigos en una red con solo un usuario" ~: (cantidadDeAmigos redD (3, "Pedro"))  ~?= 0,
    "Caso 3: Con un amigo" ~: (cantidadDeAmigos redB (3, "Pedro")) ~?= 1,
    "Caso 4: Con más de un amigo" ~: (cantidadDeAmigos redC (2, "Natalia")) ~?= 4
    ]

run4= runTestTT testusuarioConMasAmigos 
testusuarioConMasAmigos = test [
    "Caso 1: Con igual cantidad de amigos -- que otro usuario" ~: (usuarioConMasAmigos redG) ~?= (7, "Armando"),
    "Caso 2: Con igual cantidad de amigos ++ que otro usuario" ~: (usuarioConMasAmigos redC) ~?= (4, "Mariela"),
    "Caso 3: Usuario con la mayor cantidad de amigos" ~: (usuarioConMasAmigos redF) ~?= (9,"Lucia")
    ]

run5=runTestTT testestaRobertoCarlos
testestaRobertoCarlos = test [
    "Caso 1: Usuario con menos de 10 amigos en una red social sin amistades"~: (estaRobertoCarlos redE ) ~?= False,
    "Caso 2: Usuario con menos de 10 amigos"  ~: (estaRobertoCarlos redB ) ~?= False,
    "Caso 3: Usuario con mas de 10 amigos" ~: (estaRobertoCarlos redF ) ~?= True
    ]

run6=runTestTT testpublicacionesDe
testpublicacionesDe = test [
    "Caso 1: Usuario con ninguna publicacion" ~: (publicacionesDe redG (12, "Julian") ) ~?= [],
    "Caso 2: Usuario con una publicacion" ~: (publicacionesDe redE (4,"Mariela"))~?= [(usuario4, "I am Alice. Not", [usuario1, usuario2])],
    "Caso 3: Usuario con más de una publicacion" ~: (publicacionesDe redB (1, "Juan")) ~?= [((1,"Juan"),"Este es mi tercer post",[(2,"Natalia"),(5,"Natalia")]),((1,"Juan"),"Este es mi cuarto post",[]),((1,"Juan"),"Este es como mi quinto post",[(5,"Natalia")])]
    ]

run7= runTestTT testPublicacionesQueLeGustanA
testPublicacionesQueLeGustanA= test[
    "Caso 1: Usuario que no le gusta ninguna publicacion" ~: (publicacionesQueLeGustanA redA (3,"Pedro")) ~?= [],
    "Caso 2: Usuario que no le gusta ninguna publicacion en una red sin publicaciones" ~: (publicacionesQueLeGustanA redD (7,"Armando")) ~?= [],
    "Caso 3: Usuario que le gusta una publicacion" ~: (publicacionesQueLeGustanA redF (5, "Natalia")) ~?= [(usuario1, "Este es como mi quinto post", [usuario5])],
    "Caso 4: Usuario que le gusta mas de una publicacion" ~:(publicacionesQueLeGustanA redA (4, "Mariela")) ~?= [(usuario1, "Este es mi primer post", [usuario2, usuario4]),(usuario1, "Este es mi segundo post", [usuario4]),(usuario2, "Hello World", [usuario4]),(usuario2, "Good Bye World", [usuario1, usuario4])]
    ]
expectAny actual expected = elem actual expected ~? ("expected any of: " ++ show expected ++ "\n but got: " ++ show actual)

-- Ejemplos

usuario1 = (1, "Juan")
usuario2 = (2, "Natalia")
usuario3 = (3, "Pedro")
usuario4 = (4, "Mariela")
usuario5 = (5, "Natalia")
usuario6 = (6, "Ricardo") -- añadido para el ej10
usuario7 = (7, "Armando") -- añadido para el ej10
usuario8 = (8, "Alberto") -- añadido para el ej10
usuario9 = (9, "Lucia")
usuario10 = (10, "Rocio")
usuario11= (11, "Natalia")
usuario12= (12, "Julian")


relacion1_2 = (usuario1, usuario2)
relacion1_3 = (usuario1, usuario3)
relacion1_9 = (usuario1, usuario9)
relacion1_4 = (usuario4, usuario1) -- Notar que el orden en el que aparecen los usuarios es indistinto
relacion2_3 = (usuario3, usuario2)
relacion2_4 = (usuario2, usuario4)
relacion2_5 = (usuario2, usuario5)
relacion2_9 = (usuario9, usuario2)
relacion3_4 = (usuario4, usuario3)
relacion4_5 = (usuario4, usuario5) -- agregada para probar transitividad
relacion4_2 = (usuario4, usuario2)
relacion5_6 = (usuario5, usuario6) -- agregada para probar transitividad x2
relacion5_9 = (usuario9, usuario5)
relacion6_7 = (usuario6, usuario7) -- agregada para probar transitividad x3
relacion6_9 = (usuario9, usuario6) 
relacion7_8 = (usuario7, usuario8) -- agregada para probar transitividad x4
relacion7_9 = (usuario9, usuario7)
relacion8_9 = (usuario9, usuario8)
relacion9_3 = (usuario9, usuario3)
relacion9_4 = (usuario4, usuario9)
relacion10_9 =(usuario10,usuario9)
relacion11_9 = (usuario11,usuario9)
relacion12_9 = (usuario9,usuario12)


publicacion1_1 = (usuario1, "Este es mi primer post", [usuario2, usuario4])
publicacion1_2 = (usuario1, "Este es mi segundo post", [usuario4])
publicacion1_3 = (usuario1, "Este es mi tercer post", [usuario2, usuario5])
publicacion1_4 = (usuario1, "Este es mi cuarto post", [])
publicacion1_5 = (usuario1, "Este es como mi quinto post", [usuario5])

publicacion2_1 = (usuario2, "Hello World", [usuario4])
publicacion2_2 = (usuario2, "Good Bye World", [usuario1, usuario4])

publicacion3_1 = (usuario3, "Lorem Ipsum", [])
publicacion3_2 = (usuario3, "dolor sit amet", [usuario2])
publicacion3_3 = (usuario3, "consectetur adipiscing elit", [usuario2, usuario5])
publicacion4_1 = (usuario4, "I am Alice. Not", [usuario1, usuario2])
publicacion4_2 = (usuario4, "I am Bob", [])
publicacion4_3 = (usuario4, "Just kidding, i am Mariela", [usuario1, usuario3])

-- redA
usuariosA = [usuario1, usuario2, usuario3, usuario4]
relacionesA = [relacion1_2, relacion1_4, relacion2_3, relacion2_4, relacion3_4]
publicacionesA = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion4_1, publicacion4_2]
redA = (usuariosA, relacionesA, publicacionesA)

-- redB
usuariosB = [usuario1, usuario2, usuario3, usuario5]
relacionesB = [relacion1_2, relacion2_3]
publicacionesB = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]
redB = (usuariosB, relacionesB, publicacionesB)

--redC 
relacionesC = [relacion1_2, relacion2_3, relacion2_5, relacion3_4, relacion4_2, relacion4_5, relacion5_6, relacion6_7, relacion7_8,relacion9_4]
usuariosC = [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6]
publicacionesC = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]
redC = (usuariosC, relacionesC, publicacionesC)

--redVacia
usuariosvacios = []
relacionesvacias = []
publicacionesvacias = []
redVacia = (usuariosvacios, relacionesvacias, publicacionesvacias)

--redD (Con solo un usuario)
usuariosConSoloUnUsuario = [usuario3]
relacionesDeUnUsuario= []
publicacionesDeUnUsuario = []
redD = (usuariosConSoloUnUsuario, relacionesDeUnUsuario, publicacionesDeUnUsuario )

--redE (SinRelacionesDeAmistad)
relacionesE = []
usuariosE = [usuario2, usuario4, usuario5, usuario6]
publicacionesE = [publicacion2_1,publicacion4_1]
redE= (usuariosE, relacionesE, publicacionesE)

--redF (Con muchas relaciones de amistad)
relacionesF = [relacion1_9,relacion2_9, relacion9_3, relacion9_4, relacion5_9, relacion6_9, relacion7_9, relacion8_9, relacion10_9, relacion11_9, relacion12_9]
usuariosF= [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6, usuario7, usuario8, usuario9, usuario10, usuario11, usuario12]
publicacionesF = [publicacion1_1, publicacion1_5]-- no olvidar agregar publis asi lo uso para el ejercicio de publis 6 o 7!!
redF = (usuariosF, relacionesF, publicacionesF)

--redG (Con solo dos usuarios)
usuariosDos =[usuario7, usuario12]
relacionesG = []
publicacionesG = []--
redG = (usuariosDos, relacionesG, publicacionesG)