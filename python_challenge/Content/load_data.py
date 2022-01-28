from postgres_hook import PostgresHook

db_hook = PostgresHook()
files = [
    "datasets/athletes.xlsx",
    "datasets/coaches.xlsx",
    "datasets/gender.xlsx",
    "datasets/medals.xlsx",
    "datasets/teams.xlsx",
]

db_hook.insert_files(files)

data = {"Name": "LIONEL Messi", "NOC": "Argentina", "Discipline": "Football"}

table = db_hook.get_table("athletes")
engine = db_hook.get_engine()

engine.execute(table.insert(), data)
engine.execute(table.delete().where(table.c.NOC == "Chile"))
