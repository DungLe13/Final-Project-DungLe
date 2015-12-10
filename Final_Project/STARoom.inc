
#include "textures.inc"
#include "woods.inc"

#declare areaTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "Caribbean_Sea.jpg" }
    }
    scale <0.4,0.2,0.2>
    //scale <0.8,0.4,0.2>    // for cameraPos2 only
};

#declare FloorTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "floor.jpeg" }
    }
};

#declare EdgeTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "stone_wall.jpeg" }
        scale 0.5
    }
};

// FRONT WALL
// BED TEXTURE
#declare bedFrameTexture = texture {
    pigment {
        image_map { jpeg "Bed_wood.jpg" }
        scale 50
    }
};

#declare bedCushionTexture = texture {
    uv_mapping
    pigment {
        image_map { 
            jpeg "bedCushion.jpg" 
        }
        scale <.2, .3, 1>
    }
    normal {
        bumps 0.3
        scale 1.2
    }
};

#declare beddingTexture = texture {
    uv_mapping            
    pigment {
        image_map { jpeg "bedSheet.jpg" }
        scale <0.8,1,0.8>
    }
};

// DRAWER and LAMP
#declare drawerTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "drawer-wood.jpg" }
        scale 3
    }
};

#declare lampGlassTexture = texture {
    uv_mapping
    pigment {
        rgbf <1,1,1,0.2>
    }
    normal {
        bumps 0.6
        scale 0.7
    }
    finish {
        specular 0.4
        roughness .001
        reflection { 0.8 }
    }                
}

#declare lampBodyTexture = texture {
    pigment {
        image_map { jpeg "lampBody.jpg" }
        scale 50
    }
}

// TABLE and CHAIR
#declare tableTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "table_wood.jpg" }
        scale 2
    }
};

#declare chairSeatTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "chairSeat.jpg" }
        scale 2
    }
};

// RIGHT WALL
// PAINTING
#declare frameTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "pictureFrame.jpg" }
        scale 0.5
    }
};

#declare pictureTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "starryNight.jpg" }
        scale <0.35,0.7,1>
    }
};

// BOOKSHELVES
#declare bookshelfTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "dark_wood.jpg" }
        scale 0.4
    }
};

// WARDROBES
#declare wardrobeTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "walnut-wardrobe.jpg" }
        scale 0.6
    }
};

// LAMP 2
#declare lamp2Texture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "lava_lamp.jpg" }
        scale 0.6
    }
};

// MIRROR
#declare mirrorTexture = texture {
    pigment { rgb<0.1,0.1,0.1> }
    /*normal {
        dents 3.2
        scale 0.08
    }*/
    finish {
        specular 0.3
        roughness .001
        reflection { 0.9 }
        ambient rgb<1,1,1>*0.7
    }
};

// TREE POT
#declare potTexture = texture {
    Copper_Metal
    finish {
        reflection { 
            0.8
            metallic
        }
        ambient 0.7
        specular 0.5
        ambient rgb<1,1,1>*0.6
    }
};

// LEAVES
#declare leavesColor = pigment {
    gradient <1,0,0>
    color_map {
        [0 color rgb<0,0.5,0>]
        [0.4 color rgb<0,0.6,0>]
        [0.8 color rgb<0,0.8,0>]
        [1 color rgb<0,0.6,0>]
    }
    scale 1.3
    turbulence 0.2
};

#declare leavesSpot = pigment {
    agate
    agate_turb 0.2
    color_map {
        [0.2 color rgb<0.6,0.3,0>]
        [0.8 color rgb<0.8,0.4,0>]
    }
    scale 0.3
};

#declare leavesTexture = texture {
    pigment {
        gradient x
        pigment_map {
            [0.4 leavesColor]
            [0.45 leavesSpot]
            [0.6 leavesColor]
            [0.8 leavesColor]
            [0.83 leavesSpot]
            [1 leavesColor]
        }
    }
};               

// MIDDLE OF THE ROOM
// SOFAS
#declare couchTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "sofaTexture.jpg" }
    }
};

#declare couchCushionTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "cushionSofa.jpg" }
        scale 0.7
    }
}

// lrTABLE
#declare lrTableTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "lrTableWood.jpg" }
    }
};

#declare sideTablesTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "lrWood.jpg" }
    }
};

// Flower Vase
#declare flowerVaseTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "flowerVase.jpg" }
        scale 0.6
    }
};

// BEHIND WALL
// Resort Chair
#declare rChairTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "rattan.jpg" }
        scale 0.2
    }
};

#declare rChairArmsTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "rChairAmrs.jpg" }
        scale 0.6
    }
};

// POOL
#declare poolEdgeTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "crystalEdge.jpg" }
        scale 1.8
    }
};

#declare poolUpperEdgeTexture = texture {
    uv_mapping
    pigment {
        image_map { jpeg "blueGranite.jpg" }
        scale 0.9
    }
};

#declare waterTexture = texture {
    pigment { rgbf<0,0,.3,1> }
    finish {
        reflection { 
            .1, .8
            fresnel on
        }
        ambient 0
        specular 0.4
    }
    normal {
        bumps 0.3
        scale 1.2 
    }
}
    
// BACK WALL
// Pillar
#declare pillarTexture = texture {
    Chrome_Metal
    finish {
        reflection { 
            0.6
            metallic
        }
        ambient 0.3
        specular 0.5
        ambient rgb<1,1,1>*0.4
    }
};

#declare glassWallTexture = texture {
    uv_mapping
    pigment {
        rgb <0.1,0.1,0.2>
    }
    finish {
        specular 0.4
        roughness .001
        reflection { 1 }
        ambient rgb<1,1,1>*0.7
    }
}
    