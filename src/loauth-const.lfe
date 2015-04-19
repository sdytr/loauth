(defmodule loauth-const
  (export all))

(defun follow-redirects ()
  (list (lfest-codes:moved-permanently)
        (lfest-codes:found)
        (lfest-codes:temporary-redirect)
        (lfest-codes:permanent-redirect)))
