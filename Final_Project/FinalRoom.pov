#include "STARoom.inc"
#include "shapes.inc"

#declare RoomLength = 1350; 
#declare RoomWidth = 930;
#declare RoomHeight = 457;

#declare WallCutout = 5;

#declare HalfRoomWidth = RoomWidth/2;
#declare HalfRoomLength = RoomLength/2;
#declare SeatedEyeHeight = 112;

//===================================================== 
// THE ROOM (doors, ceiling, walls) and THEIR CUTOUTs / TEXTUREs
#declare STARoom = box {
	<0,0,0>
	<RoomWidth, RoomHeight, RoomLength>
};


#declare Floor = box {
    <0,0.01,0>
	<RoomWidth, 0.2, RoomLength-RoomLength/5>
};

#declare behindWall = box {
    <0,0,-WallCutout>
	<RoomWidth,RoomHeight,WallCutout>
	translate<0,0,RoomLength>
};

#declare CeilingCutout = box {
    <0,0,-WallCutout>
    <RoomWidth,WallCutout,RoomLength/5>
    translate<0,RoomHeight,RoomLength - RoomLength/5>
};

#declare edgeLeft = box {
    <0.01,0,0>
    <10, RoomHeight, RoomLength/5>
    translate<0,0,RoomLength - RoomLength/5>
};

#declare edgeRight = box {
    <-0.01,0,0>
    <-10, RoomHeight, RoomLength/5>
    translate<RoomWidth,0,RoomLength - RoomLength/5>
};

#declare edgeCutout = box {
    <-0.01,0,0>
    <15, 2/3*RoomHeight, RoomLength/3>
};

// Door and its cutouts
#declare DoorWidth = 120;
#declare DoorHeight = 240;
#declare DoorDepth = 5;
#declare DoorDistanceFromLeftWall = 800; //for Main Entrance Door
#declare DoorwayCutout = box {
	<0,0.01,-DoorDepth>
	<DoorWidth,DoorHeight,DoorDepth>
};

#declare door = box {
    <0,0,0>
    <DoorWidth,DoorHeight,DoorDepth>
};

object {
    door
    rotate<0,40,0>
    translate<RoomWidth-DoorDistanceFromLeftWall,0,0>
    texture { FloorTexture }
}

#declare BarsHeight = 100;
#declare BarsThickness = 30;
#declare CeilingBars = box {
    <0,0,0>
    <RoomWidth,BarsHeight,BarsThickness>
};

// Pool Cutout
#declare PoolCutoutWidth = 520;
#declare PoolCutoutHeight = 10;
#declare PoolCutoutLength = 450;

#declare PoolCutout = box {
    <0,0,0>
    <PoolCutoutWidth, PoolCutoutHeight, PoolCutoutLength>
};

// BACKGROUND
#declare surroundingArea = sphere {
    <HalfRoomWidth, 2*SeatedEyeHeight, HalfRoomLength>
    3100
};

object {
    surroundingArea
    texture { areaTexture }
}

// CAMERA POSITION and LIGHT_SOURCE 
// Front Camera    //from the door looking outside
#declare CameraPos1 = <RoomWidth-DoorDistanceFromLeftWall,SeatedEyeHeight+100,100>;
#declare Point1 = <HalfRoomWidth-100,SeatedEyeHeight,HalfRoomLength-100>;

// Lower-Right Corner Camera (looking at the pool)
#declare CameraPos2 = <RoomWidth-20,SeatedEyeHeight,HalfRoomLength>;
#declare Point2 = <100,SeatedEyeHeight,RoomLength>;

// Side Camera (looking at the sofa)
#declare CameraPos3 = <HalfRoomWidth+200,SeatedEyeHeight+100,HalfRoomLength>;
#declare Point3 = <HalfRoomWidth-300,SeatedEyeHeight-50,HalfRoomLength-200>;

//Outer Camera (looking inside)
#declare CameraPos4 = <HalfRoomWidth,SeatedEyeHeight+200,RoomLength+400>;
#declare Point4 = <HalfRoomWidth,SeatedEyeHeight-150,HalfRoomLength-200>;

// Upper-Right Corner Camera (near the bed)
#declare CameraPos5 = <RoomWidth-10,SeatedEyeHeight+50,10>;
#declare Point5 = <HalfRoomWidth-500,SeatedEyeHeight,RoomLength>;

// Camera looking to large wardrobe
#declare CameraPos6 = <HalfRoomWidth-50,SeatedEyeHeight+70,HalfRoomLength>;
#declare Point6 = <RoomWidth,SeatedEyeHeight,HalfRoomLength-400>;

camera {
    perspective                                                                  
    location CameraPos5
    look_at Point5
    //angle 30         //for CameraPos2 only
    /*focal_point <160, SeatedEyeHeight-50, HalfRoomLength-220>
    aperture 40
    blur_samples 50*/    //for CameraPos3 only
}

// LIGHTING starts HERE!!!
light_source {
    CameraPos5
    rgb<1,1,1>
}

#declare areaLight = light_source {
    <HalfRoomWidth-100, RoomHeight+500, RoomLength+800>
    rgb<1,1,1>*0.8
    area_light
    <8,0,8>, <0,8,8>, 12, 12
    adaptive 1
    jitter
};

light_source { areaLight }

#declare directionalLight = light_source {
    <RoomWidth-300, RoomHeight+50, RoomLength+400>
    rgb<1,1,0.4>*0.6
    parallel
    point_at <HalfRoomWidth, 10, 250>
};

light_source { directionalLight }

#declare areaLight2 = light_source {
    <RoomWidth-100, RoomHeight+300, RoomLength+1000>
    rgb<1,1,0.4>*0.7
    area_light
    <1,0,1>, <0,1,1>, 8, 8
    adaptive 0.5
    jitter
    shadowless
};

light_source { areaLight2 }

