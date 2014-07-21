.pragma library

var c = 10

function betaFromEMass(energy, mass) {
    return Math.sqrt(1 - (Math.pow(mass, 2)/Math.pow(energy, 2)))
}

function energyFromVMass(velocity, mass){
    return Math.sqrt(1/(1 - (Math.pow(velocity, 2)/Math.pow(c, 2)))) * mass
}

function vectorMag(x, y){
    return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2))
}

function distanceOf(x1,y1,x2,y2){
    return vectorMag(x2-x1, y2-y1)
}
