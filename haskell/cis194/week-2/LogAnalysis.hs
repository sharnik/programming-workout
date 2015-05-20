{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where
import Log

parseMessage :: String -> LogMessage
parseMessage raw_msg = case (words raw_msg) of
  ("E":level:timestamp:msg) ->
    LogMessage (Error (read level :: Int)) (read timestamp :: Int) (unwords msg)
  (category:timestamp:msg) ->
    let time = read timestamp :: Int in
    let message = unwords msg in
    case category of
      "I" -> LogMessage Info time message
      "W" -> LogMessage Warning time message
      _ -> Unknown raw_msg
  _ -> Unknown raw_msg


parse :: String-> [LogMessage]
parse string =
  map parseMessage (lines string)

insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert msg Leaf = Node Leaf msg Leaf
insert msg@(LogMessage _ new_timestamp _) tree@(Node left_tree (LogMessage _ tree_timestamp _) right_tree)
  | new_timestamp < tree_timestamp = insert msg left_tree
  | new_timestamp > tree_timestamp = insert msg right_tree

build :: [LogMessage] -> MessageTree
build msgs = foldr insert Leaf msgs