//===========================================================
difference {
    object {
        STARoom
        texture {
            pigment { rgb<0.7,0.8,0.6> }
        }   
    }
    object {
        Floor
        texture { FloorTexture }   
    }
    object {
        behindWall
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        CeilingCutout
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        edgeLeft
        texture { EdgeTexture }
    }
    object {
        edgeRight
        texture { EdgeTexture }
    }
    object {
        CeilingBars      // First
        translate<0,RoomHeight-BarsHeight,RoomLength-RoomLength/5-BarsThickness>
        texture { FloorTexture }
    }
    object {
        CeilingBars      // Second
        translate<0,RoomHeight-BarsHeight,RoomLength-4*(RoomLength/5-BarsThickness)>
        texture { FloorTexture }
    }    
    object {
        DoorwayCutout     // Main Entrance Door
        translate <RoomWidth-DoorDistanceFromLeftWall,0,0>
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        edgeCutout      // Left
        rotate<50,0,0>
        translate<0,RoomHeight,RoomLength-RoomLength/5>
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        edgeCutout      // Right
        translate<-10,-0.5,-0.5>
        rotate<50,0,0>
        translate<RoomWidth,RoomHeight,RoomLength-RoomLength/5>
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        PoolCutout
        translate<RoomWidth-PoolCutoutWidth, -9, RoomLength-PoolCutoutLength-10>
        texture {
            pigment { rgbf<0,0,0.8,1> }
            finish {
                reflection { 1 }
                ambient 1
            }
        }
    } 
}

//================================================================
// FRONT WALL (WHERE THE DOOR LOCATED)
// KING SIZED BED
#declare BedLength = 220;
#declare BedHeight = 30;
#declare BedWidth = 180;
#declare BedDistanceFromGround = 10; 
#declare BedDistanceFromLeftWall = 50;

#declare Bed = box {
    <0,0,0>
    <BedWidth, BedHeight, BedLength>
    translate<RoomWidth-BedWidth-BedDistanceFromLeftWall,BedDistanceFromGround,10>
}

#declare BedCushionHeight = 20;
#declare BedCushion = Round_Box (
    <0,0,0>,
    <BedWidth, BedCushionHeight, BedLength-10>,
    10,0
);

#declare beddingHeight = 60;
#declare Bedding = Round_Box (
    <0,0,0>,
    <BedWidth+12, beddingHeight, BedLength-50>,
    10,0
);

#declare beddingCutoutHeight = 20;
#declare beddingCutout = box {
    <0,0,0>
    <BedWidth+12, beddingCutoutHeight, BedLength-48>
};

difference {
    object {
        Bedding
        translate<RoomWidth-BedWidth-BedDistanceFromLeftWall-6, BedDistanceFromGround, 70>
        texture { beddingTexture }
    }
    object {
        beddingCutout
        translate<RoomWidth-BedWidth-BedDistanceFromLeftWall-6, BedDistanceFromGround, 70>
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
} 

#declare BedBackHeight = 70;
#declare BedBackThickness = 10;
#declare BedBack = box {
    <0,0,0>
    <BedWidth, BedBackHeight, BedBackThickness>
    rotate<0,0,0>
    translate<RoomWidth-BedWidth-BedDistanceFromLeftWall,BedDistanceFromGround+BedHeight,10>
}

#declare BedLegRadius = 5;
#declare BedLeg = cylinder {
    <0,0,0>
    <0,BedDistanceFromGround,0>
    BedLegRadius
} 

union {
    object {
        Bed
        texture { bedFrameTexture }
    }
    object {
        BedCushion
        translate<RoomWidth-BedWidth-BedDistanceFromLeftWall, BedDistanceFromGround+BedHeight, 20>
        texture { bedCushionTexture }
    }
    object {
        BedBack                                      
        texture { bedFrameTexture }
    }
    object {
        BedLeg   //no.1
        translate<RoomWidth-BedWidth-BedDistanceFromLeftWall+BedLegRadius,0,BedLength+10-BedLegRadius>                                   
        texture { bedFrameTexture }
    }
    object {
        BedLeg   //no.2
        translate<RoomWidth-BedWidth-BedDistanceFromLeftWall+BedLegRadius,0,10+BedLegRadius>                                   
        texture { bedFrameTexture }
    }
    object {
        BedLeg   //no.3
        translate<RoomWidth-BedDistanceFromLeftWall-BedLegRadius,0,BedLength+10-BedLegRadius>                                   
        texture { bedFrameTexture }
    }
    object {
        BedLeg   //no.4
        translate<RoomWidth-BedDistanceFromLeftWall-BedLegRadius,0,10+BedLegRadius>                                   
        texture { bedFrameTexture }
    }
}

#declare pilowWidth = 40;
#declare pillowThickness = 7.6;
#declare pillowLength = 58;
#declare pillowDistanceFromLeftWall = 130;

#declare Pillow = Round_Box (
    <0,0,0>,
    <pilowWidth, pillowThickness, pillowLength>,
    7, 0
);

object {
    Pillow    // no.1
    rotate<0,90,0>
    rotate<30,0,0>
    translate<RoomWidth-pillowDistanceFromLeftWall, 8+BedDistanceFromGround+BedHeight+BedCushionHeight, 65>
    texture { beddingTexture }
}

object {
    Pillow    // no.2
    rotate<0,90,0>
    rotate<30,0,0>
    translate<RoomWidth-pillowDistanceFromLeftWall-80, 8+BedDistanceFromGround+BedHeight+BedCushionHeight, 65>
    texture { beddingTexture }
}    

// SMALL DRAWER
#declare drawerLength = 45;
#declare drawerHeight = 60;
#declare drawerWidth = 45;
#declare drawerDistanceFromLeftWall = 300;

#declare Drawer = box {
    <0,0,0>
    <drawerWidth, drawerHeight, drawerLength>
};

object {
    Drawer
    translate<RoomWidth-drawerDistanceFromLeftWall, 0, 10>
    texture { drawerTexture }
}

// A LAMP
#declare lampBody = lathe {
    cubic_spline
    9
    <0,0>,<1.8,0>,<1.8,0.5>,
    <3,2.5>,<3,4.5>,<1.5,8>,
    <0.7,8>,<0.7,8.3>,<0,8.3>
};

#declare lampTop = cone {
    <0,0,0>, 5
    <0,4,0>, 3
};

#declare lampDistanceFromLeftWall = 275;
#declare lampDistanceFromFrontWall = 20;

