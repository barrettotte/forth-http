include unix/socket.fs
include str.fth

8004 constant fth-port
255  constant queue-size
2048 constant reqbuff-size

create fth-server
create fth-socket

\ append HTTP header to response
: append-header s\" Content-Type: text/html\n\n" s+ 2swap s+ ;

\ return 404 page
: not-found ( -- addr u ) 2drop s" 404.html" slurp-file s\" HTTP/1.1 404 Not Found\n"  append-header ;

\ check if requested file path exists
: file-exists? ( addr u -- ? ) 2dup file-status nip 0= ;

\ read request from client socket
: get-req ( socket -- addr u ) pad reqbuff-size read-socket ;

\ write response to client socket
: send-resp ( addr u socket -- ) dup >R write-socket R> close-socket ;

\ serve the file, otherwise respond with 404 page
: serve-file ( addr1 u1 -- addr2 u2 )
    file-exists? >R 
    2dup drop c@ [char] / <> R> and if 
        slurp-file s\" HTTP/1.1 200 OK\n" append-header
    else
        not-found
    then 
;

\ process client request
: handle-req ( addr u -- )
    2dup bl -strip s" GET" str= if
        [char] / after$ bl -strip serve-file
    else
        not-found
    then
    fth-socket @ send-resp
;

\ continually listen and accept new requests
: server-loop
    begin
        fth-server @ queue-size listen
        fth-server @ accept-socket fth-socket !
        fth-socket @ get-req handle-req
    again 
;

\ entry point
: forth-http
    ." Listening on http://127.0.0.1:" fth-port . ." ... " cr
    fth-port create-server fth-server ! server-loop
;

forth-http cr bye
