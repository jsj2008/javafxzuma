/*
 * ThreadTest.fx
 *
 * Created on 2010-2-28, 4:46:44
 */

package zuma.test;

import java.lang.Runnable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * @author tzp
 */
def pool : ExecutorService = Executors.newCachedThreadPool();//新建javafx的线程池

function process(){
var task: Runnable = Runnable {
   override function run(){
           FX.deferAction(function():Void{

           });
   }
}
}