#declare Lamp = union {
    object { 
        lampBody
        texture{ lampBodyTexture }    
    }
    object {
        lampTop
        translate<0, 9, 0>
        texture{ lampGlassTexture }
        interior {
            ior 1.5
        }    
    }
}

object {
    Lamp
    scale 4
    translate<RoomWidth-lampDistanceFromLeftWall, drawerHeight, 10+lampDistanceFromFrontWall>
}
    
// TABLE AND CHAIR
#declare TableLength = 61;
#declare TableThickness = 10;
#declare TableWidth = 180;
#declare TableHeightFromGround = 65;
#declare TableDistanceFromLeftWall = 570;

#declare TableTop = box {
    <0,0,0>
    <TableWidth, TableThickness, TableLength>
}

#declare TableSidesWidth = 5;
#declare TableSides = box {
    <0,0,0>
    <TableSidesWidth, TableHeightFromGround, TableLength>
}

#declare Table = union {
    object {
        TableTop
        translate<RoomWidth-TableDistanceFromLeftWall, TableHeightFromGround, 10>  
    }
    object {
        TableSides //right
        translate<RoomWidth-TableDistanceFromLeftWall, 0, 10>   
    }
    object {
        TableSides //left
        translate<RoomWidth-TableDistanceFromLeftWall+TableWidth-TableSidesWidth, 0, 10>   
    }
};

object {
    Table
    texture { tableTexture }
}

#declare ChairWidth = 50;
#declare ChairThickness = 5;
#declare ChairLength = 54;
#declare ChairHeightFromGround = 41;
#declare ChairDistanceFromLeftWall = 500;

#declare ChairSeat = Round_Box (
    <0,0,0>,
    <ChairWidth, ChairThickness, ChairLength>,
    4, 0
);

#declare ChairBackHeight = 58;
#declare ChairBack = box {
    <0,0,0>
    <ChairWidth, ChairBackHeight, ChairThickness>
}

#declare ChairLegRadius = 3;
#declare ChairLeg = cylinder {
    <0,0,0>
    <0, ChairHeightFromGround, 0>
    ChairLegRadius
}

union {
    object {
        ChairSeat
        translate<RoomWidth-ChairDistanceFromLeftWall, ChairHeightFromGround, 17+(1/3)*TableWidth>
        texture { chairSeatTexture }
    }
    object {
        ChairBack
        translate<RoomWidth-ChairDistanceFromLeftWall, ChairHeightFromGround, 8+((2/3)*TableWidth)>
        texture { chairSeatTexture }
    }
    object {
        ChairLeg  // no.1
        translate<RoomWidth-ChairDistanceFromLeftWall+ChairLegRadius, 0, 10+((2/3)*TableWidth)>
        texture {
            pigment { rgb<0,0,0> }
        }
    } 
    object {
        ChairLeg  // no.2
        translate<RoomWidth-ChairDistanceFromLeftWall+ChairWidth-ChairLegRadius/2, 0, 10+((2/3)*TableWidth)>
        texture {
            pigment { rgb<0,0,0> }
        }
    }
    object {
        ChairLeg  // no.3
        translate<RoomWidth-ChairDistanceFromLeftWall+ChairWidth-ChairLegRadius/2, 0, 10+((2/3)*TableWidth)-ChairWidth>
        texture {
            pigment { rgb<0,0,0> }
        }
    }
    object {
        ChairLeg  // no.4
        translate<RoomWidth-ChairDistanceFromLeftWall+ChairLegRadius, 0, 10+((2/3)*TableWidth)-ChairWidth>
        texture {
            pigment { rgb<0,0,0> }
        }
    }
}

//======================================================================
// RIGHT WALL 
// A PAINTING
#declare PaintingWidth = 210;
#declare PaintingHeight = 150;
#declare PaintingThickness = 3;
#declare PaintingDistanceFromLeftCorner = 100;
#declare PaintingHeightFromGround = 150;

#declare PaintingOuter = box {
    <0,0,0>
    <PaintingWidth, PaintingHeight, PaintingThickness>
}

#declare PaintingInner = box {
    <0,0,0>
    <PaintingWidth-30, PaintingHeight-30, PaintingThickness+2>
}

#declare Picture = box {
    <0,0,0>
    <PaintingWidth-30, PaintingHeight-30, PaintingThickness-2>
}

union {
    object {
        PaintingOuter
        rotate<0,-90,0>
        translate<PaintingThickness, PaintingHeightFromGround, PaintingDistanceFromLeftCorner>
        texture { frameTexture }
    }
    object {
        PaintingInner
        rotate<0,-90,0>
        translate<PaintingThickness+2, PaintingHeightFromGround+15, PaintingDistanceFromLeftCorner+15>
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        Picture
        rotate<0,-90,0>
        translate<PaintingThickness+1, PaintingHeightFromGround+15, PaintingDistanceFromLeftCorner+15>
        texture { pictureTexture }
    }
}

// BOOKSHELVES
#declare BookshelfBottomWidth = 104;
#declare BookshelfBottomHeight = 54;
#declare BookshelfBottomDepth = 45.5;
#declare BookshelfDistanceFromLeftCorner = 350;

#declare BookshelfBottom = box {
    <0,0,0>
    <BookshelfBottomWidth, BookshelfBottomHeight, BookshelfBottomDepth>
}

#declare BookshelfBarsWidth = 5;
#declare BookshelfBarsHeight = 154;
#declare BookshelfBarsDepth = 5;
#declare BookshelfBars = box {
    <0,0,0>
    <BookshelfBarsWidth, BookshelfBarsHeight, BookshelfBarsDepth>
}

#declare BookshelfFloorHeight = 5;
#declare BookshelfSecondFloor = box {
    <0,0,0>
    <BookshelfBottomWidth, BookshelfFloorHeight, BookshelfBottomDepth>
}

#declare BookshelfThirdFloor = box {
    <0,0,0>
    <BookshelfBottomWidth, BookshelfFloorHeight, BookshelfBottomDepth>
}

#declare BookshelfTopFloor = box {
    <0,0,0>
    <BookshelfBottomWidth, BookshelfFloorHeight-2, BookshelfBottomDepth>
}

