/*
 * Timer.fx
 *
 * Created on Mar 3, 2010, 1:50:30 PM
 */

package zuma.components;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

/**
 * @author javatest
 */
public class ScheduleTimer{
var taskqueue : Schedulable[] = [];
public var frequency : Duration;
def timer = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames : [
            KeyFrame {
                time: bind frequency
                action: function () {
                        for(task in taskqueue){
                                task.scheduledUpdate();
                        }
                }
            }
        ]
}
public function addTask(task : Schedulable,periode : Duration){
//    task.maxrate = (periode/frequency) as Integer;
//    insert task into taskqueue;
}
public function addTask(action : function(),periode : Duration){
    var task : Schedulable = Schedulable{
        override function update(){
            action();
        }
    };
    task.maxrate = (periode/frequency) as Integer;
    task.ontick = 0;
    insert task into taskqueue;
}
public function deleteTask(task : Schedulable){
    delete task from taskqueue;
}
public function start(){
    timer.playFromStart();
}
public function stop(){
    timer.stop();
}
}
