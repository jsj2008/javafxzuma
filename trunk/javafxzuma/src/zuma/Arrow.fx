/*
 * ArrowComposite.fx
 *
 * Created on 2010-3-20, 19:24:23
 */

package zuma;

import javafx.scene.Group;

import javafx.scene.CustomNode;

import javafx.scene.Node;


import javafx.scene.image.Image;


import zuma.components.HorizontalImagePlayer;

import javafx.scene.shape.Polygon;

import javafx.scene.paint.Color;

import javafx.scene.paint.Paint;

/**
 * @author tzp
 */

public class Arrow extends CustomNode{
public var minw : Integer = 10;
public var maxw : Integer = 30;
public var maxh : Integer= 600;
public var imageUrl : String = "{__DIR__}images/ball/arrow_blue_up.png";
public var arrows : HorizontalImagePlayer[] = [];
var h = maxh/10;
var group : Group = Group{};
public var point : Number[];
public var color : Integer = 0 on replace {
    color0 = colors[color];
};
var color0 : Paint = Color.BLUE;
var colors : Color[] = [Color.BLUE,
                        Color.GREEN,
                        Color.PURPLE,
                        Color.RED,
                        Color.WHITE,
                        Color.YELLOW];
//var p = Polygon {
//    points: [ -5.0, 0.0, 5.0, 0.0, -10.0, 100.0, 10.0, 100.0 ];
//    fill : bind color0;
//}
override public function create(): Node {
       var ty = 0;
       var w;
       var player;
       var array  : Number[];
       for(n in [0..10]){
            if(n < 5){
                continue;
            }
            w = maxw*h*(n+1)/maxh;
//            if(n == 4 or n == 9){
//                insert -w/2 into array;
//                insert ty into array;
//                insert w/2 into array;
//                insert ty into array;
//            }
            player = HorizontalImagePlayer{
                    translateY : ty
                    translateX: -w/2
                    startFrom: 0
                    image : Image{
                                width : w*12
                                height: w
                                url: imageUrl}
                    cy_w: w
                    cy_h: w
                    dur : 0.1s
                    };
            insert player into arrows;
            insert player into group.content;
            ty = ty + h;
       };
//       point = array;
//       println(point);
//       insert p into group.content;
       return group;
}
public function start(){
    for(player in arrows){
            player.opacity = 1.0;
            player.start();
    }
}
public function stop(){
    for(player in arrows){
            player.stop();
            player.opacity = 0.0;
    }
}
}