#declare Bookshelf = union {
    object {
        BookshelfBottom
        rotate<0,-90,0>
        translate<BookshelfBottomDepth, 0, BookshelfDistanceFromLeftCorner>
    }
    object {
        BookshelfSecondFloor
        rotate<0,-90,0>
        translate<BookshelfBottomDepth, BookshelfBottomHeight+(BookshelfBarsHeight/3), BookshelfDistanceFromLeftCorner>
    }
    object {
        BookshelfThirdFloor
        rotate<0,-90,0>
        translate<BookshelfBottomDepth, BookshelfBottomHeight+(2*BookshelfBarsHeight/3), BookshelfDistanceFromLeftCorner>
    }
    object {
        BookshelfTopFloor
        rotate<0,-90,0>
        translate<BookshelfBottomDepth, BookshelfBottomHeight+BookshelfBarsHeight, BookshelfDistanceFromLeftCorner>
    } 
    object {
        BookshelfBars // no.1
        rotate<0,-90,0>
        translate<BookshelfBottomDepth, BookshelfBottomHeight, BookshelfDistanceFromLeftCorner>
    }
    object {
        BookshelfBars // no.2
        rotate<0,-90,0>
        translate<BookshelfBarsWidth, BookshelfBottomHeight, BookshelfDistanceFromLeftCorner>
    }
    object {
        BookshelfBars // no.3
        rotate<0,-90,0>
        translate<BookshelfBarsWidth, BookshelfBottomHeight, BookshelfBottomWidth+BookshelfDistanceFromLeftCorner-BookshelfBarsWidth>
    }
    object {
        BookshelfBars // no.4
        rotate<0,-90,0>
        translate<BookshelfBottomDepth, BookshelfBottomHeight, BookshelfBottomWidth+BookshelfDistanceFromLeftCorner-BookshelfBarsWidth>
    }
}

object {
    Bookshelf
    texture { bookshelfTexture }
}

// Another one
#declare Bookshelf2DistanceFromBookshelf1 = 480;

object {
    Bookshelf
    translate<0, 0, Bookshelf2DistanceFromBookshelf1>
    texture { bookshelfTexture }
}

// A tree pot
// Leaves
#declare Leaf = mesh {
    triangle {
        <0,0,0>
        <1,3,0>
        <1,2,-1>
    }
    triangle {
        <0,0,0>
        <1,3,0>
        <1,2,1>
    }
    triangle {
        <4,4.5,0>
        <1,3,0>
        <1,2,1>
    }
    triangle {
        <4,4.5,0>
        <1,3,0>
        <1,2,-1>
    } 
}

#declare Leaf2 = mesh2 {
    vertex_vectors {
        5
        <0,0,0>, <0.8,3.5,0>, <1,2,-1>, 
        <1,2,1>, <3.4,0.5,0>
    }
    face_indices {
        4
        <0,1,2>, <0,1,3>,
        <4,1,2>, <4,1,3>
    }
};

#declare innerLeaves = union {
    #declare Index = 0;
    #while (Index < 360)
        object { 
            Leaf
            rotate<0,Index,0>
        }
        #declare Index = Index + 50;
    #end
    scale 1.5
    texture { leavesTexture }
}

#declare outerLeaves = union {
    #declare Index = 0;
    #while (Index < 360)
        object { 
            Leaf2
            rotate<0,Index,0>
        }
        #declare Index = Index + 30;
    #end
    scale 1.4
    texture { leavesTexture }
}

// Pot
#declare Pot = lathe {
    cubic_spline
    8
    <0,0>,<1.8,0>,<1.8,0.5>,
    <3,1.8>,<3,3>,<1.5,5>,
    <0.7,5>,<0,5>
};

#declare treePot = union {
    object {
        Pot
        translate<0,-3,0>
        texture { potTexture }
    }
    object { innerLeaves }
    object { outerLeaves }
};

object {
    treePot   // first one on closer shelf
    scale 5
    translate<20, BookshelfBottomHeight+(2*BookshelfBarsHeight/3)+20, BookshelfDistanceFromLeftCorner+50>
}

object {
    treePot   // second one on further shelf
    scale 5
    translate<20, BookshelfBottomHeight+(2*BookshelfBarsHeight/3)+20, BookshelfDistanceFromLeftCorner+Bookshelf2DistanceFromBookshelf1+50>
}
    
// Wadrobe
#declare wardrobeWidth = 252;
#declare wardrobeHeight = 82;
#declare wardrobeDepth = 65;
#declare wardrobeDistanceFromLeftCorner = 520;
                         
#declare Wardrobe = box {
    <0,0,0>
    <wardrobeWidth, wardrobeHeight, wardrobeDepth>
}

#declare wardrobeBarsNum = 2;
#declare wardrobeVBars = box {         // Vertical lines
    <0,0,0>
    <wardrobeBarsNum, wardrobeHeight, wardrobeBarsNum> 
}

#declare wardrobeHBars = box {
    <0,0,0>
    <wardrobeWidth, wardrobeBarsNum, wardrobeBarsNum>
}

union {
    object {
        Wardrobe
        rotate<0,-90,0>
        translate<wardrobeDepth, 0, wardrobeDistanceFromLeftCorner>
        texture { wardrobeTexture }
    }
    object {
        wardrobeVBars
        rotate<0,-90,0>
        translate<wardrobeDepth+1, 0, wardrobeDistanceFromLeftCorner+(wardrobeWidth/2)>
        texture { 
            pigment { rgb<0,0,0> }
        }
    }
    object {
        wardrobeHBars  // no.1
        rotate<0,-90,0>
        translate<wardrobeDepth+1, wardrobeHeight/3, wardrobeDistanceFromLeftCorner>
        texture { 
            pigment { rgb<0,0,0> }
        }
    }
    object {
        wardrobeHBars  // no.2
        rotate<0,-90,0>
        translate<wardrobeDepth+1, 2*wardrobeHeight/3, wardrobeDistanceFromLeftCorner>
        texture { 
            pigment { rgb<0,0,0> }
        }
    }
}

// A SECOND LAMP
#declare LampBoxWidth = 25;
#declare LampBoxHeight = 50;
#declare LampBoxLength = 30;
#declare LampDistanceFromLeftCorner = 470 + wardrobeWidth;
#declare LampHeightFromGround = wardrobeHeight;

