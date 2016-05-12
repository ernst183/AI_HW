value_iter implements the value iteration algorithm in order to find an optimal value function for a 3x4 grid world. This algorithm works by propogating the rewards throughout the grid world until the change between the old value function and the new value function is smaller than a certain threshold for all states, showing that the function has sufficiently converged to an optimal value function (which can be used to compute the optimal policy)

To run this code, load it into MatLab and compile/run it.

To create the T matrix for this problem, run the mk_grid_world with the arguments specified in the homework.

The R value is -.01

Setting the discount as 1 will give the exact same answers as specified in the homework.
