include("Include.jl")

# 1: Build the data dictionary -
data_dictionary = maximize_urea_production(0,0,0)

# we need t0 remove the last col from the stm related to dilution due to growth -
STMP = data_dictionary["stoichiometric_matrix"]
S = STMP[:,1:end-1]

# 2: Build the atom matrix -
 A = generate_atom_matrix("./Atom.txt",data_dictionary)

 # 3: Check the balances -
epsilon_1 = transpose(A)*S

 # 4: NOTE: The first six columns are all zeros! (happy dance) ... but wait, what about the rest?
 aug_data_dictionary = check_unbalanced_boundary_reactions(0,0,0)
 A_aug = generate_atom_matrix("./Atom.txt",aug_data_dictionary)
 S_aug = aug_data_dictionary["stoichiometric_matrix"]
 epsilon_2 = transpose(A_aug)*S_aug
