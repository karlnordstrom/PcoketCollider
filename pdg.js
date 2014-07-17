.pragma library

// PDG
//This is the Library to store the Properties of different particles
// leavesTrack      (interacts with trackers)
// leavesEnergy     (interacts with calorimeters)
var Particles = {
    index:          {cardinality: 5},
	Photon:         {mass: 0.1, charge:  0, lifetime:10000, size:10, color: "black", leavesTrack: false, leavesEnergy: true},
	Electron:       {mass:   1, charge:  1, lifetime:10000, size:10, color: "blue" , leavesTrack: true, leavesEnergy: true},
	Positron:       {mass:   1, charge: -1, lifetime:10000, size:10, color: "blue" , leavesTrack: true, leavesEnergy: true},
	Proton:         {mass:   2, charge:  1, lifetime:10000, size:10, color: "red"  , leavesTrack: true, leavesEnergy: true},
	Antiproton:     {mass:   2, charge: -1, lifetime:10000, size:10, color: "red"  , leavesTrack: true, leavesEnergy: true},
	Neutron:        {mass:   2, charge:  0, lifetime:10000, size:10, color: "grey" , leavesTrack: false, leavesEnergy: true},
	Antineutron:    {mass:   2, charge:  0, lifetime:10000, size:10, color: "grey" , leavesTrack: false, leavesEnergy: true},
	Neutrino:       {mass: 0.1, charge:  0, lifetime:10000, size:10, color: "white", leavesTrack: false, leavesEnergy: false},
	Antineutrino:   {mass: 0.1, charge:  0, lifetime:10000, size:10, color: "white", leavesTrack: false, leavesEnergy: false}
    }
