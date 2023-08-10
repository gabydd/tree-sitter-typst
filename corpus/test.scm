=====================
Test 001
=====================
a b
---------------------

(source_file
	(text)
	(text))


=====================
Test 002
=====================
#a b
---------------------

(source_file
	(ident)
	(text))


=====================
Test 003
=====================
Hello #hey World!
---------------------

(source_file
	(text)
	(ident)
	(text))


=====================
Test 004
=====================
Hello #a + b World!
---------------------

(source_file
	(text)
	(ident)
	(text)
	(text)
	(text))


=====================
Test 005
=====================
Hello #(a + b) World!
---------------------

(source_file
	(text)
	(group
		(add
			(ident)
			(ident)))
	(text))


=====================
Test 006
=====================
#(a + b + c)
---------------------

(source_file
	(group
		(add
			(add
				(ident)
				(ident))
			(ident))))


=====================
Test 007
=====================
#(a + b * c)
---------------------

(source_file
	(group
		(add
			(ident)
			(mul
				(ident)
				(ident)))))


=====================
Test 008
=====================
#(a * b + c)
---------------------

(source_file
	(group
		(add
			(mul
				(ident)
				(ident))
			(ident))))


=====================
Test 009
=====================
#(a() + c)
---------------------

(source_file
	(group
		(add
			(call
				item: (ident)
				(group))
			(ident))))


=====================
Test 010
=====================
#a() Hello
---------------------

(source_file
	(call
		item: (ident)
		(group))
	(text))


=====================
Test 011
=====================
#a()Hello
---------------------

(source_file
	(call
		item: (ident)
		(group))
	(text))


=====================
Test 012
=====================
#a!Hello
---------------------

(source_file
	(ident)
	(text))


=====================
Test 013
=====================
#a()()Hello
---------------------

(source_file
	(call
		item: (call
			item: (ident)
			(group))
		(group))
	(text))


=====================
Test 014
=====================
#[Hello World!]
---------------------

(source_file
	(content
		(text)
		(text)))


=====================
Test 015
=====================
#{a}
---------------------

(source_file
	(block
		(ident)))


=====================
Test 016
=====================
#(a, b)
---------------------

(source_file
	(group
		(ident)
		(ident)))


=====================
Test 017
=====================
#(a, c: b)
---------------------

(source_file
	(group
		(ident)
		(tagged
			field: (ident)
			(ident))))


=====================
Test 018
=====================
#hello(a, c: b)
---------------------

(source_file
	(call
		item: (ident)
		(group
			(ident)
			(tagged
				field: (ident)
				(ident)))))


=====================
Test 019
=====================
#hello(a, c: b)World
---------------------

(source_file
	(call
		item: (ident)
		(group
			(ident)
			(tagged
				field: (ident)
				(ident))))
	(text))


=====================
Test 020
=====================
#hello()[World]
---------------------

(source_file
	(call
		item:
		(call
			item: (ident)
			(group))	
		(content
			(text))))


=====================
Test 021
=====================
#if a {} else {}
---------------------

(source_file
	(branch
		test: (ident)
		(block)
		(block)))


=====================
Test 022
=====================
#if a {} elsa {}
---------------------

(source_file
	(condition
		test: (ident)
		(block))
	(text)
	(text))


=====================
Test 023
=====================
#if a {} elsee {}
---------------------

(source_file
	(condition
		test: (ident)
		(block))
	(text)
	(text))


=====================
Test 024
=====================
a b
c

d e
---------------------

(source_file
	(text)
	(text)
	(text)
	(break)
	(text)
	(text))


=====================
Test 025
=====================
#if a{}


else[]
---------------------

(source_file
	(branch
		test: (ident)
		(block)
		(content)))


=====================
Test 026
=====================
#if a[]{}
---------------------

(source_file
	(condition
		test: (call
			item: (ident)
			(content))
		(block)))


=====================
Test 027
=====================
#if a []{}
---------------------

(source_file
	(condition
		test: (ident)
		(content))
	(text))


=====================
Test 028
=====================
#if(a)[]{}
---------------------

(source_file
	(condition
		test: (call
			item: (group
				(ident))
			(content))
		(block)))


=====================
Test 029
=====================
#if(a) + b[]{}
---------------------

(source_file
	(condition
		test: (add
			(group
				(ident))
			(call
				item: (ident)
				(content)))
		(block)))


=====================
Test 030
=====================
*hello* world
---------------------

(source_file
	(strong
		(text))
	(text))


=====================
Test 031
=====================
_hello_ world
---------------------

(source_file
	(emph
		(text))
	(text))


=====================
Test 032
=====================
*hello _world_*
---------------------

(source_file
	(strong
		(text)
		(emph
			(text))))


=====================
Test 033
=====================
#ifa {}
---------------------

(source_file
	(ident)
	(text))


=====================
Test 034
=====================
#if a {} else {}()
---------------------

(source_file
	(call
		item: (branch
			test: (ident)
			(block)
			(block))
		(group)))


=====================
Test 035
=====================
#let a = b
---------------------

(source_file
	(let
		pattern: (ident)
		value: (ident)))


