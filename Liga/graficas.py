import dash
from dash import dcc, html
import plotly.express as px
import pandas as pd
from Connection import Connection
import querys as sql



external_stylesheets = ["https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"]

# Inicializacion app dash
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)



con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.jugadores(), con.connection)
con.closeConnection()
dfjugadores = pd.DataFrame(query, columns=["id_j", "nombre", "goles"])

# Grafico barras
figBarJugador = px.bar(dfjugadores.head(20), x="nombre", y="goles")

# Layout
app.layout = html.Div(children=[
    html.H1(children='Tabla goleadores'),
    dcc.Graph(
        id='barJugadores',
        figure=figBarJugador
    )
])



if __name__ == '__main__':
    app.run_server(debug=True)    
    
    