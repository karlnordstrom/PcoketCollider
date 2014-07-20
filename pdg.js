.pragma library

function determineParticle(id){
    var size = Particles["index"].cardinality
    if (id % size == 0)  { return "Photon"; }
    if (id % size == 1)  { return "Electron"; }
    if (id % size == -1) { return "Positron"; }
    if (id % size == 2)  { return "Proton"; }
    if (id % size == -2) { return "Antiproton"; }
    if (id % size == 3)  { return "Neutron"; }
    if (id % size == -3) { return "Antineutron"; }
    if (id % size == 4)  { return "Neutrino"; }
    if (id % size == -4) { return "Antineutrino"; }
    if (id % size == 5)  { return "Muon"; }
    if (id % size == -5) { return "Antimuon"; }
}

// PDG
//This is the Library to store the Properties of different particles
// leavesTrack      (interacts with trackers)
// leavesEnergy     (interacts with calorimeters)
var Particles = {
    index:          {cardinality: 6},
    Photon:         {mass: 0.5, charge:  0, lifetime:2000, size:10, color: "black", leavesTrack: false, leavesEnergy: true},
    Electron:       {mass:   1, charge:  1, lifetime:2000, size:10, color: "blue" , leavesTrack: true, leavesEnergy: true},
    Positron:       {mass:   1, charge: -1, lifetime:2000, size:10, color: "blue" , leavesTrack: true, leavesEnergy: true},
    Proton:         {mass:   2, charge:  1, lifetime:2000, size:10, color: "red"  , leavesTrack: true, leavesEnergy: true},
    Antiproton:     {mass:   2, charge: -1, lifetime:2000, size:10, color: "red"  , leavesTrack: true, leavesEnergy: true},
    Neutron:        {mass:   2, charge:  0, lifetime:2000, size:10, color: "grey" , leavesTrack: false, leavesEnergy: true},
    Antineutron:    {mass:   2, charge:  0, lifetime:2000, size:10, color: "grey" , leavesTrack: false, leavesEnergy: true},
    Neutrino:       {mass: 0.5, charge:  0, lifetime:2000, size:10, color: "white", leavesTrack: false, leavesEnergy: false},
    Antineutrino:   {mass: 0.5, charge:  0, lifetime:2000, size:10, color: "white", leavesTrack: false, leavesEnergy: false},
    Muon:           {mass: 1, charge:  1, lifetime:2000, size:10, color: Qt.darker("blue"), leavesTrack: true, leavesEnergy: false},
    Antimuon:       {mass: 1, charge: -1, lifetime:2000, size:10, color: Qt.darker("blue"), leavesTrack: true, leavesEnergy: false}
    }
