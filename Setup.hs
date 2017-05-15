import           Distribution.PackageDescription
import           Distribution.Simple
import           Distribution.Simple.Setup
import           System.Process

main :: IO ()
main = defaultMainWithHooks simpleUserHooks { preBuild = pb }

pb :: Args -> BuildFlags -> IO HookedBuildInfo
pb _ _ = callProcess "yarn" ["run", "build"] >> return emptyHookedBuildInfo
