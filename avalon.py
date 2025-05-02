import autogen
from typing import Dict, List, Any, Optional
import random

# Configure a termination message
termination_msg = "GAME OVER"

# Create configuration for the agents
config_list = [
    {
        "model": "gpt-4",
        "api_key": "",
    }
]

# Define role descriptions (hidden from players)
role_descriptions = {
    "Merlin": "You are Merlin. You have knowledge of who the evil agents are. Your goal is to help the good team win the quests without revealing your identity.",
    "Percival": "You are Percival. You know who Merlin is, but cannot distinguish between Morgana and Merlin. Your goal is to help the good team win quests.",
    "LoyalServant": "You are a Loyal Servant of Arthur. You have no special knowledge. Your goal is to help the good team win quests based on logic and observation.",
    "Assassin": "You are the Assassin. You know who the evil agents are. Your goal is to sabotage quests and, at the end of the game, identify and assassinate Merlin.",
    "Morgana": "You are Morgana. You appear as Merlin to Percival. Your goal is to sabotage quests and cause confusion among the good team."
}

# Randomly assign roles to generic agent names
roles = ["Merlin", "Percival", "LoyalServant", "Assassin", "Morgana"]
random.shuffle(roles)

# Create the agents with generic names and keep track of their roles
agents_with_roles = {}
agent_names = ["AgentA", "AgentB", "AgentC", "AgentD", "AgentE"]

# Create agents and store role mappings
agent_A = autogen.AssistantAgent(
    name="AgentA",
    system_message=role_descriptions[roles[0]],
    llm_config={"config_list": config_list},
)
agents_with_roles[agent_A] = roles[0]

agent_B = autogen.AssistantAgent(
    name="AgentB",
    system_message=role_descriptions[roles[1]],
    llm_config={"config_list": config_list},
)
agents_with_roles[agent_B] = roles[1]

agent_C = autogen.AssistantAgent(
    name="AgentC",
    system_message=role_descriptions[roles[2]],
    llm_config={"config_list": config_list},
)
agents_with_roles[agent_C] = roles[2]

agent_D = autogen.AssistantAgent(
    name="AgentD",
    system_message=role_descriptions[roles[3]],
    llm_config={"config_list": config_list},
)
agents_with_roles[agent_D] = roles[3]

agent_E = autogen.AssistantAgent(
    name="AgentE",
    system_message=role_descriptions[roles[4]],
    llm_config={"config_list": config_list},
)
agents_with_roles[agent_E] = roles[4]

# Create a user proxy agent to facilitate the game
user_proxy = autogen.UserProxyAgent(
    name="GameMaster",
    human_input_mode="ALWAYS",
    system_message="You are the Game Master who runs the Avalon game. You can speak with the agents and see their responses.",
    code_execution_config=False,
)

# All agents in the game
all_agents = [agent_A, agent_B, agent_C, agent_D, agent_E]

# Create the reverse mapping: role -> agent
role_to_agent = {role: agent for agent, role in agents_with_roles.items()}

# Game state tracking
quest_results = []

# Initialize the knowledge base for each agent
def initialize_game():
    # Get agents by their roles
    merlin = role_to_agent["Merlin"]
    percival = role_to_agent["Percival"]
    loyal_servant = role_to_agent["LoyalServant"]
    assassin = role_to_agent["Assassin"]
    morgana = role_to_agent["Morgana"]
    
    # Set up initial game knowledge
    good_team = [merlin, percival, loyal_servant]
    evil_team = [assassin, morgana]
    
    # Share knowledge according to role abilities
    # Only Merlin knows who the evil agents are
    user_proxy.send(
        message=f"You are Merlin. You know the evil agents are: {assassin.name} and {morgana.name}",
        recipient=merlin
    )
    
    # Percival knows who Merlin is, but also sees Morgana as Merlin
    user_proxy.send(
        message=f"You are Percival. You see both {merlin.name} and {morgana.name} as potential Merlins and cannot distinguish between them.",
        recipient=percival
    )
    
    # Evil agents know each other
    for evil_agent in evil_team:
        evil_teammates = [agent.name for agent in evil_team if agent != evil_agent]
        user_proxy.send(
            message=f"You are on the evil team. Your evil teammate is: {', '.join(evil_teammates)}",
            recipient=evil_agent
        )
    
    # Print the hidden role mapping (only visible to the game runner, not players)
    print("\n=== SECRET ROLE MAPPING (GAME MASTER ONLY) ===")
    for agent in all_agents:
        print(f"{agent.name} is {agents_with_roles[agent]}")
    print("=============================================\n")

# Format conversation history into a readable string
def format_conversation_history(history):
    formatted = "Conversation so far:\n"
    for entry in history:
        formatted += f"{entry['speaker']}: {entry['message']}\n"
    return formatted

