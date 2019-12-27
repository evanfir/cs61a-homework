HW_SOURCE_FILE = 'hw03.py'

#############
# Questions #
#############

def num_sevens(n):
    """Returns the number of times 7 appears as a digit of n.

    >>> num_sevens(3)
    0
    >>> num_sevens(7)
    1
    >>> num_sevens(7777777)
    7
    >>> num_sevens(2637)
    1
    >>> num_sevens(76370)
    2
    >>> num_sevens(12345)
    0
    >>> from construct_check import check
    >>> # ban all assignment statements
    >>> check(HW_SOURCE_FILE, 'num_sevens',
    ...       ['Assign', 'AugAssign'])
    True
    """
    if n < 7:
        return 0
    if n % 10 == 7:
        return 1 + num_sevens(n//10)
    else:
        return num_sevens(n//10)

def pingpong(n):
    """Return the nth element of the ping-pong sequence.

    >>> pingpong(7)
    7
    >>> pingpong(8)
    6
    >>> pingpong(15)
    1
    >>> pingpong(21)
    -1
    >>> pingpong(22)
    0
    >>> pingpong(30)
    6
    >>> pingpong(68)
    2
    >>> pingpong(69)
    1
    >>> pingpong(70)
    0
    >>> pingpong(71)
    1
    >>> pingpong(72)
    0
    >>> pingpong(100)
    2
    >>> from construct_check import check
    >>> # ban assignment statements
    >>> check(HW_SOURCE_FILE, 'pingpong', ['Assign', 'AugAssign'])
    True
    """
    "*** YOUR CODE HERE ***"
    

    return pingpong_helper(n, 1, 1, True, 1)
def pingpong_helper(n, iteration, ping_pong_num, increament, sign):
    # if increament:
    #     ping_pong_num += 1
    # else:
    #     ping_pong_num -= 1
    if n == iteration:
        return ping_pong_num
    if iteration % 7 == 0 or num_sevens(iteration) > 0:
        return pingpong_helper(n, iteration + 1, ping_pong_num + sign * -1, not increament, sign * -1)
    else:    
        return pingpong_helper(n, iteration + 1, ping_pong_num + sign, increament, sign)

    
# def ping_pong_seq(n):
#     m = 1
#     ping_pong_num = 0
#     increment = True
#     while m <= n:
#         if increment:
#             ping_pong_num += 1
#         else:
#             ping_pong_num -= 1
#         if m % 7 == 0 or num_sevens(m) > 0:
#             # print("in m % 7")
#             increment = not increment
#         # elif num_sevens(m) > 0:
#         #     # print("in num_sevens")
#         #     increment = not increment
        
#         # print("final: ", ping_pong_num)
#         m += 1
#     return ping_pong_num

import math as math
def count_change(amount):
    """Return the number of ways to make change for amount.

    >>> count_change(7)
    6
    >>> count_change(10)
    14
    >>> count_change(20)
    60
    >>> count_change(100)
    9828
    >>> from construct_check import check
    >>> # ban iteration
    >>> check(HW_SOURCE_FILE, 'count_change', ['While', 'For'])
    True
    """
    biggest_coin = pow(2, math.sqrt(amount)//1)
    # biggest_coin = 1
    # i = 0
    # while biggest_coin <= amount:
    #     biggest_coin = pow(2, i)
    #     i += 1
        
    def my_change(amount, biggest_coin, num_of_ways = 0):
        if biggest_coin < 1:
            return 0
        if amount == 0:
            return 1
        elif amount < 0:
            return 0
        else:
            value_a = my_change(amount - biggest_coin, biggest_coin, num_of_ways)
            # if biggest_coin > 2:
            value_b = my_change(amount, biggest_coin/2, num_of_ways)
            num_of_ways += value_a + value_b

            return num_of_ways
    return my_change(amount, biggest_coin)


def flatten(lst):
    """Returns a flattened version of lst.

    >>> flatten([1, 2, 3])     # normal list
    [1, 2, 3]
    >>> x = [1, [2, 3], 4]      # deep list
    >>> flatten(x)
    [1, 2, 3, 4]
    >>> x # Ensure x is not mutated
    [1, [2, 3], 4]
    >>> x = [[1, [1, 1]], 1, [1, 1]] # deep list
    >>> flatten(x)
    [1, 1, 1, 1, 1, 1]
    >>> x
    [[1, [1, 1]], 1, [1, 1]]
    """
    "*** YOUR CODE HERE ***"
    flatten_list = list()
    for item in lst:
        if type(item) == list: 
            flatten_list += flatten(item)
        else:
            flatten_list += [item]
    return flatten_list

###################
# Extra Questions #
###################

def print_move(origin, destination):
    """Print instructions to move a disk."""
    print("Move the top disk from rod", origin, "to rod", destination)

def move_stack(n, start, end):
    """Print the moves required to move n disks on the start pole to the end
    pole without violating the rules of Towers of Hanoi.

    n -- number of disks
    start -- a pole position, either 1, 2, or 3
    end -- a pole position, either 1, 2, or 3

    There are exactly three poles, and start and end must be different. Assume
    that the start pole has at least n disks of increasing size, and the end
    pole is either empty or has a top disk larger than the top n start disks.

    >>> move_stack(1, 1, 3)
    Move the top disk from rod 1 to rod 3
    >>> move_stack(2, 1, 3)
    Move the top disk from rod 1 to rod 2
    Move the top disk from rod 1 to rod 3
    Move the top disk from rod 2 to rod 3
    >>> move_stack(3, 1, 3)
    Move the top disk from rod 1 to rod 3
    Move the top disk from rod 1 to rod 2
    Move the top disk from rod 3 to rod 2
    Move the top disk from rod 1 to rod 3
    Move the top disk from rod 2 to rod 1
    Move the top disk from rod 2 to rod 3
    Move the top disk from rod 1 to rod 3
    """
    assert 1 <= start <= 3 and 1 <= end <= 3 and start != end, "Bad start/end"
    "*** YOUR CODE HERE ***"

from operator import sub, mul

def make_anonymous_factorial():
    """Return the value of an expression that computes factorial.

    >>> make_anonymous_factorial()(5)
    120
    >>> from construct_check import check
    >>> # ban any assignments or recursion
    >>> check(HW_SOURCE_FILE, 'make_anonymous_factorial', ['Assign', 'AugAssign', 'FunctionDef', 'Recursion'])
    True
    """
    return 'YOUR_EXPRESSION_HERE'