#declare LampBox = box {
    <0,0,0>
    <LampBoxWidth, LampBoxHeight, LampBoxLength>
};

#declare LampCone = cone {
    <0,0,0> , 25
    <0,27,0>, 20
    open
};

union {
    object {
        LampBox
        rotate<0,-90,0>
        translate<LampBoxLength +20, LampHeightFromGround, LampDistanceFromLeftCorner>
        texture { lamp2Texture }
    }
    object {
        LampCone
        rotate<0,-90,0>
        translate<LampBoxLength/2 +20, LampBoxHeight+LampHeightFromGround+3, LampDistanceFromLeftCorner+12>
        texture { lampGlassTexture }
    }
}  

// A MIRROR
#declare mirrorFrameWidth = 120;
#declare mirrorFrameHeight = 150;
#declare mirrorFrameThickness = 3;
#declare mirrorDistanceFromLeftCorner = 460 + wardrobeWidth/2;
#declare mirrorHeightFromGround = wardrobeHeight + 50;

#declare mirrorFrame = box {
    <0,0,0>
    <mirrorFrameWidth, mirrorFrameHeight, mirrorFrameThickness>
};

#declare Mirror = box {
    <0,0,0>
    <mirrorFrameWidth-20, mirrorFrameHeight-20, mirrorFrameThickness+2>
};

union {
    object {
        mirrorFrame
        rotate<0,-90,0>
        translate<mirrorFrameThickness, mirrorHeightFromGround, mirrorDistanceFromLeftCorner>
        texture { frameTexture }
    }
    object {
        Mirror
        rotate<0,-90,0>
        translate<mirrorFrameThickness+2, mirrorHeightFromGround+10, mirrorDistanceFromLeftCorner+10>
        texture { mirrorTexture }
    }
}

//==============================================================================
// LEFT WALL
// ANOTHER GIANT WARDROBE
#declare wardrobe2Width = 210;
#declare wardrobe2Height = 260;
#declare wardrobe2Length = 80;
#declare wardrobe2DistanceFromLeftCorner = 400;

#declare Wardrobe2 = box {
    <0,0,0>
    <wardrobe2Width, wardrobe2Height, wardrobe2Length>
};

#declare wardrobeCutoutThickness = 5;
#declare wardrobeSidesCutout = box {
    <0,0,0>
    <wardrobe2Width/3-40, wardrobe2Height-40, wardrobeCutoutThickness>
};

#declare wardrobeBehindThickness = 2;
#declare wardrobeSidesBehind = box {
    <0,0,0>
    <wardrobe2Width/3-38, wardrobe2Height-38, wardrobeCutoutThickness>
};

#declare wardrobeMirror = box {
    <0,0,0>
    <wardrobe2Width/2+10, wardrobe2Height/2, wardrobeCutoutThickness>
};

#declare lineCutThickness = 3;
#declare verticalLineCut = box {
    <0,0,0>
    <1, wardrobe2Height-40, lineCutThickness>
};

#declare verticalLineCut2 = box {
    <0,0,0>
    <1, wardrobe2Height/2-40, lineCutThickness>
};

#declare horizontalLineCut = box {
    <0,0,0>
    <wardrobe2Width/2+10, 1, lineCutThickness>
};

#declare wardrobeKnob = sphere {
    <0,0,0>
    3
};   

difference {
    object {
        Wardrobe2
        rotate<0,-90,0>
        translate<RoomWidth, 0, wardrobe2DistanceFromLeftCorner>    
        texture { wardrobeTexture }
    }
    object {
        wardrobeSidesCutout //Left
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+3, 20, wardrobe2DistanceFromLeftCorner+wardrobe2Width-40>
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        wardrobeSidesCutout //Right
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+3, 20, wardrobe2DistanceFromLeftCorner+15>
        texture {
            pigment { rgbf<1,1,1,1> }
        }
    }
    object {
        wardrobeSidesBehind //Left
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+5, 19, wardrobe2DistanceFromLeftCorner+wardrobe2Width-41>
        texture { wardrobeTexture }
    }
    object {
        wardrobeSidesBehind //Right
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+5, 19, wardrobe2DistanceFromLeftCorner+14>
        texture { wardrobeTexture }
    }
    object {
        wardrobeMirror
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+5, wardrobe2Height/2-20, wardrobe2DistanceFromLeftCorner+wardrobe2Width/3-20>
        texture { mirrorTexture }
    }
    object {
        verticalLineCut  // Mid
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+2, 20, wardrobe2DistanceFromLeftCorner+wardrobe2Width/2>
        texture {
            pigment { rgb<0,0,0> }
        }
    }
    object {
        verticalLineCut2  // Right
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+2, 20, wardrobe2DistanceFromLeftCorner+wardrobe2Width/3-20>
        texture {
            pigment { rgb<0,0,0> }
        }
    }
    object {
        verticalLineCut2  // Left
        rotate<0,-90,0>
        translate<RoomWidth-wardrobe2Length+2, 20, wardrobe2DistanceFromLeftCorner+wardrobe2Width/3-21+(wardrobe2Width/2+10)>
        texture {
            pigment { rgb<0,0,0> }
        }
    }
    union {
        #declare Index = 20;
        #while (Index < 90)
            object { 
                horizontalLineCut
                rotate<0,-90,0>
                translate<RoomWidth-wardrobe2Length+2, Index, wardrobe2DistanceFromLeftCorner+wardrobe2Width/3-20>
            }
            #declare Index = Index + 30;
        #end
        texture {
            pigment { rgb<0,0,0> }
        }
    } 
}

#declare knobs = union {
    #declare Index2 = 35;
    #while (Index2 < 100)
        object { 
            wardrobeKnob
            translate<RoomWidth-wardrobe2Length+2, Index2, wardrobe2DistanceFromLeftCorner+wardrobe2Width/3+8>
        }
        #declare Index2 = Index2 + 30;
    #end
    texture { pillarTexture }
}

object { knobs }   // right columns
object {           // left columns
    knobs
    translate<0, 0, 57>
}

//=============================================================================
// BEHIND WALL
// Indoor Swimming Pool (Water + Pool Edge)
#declare WaterWidth = 520;
#declare WaterHeight = 150;
#declare WaterLength = 450;

