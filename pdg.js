.pragma library

// PDG
//This is the Library to store the Properties of different particles
var Particles = {
    index:          {cardinality: 5},
    Photon:         {mass: 0.1, charge:  0, lifetime:10000, color: "black", leavesTrack: false},
    Electron:       {mass:   1, charge:  1, lifetime:10000, color: "blue" , leavesTrack: true},
    Positron:       {mass:   1, charge: -1, lifetime:10000, color: "blue" , leavesTrack: true},
    Proton:         {mass:  10, charge:  1, lifetime:10000, color: "red"  , leavesTrack: true},
    Antiproton:     {mass:  10, charge: -1, lifetime:10000, color: "red"  , leavesTrack: true},
    Neutron:        {mass:  10, charge:  0, lifetime:10000, color: "grey" , leavesTrack: false},
    Antineutron:    {mass:  10, charge:  0, lifetime:10000, color: "grey" , leavesTrack: false},
    Neutrino:       {mass: 0.1, charge:  0, lifetime:10000, color: "white", leavesTrack: false},
    Antineutrino:   {mass: 0.1, charge:  0, lifetime:10000, color: "white", leavesTrack: false}
    }
