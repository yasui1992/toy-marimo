import marimo

__generated_with = "0.13.15"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo

    import pandas as pd
    import altair as alt
    return alt, mo, pd


@app.cell
def _(pd):
    df = pd.read_json("https://raw.githubusercontent.com/vega/vega-datasets/main/data/penguins.json")
    df
    return (df,)


@app.cell
def _(df, mo):
    mo.ui.dataframe(df)
    return


@app.cell
def _(alt, df, mo):
    chart = alt.Chart(df).mark_point().encode(
        x="Beak Length (mm)",
        y="Beak Depth (mm)",
        color="Species",
    )

    chart = mo.ui.altair_chart(chart)
    return (chart,)


@app.cell
def _(chart, mo):
    mo.vstack([chart, chart.value])
    return


if __name__ == "__main__":
    app.run()
