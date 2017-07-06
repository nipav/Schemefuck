#!/usr/bin/guile \
--no-auto-compile -e main -s
!#

;; See COPYING file for license details.

(define buffer '(0 0 0 0 0 0 0 0 0 0))
(define pointer 0)

(define (bf-print-buffer)
  (display buffer)
  (newline))

(define (bf-inc-pointer!)
  (set! pointer (+ pointer 1)))

(define (bf-dec-pointer!)
  (set! pointer (- pointer 1)))

(define (bf-inc!)
  (list-set! buffer pointer (+ (list-ref buffer pointer) 1)))

(define (bf-dec!)
  (list-set! buffer pointer (- (list-ref buffer pointer) 1)))

(define (bf-output)
  (display (list-ref buffer pointer)))

(define (read-file)
  (let ((operator (read-char)))
    (unless (eof-object? operator)
      (case operator
        ((#\>) (bf-inc-pointer!))
        ((#\<) (bf-dec-pointer!))
        ((#\+) (bf-inc!))
        ((#\-) (bf-dec!))
        ((#\.) (bf-output)))
      (read-file))))

;; TODO: input

;; TODO: loop

(define (main args)
  (when (< (length args) 2)
    (display "Need more command-line arguments!")
    (newline)
    (exit))

  (bf-print-buffer)
  (with-input-from-file (cadr args) read-file)
  (bf-print-buffer))
