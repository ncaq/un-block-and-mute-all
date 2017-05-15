module Handler.Home where

import           Import

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "ブロック全解除ツール"
    $(widgetFile "home")
