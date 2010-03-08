/*
 * Main.fx
 *
 * Created on Jan 13, 2010, 11:17:31 AM
 */

package zuma;

import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;

import javafx.scene.paint.Color;

/**
 * @author javatest
 */

/*
* variable game data
*/
var data : LevelData[] = [LevelData{
                            EMITTER_X : 50
                            EMITTER_Y : 280
                            background : Image { url: "{__DIR__}images/background/background1.jpg" }
                            END_DOOR_X : 430;
                            END_DOOR_Y : 500;
                            PATH_DATA_FILE : "/zuma/svg/map3";
                            max_ball : 20
                          }
                          LevelData{
                            EMITTER_X : 50
                            EMITTER_Y : 280
                            background : Image { url: "{__DIR__}images/background/background2.jpg" }
                            END_DOOR_X : 430;
                            END_DOOR_Y : 500;
                            PATH_DATA_FILE : "/zuma/svg/map4";
                            INITIAL_RATE: 6
                            max_ball : 40
                          }];
public-read var ui : UI;
public-read var model : Model;
var level : Integer = 0;
var loading : UI = LoadingUI{};
public-read var currentData : LevelData = bind data[level];
/*
* 0 : game ended
* 1 : game started
* 2 : game paused
* 3 : game resumed
* 4 : game win, next level start
*/
public var gamestat = -1 on replace {
    if(gamestat == 0){
            ui.stop();
            loading.start();
            FX.deferAction(function():Void{
                ui = SplashUI{};
            });
    }
    if(gamestat == 1){
            ui.stop();
            loading.start();
            FX.deferAction(function():Void{
                ui = Game2{};
                model = Model{};
                ui.start();
            });
    }
    if(gamestat == 2){
            ui.pause();
    }
    if(gamestat == 3){
            ui.resume();
    }
    if(gamestat == 4){
            ui.stop();
            loading.start();
            FX.deferAction(function():Void{
                level++;
                ui = Game2{};
                model = Model{};
                ui.start();
            });
    }
}
public var mainscene : Scene;
function run(__ARGS__ : String[]) {
    def stage = Stage {
        title: "JavaFX Zuma"
        resizable: false
        width: Config.WINDOW_WIDTH
        height: Config.WINDOW_HEIGHT
        scene: Scene{fill: Color.BLACK};
    }
    mainscene = stage.scene;
    FX.deferAction(function ():Void{
        gamestat = 1;
    });
}
