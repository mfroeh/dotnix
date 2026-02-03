;; extends

; I don't know if treesitter builds whitespace nodes, so just treat inner and outer the same for now
(list_expression (_) @element.inner)
(list_expression (_) @element.outer)
