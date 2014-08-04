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

function determinePdgId(id, charge){
    if (id == 1)   { return "Down"; }
    if (id == -1)  { return "Antidown"; }
    if (id == 2)   { return "Up"; }
    if (id == -2)  { return "Antiup"; }
    if (id == 3)   { return "Strange"; }
    if (id == -3)  { return "Antistrange"; }
    if (id == 4)   { return "Charm"; }
    if (id == -4)  { return "Anticharm"; }
    if (id == 5)   { return "Bottom"; }
    if (id == -5)  { return "Antibottom"; }
    if (id == 6)   { return "Top"; }
    if (id == -6)  { return "Antitop"; }
    if (id == 11)  { return "Electron"; }
    if (id == -11) { return "Positron"; }
    if (id == 12)  { return "Neutrino"; }
    if (id == -12) { return "Neutrino"; }
    if (id == 13)  { return "Muon"; }
    if (id == -13) { return "Antimuon"; }
    if (id == 14)  { return "Neutrino"; }
    if (id == -14) { return "Neutrino"; }
    if (id == 15)  { return "Tau"; }
    if (id == -15) { return "Antitau"; }
    if (id == 16)  { return "Neutrino"; }
    if (id == -16) { return "Neutrino"; }
    if (id == 9)   { return "Gluon"; }
    if (id == -9)  { return "Gluon"; }
    if (id == 21)  { return "Gluon"; }
    if (id == -21) { return "Gluon"; }
    if (id == 22)  { return "Photon"; }
    if (id == -22) { return "Photon"; }
    if (id == 23)  { return "ZBoson"; }
    if (id == -23) { return "ZBoson"; }
    if (id == 24)  { return "WBoson"; }
    if (id == -24) { return "AntiWBoson"; }
    if (id == 25)  { return "Higgs"; }
    if (id == -25) { return "Higgs"; }
    if (charge == -1) { return "Negpion"; }
    if (charge ==  1) { return "Pluspion"; }
    if (charge ==  0) { return "Pion"; }
}

// PDG
//This is the Library to store the Properties of different particles
// leavesTrack      (interacts with trackers)
// leavesEnergy     (interacts with calorimeters)
var Particles = {
    index:          {cardinality: 6},
    Photon:         {mass: 0.0, charge:  0, lifetime:3000, size:0, color: "black", leavesTrack: false, leavesEMEnergy: 0.1, leavesHadEnergy: 1.},
    Electron:       {mass: 0.1, charge:  1, lifetime:3000, size:0, color: "blue" , leavesTrack: true, leavesEMEnergy: 0.2, leavesHadEnergy: 0.95},
    Positron:       {mass: 0.1, charge: -1, lifetime:3000, size:0, color: "blue" , leavesTrack: true, leavesEMEnergy: 0.2, leavesHadEnergy: 0.95},
    Proton:         {mass: 0.5, charge:  1, lifetime:3000, size:0, color: "red"  , leavesTrack: true, leavesEMEnergy: 0.95, leavesHadEnergy: 0.3},
    Antiproton:     {mass: 0.5, charge: -1, lifetime:3000, size:0, color: "red"  , leavesTrack: true, leavesEMEnergy: 0.95, leavesHadEnergy: 0.3},
    Pluspion:       {mass: 0.2, charge:  1, lifetime:3000, size:0, color: Qt.lighter("red"), leavesTrack: true, leavesEMEnergy: 0.95, leavesHadEnergy: 0.3},
    Negpion:        {mass: 0.2, charge: -1, lifetime:3000, size:0, color: Qt.lighter("red"), leavesTrack: true, leavesEMEnergy: 0.95, leavesHadEnergy: 0.3},
    Pion:           {mass: 0.2, charge:  0, lifetime:3000, size:0, color: Qt.lighter("grey"), leavesTrack: false, leavesEMEnergy: 1.0, leavesHadEnergy: 0.3},
    Neutron:        {mass: 0.5, charge:  0, lifetime:3000, size:0, color: "grey" , leavesTrack: false, leavesEMEnergy: 1.0, leavesHadEnergy: 0.3},
    Antineutron:    {mass: 0.5, charge:  0, lifetime:3000, size:0, color: "grey" , leavesTrack: false, leavesEMEnergy: 1.0, leavesHadEnergy: 0.3},
    Neutrino:       {mass: 0.0, charge:  0, lifetime:3000, size:0, color: "white", leavesTrack: false, leavesEMEnergy: 1.0, leavesHadEnergy: 1.0},
    Antineutrino:   {mass: 0.0, charge:  0, lifetime:3000, size:0, color: "white", leavesTrack: false, leavesEMEnergy: 1.0, leavesHadEnergy: 1.0},
    Muon:           {mass: 0.2, charge:  1, lifetime:3000, size:0, color: Qt.darker("blue"), leavesTrack: true, leavesEMEnergy: 0.99, leavesHadEnergy: 1.0},
    Antimuon:       {mass: 0.2, charge: -1, lifetime:3000, size:0, color: Qt.darker("blue"), leavesTrack: true, leavesEMEnergy: 0.99, leavesHadEnergy: 1.0},
    }
