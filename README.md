# RandomWords
This is a simple example of setting a recurring task and maintaining states using Elixir GenServer. 

This app makes two asynchronous api calls to fetch two random words every second and combine them to make a phrase. The three most recent phrases are saved in the GenServer cache. 


### Testing with mocks
A mock server is implemented to avoid hitting real api in testing environment. 
http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/

