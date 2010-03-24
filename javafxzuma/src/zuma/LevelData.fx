/*
 * LevelData.fx
 *
 * Created on Mar 8, 2010, 9:33:42 AM
 */

package zuma;

import javafx.scene.image.Image;

/**
 * @author perkin tang
 */
public class LevelData{
    public var EMITTER_X = 320;
    public var EMITTER_Y = 320;
    public var background : Image = Image { url: "{__DIR__}images/background1.png" };
    public var END_DOOR_X = 430;
    public var END_DOOR_Y = 500;
    public var PATH_DATA_FILE = "/zuma/svg/map1";
    public var INITIAL_RATE = 10;
    public var max_ball = 20;
    public var target : Integer = 50;
}

