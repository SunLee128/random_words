# RandomWords
This is a simple example of setting recurring tasks and setting states using Elixir GenServer. 

This app makes two asynchronous api calls to fetch 2 random words every second and combine them to make a phrase. The 3 latest phrases are saved in the GenServer cache. 