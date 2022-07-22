(defmodule compile-util-tests
  (behaviour ltest-unit))

(include-lib "ltest/include/ltest-macros.lfe")

(include-lib "apps/lfe-ls/include/lsp-model.lfe")

(deftest compile--ok--no-include
  (let ((`#(ok ,cwd) (file:get_cwd)))
    (is-equal #(ok ()) (compile-util:compile-file
                        (++ cwd "/compile-tmpls/ok-no-include.lfe")))))

(deftest compile--error--no-include
  (let ((`#(ok ,cwd) (file:get_cwd)))
    (is-equal (tuple
               'ok
               (list
                (make-diagnostic-item
                 range (line-to-range 1)
                 severity (diag-severity-error)
                 source #"lfe_lint"
                 message #"#(undefined_function #(my-fun 1))")))
              (compile-util:compile-file
               (++ cwd "/compile-tmpls/error-no-include.lfe")))))
