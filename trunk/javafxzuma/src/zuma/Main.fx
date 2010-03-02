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
var game = GameUI{};
var splash = SplashUI{};
public var gamestat = -1 on replace{
    if(gamestat == 0){
            game.stop();
    }
    if(gamestat == 1){
            game.start();
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
