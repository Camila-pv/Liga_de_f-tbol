# -*- coding: utf-8 -*-
"""
Created on Wed May 25 20:19:30 2022

@author: Laboratorios EICT
"""

import dash
from dash import dcc, html
import plotly.express as px
import pandas as pd
from Connection import Connection
import querys as sql



external_stylesheets = ["https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"]

# Inicializacion app dash
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)


# Casos por pais
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.asistencias(), con.connection)
con.closeConnection()
dfasistencias = pd.DataFrame(query, columns=["id_j", "nombre", "asistencias"])

# Grafico barras
figBarJugador = px.bar(dfasistencias.head(20), x="nombre", y="asistencias")

# Layout
app.layout = html.Div(children=[
    html.H1(children='Tabla asistidores'),
    dcc.Graph(
        id='barAsistencias',
        figure=figBarJugador
    )
])

if __name__ == '__main__':
    app.run_server(debug=True)