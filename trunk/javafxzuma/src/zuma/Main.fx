/*
 * Main.fx
 *
 * Created on Jan 13, 2010, 11:17:31 AM
 */

package zuma;

import javafx.stage.Stage;

import javafx.scene.Scene;



/**
 * @author javatest
 */
public-read var game : GameUI;
public-read var splash : SplashUI;
public-read var model : Model;
public-read var currentlevel : Level;
/*
* 0 : game ended
* 1 : game started
* 2 : game paused
* 3 : game resumed
*/
public var gamestat = -1 on replace{
    if(gamestat == 0){
            game.stop();
    }
    if(gamestat == 1){
            game = GameUI{};
            model = Model{};
            currentlevel = Level1{};
            game.start();
    }
    if(gamestat == 2){
            game.pause();
    }
    if(gamestat == 3){
            game.resume();
    }
}
public var mainscene : Scene;
function run(__ARGS__ : String[]) {
    def stage = Stage {
        title: "JavaFX Zuma"
        resizable: false
        width: Config.WINDOW_WIDTH+15
        height: Config.WINDOW_HEIGHT+35
        scene: Scene{};
    }
    mainscene = stage.scene;
    gamestat = 1;
}
