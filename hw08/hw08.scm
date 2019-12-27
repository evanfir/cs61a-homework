; Macros

(define-macro (list-of map-expr for var in lst if filter-expr)
  (define new-lst (list 'filter (list 'lambda (list var) filter-expr) lst))
  (define final (list 'map (list 'lambda (list var) map-expr) new-lst))
  final
)

(define-macro (for sym val expr)
    (list 'map (list 'lambda (list sym) expr) val)
)