#declare Water = box {
    <0,0,0>
    <WaterWidth, WaterHeight, WaterLength>
};

object {
    Water
    translate<RoomWidth-WaterWidth, -110, RoomLength-WaterLength-10>
    texture { waterTexture }
    interior {
        ior 1.33 // Water
    }
}

#declare PoolEdgeHeight = 48;
#declare PoolEdgeThickness = 39;
#declare PoolEdge1 = box {
    <0,0,0>
    <WaterWidth+PoolEdgeThickness, PoolEdgeHeight, PoolEdgeThickness>
};

#declare PoolEdge2 = box {
    <0,0,0>
    <WaterLength+PoolEdgeThickness, PoolEdgeHeight, PoolEdgeThickness>
};

#declare PoolUpperEdgeHeight = 7;
#declare PoolUpperEdgeThickness = 51;
#declare PoolUpperEdge1 = Round_Box (
    <0,0,0>, 
    <WaterWidth+PoolUpperEdgeThickness, PoolUpperEdgeHeight, PoolUpperEdgeThickness>,
    5,0
);

#declare PoolUpperEdge2 = Round_Box (
    <0,0,0>, 
    <WaterLength+PoolUpperEdgeThickness/2, PoolUpperEdgeHeight, PoolUpperEdgeThickness>,
    5,0
); 

union {
    object {
        PoolEdge1 // no.1
        translate<RoomWidth-WaterWidth+PoolEdgeThickness, 0, RoomLength-WaterLength-10-PoolEdgeThickness>
        texture { poolEdgeTexture }
    }
    object {
        PoolEdge2 // no.2
        rotate<0,-90,0>
        translate<RoomWidth-WaterWidth+PoolEdgeThickness, 0, RoomLength-WaterLength-10-PoolEdgeThickness>
        texture { poolEdgeTexture }
    }
    object {
        PoolUpperEdge1    //horizontal
        translate<RoomWidth-WaterWidth+PoolUpperEdgeThickness-8, PoolEdgeHeight, RoomLength-WaterLength-6-PoolUpperEdgeThickness>
        texture { poolUpperEdgeTexture }
    }
    object {
        PoolUpperEdge2    //vertical
        rotate<0,-90,0>
        translate<RoomWidth-WaterWidth+PoolUpperEdgeThickness-8, PoolEdgeHeight, RoomLength-WaterLength-6-PoolUpperEdgeThickness>
        texture { poolUpperEdgeTexture }
    }
}

// Resort Chairs
#declare RChairWidth = 62;
#declare RChairThickness = 5;
#declare RChairLength = 118;
#declare RChairHeightFromGround = 33;
#declare RChairDistanceFromRightCorner = 250;
#declare RChairDistanceFromBackWall = 100;

#declare RChairBot = box {
    <0,0,0>
    <RChairWidth, RChairThickness, RChairLength>
};

#declare RChairBackLength = 80;
#declare RChairBack = box {
    <0,0,0>
    <RChairWidth, RChairThickness, RChairBackLength>
};

#declare RChairLegRadius = 3;
#declare RChairLeg = cylinder {
    <0,0,0>
    <0,RChairHeightFromGround,0>
    RChairLegRadius
};

#declare RChairArmRestDistanceFromBack = 80;
#declare RChairArmRestHeight = 23;
#declare RChairVerticalArmRestRadius = 2;
#declare RChairVerticalArmRest = cylinder {
    <0,0,0>
    <0,RChairArmRestHeight,0>
    RChairVerticalArmRestRadius
};

#declare RChairArmRestWidth = 11;
#declare RChairArmRestThickness = 2;
#declare RChairHorizontalArmRest = box {
    <0,0,0>
    <RChairArmRestWidth, RChairArmRestThickness, RChairArmRestDistanceFromBack+14>
};        

#declare RChairArmsyLegs = union {
    object {
        RChairVerticalArmRest // no.1
        translate<RChairDistanceFromBackWall+RChairArmRestDistanceFromBack, RChairHeightFromGround, RoomLength-RChairDistanceFromRightCorner+RChairVerticalArmRestRadius/2>
    }
    object {
        RChairHorizontalArmRest // no.1
        rotate<0,-90,0>
        translate<RChairDistanceFromBackWall+RChairArmRestDistanceFromBack+8, RChairHeightFromGround+RChairArmRestHeight, RoomLength-RChairDistanceFromRightCorner-RChairArmRestWidth/2>
    }
    object {
        RChairVerticalArmRest // no.2
        translate<RChairDistanceFromBackWall+RChairArmRestDistanceFromBack, RChairHeightFromGround, RoomLength-RChairDistanceFromRightCorner+RChairWidth-RChairVerticalArmRestRadius/2>
    }
    object {
        RChairHorizontalArmRest // no.2
        rotate<0,-90,0>
        translate<RChairDistanceFromBackWall+RChairArmRestDistanceFromBack+8, RChairHeightFromGround+RChairArmRestHeight, RoomLength-RChairDistanceFromRightCorner+RChairWidth-RChairArmRestWidth>
    }
    object {
        RChairLeg // no.1
        translate<RChairDistanceFromBackWall, 0, RoomLength-RChairDistanceFromRightCorner+RChairLegRadius>
    }
    object {
        RChairLeg // no.2
        translate<RChairDistanceFromBackWall, 0, RoomLength-RChairDistanceFromRightCorner+RChairWidth-RChairLegRadius>
    }
    object {
        RChairLeg // no.3
        translate<RChairLength+RChairDistanceFromBackWall-RChairLegRadius, 0, RoomLength-RChairDistanceFromRightCorner+RChairLegRadius>
    }
    object {
        RChairLeg // no.4
        translate<RChairLength+RChairDistanceFromBackWall-RChairLegRadius, 0, RoomLength-RChairDistanceFromRightCorner+RChairWidth-RChairLegRadius>
    }
}   

