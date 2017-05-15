module Handler.HomeSpec (spec) where

import           TestImport

spec :: Spec
spec = withApp $ do

    describe "home" $ do
      it "getHomeR" $ do
          get HomeR
          statusIs 200
