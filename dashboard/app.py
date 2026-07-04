import streamlit as st
import pandas as pd

st.title("Discogs Funk Scanner")

try:
    df = pd.read_excel("../data/results.xlsx")
    st.dataframe(df)
except:
    st.write("No results yet. Run scanner first.")
