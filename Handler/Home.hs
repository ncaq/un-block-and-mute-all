module Handler.Home where

import           Import

getHomeR :: Handler Html
getHomeR = defaultLayout $ setTitle "ブロック全解除ツール"
