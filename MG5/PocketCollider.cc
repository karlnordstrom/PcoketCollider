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

      _histos["MULTIPLICITY"]   = bookHisto1D("particle_multiplicity", 51, -0.5, 50.5, "Particle multiplicity ($> 0.5$ GeV)", "$N^{\mathrm{part}}$", "Relative Occurence");

    }


    void analyze(const Event& event) {

      const double weight = event.weight();
      const Particles& particles = applyProjection<FinalState>(event, "FS").particles();
      _histos["MULTIPLICITY"]->fill(particles.size(), weight);

    }

    void finalize() {
      /// @todo Normalise!
      outFile.close();
    }

    //@}

  private:

    std::map<std::string, Histo1DPtr> _histos;
    std::ofstream outFile;


  };

  // The hook for the plugin system
  DECLARE_RIVET_PLUGIN(PocketCollider);

}
