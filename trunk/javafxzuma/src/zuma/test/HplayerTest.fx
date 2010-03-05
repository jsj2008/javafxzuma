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
/**
 * @author javatest
 */
var player : HorizontalImagePlayer = HorizontalImagePlayer{
        image : Resources.arrowImage[0];
        cy_w: 30
        cy_h: 30
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