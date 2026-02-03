;; extends

; all other elements
(literal_value
  "," @_start
  .
  (_) @element.inner
  (#make-range! "element.outer" @_start @element.inner))

; first element
(literal_value
  .
  (_) @element.inner
  .
  ","? @_end
  (#make-range! "element.outer" @element.inner @_end))

(literal_value
  (_) @element.inner)
