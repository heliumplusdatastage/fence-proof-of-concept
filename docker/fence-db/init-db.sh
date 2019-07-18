#!/usr/bin/python

# mod of userdatamodel-init --db fence --username fence --host localhost to make SQLAlchemyDriver  connect using a unix socket since postgresql listens only to its unix socket at this point in startup lifecycle


import argparse
from userdatamodel.models import * # noqa
from userdatamodel.init_defaults import init_defaults
from userdatamodel.driver import SQLAlchemyDriver
import os

db = SQLAlchemyDriver(
        # format: "postgresql://{username}:{password}@:5432/{db}".format(args),
        # POSTGRES_USER and POSTGRES_DB come from container ENV
        "postgresql://" + os.environ['POSTGRES_USER'] + "@:5432/" + os.environ['POSTGRES_DB'],
    ignore_db_error=False,
    )
print ("initializing fence database")
init_defaults(db)
print ("fence database initialization complete")
