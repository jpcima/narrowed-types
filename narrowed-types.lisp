;; narrowed-types.lisp

(defpackage #:narrowed-types
  (:use #:cl)
  (:export #:deftype-narrowed))

(in-package #:narrowed-types)

(defmacro deftype-narrowed ((var type super-type) &body body)
  "DEFTYPE-NARROWED defines a type with name TYPE as well as a matching
predicate TYPE-p. The instances of the resulting type are the subset of
instances of SUPER-TYPE which satisfy a condition on VAR expressed by the BODY
of the statement."
  (check-type var symbol)
  (check-type type symbol)
  (let ((satisfy-predicate (gensym))
        (predicate (intern (format nil "~A-P" type))))
    `(progn (defun ,satisfy-predicate (,var)
              ,@body)
            (defun ,predicate (,var)
              (and (typep ,var ',super-type)
                   (,satisfy-predicate ,var)))
            (deftype ,type ()
              '(and ,super-type (satisfies ,satisfy-predicate))))))
