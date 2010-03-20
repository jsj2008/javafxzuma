/*
 * ArrowCompositeTest.fx
 *
 * Created on 2010-3-20, 20:01:04
 */

package zuma.test;

import javafx.scene.Scene;
import javafx.stage.Stage;



import zuma.Arrow;

import zuma.components.HorizontalImagePlayer;

import zuma.Resources;

import javafx.scene.shape.Polygon;

import javafx.scene.paint.Color;

/**
 * @author tzp
 */
var arrow = Arrow{};
Stage {
    title: "Application title"
    width: 600
    height: 600
    scene: Scene {
    content: [
            HorizontalImagePlayer{
                    translateY : 100
                    translateX: 100
                    startFrom: 1
                    image : Resources.arrowImage[0]
                    cy_w: 32
                    cy_h: 32
                    dur : 0.1s
                    },arrow,Polygon {
                            translateX:200
                            translateY:200
    points: [ -5.0, 0.0, 5.0, 0.0, -10.0, 100.0, 10.0, 100.0 ];
    fill : Color.BLUE
}
        ]
    }
}
arrow.start();
