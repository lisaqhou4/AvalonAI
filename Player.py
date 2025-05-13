# Player.py
class Player:
    def __init__(self, name, role):
        self.name = name
        self.role = role
        self.teammates = [] # For evil players or Percival/Merlin knowledge

    def add_teammate(self, teammate_name):
        if teammate_name not in self.teammates:
            self.teammates.append(teammate_name)

    def __str__(self):
        # Streamlit's multiselect widget might try to str() the object if it's part of the options/default
        return self.name # Or f"Player({self.name}, {self.role})" if you prefer for debugging

    def __repr__(self):
        return f"Player(name='{self.name}', role='{self.role}')"

    # This method is part of the autogen.Agent interface,
    # but for the user Player object, interaction is via Streamlit UI.
    def generate_reply(self, messages=None, sender=None, config=None):
        # This won't be called directly for the user if logic correctly uses st.text_input etc.
        # It's here to make the Player object somewhat compatible if an iteration expects this method.
        print(f"WARNING: generate_reply called on User Player object: {self.name}. This should be handled by UI.")
        return "User input should come from Streamlit UI."

    # Needed for hashing if Player objects are used in sets or as dict keys (e.g. in st.multiselect options)
    def __hash__(self):
        return hash(self.name)

    def __eq__(self, other):
        if isinstance(other, Player):
            return self.name == other.name
        elif isinstance(other, str):
            return self.name == other
        return False
