import os

def get_file_name(state, year) :
    """
    returns the filename that contains election results corresponding to a given year and state
    """
    
    global_data_path = os.path.dirname(__file__) + "/../raw/"
    state_year_data_path = global_data_path + str(year) + "/" + state + "/"

    if state == "AK":
        if year < 2000:
            raise FileNotFoundError("No raw data for " + str(year) + "elections in " + state)
        elif year < 2014 :
            return state_year_data_path + "results.html"
        elif year >= 2014 :
            return state_year_data_path + "results.txt"
    else :
        raise ValueError("State " + state + " is not yet supported")