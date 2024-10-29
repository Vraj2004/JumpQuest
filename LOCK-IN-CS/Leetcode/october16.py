# Find the closest number to zero, 2239
def closestToZero(nums):
    closest = nums[0]

    for i in range(len(nums)):
        if abs(nums[i]) < abs(closest):
            closest = nums[i]
        
        elif abs(nums[i]) == closest:
            if nums[i] > closest:
                closest = nums[i]
    return closest

# Merge Strings Alternately, 1768
def mergeStrings(word1, word2):

    index = 0
    result = ''

    while index < max(len(word1), len(word2)):
        if index < len(word1):
            result += word1[index]
        elif index < len(word2):
            result += word2[index]
        index += 1
    return result

# Roman to Integer, 13
def romanToInteger(s):
    pass