#declare RChair = union {
    object {                         
        RChairBot
        rotate<0,-90,0>
        translate<RChairLength+RChairDistanceFromBackWall, RChairHeightFromGround, RoomLength-RChairDistanceFromRightCorner>
        texture { rChairTexture }
    }
    object {
        RChairBack
        rotate<-45,-90,0>
        translate<RChairDistanceFromBackWall, RChairHeightFromGround, RoomLength-RChairDistanceFromRightCorner>
        texture { rChairTexture }
    }
    object {
        RChairArmsyLegs
        texture { rChairArmsTexture }
    }
}

object { RChair } // no.1

#declare RChair2DistanceFromRChair1 = 110;
object { 
    RChair   // no.2
    translate<0,0,RChair2DistanceFromRChair1> 
}

//============================================================================
// MIDDLE OF THE ROOM
// A 'living room' TABLE
#declare lrTableWidth = 150;
#declare lrTableHeight = 53;
#declare lrTableLength = 69;
#declare lrTableDistanceFromRightWall = 110;
#declare lrTableDistanceFromFrontWall = HalfRoomLength-210;

#declare outerLrTable = box {
    <0,0,0>
    <lrTableWidth, lrTableHeight, lrTableLength>
};

#declare innerLrTable = box {
    <0,0,0>
    <lrTableWidth, lrTableHeight-20, lrTableLength-20>
};

difference {
    object {
        outerLrTable
        translate<lrTableWidth+lrTableDistanceFromRightWall, 0, lrTableDistanceFromFrontWall>
        texture { lrTableTexture }
    }
    object {
        innerLrTable
        translate<lrTableWidth+lrTableDistanceFromRightWall, 10, lrTableDistanceFromFrontWall+10>
        texture {
            pigment { rgb<0,0,0> }
        }
    }
}

// Wine Bottle + Wine Glass
#declare wineBottleUpper = lathe {
    bezier_spline
    8
    <1.3,0>,<1.3,1>,<1.3,3>,<0.6,4>,
    <0.6,4>,<0.2,5>,<0.4,6>,<0.4,7>   
};

#declare wineBottleBody = cylinder {
    <0,0,0>
    <0,-2,0>
    1.3
};

#declare wineBottle = union {
    object { 
        wineBottleUpper
        texture{
            pigment { color rgbt<0,0.7,0,0.3> }
        }
    }
    object {
        wineBottleBody
        texture{
            pigment { color rgbt<0,0.7,0,0.3> }
        }
    }    
}

#declare wineBottleDistanceFromRightWall = 300;
#declare wineBottleDistanceFromFrontWall = HalfRoomLength-160;

object { 
    wineBottle
    scale 4
    translate<wineBottleDistanceFromRightWall, lrTableHeight+8, wineBottleDistanceFromFrontWall>
    texture {
        finish {
            ambient 0
            specular .4
            roughness 0.001
            reflection { 
                0.5, 0.8   //minimum & maximum amount of reflectivity
                fresnel on 
            }
            metallic   
        }
    }
    interior {
        ior 1.33   // Water
    }
}

#declare wineGlass = lathe {
    quadratic_spline
    8
    <0,0>,<1,0>,<1,0.2>,
    <0.3,0.2>,<0.3,3>,<0.3,3.5>,
    <2.5,5.5>,<0,5.5>
};

#declare wineGlassDistanceFromRightWall = 340;
#declare wineGlassDistanceFromFrontWall = HalfRoomLength-160;

object { 
    wineGlass
    scale 3
    translate<wineGlassDistanceFromRightWall, lrTableHeight, wineGlassDistanceFromFrontWall>
    texture{
        pigment { color rgb <0.9,0.9,0.9> }
        finish {
            ambient 0
            specular .6
            roughness 0.005
            reflection { 
                0.3, 0.7   //minimum & maximum amount of reflectivity
                fresnel on 
            }
            metallic
        }    
    }
    interior {
        ior 1.5   // Glass
    }
}    

 
// First Couch (behind lrTable)
#declare couch1Width = 137;
#declare couch1Height = 44;
#declare couch1Length = 89;
#declare couch1DistanceFromRightWall = 130;
#declare couch1DistanceFromFrontWall = HalfRoomLength-100;

#declare couch1Seat = box {
    <0,0,0>
    <couch1Width, couch1Height, couch1Length>
};

#declare couch1BackHeight = 49;
#declare couch1BackLength = 31;     
#declare couch1Back = box {
    <0,0,0>
    <couch1Width, couch1BackHeight, couch1BackLength>
};

#declare couchCushionThickness = 7;
#declare couch1CushionSeat = Round_Box (
    <0,0,0>,
    <couch1Width/2, couchCushionThickness, couch1Length-couch1BackLength-couchCushionThickness>,
    7, 0
);

#declare couch1CushionBackHeight = couch1BackHeight+couchCushionThickness+4;
#declare couch1CushionBack = Round_Box (
    <0,0,0>,
    <couch1Width/2, couch1CushionBackHeight, couchCushionThickness>,
    5, 0
); 

union {
    object {
        couch1Seat
        translate<couch1Width+couch1DistanceFromRightWall, 2, couch1DistanceFromFrontWall>
        texture { couchTexture }
    }
    object {
        couch1Back
        translate<couch1Width+couch1DistanceFromRightWall, couch1Height+2, couch1DistanceFromFrontWall+couch1Length-couch1BackLength>
        texture { couchTexture }
    }
    object {
        couch1CushionSeat  // no.1
        translate<couch1Width-0.7+couch1DistanceFromRightWall, couch1Height+2, couch1DistanceFromFrontWall>
        texture { couchCushionTexture }
    }
    object {
        couch1CushionSeat  // no.2
        translate<couch1Width+0.7+couch1Width/2+couch1DistanceFromRightWall, couch1Height+2, couch1DistanceFromFrontWall>
        texture { couchCushionTexture }
    }
    object {
        couch1CushionBack  // no.1
        translate<couch1Width-0.7+couch1DistanceFromRightWall, couch1Height+2, couch1DistanceFromFrontWall+couch1Length-couch1BackLength-couchCushionThickness>
        texture { couchCushionTexture }
    }
    object {
        couch1CushionBack  // no.2
        translate<couch1Width+0.7+couch1Width/2+couch1DistanceFromRightWall, couch1Height+2, couch1DistanceFromFrontWall+couch1Length-couch1BackLength-couchCushionThickness>
        texture { couchCushionTexture }
    }
}

