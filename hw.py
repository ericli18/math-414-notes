import random

def pick_random_problem(switches):
    # Data extracted from the uploaded document

    # homework_data = {
    #     1: ["8", "15", "19", "21", "23", "26"],          # Source: Homework 1
    #     2: ["1", "3", "4", "7", "11", "16"],             # Source: Homework 2
    #     3: ["15", "18", "19", "27", "28"],               # Source: Homework 3
    #     4: ["1", "5", "6"],                              # Source: Homework 4
    #     5: ["8", "10", "13", "14"],                      # Source: Homework 5
    #     6: ["2 (pg 151)", "6.24 (a,b,c)"],               # Source: Homework 6
    #     7: ["3", "5", "6", "8", "9"],                    # Source: Homework 7
    #     8: ["10", "11", "13", "14", "17", "18"],         # Source: Homework 8
    #     9: ["2", "3", "4"]                               # Source: Homework 9
    # }
    #
    homework_data = {
        1: ["8", "15", "19", "21", "26"],          # Source: Homework 1
        2: ["1", "3", "4", "7", "11", "16"],             # Source: Homework 2
        3: ["15", "19", "27", "28"],               # Source: Homework 3
        4: ["1", "5", "6"],                              # Source: Homework 4
        5: ["8", "10", "13", "14"],                      # Source: Homework 5
        6: ["2 (pg 151)", "6.24 (a,b,c)"],               # Source: Homework 6
        7: ["3", "5", "6", "8", "9"],                    # Source: Homework 7
        8: ["10", "11", "13", "14", "17", "18"],         # Source: Homework 8
        9: ["2", "3", "4"]                               # Source: Homework 9
    }

    # Create a pool of problems based on the switches that are set to True
    pool = []
    
    for hw_num, is_active in switches.items():
        if is_active and hw_num in homework_data:
            # Add all problems from this homework to the pool
            # We store them as a tuple: (Homework Number, Problem Number)
            for problem in homework_data[hw_num]:
                pool.append((hw_num, problem))

    if not pool:
        return "No homeworks selected. Please set at least one switch to True."

    # Select a random entry from the pool
    selected_hw, selected_problem = random.choice(pool)

    return f"You should do: Homework {selected_hw}, Problem {selected_problem}"

# --- User Settings ---
# Set these to True to include the homework, or False to skip it
active_homeworks = {
    1: True,
    2: True,
    3: True,
    4: True,
    5: False, # Currently off
    6: False, # Currently off
    7: False, # Currently off
    8: False, # Currently off
    9: False  # Currently off
}

# Run the script
print("Choosing a random problem for you...")
print("-" * 30)
print("https://pi.math.cornell.edu/~luke/Homework424.pdf")
print("https://pi.math.cornell.edu/~luke/math424.html")
print(pick_random_problem(active_homeworks))
