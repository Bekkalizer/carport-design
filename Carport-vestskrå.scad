//-------------------------------------------
//-------PARAMETRE---------------------------
//-------------------------------------------

stolpeDimensjonBredde = 10.16; //4tommer
stolpeDimensjonDybde = 15.24; //6tommer

dragerDimensjonBredde = 9.8; //4tommer
dragerDimensjonHoyde = 19.8; //6tommer

skraDragerDimensjonHoyde = 15.24; //4tommer
skraDragerDimensjonDybde = 9.8; //6tommer

stolpeskoAvstandKortside = 312; 
stolpeskoAvstandLangside = 331;

stolpeHoydeVest = 240;

takVinkel = 12;

//takutsprng målt rett ut fra veggen
takUtspringOst = 20;
takUtspringVest = 60;

//-------------------------------------------
//-------PROGRAM-----------------------------
//-------------------------------------------
stolpeHoydeForskjell = stolpeskoAvstandLangside * tan(takVinkel);
stolpeHoydeOst = stolpeHoydeVest - stolpeHoydeForskjell;

nordOstSenter = [stolpeskoAvstandLangside/-2,stolpeskoAvstandKortside/-2,0];

nordVestSenter = [stolpeskoAvstandLangside/2,stolpeskoAvstandKortside/-2,0];

sorOstSenter = [stolpeskoAvstandLangside/-2,stolpeskoAvstandKortside/2,0];

sorVestSenter = [stolpeskoAvstandLangside/2,stolpeskoAvstandKortside/2,0];

stolpeSenter = [stolpeDimensjonDybde*-0.5,stolpeDimensjonBredde*-0.5,0];

translate(stolpeSenter) {
    //Skrådrager hjelpekalkulasjoner
    lengdeJusteringStolpeDydbe = stolpeDimensjonDybde / cos(takVinkel);
    hoydeJusteringStolpe = stolpeDimensjonDybde * tan(takVinkel);
    hoydejusteringUtspringOst = takUtspringOst * tan(takVinkel);
    lengdeJusteringUtspringVest = takUtspringVest / cos(takVinkel);
    stolpeTilStolpe = sqrt( stolpeskoAvstandLangside ^ 2 + 
            stolpeHoydeForskjell ^ 2);
    skraDragerLengde = takUtspringOst +
            stolpeTilStolpe + 
            lengdeJusteringStolpeDydbe +
            lengdeJusteringUtspringVest;
    
    translate([takUtspringOst * -1, 0, stolpeHoydeOst-hoydeJusteringStolpe-hoydejusteringUtspringOst]) {

        //Nordre 
        translate(nordOstSenter) {
            rotate(a = takVinkel, v = [0 ,-1 ,0 ]) {
                cube([skraDragerLengde,
                    skraDragerDimensjonDybde,
                    skraDragerDimensjonHoyde]);
            }
        }
        
        //Søndre
        translate(sorOstSenter) {
            rotate(a = takVinkel, v = [0 ,-1 ,0 ]) {
                cube([skraDragerLengde,
                    skraDragerDimensjonDybde,
                    skraDragerDimensjonHoyde]);
            }
        }
    }

    translate(nordOstSenter) {
        stolpe(stolpeHoydeOst);
    }

    translate(nordVestSenter) {
        stolpe(stolpeHoydeVest);
    }

    translate(sorOstSenter) {
        stolpe(stolpeHoydeOst);
    }

    translate(sorVestSenter) {
        stolpe(stolpeHoydeVest);
    }
    
}



//-------------------------------------------
//-------MODULER-----------------------------
//-------------------------------------------

module stolpe(hoyde) {
    cube([stolpeDimensjonDybde,stolpeDimensjonBredde,hoyde]);
}