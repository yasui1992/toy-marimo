import marimo

__generated_with = "0.13.15"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo
    return (mo,)


@app.cell
def _(mo):
    _df = mo.sql(
        f"""
        CREATE OR REPLACE TABLE penguins
        AS
        SELECT * FROM read_json("https://raw.githubusercontent.com/vega/vega-datasets/main/data/penguins.json")
        ;
        """
    )
    return (penguins,)


@app.cell
def _(mo, penguins):
    _df = mo.sql(
        f"""
        SELECT * FROM penguins;
        """
    )
    return


if __name__ == "__main__":
    app.run()
