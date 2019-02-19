import sys, os
sys.path.append(os.path.dirname(__file__))
from state import State
"""
def get_file_name(state, year) :
    returns the filename that contains election results corresponding to a given year and state
    
    global_data_path = "C:\\Users\\madhu\\Documents\\git\\TEP\\data\\"
    state_year_data_path = global_data_path + str(year) + "\\" + state + "\\"
    if state == "AK" and year >= 2014 :
        return state_year_data_path + "results.txt"
    elif state == "AK" and year < 2014 :
        return state_year_data_path + "results.html"
    else :
        raise ValueError("State " + state + " is not yet supported")

def get_total_registered_voters(state, year) :
     returns total registered voters corresponding to a given year and state. 
    Must have held either a federal or a state-wide race
    
    file = get_file_name(state, year)
    total_registered_voters = 0
    
    if file.endswith(".txt") :
        raw_data = pd.read_csv(file, header = None, encoding = "latin1")
        total_registered_voters = raw_data.loc[raw_data[0].apply(lambda x: x.strip()) == "US REPRESENTATIVE", 4].iloc[2]
    elif file.endswith(".html") :
        raw_data = pd.read_html(file)
        voters = [df_line.iloc[5,2] for df_line in raw_data if df_line.iloc[0,1] == "US REPRESENTATIVE"]
        total_registered_voters = int(str(voters[0]).split('/')[1])
        
    return int(total_registered_voters)
"""

if __name__ == "__main__":
    state = State("PA")
    print(state.name)