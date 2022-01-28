import pandas as pd
from sqlalchemy import create_engine, MetaData, Table
from sqlalchemy.engine import Engine
import os
import logging
from typing import List, Optional, Union


class PostgresHook:
    def __init__(
        self,
        db_name: Optional[str] = None,
        db_user: Optional[str] = None,
        db_pass: Optional[str] = None,
        db_host: Optional[str] = None,
        db_port: Union[Optional[str], Optional[str]] = None,
    ) -> None:
        # All of this environment variables are defined in the docker-compose.yml
        self.db_name = db_name if db_name else os.environ.get("POSTGRES_DB")
        self.db_user = db_user if db_user else os.environ.get("POSTGRES_USER")
        self.db_pass = db_pass if db_pass else os.environ.get("POSTGRES_PASSWORD")
        self.db_host = db_host if db_host else os.environ.get("POSTGRES_HOST")
        self.db_port = db_port if db_port else os.environ.get("POSTGRES_PORT")
        self.engine: Engine = self._get_engine()
        self.metadata: MetaData = MetaData(self.engine)

    def _get_engine(self, db_url: Optional[str] = "postgresql") -> Engine:
        db_string = "{}://{}:{}@{}:{}/{}".format(
            db_url, self.db_user, self.db_pass, self.db_host, self.db_port, self.db_name
        )

        engine = create_engine(db_string)

        logging.info("Connection Established!")

        return engine

    def _get_df(self, _file: str) -> pd.DataFrame:
        file_type: str = _file.split(".")[-1]
        if file_type == "xlsx":
            df = pd.read_excel(_file)
        elif file_type == "odf":
            df = pd.read_excel(_file, engine="odf")  # For my Open Source folks :D
        elif file_type == "csv":
            df = pd.read_csv(_file)
        elif file_type == "json":
            df = pd.read_json(_file)
        else:
            Exception("File type not supported")

        if df.empty:
            Exception("File is empty")

        return df.drop_duplicates()

    def insert_files(
        self,
        files: List[str],
        if_exists: Optional[str] = "replace",
        schema: Optional[str] = "public",
    ) -> None:
        for i in files:
            df = self._get_df(i)
            df.to_sql(
                i.split("/")[-1].split(".")[
                    0
                ],  # Important! This function assumes that the name of the files are the same as the tables
                self.engine,
                if_exists=if_exists,
                method="multi",
                index=False,
                schema=schema,
            )
            logging.info(f'Inserting {i.split("/")[-1].split(".")[0]} file')
        logging.info("Files inserted successfully!")

    def drop_table(self, table_name: str) -> None:
        self.engine.execute(
            """
                DROP TABLE IF EXISTS {} CASCADE;
            """.format(
                table_name
            )  # Important! This function will delete all dependencies from the dropped table so be aware of that.
        )
        logging.info(f"Table {table_name} dropped")

    def create_table(
        self, table_obj: Optional[Table] = None, metadata_obj: Optional[MetaData] = None
    ) -> None:
        if not table_obj and metadata_obj:
            metadata_obj.create_all(
                self.engine
            )  # MetaData objects can store multiple Table objects, quite useful.
            logging.info("Table created")
        elif table_obj and not metadata_obj:
            table_obj.create(self.engine)
            logging.info("Table created")
        else:
            Exception("Not valid object, table not created")

    def get_table(self, table: str) -> Table:
        return Table(table, self.metadata, autoload=True, autoload_with=self.engine)

    def get_engine(self):
        return self.engine
