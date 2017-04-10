;; narrowed-types-test.lisp

(defpackage #:narrowed-types-test
  (:use #:cl #:narrowed-types #:rtest)
  (:export #:do-tests))

(in-package #:narrowed-types-test)

(deftype-narrowed (x odd-integer integer)
  (oddp x))

(deftest types
    (values (typep 1 'odd-integer)
            (typep 2 'odd-integer)
            (typep 1.0 'odd-integer))
  t nil nil)

(deftest predicates
    (values (odd-integer-p 1)
            (odd-integer-p 2)
            (odd-integer-p 1.0))
  t nil nil)

(deftype-narrowed (age young integer)
  (< age 30))
(deftype-narrowed (age old integer)
  (> age 70))

(deftest typecase
    (flet ((test (x) (typecase x
                       (young :young)
                       (old :old))))
      (values (test 10)
              (test 80)
              (test 50)))
  :young :old nil)

(deftype-narrowed (age middle-aged (and integer (not young) (not old)))
    t)

(deftest derived
    (flet ((test (x) (typecase x
                       (young :young)
                       (old :old)
                       (middle-aged :middle-aged))))
      (values (test 10)
              (test 80)
              (test 50)))
  :young :old :middle-aged)
