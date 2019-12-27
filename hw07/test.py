def larger(lst, x):
    new_lst = list()
    for item in lst:
        if item > x:
            new_lst.append(item)
    return new_lst

def test(lst):
    """
    >>> test([4, 3, 5, 1, 2])
    [1, 2, 3, 4, 5]
    """
    if lst is None:
        return list()
    else:
        first = lst[0]
        rest = lst[1:]
        if rest is None:
            return first
        larger_values_rest = larger(rest, first)
