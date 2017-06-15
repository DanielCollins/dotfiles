{-# LANGUAGE FlexibleContexts #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import System.IO

isFloating w = gets (M.member w . W.floating . windowset)

mouse :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
mouse = \cf@(XConfig {modMask = modm}) ->
    M.insert
      (modm, button1)
      (\w -> whenX (isFloating w) (mouseMoveWindow w))
      (mouseBindings defaultConfig cf)

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $
       defaultConfig
         { modMask = mod4Mask,
           terminal = "urxvt",
           manageHook = manageDocks <+> manageHook defaultConfig,
           layoutHook = avoidStruts $ layoutHook defaultConfig,
           handleEventHook = fullscreenEventHook <+>
                             handleEventHook defaultConfig <+> docksEventHook,
           logHook = dynamicLogWithPP xmobarPP
                      { ppOutput = hPutStrLn xmproc },
           normalBorderColor = "#101010",
           focusedBorderColor = "#d0d0d0",
           startupHook = setWMName "LG3D",
           mouseBindings = mouse,
           borderWidth = 2 } `additionalKeys` 
                                [((mod4Mask, xK_b), sendMessage ToggleStruts)]
