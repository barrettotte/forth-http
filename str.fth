\ string utils

\ copy string constant to string variable
: place$ over over >r >r char+ swap chars cmove r> r> c! ;

\ copy string variable to another string variable
: copy$ ( addr1 addr2 -- ) swap dup count 1+ swap drop rot swap cmove ;

\ print string
: print$ ( addr -- ) count type ;

\ get length of string
: length$ ( addr -- ) count swap drop ;

\ check if two strings are equal
: eq$ ( addr1 len1 addr2 len2 -- ? ) compare 0= ;

\ check if two string are not equal
: neq$ ( addr1 len1 addr2 len2 -- ? ) compare 0<> ;

\ convert string to uppercase
: upper$ ( addr len -- ) over + swap do i c@ toupper i c! loop ;