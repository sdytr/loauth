(defmodule loauth-client
  (export all))

(defun get (url)
  (get url '()))

(defun get (url headers)
  (request url 'GET headers ""))

(defun put (url)
  (put url ""))

(defun put (url data)
  (request url 'PUT data))

(defun post (url)
  (post url ""))

(defun post (url data)
  (post url '() data))

(defun post (url headers data)
  (request url 'POST headers data))

(defun request (url method body)
  (request url method '() body))

(defun request (url method headers body)
  (request url method headers body (* 30 1000)))

(defun request (url method headers body timeout)
  (parse-results
    (lhttpc:request url method headers body timeout)
    method))

(defun parse-results
  ((`#(ok #(#(,code ,_status) ,headers ,body)) method)
   (if (follow? method code)
       (follow headers)
       (binary_to_list body)))
  ((x _method)
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
