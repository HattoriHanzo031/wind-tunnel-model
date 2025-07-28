$fa = $preview ? 36 : 0.1;
$fs = $preview ? 2 : 0.03;
w = 333.33;
d = 50;
h = 5;

cev = 1;
radius = 1.5;

module curve(xAngle=0, zAngle=0, trans=0, radius=1.5) {
    translate([0,0,trans])
        rotate([xAngle,0, zAngle])
            translate([-radius,0,0])
                rotate_extrude(angle=90)
                    translate([radius, 0, 0])
                        circle(d=cev);
}

//!rotate([0,0,0]){
//    translate([0,-radius,0])curve(0,0);
//    translate([-radius,0,0])
//        rotate([0,-90,0])
//            cylinder(d=1, h=10-radius);
//    
//    translate([0,-radius,0])
//        rotate([90,0,0])
//            cylinder(d=1, h=10-radius);
//}

module connect(start, finish, angle=[0,0,0], bend=1.5, inRadius=1.5) {
    xLen = abs(start[1]-finish[1])-inRadius-bend;
    yLen = abs(start[0]-finish[0])-inRadius-bend;
    
    translate([start[0], finish[1]]){
        rotate(angle){
            translate([0,-bend,0])curve(0,0,0,bend);
            translate([-bend,0,0])
                rotate([0,-90,0])
                    cylinder(d=1, h=xLen);
            
            translate([0,-bend,0])
                rotate([90,0,0])
                    cylinder(d=1, h=yLen);
        }
    }
}

module connect_no_bend(start, finish, angle=[0,0,0], inRadius=1.5) {
    xLen = abs(start[1]-finish[1])-inRadius;
    yLen = abs(start[0]-finish[0])-inRadius;
    
    translate([start[0], finish[1]]){
        rotate(angle){
            rotate([0,-90,0])
                cylinder(d=1, h=xLen);
            
            rotate([90,0,0])
                cylinder(d=1, h=yLen);
        }
    }
}


module sensor_mount(){
    difference() {
        cylinder(r=1, h=5);
        cylinder(d=cev, h=5);
    }
}

module leptir_uglasti() {
    difference(){
        linear_extrude(4)
            polygon(points = [ [0, 0], [0,30], [20, 22.5], [20,7.5]]);
        translate([12.5, 15, 0])cylinder(d=5, h=4);
    }
}

module leptir(w, h) {
    difference(){
        scale([h/(w/2),1,1])
            cylinder(d=w, h=4);
        translate([12.5, 0, 0])
            cylinder(d=5, h=4);
        translate([-h, -w/2, 0])
            cube([h,w,4]);
    }
}

module leptirBezRupe(w, h) {
    difference(){
        scale([h/(w/2),1,1])
            cylinder(d=w, h=4);
        translate([-h, -w/2, 0])
            cube([h,w,4]);
    }
}

midSensors = d/2;

xMargina = (w-328)/2;
yMargina = 3;

middleSensorL = xMargina+32+1*66-1*4;
middleSensorR = xMargina+32+3*66+1*4;
    
module ploca() {
    translate([middleSensorL-4-2*4,midSensors,0])
        rotate([0,90,0])leptir(34, 20);
    
    translate([middleSensorL+2*4,midSensors,0])
        rotate([0,90,0])leptir(34, 20);
    
    translate([middleSensorR-4-2*4,midSensors,0])
        rotate([0,90,0])leptir(34, 20);
    
    translate([middleSensorR+2*4,midSensors,0])
        rotate([0,90,0])leptir(34, 20);
    
