require unix/socket.fs

8067 constant port

create buf 1400 allot
create server
create socket

: listen-and-accept 
  cr ." listening" server @ 128 listen cr ." done listen"
  cr ." accepting" server @ accept-socket socket ! ." accepted socket" 
;

: response s\" HTTP/1.0 200 Ok\r\nContent-Type: text/html\r\n\r\n<html><head><title>hello</title></head><body><h1>hello world</h1></body></html>\r\n" 
socket @ write-socket 
;

: get-request socket @ buf 1400 read-socket ;

: httpd (  -- )
  cr ." Server started on http://127.0.0.1:" port . port create-server server ! cr 
  ." server created"
  begin
    listen-and-accept
    10 0 do \ 200 ms timeout
      cr i . r@ .
      get-request 
      0> if 255 type response r> 9 >r else ." nada" then
      20 ms 
    loop
    socket @ close-socket
  again
;

httpd bye