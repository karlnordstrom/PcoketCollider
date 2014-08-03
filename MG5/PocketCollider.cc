// -*- C++ -*-
#include "Rivet/Analysis.hh"
#include "Rivet/Projections/FinalState.hh"
#include <fstream>

namespace Rivet {


  /// @brief ATLAS monojet analysis. No data at the moment.
  class PocketCollider : public Analysis {
  public:

    /// Default constructor
    PocketCollider() : Analysis("PocketCollider")
    {    }

    /// @name Analysis methods
    //@{

    void init() {
      FinalState fs(-4.5, 4.5, 0.5*GeV);
      addProjection(fs, "FS");

      outFile.open("Events.js");
      outFile << ".pragma library" << endl;
      outFile << "var Events = {" << endl;
      outFile << "    numberOfEvents: {numEv: 10}," << endl;
      //_histos["MULTIPLICITY"]   = bookHisto1D("particle_multiplicity", 51, -0.5, 50.5, "Particle multiplicity ($> 0.5$ GeV)", "$N^{\\mathrm{part}}$", "Relative Occurence");

    }

    int eventIndex = 0;

    void analyze(const Event& event) {

      if (eventIndex > 9) vetoEvent;

      outFile << "    Event" << eventIndex << ": {" << endl;

      const double weight = event.weight();
      const Particles& particles = applyProjection<FinalState>(event, "FS").particles();

      outFile << "      numberOfParticles: {numPart:" << particles.size() << "}," << endl;

      for(unsigned int index = 0; index < particles.size(); index++){
       Particle part = particles[index];
        outFile << "      particle" << index << ": {azimuthalAngle:" << part.momentum().phi() <<", pdgId:" << part.pdgId() << ", energy:" << part.momentum().Et() << ", charge:" << part.charge() << "}," << endl;
      }

    outFile << "    }," << endl;

    eventIndex++;

    }

    void finalize() {
      /// @todo Normalise!
      outFile << "    }" << endl;
      outFile.close();
    }

    //@}

  private:

//    std::map<std::string, Histo1DPtr> _histos;
    std::ofstream outFile;


  };

  // The hook for the plugin system
  DECLARE_RIVET_PLUGIN(PocketCollider);

}
