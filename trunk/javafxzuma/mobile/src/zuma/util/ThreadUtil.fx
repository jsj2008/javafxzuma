/*
 * ThreadUtil.fx
 *
 * Created on Mar 1, 2010, 9:31:19 AM
 */

package zuma.util;

import java.lang.Runnable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import java.util.Timer;

import java.util.TimerTask;

/**
 * @author javatest
 */
def pool : ExecutorService = Executors.newFixedThreadPool(10);
def timer : Timer = Timer{};
public function runOutOfEventDispatchThread(action : function()) {
    var task: Runnable = Runnable {
         override function run() {
            action();
         }
    }
    pool.execute(task);
}
public function scheduleOutOfEventDispatchThread(task : TimerTask,period : Long){
    timer.scheduleAtFixedRate(task, 0,period);
}