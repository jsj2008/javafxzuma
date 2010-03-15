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
                            PATH_DATA_FILE : "/zuma/svg/map1";
                            max_ball : 10
                            target : 30
                          }
                          LevelData{
                            EMITTER_X : 50
                            EMITTER_Y : 280
                            background : Image { url: "{__DIR__}images/background/background2.jpg" }
                            END_DOOR_X : 430;
                            END_DOOR_Y : 500;
                            PATH_DATA_FILE : "/zuma/svg/map2";
                            INITIAL_RATE: 6
                            max_ball : 60
                          }
                          LevelData{
                            EMITTER_X : 50
                            EMITTER_Y : 280
                            background : Image { url: "{__DIR__}images/background/background3.jpg" }
                            END_DOOR_X : 430;
                            END_DOOR_Y : 500;
                            PATH_DATA_FILE : "/zuma/svg/map3";
                            INITIAL_RATE: 6
                            max_ball : 60
                            target : 10
                          }
                          LevelData{
                            EMITTER_X : 50
                            EMITTER_Y : 280
                            background : Image { url: "{__DIR__}images/background/background4.jpg" }
                            END_DOOR_X : 430;
                            END_DOOR_Y : 500;
                            PATH_DATA_FILE : "/zuma/svg/map4";
                            INITIAL_RATE: 6
                            max_ball : 60
                          }
                          LevelData{
                            EMITTER_X : 50
                            EMITTER_Y : 280
                            background : Image { url: "{__DIR__}images/background/background5.jpg" }
                            END_DOOR_X : 430;
                            END_DOOR_Y : 500;
                            PATH_DATA_FILE : "/zuma/svg/map5";
                            INITIAL_RATE: 6
                            max_ball : 60
                          }
                          LevelData{
                            EMITTER_X : 50
                            EMITTER_Y : 280
                            background : Image { url: "{__DIR__}images/background/background6.jpg" }
                            END_DOOR_X : 430;
                            END_DOOR_Y : 500;
                            PATH_DATA_FILE : "/zuma/svg/map6";
                            INITIAL_RATE: 6
                            max_ball : 60
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
                ui = Game2{};
                model = Model{};
                ui.start();
                gamestat = -1;
            });
    }
    if(gamestat == 1){
            ui.stop();
            loading.start();
            FX.deferAction(function():Void{
                ui = Game2{};
                model = Model{};
                ui.start();
                gamestat = -1;
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
            if(level == (sizeof data)-1){
                //congratulations   
            }else{
                FX.deferAction(function():Void{
                    level++;
                    ui = Game2{};
                    model = Model{};
                    ui.start();
                    gamestat = -1;
                });
            }
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
