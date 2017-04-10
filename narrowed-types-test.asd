;; narrowed-types-test.asd

(defsystem #:narrowed-types-test
    :description "Unit tests for narrowed-types"
    :version "0.1"
    :author "JP Cimalando"
    :licence "BSD"
    :components ((:file "narrowed-types-test"))
    :depends-on (#:narrowed-types #:rt))
