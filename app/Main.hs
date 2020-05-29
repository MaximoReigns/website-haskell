{-# LANGUAGE OverloadedStrings #-}
module Main where

--librerias importadas a partir de las dependencias
import Web.Spock
import Web.Spock.Config
import Network.Wai.Middleware.Static

import Data.IORef
import Web.Spock.Lucid (lucid)

import Lucid

data MySession = EmptySession
data MyAppState = DummyAppState (IORef Int)
    
main :: IO ()
-- Conexion al localhost con el puerto 8080 , diciendole que no usaremos base de datos
main =
    do ref <- newIORef 0
       spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
       runSpock 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
    -- carpeta estatica para las imagenes
    do middleware $ staticPolicy (addBase "static")
    -- la ruta para ir a Mario
       get root $
           text ""
       get ("" ) $    do 
        ----Libreria lucid para usar html y css
         lucid $ do
            -- cabeza del html
             head_ $ do
                 title_ "Curriculum Vitae C.A.S.R"
                 -- body html
             body_  [style_ "background:linear-gradient(45deg,#ea3171,#fc9c4e);"] $ do
                -- el div de fondo de la imagen
                 div_  [style_ "text-align:center"] $ do
                      img_  [src_ "/images/undraw_welcome_cats_thqn.svg",style_ "width:300px; "]
                 div_ [style_ "text-align: center"] $ do
                      img_  [src_ "/images/soy_cesar.gif",style_ "width:350px; background-repeat: no-repeat; background-position: center; padding: 10px; background-size: 350px;"]             
                 h1_[style_"font-family: 'Open Sans', sans-serif; text-align: center;"] $ "Ing. sistemas computacionales"
                 p_ [style_"font-family: 'Open Sans', sans-serif; text-align: center; font-size: 25px"] "Mi nombre es Cesar Alonso Sánchez Ríos y soy mejor conocido como @ELCHINO, nací el 10 de Septiembre de 1998 en cancún Quintana Roo Jugador profesional hardcore, me gusta el internet y los pug." 
                 div_ [style_ "text-align: center;"] $ do
                     img_  [src_ "/images/background-cesar.JPEG",style_ "width:700px; background-repeat: no-repeat; background-position: center; padding: 10px; background-size: 350px;"]
                     h1_[style_"font-family: 'Open Sans', sans-serif; text-align: center;"] $ "MI EXPERIENCIA"
                     p_ [style_"font-family: 'Open Sans', sans-serif; text-align: center; font-size: 25px"] "Desarrollo en Java"
                     p_ [style_"font-family: 'Open Sans', sans-serif; text-align: center; font-size: 25px"] "Desarrollo y administración MySQL"
                     p_ [style_"font-family: 'Open Sans', sans-serif; text-align: center; font-size: 25px"] "Analista de tráfico de redes en Wireshark"
                     p_ [style_"font-family: 'Open Sans', sans-serif; text-align: center; font-size: 25px"] "Pentester Hack the Box"
                     p_ [style_"font-family: 'Open Sans', sans-serif; text-align: center; font-size: 25px"] "Manualidades (Origami)"