    difference() {
        topXAngle = -90;
        bottomXAngle = 90;
        topTrans = h;
        
        y1=yMargina;
        y2=d/2;
        y3=d-yMargina;
        
        x1=xMargina;
        x2=xMargina+32+0*44;
        x3=xMargina+32+1*44;
        x4=xMargina+32+2*44;
        x5=xMargina+32+3*44;
        x6=xMargina+32+4*44;
        x7=xMargina+32+5*44;
        x8=xMargina+32+6*44;
        x9=xMargina+32+6*44+32;
        
        raise = radius+cev/2;
        
        sensorL1X = xMargina+32+1*66-2*4;
        sensorL2X = xMargina+32+1*66-1*4;
        sensorL3X = xMargina+32+1*66;
    
        sensorR1X = xMargina+32+3*66+2*4;
        sensorR2X = xMargina+32+3*66+1*4;
        sensorR3X = xMargina+32+3*66;
    
        sensorY1 = d/2-4*4;
        sensorY2 = d/2-3*4;
        sensorY3 = d/2-2*4;
        sensorY4 = d/2-1*4;
        sensorY5 = d/2-0*4;
        sensorY6 = d/2+1*4;
        sensorY7 = d/2+2*4;
        sensorY8 = d/2+3*4;
        
        union(){
            cube([w,d,h]);
                    
            translate([sensorL1X, sensorY1, -5]) sensor_mount();
            translate([sensorL1X, sensorY2, -5]) sensor_mount();
            translate([sensorL1X, sensorY3, -5]) sensor_mount();
            translate([sensorL1X, sensorY4, -5]) sensor_mount();
            translate([sensorL1X, sensorY5, -5]) sensor_mount();
            translate([sensorL1X, sensorY6, -5]) sensor_mount();
            translate([sensorL1X, sensorY7, -5]) sensor_mount();
            translate([sensorL1X, sensorY8, -5]) sensor_mount();
            
            translate([sensorL2X, sensorY1, -5]) sensor_mount();
            translate([sensorL2X, sensorY2, -5]) sensor_mount();
            translate([sensorL2X, sensorY3, -5]) sensor_mount();
            translate([sensorL2X, sensorY4, -5]) sensor_mount();
            translate([sensorL2X, sensorY5, -5]) sensor_mount();
            translate([sensorL2X, sensorY6, -5]) sensor_mount();
            translate([sensorL2X, sensorY7, -5]) sensor_mount();
            translate([sensorL2X, sensorY8, -5]) sensor_mount();
            
            translate([sensorL3X, sensorY1, -5]) sensor_mount();
            translate([sensorL3X, sensorY2, -5]) sensor_mount();
            translate([sensorL3X, sensorY3, -5]) sensor_mount();
            translate([sensorL3X, sensorY4, -5]) sensor_mount();
            translate([sensorL3X, sensorY5, -5]) sensor_mount();
            translate([sensorL3X, sensorY6, -5]) sensor_mount();
            translate([sensorL3X, sensorY7, -5]) sensor_mount();
            translate([sensorL3X, sensorY8, -5]) sensor_mount();
            
            translate([sensorR1X, sensorY1, -5]) sensor_mount();
            translate([sensorR1X, sensorY2, -5]) sensor_mount();
            translate([sensorR1X, sensorY3, -5]) sensor_mount();
            translate([sensorR1X, sensorY4, -5]) sensor_mount();
            translate([sensorR1X, sensorY5, -5]) sensor_mount();
            translate([sensorR1X, sensorY6, -5]) sensor_mount();
            translate([sensorR1X, sensorY7, -5]) sensor_mount();
            translate([sensorR1X, sensorY8, -5]) sensor_mount();
            
            translate([sensorR2X, sensorY1, -5]) sensor_mount();
            translate([sensorR2X, sensorY2, -5]) sensor_mount();
            translate([sensorR2X, sensorY3, -5]) sensor_mount();
            translate([sensorR2X, sensorY4, -5]) sensor_mount();
            translate([sensorR2X, sensorY5, -5]) sensor_mount();
            translate([sensorR2X, sensorY6, -5]) sensor_mount();
            translate([sensorR2X, sensorY7, -5]) sensor_mount();
            translate([sensorR2X, sensorY8, -5]) sensor_mount();
            
            translate([sensorR3X, sensorY1, -5]) sensor_mount();
            translate([sensorR3X, sensorY2, -5]) sensor_mount();
            translate([sensorR3X, sensorY3, -5]) sensor_mount();
            translate([sensorR3X, sensorY4, -5]) sensor_mount();
            translate([sensorR3X, sensorY5, -5]) sensor_mount();
            translate([sensorR3X, sensorY6, -5]) sensor_mount();
            translate([sensorR3X, sensorY7, -5]) sensor_mount();
            translate([sensorR3X, sensorY8, -5]) sensor_mount();
    
        }    
        union() {
    
            // BOTTOM
            translate([xMargina,            yMargina, 0]) {
                curve(bottomXAngle,-90,0);
            }
            translate([xMargina+32,         yMargina, 0]) curve(bottomXAngle,-90,0);
            translate([xMargina+32+1*44,    yMargina, 0]) curve(bottomXAngle,-90,0);
            translate([xMargina+32+2*44,    yMargina, 0]) curve(bottomXAngle,-90,0);
            translate([xMargina+32+3*44,    yMargina, 0]) curve(bottomXAngle,-90,0);
            translate([xMargina+32+4*44,    yMargina, 0]) curve(bottomXAngle,-90,0);
            translate([xMargina+32+5*44,    yMargina, 0]) curve(bottomXAngle,-90,0);
            translate([xMargina+32+6*44,    yMargina, 0]) curve(bottomXAngle,-90,0);
            translate([xMargina+32+6*44+32, yMargina, 0]) curve(bottomXAngle,-90,0);
            
            translate([xMargina,            d/2, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32,         d/2, 0]) curve(bottomXAngle,180,0);
            //translate([xMargina+32+1*66,    d/2, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+2*66,    d/2, 0]) curve(bottomXAngle,90,0);
            //translate([xMargina+32+3*66,    d/2, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+4*66,    d/2, 0]) curve(bottomXAngle,0,0);
            translate([xMargina+32+4*66+32, d/2, 0]) curve(bottomXAngle,90,0);
            
            translate([xMargina,            d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32,         d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+1*44,    d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+2*44,    d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+3*44,    d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+4*44,    d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+5*44,    d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+6*44,    d-yMargina, 0]) curve(bottomXAngle,90,0);
            translate([xMargina+32+6*44+32, d-yMargina, 0]) curve(bottomXAngle,90,0);
            
            // TOP
            translate([xMargina,            yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32,         yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32+1*44,    yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32+2*44,    yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32+3*44,    yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32+4*44,    yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32+5*44,    yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32+6*44,    yMargina, 0]) curve(topXAngle,-90,topTrans);
            translate([xMargina+32+6*44+32, yMargina, 0]) curve(topXAngle,-90,topTrans);
            
            translate([xMargina,            d/2, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32,         d/2, 0]) curve(topXAngle,180,topTrans);
            translate([xMargina+32+1*66,    d/2, 0]) cylinder(d=cev, h=h);
            translate([xMargina+32+2*66,    d/2, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+3*66,    d/2, 0]) cylinder(d=cev, h=h);
            translate([xMargina+32+4*66,    d/2, 0]) curve(topXAngle,0,topTrans);
            translate([xMargina+32+4*66+32, d/2, 0]) curve(topXAngle,90,topTrans);
            
            translate([xMargina,            d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32,         d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+1*44,    d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+2*44,    d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+3*44,    d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+4*44,    d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+5*44,    d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+6*44,    d-yMargina, 0]) curve(topXAngle,90,topTrans);
            translate([xMargina+32+6*44+32, d-yMargina, 0]) curve(topXAngle,90,topTrans);
            
            // SENSOR
    
            // left
            translate([sensorL1X,    sensorY1, 0]) curve(bottomXAngle,0,0);
            translate([sensorL1X,    sensorY2, 0]) curve(bottomXAngle,0,0);
            translate([sensorL1X,    sensorY3, 0]) curve(bottomXAngle,0,0);
            translate([sensorL1X,    sensorY4, 0]) curve(bottomXAngle,0,0);
            translate([sensorL1X,    sensorY5, 0]) curve(bottomXAngle,0,0);
            translate([sensorL1X,    sensorY6, 0]) curve(bottomXAngle,0,0);
            translate([sensorL1X,    sensorY7, 0]) curve(bottomXAngle,0,0);
            translate([sensorL1X,    sensorY8, 0]) curve(bottomXAngle,0,0);
            
            translate([sensorL2X,    sensorY1, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorL2X,    sensorY2, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorL2X,    sensorY3, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorL2X,    sensorY4, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorL2X,    sensorY5, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorL2X,    sensorY6, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorL2X,    sensorY7, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorL2X,    sensorY8, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            
            translate([sensorL3X,    sensorY1, 0]) curve(bottomXAngle,180,0);
            translate([sensorL3X,    sensorY2, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorL3X,    sensorY3, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorL3X,    sensorY4, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            //translate([sensorL3X,    sensorY5, 0]) curve(bottomXAngle,0,0);
            translate([sensorL3X,    sensorY6, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorL3X,    sensorY7, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorL3X,    sensorY8, 0]) curve(bottomXAngle,180,0);
       
            // right
            translate([sensorR1X,    sensorY1, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY1, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY2, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY3, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY4, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY5, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY6, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY7, 0]) curve(bottomXAngle,180,0);
            translate([sensorR1X,    sensorY8, 0]) curve(bottomXAngle,180,0);
            
            translate([sensorR2X,    sensorY1, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorR2X,    sensorY2, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorR2X,    sensorY3, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorR2X,    sensorY4, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorR2X,    sensorY5, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorR2X,    sensorY6, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorR2X,    sensorY7, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            translate([sensorR2X,    sensorY8, 0]) {translate([0,0,raise])curve(bottomXAngle,180,0); cylinder(d=cev, h=raise);}
            
            translate([sensorR3X,    sensorY1, 0]) curve(bottomXAngle,0,0);
            translate([sensorR3X,    sensorY2, 0]) curve(bottomXAngle,0,0);
            translate([sensorR3X,    sensorY3, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorR3X,    sensorY4, 0]) {curve(bottomXAngle,0,0);}
            //translate([sensorR3X,    sensorY5, 0]) curve(bottomXAngle,0,0);
            translate([sensorR3X,    sensorY6, 0]) {translate([0,0,raise])curve(bottomXAngle,0,0); cylinder(d=cev, h=raise);}
            translate([sensorR3X,    sensorY7, 0]) curve(bottomXAngle,0,0);
            translate([sensorR3X,    sensorY8, 0]) curve(bottomXAngle,0,0);
            
            translate([0,0,radius]){
                connect([x3,y3], [sensorL1X, sensorY8], [0,180,90]);
                connect([x2,y3], [sensorL1X, sensorY7], [0,180,90]);
                connect([x1,y3], [sensorL1X, sensorY6], [0,180,90]);
                connect_no_bend([x2+radius,y2], [sensorL1X, sensorY5], [0,180,90]);
                connect([x1,y2], [sensorL1X, sensorY4], [0,180,90]);
                connect([x1,y1], [sensorL1X, sensorY3], [0,0,90]);
                connect([x2,y1], [sensorL1X, sensorY2], [0,0,90]);
                connect([x3,y1], [sensorL1X, sensorY1], [0,0,90]);
                
                connect([x4,y3], [sensorL3X, sensorY8], [0,0,-90]);
                connect([x4,y1], [sensorL3X, sensorY1], [0,180,-90]);
    //     prenesen gore       connect([x5,y2], [sensorL3X, sensorY4], [0,0,-90]);
    
    
                connect([x5,y1], [sensorR3X, sensorY2], [0,0,90]);
                connect([x6,y1], [sensorR3X, sensorY1], [0,0,90]);
                connect([x5,y3], [sensorR3X, sensorY7], [0,180,90]);
                connect([x6,y3], [sensorR3X, sensorY8], [0,180,90]);
                
                connect([x7,y3], [sensorR1X, sensorY8], [0,0,-90]);
                connect([x8,y3], [sensorR1X, sensorY7], [0,0,-90]);
                connect([x9,y3], [sensorR1X, sensorY6], [0,0,-90]);
                connect_no_bend([x8-radius,y2], [sensorR1X, sensorY5], [0,0,-90]);
                connect([x9,y2], [sensorR1X, sensorY4], [0,0,-90]);
                connect([x9,y1], [sensorR1X, sensorY3], [0,180,-90]);
                connect([x8,y1], [sensorR1X, sensorY2], [0,180,-90]);
                connect([x7,y1], [sensorR1X, sensorY1], [0,180,-90]);
                
                connect([x5,y2], [sensorR3X, sensorY4], [0,180,90]); // prenesen
            }
            
            translate([0,0,raise+radius]) {
                connect([x5,y2], [sensorL3X, sensorY4], [0,0,-90]); // prenesen
                
                connect([x3,y3], [sensorL2X, sensorY8], [0,180,90]);
                connect([x2,y3], [sensorL2X, sensorY7], [0,180,90]);
                connect([x1,y3], [sensorL2X, sensorY6], [0,180,90]);
                connect_no_bend([x2+radius,y2], [sensorL2X, sensorY5], [0,180,90]);
                connect([x1,y2], [sensorL2X, sensorY4], [0,180,90]);
                connect([x1,y1], [sensorL2X, sensorY3], [0,0,90]);
                connect([x2,y1], [sensorL2X, sensorY2], [0,0,90]);
                connect([x3,y1], [sensorL2X, sensorY1], [0,0,90]);
                
                connect([x4,y3], [sensorL3X, sensorY7], [0,0,-90]);
                connect([x4,y1], [sensorL3X, sensorY2], [0,180,-90]);
                connect([x5,y3], [sensorL3X, sensorY6], [0,0,-90]);
                connect([x5,y1], [sensorL3X, sensorY3], [0,180,-90]);
                
                //connect([x5,y2], [sensorR3X, sensorY4], [0,180,90]);
                connect([x6,y1], [sensorR3X, sensorY3], [0,0,90]);
                connect([x6,y3], [sensorR3X, sensorY6], [0,180,90]);
                
                connect([x7,y3], [sensorR2X, sensorY8], [0,0,-90]);
                connect([x8,y3], [sensorR2X, sensorY7], [0,0,-90]);
                connect([x9,y3], [sensorR2X, sensorY6], [0,0,-90]);
                connect_no_bend([x8-radius,y2], [sensorR2X, sensorY5], [0,0,-90]);
                connect([x9,y2], [sensorR2X, sensorY4], [0,0,-90]);
                connect([x9,y1], [sensorR2X, sensorY3], [0,180,-90]);
                connect([x8,y1], [sensorR2X, sensorY2], [0,180,-90]);
                connect([x7,y1], [sensorR2X, sensorY1], [0,180,-90]);
            }
        }
    }
}

module parts() {
    preklop = 15;

    difference() {
        ploca();
        
        translate([0,0,h/2])
            cube([w/2+preklop, d, h]);

        translate([0,0,-50+h])
            cube([w/2-preklop, d, 50]);
    }

    translate([-0.5,0,0.5]) {
        difference() {
            ploca();
            
            translate([w/2+preklop,0,h/2])
                cube([w/2, d, h]);
        
            translate([w/2-preklop,0,-50+h/2])
                cube([w/2+preklop, d, 50]);
        }
    }
}

//parts();

module sipka(uPloci, x) {
    uNastavku = d/2;
    l = uNastavku + uPloci;
    translate([x, uPloci,h/2])
        rotate([90,0,0])
            cylinder(d=2, h=l);
}

module leptirNastavak() {
    difference() {
        translate([0,50,0])
            leptirBezRupe(90+30, 20);
        translate([0,midSensors*2,0]) {
            leptirBezRupe(34, 20);
            translate([0,-1.5,0])
                cube([20,90,5]);
        }
    }
}


module sipke() {
    sipka(15, 10);
    sipka(15, 163);
    sipka(15, w-10);
}

module nastavak() {
    //color([1,0,0])ploca();
    
    translate([0, -d, 0])
        cube([w,d,h]);

    
    translate([middleSensorL-4-2*4,-midSensors,0])
        rotate([0,90,0])leptirNastavak();
    
    translate([middleSensorL+2*4,-midSensors,0])
        rotate([0,90,0])leptirNastavak();
    
    translate([middleSensorR-4-2*4,-midSensors,0])
        rotate([0,90,0])leptirNastavak();
    
    translate([middleSensorR+2*4,-midSensors,0])
        rotate([0,90,0])leptirNastavak();
}

module saNastavkom() {
    difference() {
        ploca();
        sipke();
    }

    difference() {
        nastavak();
        sipke();
    }
}

module projekcije() {
    projection(cut = true) 
        translate([0,0,-4.99]) 
            ploca();
    projection(cut = true) 
        translate([0,0,0]) 
            ploca();
            
    !projection(cut = true)
        translate([0, 0, middleSensorL-4/2-2*4])
            rotate([0,90,0])
                ploca();
    projection(cut = true)
        rotate([90,0,0])
            translate([0, -d/2, 0])
                ploca();
}

projekcije();