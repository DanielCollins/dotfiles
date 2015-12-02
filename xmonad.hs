{-# LANGUAGE FlexibleContexts #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import System.IO

main = xmonad =<< statusBar bar pp toggleStrutsKey conf

bar = "xmobar"

pp = xmobarPP

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

isFloating w = gets (M.member w . W.floating . windowset)

mouse :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
mouse = \cf@(XConfig {modMask = modm}) ->
     M.insert
      (modm, button1)
      (\w -> whenX (isFloating w) (mouseMoveWindow w))
      (mouseBindings defaultConfig cf)

conf = defaultConfig { modMask = mod4Mask,
                       terminal = "urxvt",
                       normalBorderColor = "#101010",
                       focusedBorderColor = "#d0d0d0",
                       startupHook = setWMName "LG3D",
                       mouseBindings = mouse,
                       borderWidth = 3 }
