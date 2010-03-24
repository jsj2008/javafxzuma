/*
 * Pointer.fx
 *
 * Created on Feb 25, 2010, 12:00:11 PM
 */

package zuma;

import javafx.scene.CustomNode;
import javafx.scene.shape.Polygon;

import javafx.scene.Node;

import javafx.scene.paint.Color;
import javafx.scene.paint.Paint;

/**
 * @author perkin tang
 */

public class Pointer extends CustomNode{
public var color : Integer = 0 on replace {
    color0 = colors[color];
};
public var color0 : Paint = Color.BLACK;
var colors : Color[] = [Color.BLUE,
                        Color.GREEN,
                        Color.PURPLE,
                        Color.RED,
                        Color.WHITE,
                        Color.YELLOW];
public var topx = 0.0;
public var topy = 0.0;
public var botm_left_x = 20.0;
public var botm_lefx_y = 10.0;
public var botm_right_x = 10.0;
public var botm_right_y = 20.0;
public var point : Number[];
var p = Polygon {
    points: bind point;
    fill : bind color0;
}
override public function create(): Node {
    p;
}
public function genPoints(){
    return point = [topx,topy,botm_left_x,botm_lefx_y,botm_right_x,botm_right_y];
}
}
