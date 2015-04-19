(defmodule loauth-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'loauth))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(loauth ,(get-version)))))
