;; extends

; all other elements
(literal_value
  "," @element.outer
  .
  (_) @element.inner @element.outer)

; first element
(literal_value
  .
  (_) @element.inner @element.outer
  .
  ","? @element.outer)


(literal_value
  (_) @element.inner)
