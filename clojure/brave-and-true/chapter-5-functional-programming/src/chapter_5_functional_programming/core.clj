(ns chapter-5-functional-programming.core
  (:gen-class))

#_ (Exercise 1)

(def character
  {:name "Smooches McCutes"
   :attributes {:intelligence 10
                :strength 4
                :dexterity 5}})

(defn attr
  "Returns character's attribute value"
  [attribute]
  (fn [character] (attribute (:attributes character))))

(def c-int (attr :intelligence))

#_ (Exercise 2)

(defn my-comp
  "My version of the comp function"
  [f & fx]
    (if (empty? fx)
      f
      (let [g (first fx)
            tail (rest fx)]
        (recur (fn [& args] (f (apply g args))) tail))))

(def c-dex (my-comp :dexterity :attributes))

#_ (Exercise 3)

(defn my-assoc-in
  "My re-implementation of assoc-in"
  [m [k & ks] v]
  (if (empty? ks)
    (assoc m k v)
    (assoc m k (my-assoc-in {} ks v))))

#_ (Exercise 4)

(def updated-character
  (update-in character '(:attributes :dexterity) + 2))

#_ (Exercise 5)

(defn my-update-in
  "My re-implementation of update-in function"
  [m [k & ks] f & args]
  (let [old-value (get-in m (cons k ks))
       new-value (apply f (cons old-value args))]
    (assoc-in m (cons k ks) new-value)))


(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println (c-int character)))
