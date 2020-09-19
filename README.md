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

The instructions are as follows:

## HUD
 * Right-click on the Game node and Add Child Node. Select Control. Rename the new Control node "HUD".
 * Right-click on the HUD node and Add Child Node. Select ColorRect. In the Inspector panel, Select Control->Rect->Size. Set it to x=1024, y=40. Select ColorRect->Color. Set A=64
 * Right-click on the HUD node and Add Child Node. Select Label. Rename the new Label node "Health". In the Inspector panel, select Control->Margin and set Left=10. select select Control->Rect->Size. Set it to x=502, y=40. Select Label->Text. Set it to "Health: ". Set Valign=Center. Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=20.
 * Right-click on the Health node and Duplicate. Rename the Health2 node "Score". In the Inspector panel, set Label->Text to "Score: ". Set Label->Align=Right. In  Control->Rect set Position.x=512
 * Choose the Script Workspace, and select File->New Script. Name the script Global.gd. Replace the contents of that script (make sure you use tabs to indent it) with:

```
extends Node

var score = 0
var health = 100
var level = 0

func _process(delta):
	if Input.is_action_pressed("quit"):	
		get_tree().quit()
```
 * Save the script.

 * In Project Settings, select the AutoLoad tab. In the path field, select res://Global.gd. The Node Name should be Global. Press Add.
 * Right-click on the HUD node and Attach Script. Press the file icon next to Path. Create a new Folder: HUD. Save the new script to res://HUD/HUD.gd. Replace the contents of that script with:
 
```
extends Control

onready var global = get_node("/root/Global")

func _ready():
	update_score(0)
	update_health(0)


func update_score(s):
	global.score += s
	$Score.text = "Score: " + str(global.score)
	if global.score >= 100 and global.level != 2:
		get_node("/root/Game/Level").show()
		get_node("/root/Game/Level").monitoring = true

func update_health(h):
	global.health += h
	$Health.text = "Health: " + str(global.health)
	if global.health <= 0:
		get_tree().change_scene("res://Menu/Die.tscn")

 ```

## Changing levels and Level 2

 * Select the Level node. In the Inspector, uncheck Monitoring. Select the Node panel (the tab next to the Inspector panel)->Signals. Double-click on the body_entered signal and select Level (Connecting from). Replace the `func _on_Level_body_entered(body):` method with:

 ```
func _on_Level_body_entered(body):
	 get_tree().change_scene("res://Level/Level2.tscn")
 ```

* Save the changes.

* In the Scene menu, select Save Scene As…. Save it as res://Level/Level2.tscn
* In the new Level2 scene, right-click on the Level node and select Delete Node(s). Confirm that you want to delete it
* Next to the Enemies node, click on the script icon. Viewing Enemies.gd in the Script Workspace, File->Save As… res://Enemies/Enemies2.gd
* Change line 3 of Enemies2.gd to: `onready var Enemy = load("res://Enemy/Enemy2.tscn")
* In the Scene menu, Open Scene. Open res://Enemy/Enemy.tscn
* Open the Enemy.gd script. On line 20 (the first line of the die() method), add the following:
```
	HUD.update_score(points)
```
* Again, in the Scene menu, Save Scene As… res://Enemy/Enemy2.tscn
* Right click on the cow node and select Delete Node(s). Also, delete the CollisionPolygon2D.
* Drag the narwhal.png image out of the Assets folder into the Workspace. In the Inspector panel, Node2D->Transform->Position set both x and y = 0
* In the toolbar, select Sprite->Create CollisionPolygon2D Sibling
* Save the scene

## Main menu

 * In the Scene menu, select New Scene. In the Scene panel, Create Root Node: select User Interface. Change the name of the Control node to "Menu"
 * Right-click on the Menu node and Add Child Node. Select Label. In the Inspector Panel, set the Label->Text="Welcome!". Label->Align=Center, Label->Valign=Center. Control->Rect->Size x=1024, y=300.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=60.
 * Right-click on the Menu node and Add Child Node. Select Button. Change the name of the node to "Play". In the Inspector Panel, set the Button->Text="Play". Control->Rect->Position x=412, y=300. Control->Rect->Size x=200, y=60.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=24.
 * Right-click on the Play node and Duplicate. Change the name of the Play2 node to "Quit". In the Inspector Panel, set the Label->Text="Quit". Control->Rect->Position y=380.
 * Right-click on the Menu node and Attach Script. Create a new Menu folder, and save the script as res://Menu/Menu.gd
 * Select the Play node and open the Node panel. Double-click on the pressed() signal and attach it to the Menu script
 * Select the Quit node and open the Node panel. Double-click on the pressed() signal and attach it to the Menu script
 * Replace the contents of Menu.gd with the following:

```
extends Control

func _on_Play_pressed():
   get_tree().change_scene("res://Game.tscn")

func _on_Quit_pressed():
  get_tree().quit()
```

 * Save the scene as res://Menu/Menu.tscn
 * Open the Project Settings. In General->Appliction->Run, set the main scene as res://Menu/Menu.tscn

## End-game screen

 * In the Scene menu, select New Scene. In the Scene panel, Create Root Node: select User Interface. Change the name of the Control node to "Menu"
 * Right-click on the Menu node and Add Child Node. Select Label. In the Inspector Panel, set the Label->Text="You Died!". Label->Align=Center, Label->Valign=Center. Control->Rect->Size x=1024, y=300.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=60.
 * Right-click on the Menu node and Add Child Node. Select Button. Change the name of the node to "Play". In the Inspector Panel, set the Button->Text="Play Again?". Control->Rect->Position x=412, y=300. Control->Rect->Size x=200, y=60.  Select Control->Custom Fonts->Font->New Dynamic Font. Select Font again, and select Edit. In the DynamicFont menu that appears, Select Font->FontData and choose Load. Open res://Assets/BebasNeueRegular.otf/. Select DynamicFont->Settings and set Size=24.
 * Right-click on the Play node and Duplicate. Change the name of the Play2 node to "Quit". In the Inspector Panel, set the Label->Text="Quit". Control->Rect->Position y=380.
 * Right-click on the Menu node and Attach Script. Create a new Menu folder, and save the script as res://Menu/Die.gd
 * Select the Play node and open the Node panel. Double-click on the pressed() signal and attach it to the Menu script
 * Select the Quit node and open the Node panel. Double-click on the pressed() signal and attach it to the Menu script
 * Replace the contents of Menu.gd with the following:

```
extends Control

onready var global = get_node("/root/Global")

func _on_Play_pressed():
	global.score = 0
	global.health = 100
	global.level = 1
	get_tree().change_scene("res://Game.tscn")

func _on_Quit_pressed():
	get_tree().quit()
```

 * Save the scene as res://Menu/Die.tscn
 * Finally, open the Player.gd script. On line 26 (the first line of the `_on_Damage_body_entered(body)` method), add the following line:
 ```
 	HUD.update_health(-body.damage)
 ```

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
