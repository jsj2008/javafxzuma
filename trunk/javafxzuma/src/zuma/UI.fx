/*
 * UI.fx
 *
 * Created on Mar 2, 2010, 5:22:54 PM
 */

package zuma;

/**
 * @author javatest
 */

public abstract class UI {
public var ui = [];
abstract public function start():Void;
abstract public function stop():Void;
abstract public function pause():Void;
abstract public function resume():Void;
}
