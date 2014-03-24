import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar"

myPP = xmobarPP { ppCurrent = xmobarColor "#2aa198" "" . wrap "[" "]", ppTitle = xmobarColor "#2aa198" "" . shorten 50 }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig { modMask = mod4Mask,
                           terminal = "urxvt",
                           normalBorderColor = "#586e75",
                           focusedBorderColor = "#d33682",
                           borderWidth = 3 }

