/*
 * HplayerTest.fx
 *
 * Created on Mar 5, 2010, 10:19:19 AM
 */

package zuma.test;

import zuma.components.HorizontalImagePlayer;
import zuma.Resources;

import javafx.scene.Scene;
import javafx.stage.Stage;

import zuma.Config;
/**
 * @author javatest
 */
var player : HorizontalImagePlayer = HorizontalImagePlayer{
        startFrom: 0
        image : Resources.spear_ball;
        cy_w: Config.BALL_DIAMETER
        cy_h: Config.BALL_DIAMETER
        dur : 0.1s
        };
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
        content: [
                player
        ]
    }
}
player.start();