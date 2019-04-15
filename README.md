# suboptimal

Version: prototype-v1

## What is it?

A local coop game about controlling a submarine through treacherous waters containing everything from sink bombs to sharks emergency repairs, low oxygen levels, lasers, hunger, implosions and everything else that makes sense to have in a game about submarines (e.g. dinosaurs)

## Development methodology

* Create a new branch for functionality
* Scenes are hard to merge if there are merge conflicts
    * Instead, create individual scenes for stuff like an enemy
    * If the implementation requires additional context, create a new example scene instead
* When functionality has been implemented, create a pull request (verify first that there are no merge conflicts)
    * If there are merge conflicts, merge the master branch into your feature-branch first and resolve any conflicts that may have arisen.