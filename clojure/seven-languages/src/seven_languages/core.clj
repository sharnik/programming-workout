(ns seven-languages.core)

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))

(defn big
  [st n]
  (> (count st) n))

(defn collection-type
  [col]
  ({ clojure.lang.PersistentList :list, clojure.lang.PersistentArrayMap :map, clojure.lang.PersistentVector :vector} (type col)))
