
# Avalon LLM Agent Web App

This project implements a Streamlit-based web interface for the social deduction game **The Resistance: Avalon**. It integrates large language model (LLM) agents to play various roles in the game, simulating reasoning, dialogue, voting, and decision-making.

##  Project Structure

- `avalon_app.py` – Main entry point of the Streamlit app that orchestrates gameplay.
- `Player.py` – Defines the `Player` class used to manage agent behavior and role logic.
- `prompts.py` – Contains structured prompts for guiding agent interactions across game phases.

## Installation

### 1. Clone this Repository

```bash
git clone https://github.com/Rachelz1231/AvalonAI.git
```

### 2. Create and Activate Virtual Environment (Recommended)

```bash
python3 -m venv venv
source venv/bin/activate    # On Windows: venv\Scripts\activate
```

### 3. Install Required Packages

Make sure you have Python 3.8 or above installed. Then install dependencies:

```bash
pip install -r requirements.txt
```

If `requirements.txt` is not present, install manually:

```bash
pip install streamlit openai python-dotenv autogen
```


You may also need:

```bash
pip install python-dotenv
```

## API Key

This app uses OpenAI's GPT-based agents. You must set your OpenAI API key before launching:

### Set API_KEY in avalon_app.py

```API_KEY = ""
```

## ▶ Run the App

Once the dependencies are installed and the API key is set, launch the web interface using:

```bash
streamlit run avalon_app.py
```
Then open the local server URL provided by Streamlit (usually `http://localhost:8501`) in your browser.

## Gameplay Overview

- A new game initializes with a set of players (human and/or LLM agents).
- Each round involves team selection, discussion, voting, and quest execution.
- Specialized prompts (in `prompts.py`) guide agents through decision-making phases.

## Notes

- This app is for experimental and demonstration purposes.
- Agent behavior depends on LLM responses, which may vary by temperature and prompt design.

## iOS Frontend (Xcode)

This folder also includes preliminary frontend code for an iOS app implementation of the Avalon AI interface.

To explore or develop the iOS frontend:

1. Open the `AvalonAI.xcodeproj` file in Xcode.
2. Make sure you have a valid Apple Developer setup if you plan to run the app on a physical device.
3. The iOS project contains basic UI screens for agent interaction and game control.

This part is optional and not required to run the Streamlit-based web interface.

## License

MIT License (add your license here if applicable)
