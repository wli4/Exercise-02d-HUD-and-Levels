# Exercise-02d-HUD-and-Levels
Exercise for MSCH-C220, 17 September 2020

This exercise is designed to explore changing scenes and control nodes. I am hoping this gives you what you need to complete your project.

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-02d-HUD-and-Levels. *Edit the LICENSE and replace BL-MSCH-C220-F20 with your full name.* Commit your changes.

Press the green "Code" button and select "Open in GitHub Desktop". Clone the repository to a Local Path on your computer.

Open Godot. In the Project Manager, tap the "Import" button. Tap "Browse" and navigate to the repository folder. Select the project.godot file and tap "Open".

In the viewport, you should see a *very* rough 2D space shooter-style game. The A and D controls move the ship left and right, and the space button will shoot a laser at the space cows.

Your assignment for this exercise is to provide the following: change the default scene to a main menu that offers options to Play and Quit. The play button should load the Game.tscn scene. Add an AutoLoad HUD scene that displays score and health as labels. When the score reaches 100, show the Level node; if the player touches the Level, the scene should change to level2.tscn (which you will need to create), which is identical to game.tscn, except without the Level node and the cows are replaced by narwhals. Add an end-game screen that appears when the player's health reaches zero.

You can change to a new scene in Godot with a simple statement:
```
get_tree().change_scene("res://path/to/scene.tscn")
```

I will take a significant time in class to walk through the details of this exercise. That demonstration will also be posted to youtube.

Test the game. You should be able to start the game, go to the second level, and then see the end-game screen when the health goes to zero.

Quit Godot. In GitHub desktop, you should now see the updated files listed in the left panel. In the bottom of that panel, type a Summary message (something like "Completes the game development") and press the "Commit to master" button. On the right side of the top, black panel, you should see a button labeled "Push origin". Press that now.

If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-02d-HUD-and-Levels) on Canvas.

The final state of the file should be as follows (replacing my information with yours):
```
# Exercise-02d-HUD-and-Levels
Exercise for MSCH-C220, 17 September 2020

A simple game exploring HUD elements and changing scenes.

## Implementation
Built using Godot 3.2.2

The font, Bebas Neue Regular (Ryoichi Tsunekawa) was downloaded from [https://fontlibrary.org/en/font/bebasneueregular](https://fontlibrary.org/en/font/bebasneueregular)

The looping moving starfield video was created by David Greensmith: [https://archive.org/details/LoopingMovingStarfield](https://archive.org/details/LoopingMovingStarfield)

The explosion sprite sheet was downloaded from [assetsdownload.com](https://assetsdownload.com/cartoon-explosion-2d-game-sprite-free-download/)

The other assets were downloaded from [kenney.nl](https://kenney.nl/assets)


## References
None

## Future Development
None

## Created by 
Jason Francis

```

