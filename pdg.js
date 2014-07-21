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

function determinePdgId(id){
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
}

// PDG
//This is the Library to store the Properties of different particles
// leavesTrack      (interacts with trackers)
// leavesEnergy     (interacts with calorimeters)
var Particles = {
    index:          {cardinality: 6},
    Photon:         {mass: 0.0, charge:  0, lifetime:2000, size:10, color: "black", leavesTrack: false, leavesEMEnergy: true, leavesHadEnergy: false},
    Electron:       {mass: 0.5, charge:  1, lifetime:2000, size:10, color: "blue" , leavesTrack: true, leavesEMEnergy: true, leavesHadEnergy: true},
    Positron:       {mass: 0.5, charge: -1, lifetime:2000, size:10, color: "blue" , leavesTrack: true, leavesEMEnergy: true, leavesHadEnergy: true},
    Proton:         {mass: 0.5, charge:  1, lifetime:2000, size:10, color: "red"  , leavesTrack: true, leavesEMEnergy: true, leavesHadEnergy: true},
    Antiproton:     {mass: 0.5, charge: -1, lifetime:2000, size:10, color: "red"  , leavesTrack: true, leavesEMEnergy: true, leavesHadEnergy: true},
    Neutron:        {mass: 0.5, charge:  0, lifetime:2000, size:10, color: "grey" , leavesTrack: false, leavesEMEnergy: false, leavesHadEnergy: true},
    Antineutron:    {mass: 0.5, charge:  0, lifetime:2000, size:10, color: "grey" , leavesTrack: false, leavesEMEnergy: false, leavesHadEnergy: true},
    Neutrino:       {mass: 0.5, charge:  0, lifetime:2000, size:10, color: "white", leavesTrack: false, leavesEMEnergy: false, leavesHadEnergy: false},
    Antineutrino:   {mass: 0.5, charge:  0, lifetime:2000, size:10, color: "white", leavesTrack: false, leavesEMEnergy: false, leavesHadEnergy: false},
    Muon:           {mass: 0.5, charge:  1, lifetime:2000, size:10, color: Qt.darker("blue"), leavesTrack: true, leavesEMEnergy: false, leavesHadEnergy: false},
    Antimuon:       {mass: 0.5, charge: -1, lifetime:2000, size:10, color: Qt.darker("blue"), leavesTrack: true, leavesEMEnergy: false, leavesHadEnergy: false}
    }
