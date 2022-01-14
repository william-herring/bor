# Returns an HTML template for the invite email
def get_invite_template(join_link: str):
    content = f'<h1 style="text-align: center">Hey! You have been invited to a team!</h1><br><a href="localhost:3000/join/{join_link}">Join here</a>'
    return content
