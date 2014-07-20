.pragma library

function betaFromEMass(energy, mass) {
    return Math.sqrt(1 - (Math.pow(mass, 2)/Math.pow(energy, 2)));
}
