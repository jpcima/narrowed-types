# narrowed-types
Type definitions narrowed with predicates

# Description

This Common Lisp package provides a single macro which helps you define type specifiers for subsets, on the basis on an existing supertype and a condition expressed on the value.

DEFMACRO **deftype-narrowed** ((*var* *type* *super-type*) &body *body*)

    DEFTYPE-NARROWED defines a type with name TYPE as well as a matching predicate TYPE-p.
    The instances of the resulting type are the subset of instances of SUPER-TYPE which satisfy
    a condition on VAR expressed by the BODY of the statement.

# Example

This simple example defines a type for the odd integers.

    (deftype-narrowed (x odd-integer integer)
      (oddp x))

Note: In the body of the example, the argument *x* to *oddp* is guaranteed to be an instance of the supertype *integer*.

The type *odd-integer* is usable in any context where a type specifier is expected.
This includes standard forms such as *typep*, *check-type*, *typecase*, *the*, *defstruct*, *defclass*.
You may not use it however to specialize a generic method.

    (typecase x
      (odd-integer :odd)
      (integer :even)
      (t :other))

For some more usage examples, see tests.

# References

[CLHS 4.2.3: Type Specifiers](http://www.lispworks.com/documentation/HyperSpec/Body/04_bc.htm)