# Run a quest with the selected agents
def run_quest(selected_agents, conversation_history):
    print("\n=== QUEST BEGINS ===\n")
    print(f"Selected agents for this quest: {', '.join([a.name for a in selected_agents])}")
    
    # Track quest votes (success/fail)
    quest_success_votes = 0
    quest_fail_votes = 0
    
    # Add quest information to conversation history
    quest_start_msg = f"Quest begins with {', '.join([a.name for a in selected_agents])} on the quest."
    conversation_history.append({"speaker": "GameMaster", "message": quest_start_msg})
    print(f"GameMaster: {quest_start_msg}")
    
    # Get votes from selected agents
    for agent in selected_agents:
        # Format conversation history
        history_text = format_conversation_history(conversation_history)
        
        # Evil agents (Assassin and Morgana) can choose to fail the quest
        is_evil = agents_with_roles[agent] in ["Assassin", "Morgana"]
        
        if is_evil:
            vote_prompt = "You are on the quest. Do you want the quest to SUCCEED or FAIL? As an evil agent, you can choose to make the quest fail. Respond with just 'SUCCEED' or 'FAIL'."
        else:
            vote_prompt = "You are on the quest. As a good agent, you must make the quest succeed. Respond with just 'SUCCEED'."
        
        # Get agent's vote
        vote = agent.generate_reply(
            messages=[
                {"role": "user", "content": history_text},
                {"role": "user", "content": vote_prompt}
            ]
        ).strip().upper()
        
        # Count votes (don't reveal individual votes to maintain secrecy)
        if vote == "FAIL":
            quest_fail_votes += 1
        else:  # Default to success for invalid responses
            quest_success_votes += 1
    
    # Determine quest outcome
    quest_succeeded = quest_fail_votes == 0
    quest_results.append(quest_succeeded)
    
    # Report quest results
    if quest_succeeded:
        result_message = f"Quest has SUCCEEDED! ({quest_success_votes} success votes, {quest_fail_votes} fail votes)"
    else:
        result_message = f"Quest has FAILED! ({quest_success_votes} success votes, {quest_fail_votes} fail votes)"
    
    print(result_message)
    conversation_history.append({"speaker": "GameMaster", "message": result_message})
    
    print("\n=== QUEST ENDS ===\n")
    return quest_succeeded

# Select agents for a quest
def select_agents_for_quest(is_initial=False):
    if is_initial:
        print("\n=== INITIAL TEAM SELECTION ===\n")
        print("Select three agents for the initial team (e.g., 'A B C' or 'AgentA AgentB AgentC'):")
    else:
        print("\n=== FINAL TEAM SELECTION ===\n")
        print("Select three agents for the quest (e.g., 'A B C' or 'AgentA AgentB AgentC'):")
    
    while True:
        selection = input().strip()
        
        # Parse selection
        selected_agents = []
        selected_names = [name.strip() for name in selection.split()]
        
        for name in selected_names:
            # Allow both 'A' and 'AgentA' formats
            if name.lower() in ["a", "b", "c", "d", "e"]:
                name = "Agent" + name.upper()
            
            # Find the corresponding agent
            for agent in all_agents:
                if agent.name.lower() == name.lower():
                    selected_agents.append(agent)
                    break
        
        # Validate selection
        if len(selected_agents) != 3:
            print(f"Please select exactly 3 agents. You selected {len(selected_agents)}.")
            continue
        
        # Confirm selection
        print(f"You've selected: {', '.join([a.name for a in selected_agents])}")
        print("Is this correct? (y/n)")
        confirmation = input().strip().lower()
        
        if confirmation == 'y':
            return selected_agents

# Main game loop
def run_game():
    # Initialize the game and share role knowledge
    initialize_game()
    
    # Start tracking conversation history
    conversation_history = []
    
    # Step 1: Select initial 3 players
    print("\nStep 1: Select the initial 3 players for the team.")
    initial_team = select_agents_for_quest(is_initial=True)
    initial_team_msg = f"Initial team: {', '.join([a.name for a in initial_team])}"
    print(initial_team_msg)
    conversation_history.append({"speaker": "GameMaster", "message": initial_team_msg})
    
    # Step 2: Everyone speaks once
    print("\nStep 2: Now everyone speaks once about the initial team.")
    
    # User speaks first
    print("\nYour turn to speak. What do you want to say about the initial team?")
    user_input = input("You: ")
    conversation_history.append({"speaker": "You", "message": user_input})
    
    # Each agent speaks once
    print("\n=== AGENT RESPONSES ===")
    for agent in all_agents:
        # Format conversation history
        history_text = format_conversation_history(conversation_history)
        
        # Ask the agent for their opinion
        response = agent.generate_reply(
            messages=[
                {"role": "user", "content": history_text},
                {"role": "user", "content": f"Based on the conversation so far and your role, give your honest opinion about the proposed team: {', '.join([a.name for a in initial_team])}. DO NOT REVEAL YOUR ROLE directly."}
            ]
        )
        
        print(f"{agent.name}: {response}")
        print("---")
        
        # Add to conversation history
        conversation_history.append({"speaker": agent.name, "message": response})
    
    # Step 3: Select 3 players for the quest again
    print("\nStep 3: After hearing everyone's opinion, select the final 3 players for the quest.")
    final_team = select_agents_for_quest(is_initial=False)
    
    # Step 4: Execute quest and see results
    print("\nStep 4: Execute the quest with the selected team.")
    quest_succeeded = run_quest(final_team, conversation_history)
    
    # Display final result
    print("\n=== GAME COMPLETED ===\n")
    if quest_succeeded:
        print("The GOOD team won the quest!")
    else:
        print("The EVIL team sabotaged the quest!")

if __name__ == "__main__":
    run_game()