=====================
Test 036
=====================
#let a = b;Hello
---------------------

(source_file
	(let
		pattern: (ident)
		value: (ident))
	(text))


=====================
Test 037
=====================
#a; Hello
---------------------

(source_file
	(ident)
	(text))


=====================
Test 038
=====================
#{
	let a = b
	a + a
}
---------------------

(source_file
	(block
		(let
			pattern: (ident)
			value: (ident))
	(add
		(ident)
		(ident))))


=====================
Test 039
=====================
#(4.2)
---------------------

(source_file
	(group
		(float)))


=====================
Test 040
=====================
#(4.2em)
---------------------

(source_file
	(group
		(float
			(unit))))


=====================
Test 041
=====================
#3
---------------------

(source_file
	(int))


=====================
Test 042
=====================
#3.2
---------------------

(source_file
	(float))


=====================
Test 043
=====================
#a.b
---------------------

(source_file
	(field
		(ident)
		field: (ident)))


=====================
Test 044
=====================
H #a

W
---------------------

(source_file
	(text)
	(ident)
	(break)
	(text))


=====================
Test 045
=====================
Hello #a
World
---------------------

(source_file
	(text)
	(ident)
	(text))


=====================
Test 046
=====================
Hello #a




World
---------------------

(source_file
	(text)
	(ident)
	(break)
	(text))


=====================
Test 047
=====================
*_hello_ world*
---------------------

(source_file
	(strong
		(emph
			(text))
		(text)))


=====================
Test 048
=====================
*_*hello*_ world*
---------------------

(source_file
	(strong
		(emph
			(strong
				(text)))
		(text)))


=====================
Test 049
=====================
Hello\nWorld
---------------------

(source_file
	(text
		(escape)))


=====================
Test 050
=====================
Hello\#World
---------------------

(source_file
	(text
		(escape)))


=====================
Test 051
=====================
#[
	Hello
]
---------------------

(source_file
	(content
		(text)))


=====================
Test 052
=====================


a b


---------------------

(source_file
	(break)
	(text)
	(text)
	(break))


=====================
Test 053
=====================
a#[

b

]c
---------------------

(source_file
	(text)
	(content
		(break)
		(text)
		(break))
	(text))


=====================
Test 054
=====================
a#[
b

]c
---------------------

(source_file
	(text)
	(content
		(text)
		(break))
	(text))


=====================
Test 055
=====================
a#[
b
]c
---------------------

(source_file
	(text)
	(content
		(text))
	(text))


=====================
Test 056
=====================
a

---------------------

(source_file
	(text))


; =====================
; Test 057
; =====================
; // Hey
; ---------------------

; (source_file
; 	(comment))


; =====================
; Test 058
; =====================
; // Hey


; ---------------------

; (source_file
; 	(comment))


; =====================
; Test 059
; =====================
; #/**/let a = 0
; ---------------------

; (source_file
; 	(comment)
; 	(let
; 		pattern: (ident)
; 		value: (int)))


; =====================
; Test 060
; =====================
; #let /* HEY */ a = 0
; ---------------------

; (source_file
; 	(let
; 		(comment)
; 		pattern: (ident)
; 		value: (int)))


=====================
Test 061
=====================
#set text(a: 0)
---------------------

(source_file
	(set
		(call
			item: (ident)
			(group
				(tagged
					field: (ident)
					(int))))))


=====================
Test 062
=====================
#{
	set text()
}
---------------------

(source_file
	(block
		(set
			(call
				item: (ident)
				(group)))))


=====================
Test 063
=====================
#{
	set text()


	[Hey]
}
---------------------

(source_file
	(block
		(set
			(call
				item: (ident)
				(group)))
		(content
			(text))))


=====================
Test 064
=====================
#"a"4
---------------------

(source_file
	(string)
	(text))


=====================
Test 065
=====================
#"a\""4
---------------------

(source_file
	(string)
	(text))


=====================
Test 066
=====================
#import "a"
---------------------

(source_file
	(import
		(string)))


=====================
Test 067
=====================
#import "a": a, b
---------------------

(source_file
	(import
		(string)
		(ident)
		(ident)))


=====================
Test 068
=====================
#(
	a
)
---------------------

(source_file
	(group
		(ident)))


=====================
Test 069
=====================
#(
	a,
)
---------------------

(source_file
	(group
		(ident)))


=====================
Test 070
=====================
#(
	a,


	o
)
---------------------

(source_file
	(group
		(ident)
		(ident)))


=====================
Test 071
=====================
#(
	b,
	c: d,
)
---------------------

(source_file
	(group
		(ident)
		(tagged
			field: (ident)
			(ident))))


=====================
Test 072
=====================
#import "a"     
---------------------

(source_file
	(import
		(string)))


=====================
Test 073
=====================
#let a = 0          
---------------------

(source_file
	(let
		pattern: (ident)
		value: (int)))


=====================
Test 074
=====================
#import "a";Hello
---------------------

(source_file
	(import
		(string))
	(text))


=====================
Test 075
=====================
#import "a"  ; Hello
---------------------

(source_file
	(import
		(string))
	(text))


