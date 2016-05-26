(ns chapter-3-do-things.core
  (:gen-class))

#_ (Exercise 1)
(def my-vector (vector 1 2 3))
(def my-list (list 1 2 3))
(def my-hash-map (hash-map :one 2 :three 4))
(def my-hash-set (hash-set :one 2 :three 4))

#_ (Exercise 2)
(defn inc-100
  "This function adds a 100"
  [number]
  (+ 100 number))

#_ (Exercise 3)
(defn dec-maker
  "This function creates custom dec-X functions"
  [inc-by]
  (fn [number]
    (- number inc-by)))

(def dec-9 (dec-maker 9))

#_ (Exercise 4)
(defn mapset
  "It's a map for sets"
  [func input-set]
  (loop [remaining-input input-set final-set #{}]
    (let [[elem & remaining] remaining-input
          new-final-set (into final-set [(func elem)])]
      (if (empty? remaining)
        new-final-set
        (recur remaining new-final-set)))))


#_ (Exercise 5)
(def asym-hobbit-body-parts [{:name "head" :size 3}
                             {:name "left-eye" :size 1}
                             {:name "left-ear" :size 1}
                             {:name "mouth" :size 1}
                             {:name "nose" :size 1}
                             {:name "neck" :size 2}
                             {:name "left-shoulder" :size 3}
                             {:name "left-upper-arm" :size 3}
                             {:name "chest" :size 10}
                             {:name "back" :size 10}
                             {:name "left-forearm" :size 3}
                             {:name "abdomen" :size 6}
                             {:name "left-kidney" :size 1}
                             {:name "left-hand" :size 2}
                             {:name "left-knee" :size 2}
                             {:name "left-thigh" :size 4}
                             {:name "left-lower-leg" :size 3}
                             {:name "left-achilles" :size 1}
                             {:name "left-foot" :size 2}])

(defn matching-parts
  "Returns a list of matching parts"
  [part]
  (let [body-part-prefixes '("center-" "right-" "left-center-" "right-center-")]
    (map (fn [prefix]
           {:name (clojure.string/replace (:name part) #"^left-" prefix)
             :size (:size part)})
         body-part-prefixes)))

(defn symmetrize-alien-parts
  "Matches left-* body parts to fit alien hobbit physiology"
  [asym-body-parts]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set (cons part (matching-parts part)))))
          []
          asym-body-parts))

#_ (Exercise 6)
(defn matching-parts
  "Returns a list of matching parts for any physiology"
  [part body-part-prefixes]
  (map (fn [prefix]
          {:name (clojure.string/replace (:name part) #"^left-" prefix)
          :size (:size part)})
        body-part-prefixes))

(defn symmetrize-custom-body-parts
  "Matches asymetric body parts list to any physiology"
  [asym-body-parts body-part-prefixes]
  (reduce (fn [final-body-parts part]
            (into final-body-parts (set (cons part (matching-parts part body-part-prefixes)))))
          []
          asym-body-parts))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println (str "Hello," " World!"))
  (println my-vector)
  (println my-list)
  (println my-hash-map)
  (println my-hash-set)
  (println (inc-100 31))
  (println (dec-9 12))
  (println (mapset #(+ % 3) [1 2 2 3 3]))
)
