# Is Subsequence - 392

def isSubsequence(s, t):
    
    i = 0
    j = 0

    while i < len(s) and j < len(t):
        if s[i] == t[j]:
            i += 1 
        j += 1 
    return len(s) == i

# Best time to buy and sell a stock - 121

def bestTime(prices):
    
    l = 0
    r = 0
    total = 0

    while r < len(prices):
        if prices[r] - prices[l] > profit:
            profit = prices[r] - prices[l]
        else:
            if prices[r] - prices[l] > 0:
                r += 1
            else:
                l += 1 
    return total