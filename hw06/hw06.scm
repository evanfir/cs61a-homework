;;;;;;;;;;;;;;;
;; Questions ;;
;;;;;;;;;;;;;;;

; Scheme

(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)

(define (sign x)
  (cond
      ((> x 0) 1)
      ((< x 0) -1)
      (else 0))
)

(define (square x) (* x x))

(define (pow b n)
  (cond ((= n 0) 1)
        ((= n 1) b)
        ((= (modulo n 2) 1) (* (pow b (- n 1)) b))
        (else (pow (* b b) (quotient n 2))) 
  )
)

(define (unique s)
    (define result '())
    (unique-helper s result)
)

(define (unique-helper s result)
        (cond
            ((null? s) result)
            ((contain result (car s))
                      (unique-helper (cdr s) result))
            (else (unique-helper (cdr s) (append result (cons (car s) nil))))
        )
    
)

(define (contain lst x)
    (cond
        ((null? lst) #f)
        ((equal? (car lst) x) #t)
        (else (contain (cdr lst) x))
    )
)