import openai
openai.api_key = "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"

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

while True:
    user_input = input("You: ")
    response = generate_response(user_input)
    print("AI: " + response)
