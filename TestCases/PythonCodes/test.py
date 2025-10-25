

myString = "Hello, World!"
reversed_String = myString[::-1]
print(reversed_String)

myString = "Hello, World!"
reversed_String = ''.join(reversed(myString))   
print(reversed_String)  

# I want get numbers from string
import re
myString = "There are 2 apples and 5 bananas."
numbers = re.findall(r'\d+', myString)
print(numbers)  # Output: ['2', '5']

# I want to replace spaces with underscores in a string
myString = "Hello World, this is a test."
StringLength = len(myString)
print(StringLength)  # Output: 27
modified_String = myString.replace(" ", "_")
print(modified_String)  # Output: Hello_World,_this_is_a_test.

