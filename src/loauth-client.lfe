(defmodule loauth-client
  (export all))

(defun parse-results
  ((args _opts `#(ok #(#(,code ,_status) ,headers ,body)))
   (if (follow? (cadr args) code)
       (follow headers)
       `#(ok ,body)))
  ((_args _opts x)
   x))

(defun follow?
  (('GET code)
   (if (lists:member code (loauth-const:follow-redirects))
       'true
       'false))
  ((_ _)
   'false))

(defun follow (headers)
  (get (get-location headers)))

(defun get-location
  ((`#("Location" ,url))
   url)
  ((headers)
   (get-location (lists:keyfind "Location" 1 headers))))
