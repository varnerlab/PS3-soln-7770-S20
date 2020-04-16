## PS3 Solution CHEME 5440/7770
In this problem we ask to you to compile a list of chemical reactions for a model of the [Urea cycle in human]((https://www.genome.jp/kegg-bin/show_pathway?hsa00220)).  
This solution is slightly different from the [PS3 solution posted last year](https://github.com/varnerlab/CHEME-7770-Cornell-S19) because in this problem we ask you to
update the flux bounds array, and include a dilution due to growth term, using the metabolite measurements and saturation constants from [Park et al](https://pubmed.ncbi.nlm.nih.gov/27159581/) or [BRENDA](https://www.brenda-enzymes.org).

### How do I do the QA/QC balance check?
To check if the chemical reactions (contained in the ``Reactions.dat`` file) are balanced, issue the command:

  ```jl
    julia > include("CheckBalances.jl")
  ```
This will formulate the Atom matrix ``A``, and then compute the product of ``transpose(A)*S`` where ``S`` denotes the stoichiometric matrix (contained in the file ``Network.net``). Two arrays are produced: 1) ``epsilon_1`` describes the case when we do not consider the boundary species (we have to nothing/from nothing reactions). These reactions will appear unbalanced with all internal reactions balanced (first few cols); ii) however, ``epsilon_2`` describes the case when you do include the boundary species, all reactions are balanced (all cols aer zero).

### How do I estimate the fluxes?
To estimate the Urea flux, issue the command:

  ```jl
    julia > include("Solve.jl")
  ```
The ``Solve`` script formulates the constraints into a [Julia Dictionary](https://docs.julialang.org/en/v1/base/collections/#Dictionaries-1) which is passed to the solver code contained in the ``Flux.jl`` file.
The solver returns a bunch of stuff; the ``objective_value`` and ``flux_array`` arguments contain the Urea flux and
the optimal flux distribution, respectively. The optimal flux that I calculated was approximately: 1.24 mmol/gDW-hr.
This solution considers both the dilution effects, and updated bounds. 

### Requirements
The ``Solve.jl`` solution script requires the ``GLPK`` package to solve the FBA problem. See [GLPK](https://github.com/JuliaOpt/GLPK.jl) for details.
We also require the ``DelimitedFiles.jl`` package to load system arrays. 
