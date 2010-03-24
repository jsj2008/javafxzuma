/*
 * BallParcitle.fx
 *
 * Created on Mar 11, 2010, 2:33:35 PM
 */

package zuma;

import javafx.scene.image.Image;
import zuma.Resources;

import zuma.components.HorizontalImagePlayer;

import zuma.components.ParabolaTransition;

import javafx.scene.CustomNode;

import javafx.scene.Node;

import zuma.util.Util;

/**
 * @author perkin tang
 */

public class BallParcitle extends CustomNode{
public var startx : Number;
public var starty : Number;
public var vx : Number;
public var vy : Number;
var parcilte : Image = Resources.balls_particles;
var player : HorizontalImagePlayer = HorizontalImagePlayer{
        startFrom : Util.random(5);
        image : parcilte
        cy_w: 23/2
        cy_h: 32/2
        dur : 0.3s
        };
public-read var transiton = ParabolaTransition{
            node : this
            vy : bind vy
            vx : bind vx
            maxx : Config.WINDOW_WIDTH - 23/2;
            minx : -100
            borderx: bind startx
            bordery: bind starty
            g : 0.05
            p : 1
        };
override public function create(): Node {
        player;
}
public function start(){
    player.start();
    transiton.selfStart();
}
public function stop(){
    player.stop();
    transiton.stop();
}
}
