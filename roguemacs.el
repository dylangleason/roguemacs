;;; roguemacs.el --- A rogue-like dungeon crawler. -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Dylan Gleason

;; Author: Dylan Gleason <dgleason8384@gmail.com>
;; Created: 2023
;; Keywords: games
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

;; RoguEmacs is a rogue-like dungeon crawler game implemented using
;; `gamegrid'. The player advances through a procedurally generated
;; dungeon, encountering monsters and finding treasure along the way.

;;; Code:

;;(eval-when-compile (require 'cl-lib))

(require 'gamegrid)

;;; ;;;;;;;;;;;;;;;;;;;;; constants ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst roguemacs-buffer-name "RoguEmacs"
  "Name of the RoguEmacs game buffer.")

(defconst roguemacs-buffer-width 16
  "Buffer width for the gamegrid.")

(defconst roguemacs-buffer-height 16
  "Buffer height for the gamegrid.")

(defconst roguemacs-tick-interval 0.5
  "Time taken for the game state to update.")

(defconst roguemacs-dungeon-empty-space 0
  "Empty dungeon space placed into the gamegrid buffer.")

(defconst roguemacs-dungeon-wall 1
  "Dungeon floor placed into the gamegrid buffer.")

(defconst roguemacs-dungeon-wall 2
  "Dungeon wall placed into the gamegrid buffer.")

(defconst roguemacs-score-file-name "roguemacs-scores"
  "File name for writing RoguEmacs game scores.")

;;; ;;;;;;;;;;;;;;;;;;;;; game logic ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar-local roguemacs-score 0
  "Player RoguEmacs game score.")

(defvar-local roguemacs-init-gamegrid #'gamegrid-init-buffer
  "Initialize the RoguEmacs game buffer.")

(defvar-local roguemacs-set-cell #'gamegrid-set-cell
  "Set a gamegrid cell.")

;;; ;;;;;;;;;;;;;;;;;;;;; keymaps ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar-keymap roguemacs-mode-map
  :doc "Keymap for RoguEmacs games."
  :name 'roguemacs-mode-map
  "n"   #'roguemacs-start-game
  "q"   #'roguemacs-end-game
  "p"   #'roguemacs-pause-game
  "w"   #'roguemacs-move-north
  "a"   #'roguemacs-move-west
  "s"   #'roguemacs-move-south
  "d"   #'roguemacs-move-east)

(defvar-keymap roguemacs-null-map
  :doc "Keymap for finished RoguEmacs games."
  :name 'roguemacs-null-map
  "n"   #'roguemacs-start-game
  "q"   #'quit-window)

;;; ;;;;;;;;;;;;;;;;;;;;; game logic ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun roguemacs--carve-rooms ()
  ;; TODO
  )

(defun roguemacs--carve-pathways ()
  ;; TODO
  )

(defun roguemacs--connect-rooms ()
  ;; TODO
  )

;;; ;;;;;;;;;;;;;;;;;;;;; game setup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun roguemacs--display-options ()
  "Game options used for configuring the gamegrid display."
  ;; TODO
  )

(defun roguemacs-init-buffer ()
  "Initialize the RoguEmacs game buffer, which should be executed prior
to initializing the display when starting or restarting the game."
  (funcall roguemacs-init-gamegrid
	   roguemacs-buffer-width
	   roguemacs-buffer-height
	   roguemacs-dungeon-empty-space)
  ;; This mode derives from `special-mode', so temporarily write to
  ;; the buffer by setting `buffer-read-only' to nil.
  (let ((buffer-read-only nil))
    ;; First populate the buffer by setting all the walls, starting at
    ;; top left coordinates (0, 0)
    (dotimes (y roguemacs-buffer-height)
      (dotimes (x roguemacs-buffer-width)
	(funcall roguemacs-set-cell x y roguemacs-dungeon-wall)))
    ;; TODO: Carve out the walls of the dungeon, placing the floors
    ))

(defun roguemacs-update-game ()
  "Called by the game loop on each tick. Updates the position of
the game objects within the dungeon, including the player and
enemies."
  ;; TODO
  )

(defun roguemacs-reset-game ()
  "Reset the current RoguEmacs game."
  (gamegrid-kill-timer)
  (roguemacs-init-buffer))

(defun roguemacs-start-game ()
  "Start a new game of RoguEmacs."
  (interactive nil roguemacs-mode)
  (roguemacs-reset-game)
  (use-local-map roguemacs-mode-map)
  (gamegrid-start-timer roguemacs-tick-interval #'roguemacs-update-game))

(defun roguemacs-end-game ()
  "End the current RoguEmacs game and add the player scores."
  (interactive nil roguemacs-mode)
  (gamegrid-kill-timer)
  (use-local-map roguemacs-null-map)
  (gamegrid-add-score roguemacs-score-file-name roguemacs-score))

(define-derived-mode roguemacs-mode special-mode "RoguEmacs"
  "A mode for playing RoguEmacs, a rogue-like dungeon crawler."
  :interactive nil
  (add-hook 'kill-buffer-hook 'gamegrid-kill-timer nil t)
  (use-local-map roguemacs-null-map)
  (gamegrid-init (roguemacs--display-options)))

;;;###autoload
(defun roguemacs ()
  "Play a rogue-like dungeon crawler game. You, the hero, advance
through a procedurally generated dungeon, encountering monsters,
finding treasure, and discovering hidden rooms."
  (interactive nil roguemacs-mode)
  (switch-to-buffer roguemacs-buffer-name)
  (gamegrid-kill-timer)
  (roguemacs-mode)
  (roguemacs-start-game))

(provide 'roguemacs)

;;; roguemacs.el ends here
