/*
 * Util.fx
 *
 * Created on Feb 3, 2010, 3:26:08 PM
 */

package zuma.util;

import javafx.util.Math;

def RANDOM = new java.util.Random();
/**
 * @author perkin tang
 */
public function mergeSeq(seq: java.lang.Object[],to : java.lang.Object[]) : java.lang.Object[]{
    var tmp : java.lang.Object[] = [];
    for(obj in to){
            insert obj into tmp;
    }
    for(obj in seq){
            insert obj into tmp;
    }
    return tmp;
}
/**
* get x coordinate of intersection when given coordinate of center of acircle and another point's coordinate.
*/
public function getCoordx(ox : Double,oy : Double,nx : Double,ny : Double,r : Double){
   return (nx-ox)*r/Math.sqrt((nx-ox)*(nx-ox)+(ny-oy)*(ny-oy))+ox;
}
/**
* get x coordinate of another intersection when given coordinate of center of acircle and another point's coordinate.
*/
public function getCoordx1(ox : Double,oy : Double,nx : Double,ny : Double,r : Double){
   return -(nx-ox)*r/Math.sqrt((nx-ox)*(nx-ox)+(ny-oy)*(ny-oy))+ox;
}
/**
* get y coordinate of intersection when given coordinate of center of acircle and another point's coordinate.
*/
public function getCoordy(ox : Double,oy : Double,nx : Double,ny : Double,r : Double){
   return (ny-oy)*r/Math.sqrt((nx-ox)*(nx-ox)+(ny-oy)*(ny-oy))+oy;
}
/**
* get y coordinate of another intersection when given coordinate of center of acircle and another point's coordinate.
*/
public function getCoordy1(ox : Double,oy : Double,nx : Double,ny : Double,r : Double){
   return -(ny-oy)*r/Math.sqrt((nx-ox)*(nx-ox)+(ny-oy)*(ny-oy))+oy;
}
public function getCoordxByDegree(ox : Double,oy : Double,degree : Number,r : Double){
//   if(degree == 0 and degree == 360){
//        return r+ox;
//   }
//   if(degree == 90 and degree == 270){
//        return ox;
//   }
//   if(degree == 180){
//        return -r+ox;
//   }
   return r*Math.cos(Math.toRadians(degree))+ox;
}
public function getCoordyByDegree(ox : Double,oy : Double,degree : Number,r : Double){
//   if(degree == 0 and degree == 360){
//        return r+ox;
//   }
//   if(degree == 90 and degree == 270){
//        return ox;
//   }
//   if(degree == 180){
//        return -r+ox;
//   }
   return r*Math.sin(Math.toRadians(degree))+oy;
}
/**
* get Degrees when given coordinate of center of acircle and another point's coordinate.
*/
public function getDegrees(ox : Double,oy : Double,nx : Double,ny : Double,r : Double){
        var x: Double = getCoordx(ox,oy,nx,ny,r);
        var y: Double = getCoordy(ox,oy,nx,ny,r);
        if((x == 0) and (y < 0)){
                return -90;
        }
        if((x == 0) and (y > 0)){
                return 90;
        }
        if((y == 0) and (x > 0)){
                return 0;
        }
        if((y == 0) and (x < 0)){
                return 180;
        }
        if((x > 0) and (y > 0)){

                return Math.toDegrees(Math.atan(y/x));
        }
        if((x < 0) and (y > 0)){

                return 180+Math.toDegrees(Math.atan(y/x));
        }
        if((x > 0) and (y < 0)){

                return 360+Math.toDegrees(Math.atan(y/x));
        }
        if((x < 0) and (y < 0)){

                return 180+(Math.toDegrees(Math.atan(y/x)));
        }
        return 90;
        //return Math.toDegrees(n);
}
public function square(n){
    return n*n;
}
public function random(max: Integer): Integer {
    RANDOM.nextDouble() * max as Integer;
}
