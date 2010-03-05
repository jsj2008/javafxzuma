/*
 * Main.fx
 *
 * Created on Jan 13, 2010, 11:17:31 AM
 */

package zuma;

import javafx.stage.Stage;

import javafx.scene.Scene;
import zuma.SplashUI;



/**
 * @author javatest
 */
public-read var ui : UI;
public-read var model : Model;
public-read var levels : Level[] = [Level1{},Level2{}];
/*
* 0 : game ended
* 1 : game started
* 2 : game paused
* 3 : game resumed
*/
public var gamestat = -1 on replace{
    if(gamestat == 0){
            ui.stop();
            ui = SplashUI{};
            ui.start();
    }
    if(gamestat == 1){
            ui.stop();
            ui = levels[0];
            model = Model{};
            ui.start();
    }
    if(gamestat == 2){
            ui.pause();
    }
    if(gamestat == 3){
            ui.resume();
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
