(ns fwpd.core)

(def filename "suspects.csv")

(def vamp-keys [:name :glitter-index])

(defn str->int
  [str]
  (Integer. str))

(def conversions {:name identity
                  :glitter-index str->int})

(defn convert
  [vamp-key value]
  ((get conversions vamp-key) value))

(defn parse
  "Convert a CSV into rows of columns"
  [string]
  (map #(clojure.string/split % #",")
       (clojure.string/split string #"\n")))

(defn mapify
  "Return a seq of maps like {:name \"Edward Cullen\" :glitter-index 10}"
  [rows]
  (map (fn [unmapped-row]
         (reduce (fn [row-map [vamp-key value]]
                   (assoc row-map vamp-key (convert vamp-key value)))
                 {}
                 (map vector vamp-keys unmapped-row)))
       rows))

(defn glitter-filter
  [minimum-glitter records]
  (filter #(>= (:glitter-index %) minimum-glitter) records))

#_ (Exercise 1)

(defn namify-villain
  "Returns just the name from a record"
  [records]
  (map #(:name %) records()))

#_ (Exercise 2)

(defn append-suspect
  "Appends a suspect to the list"
  [suspects name glitter-index]
  (conj suspects {:name name :glitter-index glitter-index}))

#_ (Exercise 3)

(def validations {:name #(string? %)
                  :glitter-index #(integer? %)})

(defn validate
  "Validates both :name and :glitter-index are present"
  [keywords record]
  record
  (every? #((% validations) (% record)) keywords))

#_ (Exercise 4)

(defn to-csv
  "Convert vampire records to CSV"
  [keywords records]
  (let [records-as-name-index-list (map (fn [record]
                                          (map #(% record) keywords))
                                        records)
        records-as-strings (map #(clojure.string/join ", " %) records-as-name-index-list)]
    (clojure.string/join "\n" records-as-strings)))
