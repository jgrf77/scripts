# Import libraries
import openai
import os
from dotenv import load_dotenv

# Load the environment variables from the .env file
load_dotenv()

# Get the API key from the environment variable
openai.api_key = os.getenv("OPENAI_API_KEY")

# Define function
def generate_response(query):
    model_engine = "text-davinci-003" # choose your preferred model engine
    prompt = f"User: {query}\nAI:"
    completions = openai.Completion.create(
        engine=model_engine,
        prompt=prompt,
        max_tokens=60,
        n=1,
        stop=None,
        temperature=0.5,
    )
    message = completions.choices[0].text.strip()
    return message

# Define Loop
while True:
    user_input = input("You: ")
    response = generate_response(user_input)
    print("AI: " + response)
    # Break statement
    if user_input == "exit":
        break

