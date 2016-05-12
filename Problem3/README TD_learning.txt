TD_learning uses a temporal difference agent and reinforced learning to attempt to learn the optimal policy for a 3x4 grid world. The agent wanders around the world tyring to find paths that lead to a desirable outcome and give those paths weights appropriately. Finally, it computes the policy using those values 

To run the program, give arguments T (from the mk_grid_world function), R = -.01, and your discount. You can run find_policy on the outputted value function to see the policy that the value matrix computes to.

You can change the alpha value in line 3, marked by a comment