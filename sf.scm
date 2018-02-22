#!/usr/bin/env sh
exec guile --no-auto-compile -e main -s "$0" "$@"
!#

;; See COPYING file for license details.

(use-modules (ice-9 rdelim))

;; Used later for user input
(define current-port (current-input-port))

(define buffer-size 10)
(define buffer (make-list buffer-size '0))
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
  (display (integer->char (list-ref buffer pointer))))

(define (bf-input)
  (let ((ascii (char->integer (read-char current-port))))
    (list-set! buffer pointer ascii)))

(define (bf-loop expr)
  (unless (= (list-ref buffer pointer) 0)
    (with-input-from-string expr read-file)
    (bf-loop expr)))

(define (read-file)
  (let ((operator (read-char)))
    (unless (eof-object? operator)
      (case operator
        ((#\>) (bf-inc-pointer!))
        ((#\<) (bf-dec-pointer!))
        ((#\+) (bf-inc!))
        ((#\-) (bf-dec!))
        ((#\.) (bf-output))
        ((#\,) (bf-input))
        ((#\[) (let ((expr (read-delimited "]")))
                 (bf-loop expr))))
      (read-file))))

(define (main args)
  (when (< (length args) 2)
    (display "Need more command-line arguments!")
    (newline)
    (exit))

  (with-input-from-file (cadr args) read-file))
