import operator

from sympy.solvers.diophantine.diophantine import diop_DN


def min_x(x_y_tuples):
    return min(x_y_tuples, key=operator.itemgetter(0))


def solution_for(D):
    solutions = diop_DN(D, 1)
    return min_x(solutions)


solutions = [(solution_for(D), D) for D in range(2, 1001)]
print(max(solutions, key=operator.itemgetter(0)))
# ((16421658242965910275055840472270471049, 638728478116949861246791167518480580), 661)
