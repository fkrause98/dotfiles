;;; dape.el -*- lexical-binding: t; -*-
(setq dape-cwd-fn 'projectile-project-root)
(map! :map dape-mode-map
      :leader
      :prefix ("d" . "dap")
      :desc "dap hydra" "h" #'hydra-dap/body

      :desc "dap debug"   "s" #'dape
      :desc "dap quit"    "q" #'dape-quit
      :desc "dap restart" "r" #'dape-restart

      :desc "dap breakpoint toggle"     "b" #'dape-breakpoint-toggle
      :desc "dap breakpoint remove all" "B" #'dape-breakpoint-remove-all
      :desc "dap breakpoint log"        "l" #'dape-breakpoint-log

      :desc "dap continue" "c" #'dape-continue
      :desc "dap next"     "n" #'dape-next
      :desc "dap step in"  "i" #'dape-step-in
      :desc "dap step out" "o" #'dape-step-out

      :desc "dap eval" "e" #'dape-evaluate-expression)
(require 'hydra)
(defhydra hydra-dap (:color pink :hint nil)
  "
        ^Dape Hydra^
        ------------------------------------------------
        _n_: Next       _e_: Eval    _Q_: Disconnect
        _i_: Step In
        _o_: Step Out
        _c_: Continue
        _r_: Restart

        "
  ("n" #'dape-next)
  ("i" #'dape-step-in)
  ("o" #'dape-step-out)
  ("c" #'dape-continue)
  ("e" #'dape-evaluate-expression)
  ("r" #'dape-restart)
  ("q" nil "Quit" :color blue)
  ("Q" #'dape-quit :color blue))
