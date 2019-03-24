import os
import pandas as pd
from sqlalchemy import create_engine
import urllib

class State(object):
    def __init__(self, init_code):
        self.code = init_code

    @property
    def name(self):
        df_lookup = pd.read_csv(os.path.dirname(__file__) + "/data/lookup_statecodes.txt"
                                , sep = "\t")
        df_state = df_lookup.loc[df_lookup["State_or_Region_Code"] == self.code]
        return df_state.iloc[0,1]

    def get_raw_files(self, year):
        """
        year: int
        returns: list of filenames in the raw folder
        """
        generator_directory_listing = os.walk(os.path.dirname(__file__) + ("/data/raw/%s/%s/" % (str(year), self.code)))
        dirpath, dirnames, filenames = next(generator_directory_listing)
        return [dirpath + filename for filename in filenames]

class AK(State):
    def __init__(self):
        self.code = "AK"

    def load_raw_files_to_database(self, year):
        """
        year: int
        inserts the data for the corresponding files
        and returns success or failure
        """
        connection_string = urllib.parse.quote_plus("Driver={ODBC Driver 13 for SQL Server};Server=tcp:dev-mercury.database.windows.net,1433;Database=TEP;Uid=astronaut@dev-mercury;Pwd=USA2019!;Encrypt=yes;")
        engine = create_engine("mssql+pyodbc:///?odbc_connect=%s" % connection_string)

        # read from file to a dataframe
        for file in self.get_raw_files(year):
            data = pd.read_csv(file, header=None, encoding="latin1", sep=",", error_bad_lines=False)
            print("Processing file: %s" % file)
            print(data.head())
            data["election_year"] = year
            table_name = self.code + os.path.splitext(os.path.basename(file))[0]
            print("Writing to table %s" % table_name)
            try:
                data.to_sql(table_name, con = engine, if_exists="replace", index=False)
                print("Success")
            except Exception as e:
                print("Failed with exception %s" % e)
