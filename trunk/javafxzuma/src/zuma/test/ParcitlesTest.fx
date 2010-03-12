/*
 * ParcitlesTest.fx
 *
 * Created on Mar 11, 2010, 12:12:22 PM
 */

package zuma.test;

import javafx.scene.Scene;
import javafx.stage.Stage;
import zuma.BallParcitle;

import zuma.Config;

import javafx.scene.image.ImageView;

import javafx.scene.input.MouseEvent;


import zuma.Resources;
import zuma.util.Util;


/**
 * @author javatest
 */
var x : Number;
var y : Number;
var backgroundview = ImageView {
                        image: Resources.fortest
                        focusTraversable: true
                        visible: true
    onMousePressed: function( e: MouseEvent ){
            par0.stop();
            par1.stop();
            par2.stop();
            par3.stop();
            par4.stop();
            par5.stop();
            par6.stop();
            par7.stop();
            x = e.x;
            y = e.y;
            par0.start();
            par1.start();
            par2.start();
            par3.start();
            par4.start();
            par5.start();
            par6.start();
            par7.start();
     }
};
var par0 = BallParcitle{startx:bind x,starty:bind y,vx : 4/2/2,vy : 2.8/2};
var par1 = BallParcitle{startx:bind x,starty:bind y,vx : 2.8/2/2,vy : 2.8/2/2};
var par2 = BallParcitle{startx:bind x,starty:bind y,vx : 0,vy : 4/2};
var par3 = BallParcitle{startx:bind x,starty:bind y,vx : -2.8/2,vy : 2.8/2};
var par4 = BallParcitle{startx:bind x,starty:bind y,vx : -4/2/2,vy : 0};
var par5 = BallParcitle{startx:bind x,starty:bind y,vx : -2.8/2/2,vy : -2.8/2/2};
var par6 = BallParcitle{startx:bind x,starty:bind y,vx : 0,vy : -4/2/2/2};
var par7 = BallParcitle{startx:bind x,starty:bind y,vx : 2.8/2,vy : -2.8/2};
Stage {
    title: "Application title"
    width: Config.WINDOW_WIDTH
    height: Config.WINDOW_HEIGHT
    scene: Scene {
        content: [
                backgroundview,par0,par1,par2,par3,par4,par5,par6,par7
        ]
    }
}
//par.start();
