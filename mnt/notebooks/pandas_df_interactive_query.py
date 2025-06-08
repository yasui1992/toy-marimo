import marimo

__generated_with = "0.13.15"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo
    return (mo,)


@app.cell
def _():
    from vega_datasets import data
    import plotly.graph_objects as go
    return data, go


@app.cell
def _(data):
    df = data.stocks()
    df
    return (df,)


@app.cell
def _(df, mo):
    symbols = (
        df["symbol"]
        .drop_duplicates()
        .to_list()
    )

    dp_symbols = mo.ui.dropdown(options=symbols, value=symbols[0])
    dp_symbols
    return (dp_symbols,)


@app.cell
def _(df, dp_symbols, go):
    df_filtered_symbol = df.query("symbol == @dp_symbols.value")

    fig = go.Figure()
    fig.add_trace(go.Scatter(
        x=df_filtered_symbol["date"],
        y=df_filtered_symbol["price"],
        mode="lines"
    ))
    fig.update_layout(
        title=f"Price by date (symbol: {dp_symbols.value})",
        xaxis=dict(
            rangeslider=dict(visible=True),
            type="date"
        )
    )

    fig
    return


if __name__ == "__main__":
    app.run()
