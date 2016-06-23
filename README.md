# shell-w32-env - make shell work a little better on windows

Author: noah peart

This is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Commentary

Fix shell completion at point for windows env. variables:
 + case-insensitive
 + preceded by '%' instead of '$'
 + add annotation for company-capf to show actually values
of env. variables in minibuffer and completion menu.

## Usage

In shell-mode hook, if using cmd.exe of cmdproxy.exe

       (setq shell-dynamic-complete-functions
         '(comint-c-a-p-replace-by-expanded-history
           shell-w32-environment-variable-completion
           shell-c-a-p-replace-by-expanded-directory
           pcomplete-completions-at-point
           shell-filename-completion
           comint-filename-completion))

   ;; and create hook, here using company-shell backend as well

       (defun my-shell-hook ()
         (setq-local company-backends
           '((company-capf company-shell)))
         (shell-completion-vars))

       (add-hook 'shell-mode-hook #'my-shell-hook)


---
Converted from `shell-w32-env.el` by [*el2markdown*](https://github.com/Lindydancer/el2markdown).