// Chess Table (next to First Couch)
#declare chessTableWidth = 40;
#declare chessTableHeight = 70;
#declare chessTableLength = 40;
#declare chessTableDistanceFromRightWall = 256;
#declare chessTableDistanceFromFrontWall = HalfRoomLength-70;

#declare chessTableInner = box {
    <0,0,0>
    <chessTableWidth, chessTableHeight, chessTableLength>
};

#declare Inner_OuterDifference = 16;
#declare chessTableOuter = box {
    <0,0,0>
    <chessTableWidth+Inner_OuterDifference, chessTableHeight-Inner_OuterDifference-8, chessTableLength+Inner_OuterDifference>
};

#declare chessBoard = box {
    <0,0,0>
    <chessTableWidth, 1.5, chessTableLength>
};

union {
    object {
        chessTableInner
        translate<chessTableWidth+chessTableDistanceFromRightWall+couch1Width, 0, chessTableDistanceFromFrontWall>
        texture { lrTableTexture }
    }
    object {
        chessTableOuter
        translate<chessTableWidth+chessTableDistanceFromRightWall+couch1Width-Inner_OuterDifference/2, 4+Inner_OuterDifference/2, chessTableDistanceFromFrontWall-Inner_OuterDifference/2>
        texture { sideTablesTexture }
    }
    object {
        chessBoard
        translate<chessTableWidth+chessTableDistanceFromRightWall+couch1Width, chessTableHeight, chessTableDistanceFromFrontWall>
        texture {
            pigment { 
                checker rgb<0,0,0>, rgb<1,1,1>
                scale 4  
            }
        }
    }
}

// Couch Side Table + A Flower Vase
#declare couchSideTableWidth = 45;
#declare couchSideTableHeight = 63;
#declare couchSideTableLength = 50;
#declare couchSideTableDistanceFromRightWall = 150;
#declare couchSideTableDistanceFromFrontWall = HalfRoomLength-70;

#declare couchSideTable = box {
    <0,0,0>
    <couchSideTableWidth, couchSideTableHeight, couchSideTableLength>
};

object {
    couchSideTable
    translate<couchSideTableWidth+couchSideTableDistanceFromRightWall, 0, couchSideTableDistanceFromFrontWall>
    texture { sideTablesTexture }
}

// Add a Flower Vase here 
#declare flowerVase = lathe {
    cubic_spline
    7
    <0,0>,<2.0,0>,<4,5>,
    <2,8>,<1.5,13>,<1.7,14>,
    <0,14>
};

object { 
    flowerVase
    scale 4
    translate<couchSideTableWidth+couchSideTableDistanceFromRightWall+22, couchSideTableHeight, couchSideTableDistanceFromFrontWall+15>
    texture{ flowerVaseTexture }    
}

// Second Couch (left side from lrTable)
#declare couch2Width = 92;
#declare couch2Height = 44;
#declare couch2Length = 110;
#declare couch2DistanceFromRightWall = 90;
#declare couch2DistanceFromFrontWall = HalfRoomLength-300;

#declare couch2Seat = box {
    <0,0,0>
    <couch2Width, couch2Height, couch2Length>
};

#declare couch2BackHeight = 49;
#declare couch2BackLength = 21;     
#declare couch2Back = box {
    <0,0,0>
    <couch2Width, couch2BackHeight, couch2BackLength>
};

#declare couch2CushionSeat = Round_Box (
    <0,0,0>,
    <couch2Width-couch2BackLength-couchCushionThickness, couchCushionThickness, couch2Length-couch2BackLength-couchCushionThickness>,
    7, 0
);

#declare couch2CushionBackHeight = couch2BackHeight+couchCushionThickness+4;
#declare couch2CushionBack = Round_Box (
    <0,0,0>,
    <couch2Width-couch2BackLength, couch2CushionBackHeight, couchCushionThickness>,
    5, 0
);

#declare couch2 = union {
    object {
        couch2Seat  
        texture { couchTexture }
    }
    object {
        couch2Back  // no.1
        translate<0, couch2Height, couch2Length-couch2BackLength>
        texture { couchTexture }
    }
    object {
        couch2Back  // no.2
        rotate<0,90,0>
        translate<0, couch2Height, couch2Length-couch2BackLength+3>
        texture { couchTexture }
    }
    object {
        couch2CushionSeat  
        translate<couch2BackLength+couchCushionThickness, couch2Height, 0>
        texture { couchCushionTexture }
    }
    object {
        couch2CushionBack  // no.1
        translate<couch2BackLength, couch2Height, couch2Length-couch2BackLength-couchCushionThickness>
        texture { couchCushionTexture }
    }
    object {
        couch2CushionBack  // no.2
        rotate<0,90,0>
        translate<couch2BackLength, couch2Height, couch2Length-couch2BackLength-couchCushionThickness-5>
        texture { couchCushionTexture }
    }
}

object { 
    couch2
    rotate<0,-55,0>
    translate<couch2Width+couch2DistanceFromRightWall, 2, couch2DistanceFromFrontWall> 
}

// BACK WALL
// Metal Pellar
#declare pillarHeight = 142;
#declare pillarBar = cylinder {
    <0,0,0>
    <0, pillarHeight, 0>
    3
};

#declare pillarBall = sphere {
    <0,0,0>
    4.3
};

#declare pillar = union {
    object { pillarBar }
    object {
        pillarBall
        translate<0, pillarHeight+2, 0>
    }
};

union {
    #declare Index = 200;
    #while (Index < RoomWidth)
        object { 
            pillar
            translate<Index, 0, RoomLength-5>
        }
        #declare Index = Index + 200;
    #end
    texture { pillarTexture }
}

// Glass Wall
#declare glassWallWidth = 200;
#declare glassWallThickness = 3;
#declare glassWall = box {
    <0,0,0>
    <glassWallWidth, pillarHeight, glassWallThickness>
};

union {
    #declare Index = 0;
    #while (Index < RoomWidth)
        object { 
            glassWall
            translate<Index, 0, RoomLength-6>
        }
        #declare Index = Index + 6;
    #end
    texture { glassWallTexture }
}
                    
    



 
   
     
    
                                                          