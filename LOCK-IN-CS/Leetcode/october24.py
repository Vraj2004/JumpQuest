# 1431 - Kids with Greatest Candies

def kidsWithMostCandies(candies, extraCandies):
    maxCandies = max(candies)
    result = []

    for i in range(len(candies)):
        if candies[i] + extraCandies >= maxCandies:
            result.append(True)
        else:
            result.append(False)
    return result

#print(kidsWithMostCandies([2,3,5,1,3], 3))
#print(kidsWithMostCandies([4,2,1,1,2], 1))
#print(kidsWithMostCandies([12,1,12], 10))

# 1071 - Can Place Flowers

def can_place_flowers(flowerbed, n):
    count = 0
    new_arr = [0] + flowerbed + [0]

    for i in range(1, len(new_arr) - 1):
        if new_arr[i] == 0 and new_arr[i + 1] == 0 and new_arr[i - 1] == 0:
            count += 1 
            new_arr[i] == 1
    
    if count >= n:
        return True
    return False

#print(can_place_flowers([1,0,0,0,1], 1))
#print(can_place_flowers([1,0,0,0,1], 2))

# 283 - Move Zeroes