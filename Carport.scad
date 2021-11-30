//-------------------------------------------
//-------PARAMETRE---------------------------
//-------------------------------------------

stolpeDimensjonBredde = 10.16; //4tommer
stolpeDimensjonDybde = 15.24; //6tommer

dragerDimensjonBredde = 10.16; //4tommer
dragerDimensjonHoyde = 15.24; //6tommer

skraDragerDimensjonHoyde = 15.24; //4tommer
skraDragerDimensjonDybde = 10.16; //6tommer

stolpeskoAvstandKortside = 312; 
stolpeskoAvstandLangside = 331;

stolpeHoydeNord = 220;
takVinkel = 15; //Grader

sperreDimensjonDybde = 5;
sperreDimensjonHoyde = 15;
sperreAntall = 10;
moneLengde = 530;
takutspringOst = 60;

takutspringNordSor = 40;

skraDragerJustering = -50; //Justerer skrådrager ned fra tak
skraDragerMotstaendeLengde = 100;

skraDragerOstVestLengde = 170;

//-------------------------------------------
//-------PROGRAM-----------------------------
//-------------------------------------------

stolpeHoydeForskjell = tan(takVinkel)*stolpeskoAvstandKortside;
echo(stolpeHoydeForskjell);
stolpeHoydeSor = stolpeHoydeNord + stolpeHoydeForskjell;

skraAvstand = sqrt(stolpeskoAvstandKortside ^ 2 + stolpeHoydeForskjell ^2);

sperreAvstand = (moneLengde-sperreDimensjonDybde)/sperreAntall;
echo(sperreAvstand);


nordOstSenter = [stolpeskoAvstandLangside/-2,stolpeskoAvstandKortside/-2,0];

nordVestSenter = [stolpeskoAvstandLangside/2,stolpeskoAvstandKortside/-2,0];

sorOstSenter = [stolpeskoAvstandLangside/-2,stolpeskoAvstandKortside/2,0];

sorVestSenter = [stolpeskoAvstandLangside/2,stolpeskoAvstandKortside/2,0];

stolpeSenter = [stolpeDimensjonDybde*-0.5,stolpeDimensjonBredde*-0.5,0];

translate(stolpeSenter) {
    translate([takutspringOst * -1, 0, stolpeHoydeNord]) {
        translate(nordOstSenter) {
            drager();
        }
    }

    translate([takutspringOst * -1, 0, stolpeHoydeSor]) {
        translate(sorOstSenter) {
            drager();
        }
    }

    translate(nordOstSenter) {
        stolpe(stolpeHoydeNord);
    }

    translate(nordVestSenter) {
        stolpe(stolpeHoydeNord);
    }

    translate(sorOstSenter) {
        stolpe(stolpeHoydeSor);
    }

    translate(sorVestSenter) {
        stolpe(stolpeHoydeSor);
    }
    
    forskyvningSkraDrager = (stolpeDimensjonDybde - skraDragerDimensjonDybde)/2;
    
    skraDrager(stolpeskoAvstandLangside/-2 +forskyvningSkraDrager );
    skraDragerMotstaende(stolpeskoAvstandLangside/-2 +forskyvningSkraDrager);
    
    skraDrager(stolpeskoAvstandLangside/2 + forskyvningSkraDrager);
    skraDragerMotstaende(stolpeskoAvstandLangside/2 + forskyvningSkraDrager);
    
    skraDragerSorVest();
    skraDragerSorVestMotstaende();    
    //skraDragerNordVest();
    //skraDragerNordVestMotstaende();
}

for(i = [0:1:sperreAntall]) {
    sperreNy(i);
}


//-------------------------------------------
//-------MODULES-----------------------------
//-------------------------------------------

module stolpe(hoyde) {
    cube([stolpeDimensjonDybde,stolpeDimensjonBredde,hoyde]);
}

module drager() {
    cube([moneLengde,dragerDimensjonBredde,dragerDimensjonHoyde]);
}

module skraDrager(ostVestPosisjon) {
    translate([ostVestPosisjon,stolpeskoAvstandKortside/-2 + stolpeDimensjonBredde,stolpeHoydeNord + skraDragerJustering]) {
        rotate(a= takVinkel, v = [1 ,0 ,0 ]) {
            cube([skraDragerDimensjonDybde,skraAvstand,skraDragerDimensjonHoyde]);
        }
    }
}

module skraDragerSorVest() {
    translate ([0,stolpeskoAvstandKortside/2,stolpeHoydeSor]) {
        skraDragerVest();
    }
}

module skraDragerNordVest() {
    translate ([0,stolpeskoAvstandKortside/-2,stolpeHoydeNord]) {
        skraDragerVest();
    }
}

module skraDragerVest() {
    skraDragerOstVestAvstand = skraDragerOstVestLengde * cos(takVinkel);
    
    translate([stolpeskoAvstandLangside/2 - skraDragerOstVestAvstand,0,0]) {
        rotate(a= takVinkel, v = [0 ,1 ,0 ]) {
            cube([skraDragerOstVestLengde,skraDragerDimensjonDybde,skraDragerDimensjonHoyde]);
        }
    }
}

module skraDragerSorVestMotstaende() {
    skraDragerOstVestHoyde = skraDragerOstVestLengde * sin(takVinkel);
    
    translate ([0,stolpeskoAvstandKortside/2,stolpeHoydeSor - skraDragerOstVestHoyde]) {
        skraDragerVestMotstaende();
    }
}

module skraDragerNordVestMotstaende() {
    skraDragerOstVestHoyde = skraDragerOstVestLengde * sin(takVinkel);
    
    translate ([0,stolpeskoAvstandKortside/-2,stolpeHoydeNord-skraDragerOstVestHoyde]) {
        skraDragerVestMotstaende();
    }
}

module skraDragerVestMotstaende() {
    translate([stolpeskoAvstandLangside/2+stolpeDimensjonDybde,0,0]) {
        rotate(a = takVinkel * -1, v = [0 ,1 ,0 ]) {
            cube([skraDragerOstVestLengde,skraDragerDimensjonDybde,skraDragerDimensjonHoyde]);
        }
    }
}

module skraDragerMotstaende(ostVestPosisjon) {
    skraDragerMotstaendeAvstand = skraDragerMotstaendeLengde * cos(takVinkel);
    skraDragerMotstaendeHoyde = skraDragerMotstaendeLengde * sin(takVinkel);
    
    translate([ostVestPosisjon,stolpeskoAvstandKortside/2 - skraDragerMotstaendeAvstand,stolpeHoydeNord + skraDragerJustering + stolpeHoydeForskjell - skraDragerMotstaendeHoyde]) {
        rotate(a= takVinkel * -1, v = [1 ,0 ,0 ]) {
            cube([skraDragerDimensjonDybde,skraDragerMotstaendeLengde,skraDragerDimensjonHoyde]);
        }
    }
}


module sperreNy(sperreNummer) {
    ostreSperre = stolpeskoAvstandLangside / -2 - takutspringOst -sperreDimensjonDybde;
    sperrePlasseringOstVest = ostreSperre + sperreAvstand * sperreNummer;
        translate([sperrePlasseringOstVest,0,dragerDimensjonHoyde + stolpeHoydeNord + stolpeHoydeForskjell / 2]){
        rotate ( a= takVinkel, v = [1 ,0 ,0 ]) {            
            cube([sperreDimensjonDybde,skraAvstand + takutspringNordSor * 2, sperreDimensjonHoyde],true);
        }
    }
}