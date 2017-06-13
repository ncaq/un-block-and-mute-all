module Handler.Home where

import           Control.Monad.IO.Class
import           Data.Conduit
import qualified Data.Conduit.List                 as CL
import           Import
import           Web.Twitter.Conduit
import           Web.Twitter.Conduit.Api
import           Web.Twitter.Conduit.Parameters
import           Web.Twitter.Conduit.Parameters.TH
import           Web.Twitter.Types

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "全解除ツール(WIP)"
    $(widgetFile "home")
    $(widgetFile "elm-main-embed")
    $(widgetFile "twitter-value")

getBlocksR :: Handler Value
getBlocksR = do
    twInfo <- handlerTwInfo
    mgr <- liftIO $ Web.Twitter.Conduit.newManager tlsManagerSettings
    blocks <- liftIO $ call twInfo mgr blockIds
    returnJson $ contents blocks

data BlockIds

blockIds :: APIRequest BlockIds (WithCursor IdsCursorKey UserId)
blockIds = APIRequestGet ("https://api.twitter.com/1.1/blocks/ids.json") def

handlerTwInfo :: Handler TWInfo
handlerTwInfo = do
    oauth <- sessionOAuth
    credential <- sessionCredential
    return $ setCredential oauth credential def

sessionOAuth :: Handler OAuth
sessionOAuth = do
    master <- getYesod
    return $ twitterOAuth
        { oauthConsumerKey = encodeUtf8 (appTwitterKey (appSettings master))
        , oauthConsumerSecret = encodeUtf8 (appTwitterSecret (appSettings master))
        }

sessionCredential :: Handler Credential
sessionCredential = do
    mOAuthToken <- lookupSession "oauth_token"
    mOAuthTokenSecret <- lookupSession "oauth_token_secret"
    case (mOAuthToken, mOAuthTokenSecret) of
        (Just oauthToken, Just oauthTokenSecret) ->
            return $ newCredential (encodeUtf8 oauthToken) (encodeUtf8 oauthTokenSecret)
        _                                        -> notAuthenticated
