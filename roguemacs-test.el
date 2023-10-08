;;; roguemacs-test.el --- RoguEmacs Tests -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Dylan Gleason

;; Author: Dylan Gleason <dgleason8384@gmail.com>
;; Created: 2023
;; Keywords: games
;; Package-Requires: ((emacs "29.1"))
;; Homepage: https://github.com/dylangleason/roguemacs
;; Version: 0.0.1

;; This file is NOT part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This file contains tests exercising RoguEmacs game logic.

;;; Code:

(require 'roguemacs)

(ert-deftest roguemacs-test-initial-buffer ()
  (let* ((expected)
         (actual (make-list (* roguemacs-buffer-height
                               roguemacs-buffer-width)
                            roguemacs-dungeon-wall))
         (roguemacs-init-gamegrid
          (lambda (_ _ _)))
         (roguemacs-set-cell
          (lambda (_ _ marker)
            (push marker expected))))
    (roguemacs-init-buffer)
    (should (equal expected actual))))

(provide 'roguemacs-test)

;;; roguemacs-test.el ends here
