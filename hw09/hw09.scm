
; Tail recursion

(define (replicate x n)
  (define (helper lst i)
    (if (= n i)
      lst
      (
        helper (cons x lst) (+ i 1)
      )
    )   
  )
  (helper '() 0)
)

(define (accumulate combiner start n term)
  (define (helper sofar i)
      (if (< n i)
          sofar
          (helper (combiner sofar (term i)) (+ i 1))
      )
  )
  (helper start 1)
)

(define (accumulate-tail combiner start n term)
  (define (helper sofar i)
      (if (< n i)
          sofar
          (helper (combiner sofar (term i)) (+ i 1))
      )
  )
  (helper start 1)
)

; Streams

(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))


(define multiples-of-three
    (map-stream (lambda (n) (+ n 3)) (map-stream (lambda (n) n) (cons-stream 0 multiples-of-three)))
)

; I tried the two below approaches. I still have a bug and can't get the final result in order. Its the reverse. 
; It doesn't crash since I'm doing tail recursion but it doesn't give me any answer for infinite streams.

(define (nondecreastream s)
    (define (helper final sofar last-element s)
        (cond
            ((null? s) (cons-stream (reverse sofar) final))
            ((> last-element (car s)) (helper (cons-stream (reverse sofar) final) (cons (car s) nil) (car s) (cdr-stream s)))
            (else (helper final (cons (car s) sofar) (car s) (cdr-stream s)))
        )
    )
    (helper '() '() 0 s)
)

(define (nondecreastream1 s)
    (define (helper final sofar last-element s)
        (cond
            ((null? s) final)
            ((> last-element (car s)) (cons-stream (nondecreastream1 (cdr-stream s)) final))
            (else (helper final (cons (car s) sofar) (car s) (cdr-stream s)))
        )
    )
    (helper '() '() 0 s)

)


(define (reverse l)
  (if (null? l)
     nil
     (append (reverse (cdr l)) (list (car l)))
  )
)

(define (reverse-stream l)
  (if (null? l)
    nil
    (append (reverse-stream (cdr-stream l)) (cons-stream (car l)))
  )
)
(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))