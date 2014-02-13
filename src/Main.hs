module Main where
import GHCore
import CoreTest
import OAuth

-- main = testIssue
-- main = testGithub
main = testCachedAccess >>= print

