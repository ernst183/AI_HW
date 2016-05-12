policy_iter implements the policy iteration algorithm in order to find an optimal policy for a 3x4 grid world. This algorithm works by calculating all Q function for each position repeatedly until there is no change within the policy function, meaning that all states are locally optimal. 

To run this code, load it into MatLab and compile/run it.

To create the T matrix for this problem, run the mk_grid_world with the arguments specified in the homework.

The R value is -.01

Setting the discount as 1 will give the exact same answers as specified in the homework.