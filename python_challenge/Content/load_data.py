from postgres_hook import PostgresHook

db_hook = PostgresHook()
files = [
    "Datasets/athletes.xlsx",
    "Datasets/coaches.xlsx",
    "Datasets/gender.xlsx",
    "Datasets/medals.xlsx",
    "Datasets/teams.xlsx",
]

db_hook.insert_files(files)

data = {"Name": "WANCHOPE Abila", "NOC": "Argentina", "Discipline": "Football"}

table = db_hook.get_table("athletes")
engine = db_hook.get_engine()

engine.execute(table.insert(), data)
engine.execute(table.delete().where(table.c.NOC == "Chile"))