=====================
Test 076
=====================
#(2 / 1 * 3)
---------------------

(source_file
	(group
		(mul
			(div
				(int)
				(int))
			(int))))


=====================
Test 077
=====================
#(2 - 1 * 3)
---------------------

(source_file
	(group
		(sub
			(int)
			(mul
				(int)
				(int)))))


=====================
Test 078
=====================
#(2 + - 1)
---------------------

(source_file
	(group
		(add
			(int)
			(sign
				(int)))))


=====================
Test 079
=====================
#(2 - - 1)
---------------------

(source_file
	(group
		(sub
			(int)
			(sign
				(int)))))


=====================
Test 080
=====================
#(0 in "0" not in a)
---------------------

(source_file
	(group
		(in
			(in
				(int)
				(string))
			(ident))))


=====================
Test 081
=====================
#if 2 > 1 []
---------------------

(source_file
	(condition
		test: (cmp
			(int)
			(int))
		(content)))


=====================
Test 082
=====================
#(3

+

4

)
---------------------

(source_file
	(group
		(add
			(int)
			(int))))


=====================
Test 083
=====================
#(
let


a

= 0


+2)
---------------------

(source_file
	(group
		(let
			pattern: (ident)
			value: (add
				(int)
				(int)))))


=====================
Test 084
=====================
#(a => a)
---------------------

(source_file
	(group
		(lambda
			pattern: (ident)
			value: (ident))))


=====================
Test 085
=====================
#range().map
---------------------

(source_file
	(field
		(call
			item: (ident)
			(group))
		field: (ident)))


=====================
Test 086
=====================
#if a {}

---------------------

(source_file
	(condition
		test: (ident)
		(block)))


=====================
Test 087
=====================
#{
 }
---------------------

(source_file
	(block))


=====================
Test 088
=====================
#"httpsgitlab.com"
---------------------

(source_file
	(string))


=====================
Test 089
=====================
#"https://gitlab.com"
---------------------

(source_file
	(string))


=====================
Test 090
=====================
#a-b
---------------------

(source_file
	(ident))


=====================
Test 091
=====================
#for i in a {}
---------------------

(source_file
	(for
		pattern: (ident)
		value: (ident)
		(block)))


=====================
Test 092
=====================
#{let x = 1; x + 2}
---------------------

(source_file
	(block
		(let
			pattern: (ident)
			value: (int))
		(add
			(ident)
			(int))))


=====================
Test 093
=====================
#[*Hey* there!]
---------------------

(source_file
	(content
		(strong
			(text))
		(text)))


=====================
Test 094
=====================
#let add(x, y) = x + y
Sum is #add(2, 3).
---------------------

(source_file
	(let
		pattern: (call
			item: (ident)
			(group
				(ident)
				(ident)))
		value: (add
			(ident)
			(ident)))
	(text)
	(text)
	(call
		item: (ident)
		(group
			(int)
			(int)))
	(text))


=====================
Test 095
=====================
#a. Hello
---------------------

(source_file
	(ident)
	(text)
	(text))


=====================
Test 096
=====================
#a._b_
---------------------

(source_file
	(field
		(ident)
		field: (ident)))


=====================
Test 097
=====================
#a._ b _
---------------------

(source_file
	(ident)
	(text)
	(emph
		(text)))


=====================
Test 098
=====================
#let (_, y) = (1, 2)
---------------------

(source_file
	(let
		pattern: (group
			(ident)
			(ident))
		value: (group
			(int)
			(int))))


=====================
Test 099
=====================
#let (a, .., b) = (1, 2, 3, 4)
---------------------

(source_file
	(let
		pattern: (group
			(ident)
			(elude)
			(ident))
		value: (group
			(int)
			(int)
			(int)
			(int))))


=====================
Test 100
=====================
#let (Homer, ..other) = books
---------------------

(source_file
	(let
		pattern: (group
			(ident)
			(elude
				(ident)))
		value: (ident)))


=====================
Test 101
=====================
#left.zip(right).map(
  ((a,b)) => a + b
)
---------------------

(source_file
	(call
		item: (field
			(call
				item: (field
					(ident)
					field: (ident))
				(group
					(ident)))
			field: (ident))
		(group
			(lambda
				pattern: (group
					(group
						(ident)
						(ident)))
				value: (add
					(ident)
					(ident))))))


=====================
Test 102
=====================
#(a, b => b)
---------------------

(source_file
	(group
		(ident)
		(lambda
			pattern: (ident)
			value: (ident))))


=====================
Test 103
=====================
#if a {}
else if b {}
else {}
---------------------

(source_file
	(branch
		test: (ident)
		(block)
		test: (ident)
		(block)
		(block)))


=====================
Test 104
=====================
#while n < 10 {
	(n,)
}
---------------------

(source_file
	(while
		test: (cmp
			(ident)
			(int))
		(block
			(group
				(ident)))))


=====================
Test 105
=====================
```rust
fn main() {}
```
---------------------

(source_file
	(raw
		lang: (ident)
		(blob)))


=====================
Test _
=====================
---------------------

(source_file
	)
