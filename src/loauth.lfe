(defmodule loauth
  (export all))

(include-lib "lutil/include/compose.lfe")
(include-lib "loauth/include/loauth.lfe")

(defun start ()
  `(#(inets ,(inets:start))
    #(ssl ,(ssl:start))
    #(lhttpc ,(lhttpc:start))))

(defun get-code (state)
  (loauth-client:get (get-auth-url state)))

(defun get-token (state)
  'noop)

(defun get-token (username password state)
    (->> (get-token-json username password state)
         (ljson:decode)
         (ljson:get '#("access_token"))
         (binary_to_list)))

(defun get-token-json (username password state)
  (lhc:post (loauth-data-token-uri state)
            '(#("Content-Type" "application/x-www-form-urlencoded"))
            (++ "grant_type=password&"
                "username=" username "&"
                "password=" password "&"
                "client_id=" (loauth-data-client-id state) "&"
                "client_secret=" (loauth-data-client-secret state))
            (set-lhc-opts)))

;;; Support functions

(defun set-lhc-opts ()
  `(#(callback ,#'loauth-client:parse-results/3)))

(defun get-auth-url
  (((match-loauth-data auth-uri url
                       client-id id
                       auth-redirect-uri redirect
                       response-type rtype))
    (++ url "/?"
        "client_id=" id "&"
        "redirect_uri=" redirect "&"
        "response_type=" rtype)))
