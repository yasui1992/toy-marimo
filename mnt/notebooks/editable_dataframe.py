import marimo

__generated_with = "0.13.15"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo

    import requests
    import polars as pl
    return mo, pl, requests


@app.cell
def _(pl, requests):
    url = "https://github.com/vega/vega-datasets/raw/main/data/penguins.json"
    response = requests.get(url)
    response.raise_for_status()

    df = pl.DataFrame(response.json())
    return (df,)


@app.cell
def _(df, mo):
    editor = mo.ui.data_editor(df)
    editor
    return (editor,)


@app.cell
def _(editor):
    editor.value
    return


if __name__ == "__main__":
    app.run()
