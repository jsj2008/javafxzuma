/*
 * Ball.fx
 *
 * Created on Jan 13, 2010, 1:43:08 PM
 */

package zuma.components;

import javafx.scene.CustomNode;

import javafx.scene.image.Image;

/**
 * @author javatest
 */

public abstract class Ball extends CustomNode {
public var image : Image;
public var smooth = false;
public abstract function start() : Void;
public abstract function pause() : Void;
public abstract function resume() : Void;

}
