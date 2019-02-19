import os
import pandas as pd

class State(object):
    def __init__(self, init_code):
        self.code = init_code

    @property
    def name(self):
        df_lookup = pd.read_csv(os.path.dirname(__file__) + "/data/lookup_statecodes.txt"
                                , sep = "\t")
        df_state = df_lookup.loc[df_lookup["State_or_Region_Code"] == self.code]
        return df_state.iloc[0,1]

# state = State("NY")
# print(state.name)